Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132520AbRCZRxN>; Mon, 26 Mar 2001 12:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132519AbRCZRxD>; Mon, 26 Mar 2001 12:53:03 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:41221
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S132518AbRCZRwm>; Mon, 26 Mar 2001 12:52:42 -0500
Date: Mon, 26 Mar 2001 12:51:46 -0500
From: Chris Mason <mason@suse.com>
To: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com, alan@redhat.com,
        Alexander Viro <viro@math.psu.edu>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: 2.4.2 fs/inode.c
Message-ID: <90660000.985629106@tiny>
In-Reply-To: <20010322134215.A25508@cs.cmu.edu>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, March 22, 2001 01:42:15 PM -0500 Jan Harkes
<jaharkes@cs.cmu.edu> wrote:

> 
> I found some code that seems wrong and didn't even match it's comment.
> Patch is against 2.4.2, but should go cleanly against 2.4.3-pre6 as well.
> 

Ok, this looks correct, makes reiserfs faster, and survived under load.  The
idea was to only call dirty_inode if sync_one might decide the inode needs
flushing to disk.  So, the check in __mark_inode_dirty should look the same
as the check in sync_one.

> --- linux/fs/inode.c.orig	Thu Mar 22 13:20:55 2001
> +++ linux/fs/inode.c	Thu Mar 22 13:21:32 2001
> @@ -133,7 +133,7 @@
>  
> 	 if (sb) {
> 		 /* Don't do this for I_DIRTY_PAGES - that doesn't actually dirty the
> 		 inode itself */ 
> -		if (flags & (I_DIRTY | I_DIRTY_SYNC)) {
> +		if (flags & (I_DIRTY_SYNC | I_DIRTY_DATASYNC)) {
> 			 if (sb->s_op && sb->s_op->dirty_inode)
> 				 sb->s_op->dirty_inode(inode);
> 		 }
> -

-chris

