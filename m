Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265018AbTFQXxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 19:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbTFQXxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 19:53:10 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:11660 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S265018AbTFQXxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 19:53:08 -0400
Date: Tue, 17 Jun 2003 17:06:58 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() again, and trivial nfs_fhget
Message-ID: <20030617170658.B19126@google.com>
References: <20030617051408.A17974@google.com> <shs1xxsr1gx.fsf@charged.uio.no> <20030617165507.A19126@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030617165507.A19126@google.com>; from fcusack@fcusack.com on Tue, Jun 17, 2003 at 04:55:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 04:55:07PM -0700, Frank Cusack wrote:
> On Tue, Jun 17, 2003 at 11:41:18AM -0700, Trond Myklebust wrote:
> > If you think that code is wrong then make an argument for
> > changing it, and send me a patch.
> 
> I did make an argument, and did send you a patch.  Please see my email
> with message id <20030611002226.A19078@google.com>.

Let me quickly amend that, the referenced message is also a VFS change,
but a worse one than proposed in this thread.  The reason I proposed to
do it in the VFS is that I couldn't get it to work in the NFS code.

After returning from nfs_rename(), I'd promptly get a null pointer deref.

Yes, I did want to suggest an NFS patch, but it became clear that after
the VFS calls ->rename, it expects things to happen which I didn't do.
More specifically, I avoided the 'if (!d_unhashed()) d_drop()' code, and
rather than figure out the requirements I simply figured I'd propose a
VFS change.  Simple just seemed good to me ... I don't think it's so
bad for the VFS to have *small* bits of fs-specific knowledge.  You could
call the flag (say) DCACHE_DONT_UNLINK if it makes it sound less specific.

/fc
