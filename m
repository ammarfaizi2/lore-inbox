Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbUKXVrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbUKXVrq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbUKXVp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:45:28 -0500
Received: from zeus.kernel.org ([204.152.189.113]:55205 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262778AbUKXVpD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:45:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] cciss: Off-by-one error causing oops in CCISS_GETLUNIFOioctl
Date: Wed, 24 Nov 2004 14:58:09 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC005B@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cciss: Off-by-one error causing oops in CCISS_GETLUNIFOioctl
Thread-Index: AcTSUzqYWQ4QEVyIRjKBigmnTg/1PgAFAOdg
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Nov 2004 20:58:10.0405 (UTC) FILETIME=[4E39A950:01C4D268]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes an an "off-by-one" error found in the CCISS_GETLUNIFO
> ioctl in the cciss driver.  It is cycling through the part 
> table of the
> gendisk structure which is a zero-based array, not a one-based array.
> This often causes an oops when referencing the out-of-bounds 
> element.  
> 
> Signed-off by: Andrew Patterson <andrew.patterson@hp.com>
> ---
Thanks, Andrew, but I was informed in no uncertain terms that my driver has "no damn business" reading the part table struct. This ioctl will be removed in the next version of the driver. Applications that use this should be changed to use readdir.

Thanks,
mikem

> 
> --- linux-2.6.9/drivers/block/cciss.c.orig	2004-11-24 
> 10:22:30.000000000 -0700
> +++ linux-2.6.9/drivers/block/cciss.c	2004-11-24 
> 10:27:38.000000000 -0700
> @@ -799,7 +799,7 @@
>   		luninfo.num_opens = drv->usage_count;
>   		luninfo.num_parts = 0;
>   		/* count partitions 1 to 15 with sizes > 0 */
> - 		for(i=1; i <MAX_PART; i++) {
> + 		for(i=0; i <MAX_PART-1; i++) {
>  			if (!disk->part[i])
>  				continue;
>  			if (disk->part[i]->nr_sects != 0)
> 
> 
> 
