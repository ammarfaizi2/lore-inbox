Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbTFVBcY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 21:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265417AbTFVBcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 21:32:24 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:30123 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S265133AbTFVBcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 21:32:23 -0400
Date: Sat, 21 Jun 2003 18:46:23 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() again, and trivial nfs_fhget
Message-ID: <20030621184623.A29657@google.com>
References: <20030617051408.A17974@google.com> <shs1xxsr1gx.fsf@charged.uio.no> <20030617165507.A19126@google.com> <16112.63615.561414.52943@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16112.63615.561414.52943@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Jun 18, 2003 at 04:40:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 04:40:47PM -0700, Trond Myklebust wrote:
> >>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:
> 
>     >> There is already code to handle this case in the NFS filesystem
>     >> code itself.
> 
>      > No, there isn't.
> 
> Yes there is. Look again at nfs_unlink(), following the path

My orig. message wasn't clear because I've gone through this so many
times that I didn't bother to write a complete essay this time.
In fact, it's less than "wasn't clear"; it was UNCLEAR.

My patch does appear to simply prevent unlink, and yes, that case is
ALREADY taken care of.  Sorry for the confusion there.  My patch isn't
for that purpose.

It's to prevent RENAME of silly-renamed files.  Doing so in VFS is a
one-liner, and I agree that the VFS should be as clean as possible,
but let's face it, the VFS *must* have specific fs knowledge.  eg,
the ALWAYS_REVAL (something like that) patch you recently submitted
is just to treat NFS differently than other fs's.  Just because the
flag doesn't have "NFS" in it doesn't make it generic.  (And so I
repeat my earlier suggestion that might make the change more palatable:
rename the NFSFS_RENAMED flag to DONT_UNLINK.)

Please review the thread which ended with the message I previously cited.
One of the things there is a test case showing the problem.

I could write another essay on why the one-liner I proposed is a decent
patch, but I'd rather not. :-)  If  the patch is accepted, there is a
some simplification that could be done in the NFS code; I will submit a
subsequent patch for that if this first one is accepted.

/fc
