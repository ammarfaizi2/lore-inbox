Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287545AbSA1XSX>; Mon, 28 Jan 2002 18:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287657AbSA1XSN>; Mon, 28 Jan 2002 18:18:13 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:1796 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S287616AbSA1XR7>; Mon, 28 Jan 2002 18:17:59 -0500
Date: Mon, 28 Jan 2002 18:17:54 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200201282317.g0SNHs326065@devserv.devel.redhat.com>
To: wpeter@us.ibm.com, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: Re: Encountered a Null Pointer Problem on the SCSI Layer
In-Reply-To: <mailman.1012257244.13523.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1012257244.13523.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux/drivers/scsi/sd.c     Fri Jan 25 14:01:07 2002
> +++ linux-2.4.17-diskio/drivers/scsi/sd.c       Fri Jan 25 13:57:01 2002
> @@ -279,7 +279,7 @@
>         target = DEVICE_NR(dev);
> 
>         dpnt = &rscsi_disks[target];
> -       if (!dpnt)
> +       if (!dpnt->device)
>                 return NULL;    /* No such device */
>         return &dpnt->device->request_queue;
>  }

> Wai Yee Peter Wong

There's one more of theese

--- linux-2.4.18-pre1/drivers/scsi/sd.c	Fri Nov  9 14:05:06 2001
+++ linux-2.4.18-pre1-p3/drivers/scsi/sd.c	Mon Jan 28 14:46:11 2002
@@ -302,7 +302,7 @@
 
 	dpnt = &rscsi_disks[dev];
 	if (devm >= (sd_template.dev_max << 4) ||
-	    !dpnt ||
+	    !dpnt->device ||
 	    !dpnt->device->online ||
  	    block + SCpnt->request.nr_sectors > sd[devm].nr_sects) {
 		SCSI_LOG_HLQUEUE(2, printk("Finishing %ld sectors\n", SCpnt->request.nr_sectors));

-- Pete
