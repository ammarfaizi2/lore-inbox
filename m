Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbUKYDuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbUKYDuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 22:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbUKYDuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 22:50:12 -0500
Received: from zeus.kernel.org ([204.152.189.113]:52406 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262961AbUKYDtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 22:49:32 -0500
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, tridge@samba.org,
       uweigand@de.ibm.com
Subject: Re: [PATCH] Sync in core time granuality with filesystems
References: <20041124161530.GD2729@wotan.suse.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I just heard the SEVENTIES were over!!  And I was just getting in
 touch
 with my LEISURE SUIT!!
Date: Thu, 25 Nov 2004 01:43:40 +0100
In-Reply-To: <20041124161530.GD2729@wotan.suse.de> (Andi Kleen's message of
 "Wed, 24 Nov 2004 17:15:30 +0100")
Message-ID: <jek6saiwqr.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/jfs/namei.c linux-2.6.10rc2-time/fs/jfs/namei.c
> --- linux-2.6.10rc2/fs/jfs/namei.c	2004-10-19 01:55:28.000000000 +0200
> +++ linux-2.6.10rc2-time/fs/jfs/namei.c	2004-11-21 23:27:52.000000000 +0100
> @@ -1233,7 +1233,7 @@ static int jfs_rename(struct inode *old_
>  	old_ip->i_ctime = CURRENT_TIME;
>  	mark_inode_dirty(old_ip);
>  
> -	new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
> +	new_dir->i_ctime = new_dir->i_mtime = current_fs_time(new_dir->i_sb);
>  	mark_inode_dirty(new_dir);
>  
>  	/* Build list of inodes modified by this transaction */
> @@ -1245,7 +1245,7 @@ static int jfs_rename(struct inode *old_
>  
>  	if (old_dir != new_dir) {
>  		iplist[ipcount++] = new_dir;
> -		old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
> +		old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME; 

Is this supposed to be CURRENT_TIME_SEC?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
