Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbUKZX5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbUKZX5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUKZX5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:57:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:26565 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263084AbUKZTmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:42:53 -0500
Date: Thu, 25 Nov 2004 11:53:09 +0100
From: Andi Kleen <ak@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       tridge@samba.org, uweigand@de.ibm.com
Subject: Re: [PATCH] Sync in core time granuality with filesystems
Message-ID: <20041125105309.GA28698@wotan.suse.de>
References: <20041124161530.GD2729@wotan.suse.de> <jek6saiwqr.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jek6saiwqr.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 01:43:40AM +0100, Andreas Schwab wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/jfs/namei.c linux-2.6.10rc2-time/fs/jfs/namei.c
> > --- linux-2.6.10rc2/fs/jfs/namei.c	2004-10-19 01:55:28.000000000 +0200
> > +++ linux-2.6.10rc2-time/fs/jfs/namei.c	2004-11-21 23:27:52.000000000 +0100
> > @@ -1233,7 +1233,7 @@ static int jfs_rename(struct inode *old_
> >  	old_ip->i_ctime = CURRENT_TIME;
> >  	mark_inode_dirty(old_ip);
> >  
> > -	new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
> > +	new_dir->i_ctime = new_dir->i_mtime = current_fs_time(new_dir->i_sb);
> >  	mark_inode_dirty(new_dir);
> >  
> >  	/* Build list of inodes modified by this transaction */
> > @@ -1245,7 +1245,7 @@ static int jfs_rename(struct inode *old_
> >  
> >  	if (old_dir != new_dir) {
> >  		iplist[ipcount++] = new_dir;
> > -		old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
> > +		old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME; 
> 
> Is this supposed to be CURRENT_TIME_SEC?

No, JFS supports nanosecond resolution. The first hunk could
stay at CURRENT_TIME, but it doesn't matter much (would be just
a small optimization) 

-Andi
