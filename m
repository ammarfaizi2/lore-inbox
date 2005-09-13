Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbVIMT1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVIMT1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbVIMT1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:27:17 -0400
Received: from mail.dvmed.net ([216.237.124.58]:53414 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965164AbVIMT1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:27:16 -0400
Message-ID: <43272806.60806@pobox.com>
Date: Tue, 13 Sep 2005 15:27:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike.miller@hp.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] cciss: bug fix in cciss_remove_one
References: <200509131910.j8DJAOfZ024676@hera.kernel.org>
In-Reply-To: <200509131910.j8DJAOfZ024676@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> tree 30a07d018d74fbd99d323d6d6a6e08cac3a1b767
> parent 33079b21978f478865068ee6a3c5807b6c6ecdbe
> author Mike Miller <mike.miller@hp.com> Tue, 13 Sep 2005 15:25:23 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> Tue, 13 Sep 2005 22:22:30 -0700
> 
> [PATCH] cciss: bug fix in cciss_remove_one
> 
> This patch fixes a bug in cciss_remove_one.  A set of braces was missing for
> the if statement causing an Oops on driver unload.
> 
> Signed-off-by: Mike Miller <mike.miller@hp.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>  drivers/block/cciss.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
> --- a/drivers/block/cciss.c
> +++ b/drivers/block/cciss.c
> @@ -3095,9 +3095,10 @@ static void __devexit cciss_remove_one (
>  	/* remove it from the disk list */
>  	for (j = 0; j < NWD; j++) {
>  		struct gendisk *disk = hba[i]->gendisk[j];
> -		if (disk->flags & GENHD_FL_UP)
> -			blk_cleanup_queue(disk->queue);
> +		if (disk->flags & GENHD_FL_UP) {
>  			del_gendisk(disk);
> +			blk_cleanup_queue(disk->queue);

hrm.  Would be nice to get cciss patches reviewed by Jens or me, or 
somebody...

Take a look at drivers/block/sx8.c:carm_free_disks() for the proper way 
to do this.

	Jeff


