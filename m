Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWHQAQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWHQAQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWHQAQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:16:51 -0400
Received: from pat.uio.no ([129.240.10.4]:15083 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932153AbWHQAQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:16:50 -0400
Subject: Re: [PATCH] NFS: possible NULL pointer deref in nfs_sillyrename()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rick Sladkey <jrs@world.std.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net
In-Reply-To: <200608170022.29168.jesper.juhl@gmail.com>
References: <200608170022.29168.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 20:16:41 -0400
Message-Id: <1155773801.6739.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.988, required 12,
	autolearn=disabled, AWL 0.50, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 00:22 +0200, Jesper Juhl wrote:
> The coverity checker spotted this as bug #1013.
> 
> If we get a NULL dentry->d_inode, then regardless of 
> NFS_PARANOIA or no NFS_PARANOIA, then if 
>    if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
> turns out to be false we'll end up dereferencing 
> that NULL d_inode in two places below.
> 
> And since the check for "(!dentry->d_inode)" even exists
> (although inside #ifdef NFS_PARANOIA) I take that to mean
> that this is a possibility. 

Sorry, but it isn't possible. See the checks in may_delete() (which is
called before ->unlink()) and nfs_rename().

IOW: Feel free to kill the NFS_PARANOIA crap. It looks like legacy code
from a debugging session about a decade or so ago.

Cheers,
  Trond

