Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSA1Wah>; Mon, 28 Jan 2002 17:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287287AbSA1WaS>; Mon, 28 Jan 2002 17:30:18 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:26544 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S287204AbSA1WaQ>; Mon, 28 Jan 2002 17:30:16 -0500
Subject: Encountered a Null Pointer Problem on the SCSI Layer
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFA3681BF4.8B57AF11-ON85256B4F.007A7E3A@raleigh.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Mon, 28 Jan 2002 16:30:13 -0600
X-MIMETrack: Serialize by Router on D04NM203/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/28/2002 05:30:13 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered a null pointer problem on the SCSI layer when
I was testing Mingming Cao's diskio patch "diskio-stat-rq-2414"
on 2.4.14.

Mingming's patch is at http://sourceforge.net/projects/lse/.

The code in sd_find_queue() that protects against accessing a
non-existent device is not correct. The patch to fix it is given
below. Please check.

The following patch is based on the 2.4.18-pre7 code:

---------------------------------------------------------------------------
--- linux/drivers/scsi/sd.c     Fri Jan 25 14:01:07 2002
+++ linux-2.4.17-diskio/drivers/scsi/sd.c       Fri Jan 25 13:57:01 2002
@@ -279,7 +279,7 @@
        target = DEVICE_NR(dev);

        dpnt = &rscsi_disks[target];
-       if (!dpnt)
+       if (!dpnt->device)
                return NULL;    /* No such device */
        return &dpnt->device->request_queue;
 }
---------------------------------------------------------------------------

Regards,
Peter

Wai Yee Peter Wong
IBM Linux Technology Center, Performance Analysis
email: wpeter@us.ibm.com

