Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTEMQEj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbTEMQEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:04:38 -0400
Received: from franka.aracnet.com ([216.99.193.44]:5576 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262013AbTEMQDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:03:52 -0400
Date: Tue, 13 May 2003 06:58:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: bharata@in.ibm.com
cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: 2.5.69-mjb1: undefined reference to `blk_queue_empty'
Message-ID: <25840000.1052834304@[10.10.2.4]>
In-Reply-To: <20030513124807.A31823@in.ibm.com>
References: <9380000.1052624649@[10.10.2.4]> <20030512205139.GT1107@fs.tum.de> <20570000.1052797864@[10.10.2.4]> <20030513124807.A31823@in.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have already sent you a fix for this. Anyway here it is again.

Oops, I must have dropped it - thanks, I'll stick it in the next release.
 
> --- linux-2.5.69/drivers/dump/dump_blockdev.c.orig	Tue May 13 12:30:49 2003
> +++ linux-2.5.69/drivers/dump/dump_blockdev.c	Tue May 13 12:34:09 2003
> @@ -261,7 +261,7 @@
>  
>  	/* For now we assume we have the device to ourselves */
>  	/* Just a quick sanity check */
> -	if (!blk_queue_empty(bdev_get_queue(dump_bdev->bdev))) {
> +	if (elv_next_request(bdev_get_queue(dump_bdev->bdev))) {
>  		/* i/o in flight - safer to quit */
>  		return -EBUSY;
>  	}

