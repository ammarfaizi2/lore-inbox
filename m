Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267741AbUBSDki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 22:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268187AbUBSDki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 22:40:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32982 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267741AbUBSDkg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 22:40:36 -0500
Message-ID: <40343024.8000204@pobox.com>
Date: Wed, 18 Feb 2004 22:40:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Christie <mikenc@us.ibm.com>
CC: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: dm core patches
References: <1076690681.2158.54.camel@mulgrave> <403402C1.50102@us.ibm.com>
In-Reply-To: <403402C1.50102@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie wrote:
> diff -aurp linux-2.6.3-orig/include/linux/errno.h linux-2.6.3-ec/include/linux/errno.h
> --- linux-2.6.3-orig/include/linux/errno.h	2004-02-17 19:59:12.000000000 -0800
> +++ linux-2.6.3-ec/include/linux/errno.h	2004-02-18 12:45:42.000000000 -0800
> @@ -23,6 +23,14 @@
>  #define EJUKEBOX	528	/* Request initiated, but will not complete before timeout */
>  #define EIOCBQUEUED	529	/* iocb queued, will get completion event */
>  
> +/* Block device error codes */
> +#define EFATALDEV	540	/* Fatal device error */
> +#define EFATALTRNSPT	541	/* Fatal transport error */
> +#define EFATALDRV	542	/* Fatal driver error */
> +#define ERETRYDEV	543	/* Device error occured, I/O may be retried */
> +#define ERETRYTRNSPT	544	/* Transport error occured, I/O may be retried */
> +#define ERETRYDRV	545	/* Driver error occured, I/O may be retried */


I'm not sure errno is the best place...   I would rather define them in 
blkdev.h and prefix them such that it's obvious they are specific to 
block devices.

Also, WRT the I/O error printk, you probably want to print out a string 
representing the error value returned...  that info is available now, 
might as well tell the user about it.

	Jeff



