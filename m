Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288862AbSATR4G>; Sun, 20 Jan 2002 12:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288867AbSATRz5>; Sun, 20 Jan 2002 12:55:57 -0500
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:46092 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S288862AbSATRzt>;
	Sun, 20 Jan 2002 12:55:49 -0500
Message-ID: <3C4B04C8.2050403@si.rr.com>
Date: Sun, 20 Jan 2002 12:56:24 -0500
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Frank Davis <fdavis@si.rr.com>
Subject: Re: [PATCH]2.5.3-pre2: drivers/ieee1394/video1394.c
In-Reply-To: <Pine.LNX.4.33.0201201226270.12409-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   fyi: The last error (line 831) is regarding
remap_page_range(struct vm_area_struct, unsigned long, unsigned long, 
unsigned long, pgprot_t )
Regards,
Frank


Frank Davis wrote:

> Hello all,
>    This patch fixes some of the compile errors in 2.5.3-pre2, MINOR -> 
> minor
> Regards,
> Frank
> 
> --- drivers/ieee1394/video1394.c.old	Mon Jan 14 21:54:46 2002
> +++ drivers/ieee1394/video1394.c	Sun Jan 20 12:24:41 2002
> @@ -850,7 +850,7 @@
>  		struct video_card *p;
>  		list_for_each(lh, &video1394_cards) {
>  			p = list_entry(lh, struct video_card, list);
> -			if (p->id == MINOR(inode->i_rdev)) {
> +			if (p->id == minor(inode->i_rdev)) {
>  				video = p;
>  				ohci = video->ohci;
>  				break;
> @@ -860,7 +860,7 @@
>  	spin_unlock_irqrestore(&video1394_cards_lock, flags);
>  
>  	if (video == NULL) {
> -		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d", MINOR(inode->i_rdev));
> +		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d", minor(inode->i_rdev));
>  		return -EFAULT;
>  	}
>  
> @@ -1328,7 +1328,7 @@
>  		struct video_card *p;
>  		list_for_each(lh, &video1394_cards) {
>  			p = list_entry(lh, struct video_card, list);
> -			if (p->id == MINOR(file->f_dentry->d_inode->i_rdev)) {
> +			if (p->id == minor(file->f_dentry->d_inode->i_rdev)) {
>  				video = p;
>  				break;
>  			}
> @@ -1338,7 +1338,7 @@
>  
>  	if (video == NULL) {
>  		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d",
> -			MINOR(file->f_dentry->d_inode->i_rdev));
> +			minor(file->f_dentry->d_inode->i_rdev));
>  		return -EFAULT;
>  	}
>  
> @@ -1357,7 +1357,7 @@
>  
>  static int video1394_open(struct inode *inode, struct file *file)
>  {
> -	int i = MINOR(inode->i_rdev);
> +	int i = minor(inode->i_rdev);
>  	unsigned long flags;
>  	struct video_card *video = NULL;
>  	struct list_head *lh;
> @@ -1397,7 +1397,7 @@
>  		struct video_card *p;
>  		list_for_each(lh, &video1394_cards) {
>  			p = list_entry(lh, struct video_card, list);
> -			if (p->id == MINOR(inode->i_rdev)) {
> +			if (p->id == minor(inode->i_rdev)) {
>  				video = p;
>  				break;
>  			}
> @@ -1407,7 +1407,7 @@
>  
>  	if (video == NULL) {
>  		PRINT_G(KERN_ERR, __FUNCTION__": Unknown device for minor %d",
> -				MINOR(inode->i_rdev));
> +				minor(inode->i_rdev));
>  		return 1;
>  	}
>  
>  
> 
> 
> 
> 
> 


