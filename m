Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965357AbWHOKQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965357AbWHOKQa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbWHOKQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:16:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6636 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965357AbWHOKQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:16:29 -0400
Date: Tue, 15 Aug 2006 12:16:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][Fix] swsusp: Fix swap_type_of
Message-ID: <20060815101611.GH7496@elf.ucw.cz>
References: <200608151218.41041.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608151218.41041.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-08-15 12:18:40, Rafael J. Wysocki wrote:
> There is a bug in mm/swapfile.c#swap_type_of() that makes swsusp only be
> able to use the first active swap partition as the resume device.
> Fix it.

ACK. (And I guess this is 2.6.18 material, right? Or is that fix not
needed in mainline?) 
								Pavel

> Index: linux-2.6.18-rc4-mm1/mm/swapfile.c
> ===================================================================
> --- linux-2.6.18-rc4-mm1.orig/mm/swapfile.c	2006-08-13 14:54:43.000000000 +0200
> +++ linux-2.6.18-rc4-mm1/mm/swapfile.c	2006-08-14 21:09:09.000000000 +0200
> @@ -442,11 +442,12 @@ int swap_type_of(dev_t device)
>  
>  		if (!(swap_info[i].flags & SWP_WRITEOK))
>  			continue;
> +
>  		if (!device) {
>  			spin_unlock(&swap_lock);
>  			return i;
>  		}
> -		inode = swap_info->swap_file->f_dentry->d_inode;
> +		inode = swap_info[i].swap_file->f_dentry->d_inode;
>  		if (S_ISBLK(inode->i_mode) &&
>  		    device == MKDEV(imajor(inode), iminor(inode))) {
>  			spin_unlock(&swap_lock);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
