Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267566AbSLLXH5>; Thu, 12 Dec 2002 18:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbSLLXH5>; Thu, 12 Dec 2002 18:07:57 -0500
Received: from hera.cwi.nl ([192.16.191.8]:8576 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267566AbSLLXH4>;
	Thu, 12 Dec 2002 18:07:56 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 13 Dec 2002 00:15:39 +0100 (MET)
Message-Id: <UTC200212122315.gBCNFdp22965.aeb@smtp.cwi.nl>
To: anders.henke@sysiphus.de, linux-kernel@vger.kernel.org
Subject: Re: using 2 TB  in real life
Cc: marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SCSI device sdb: -320126976 512-byte hdwr sectors (-163904 MB)

Yes, the code in 2.4.20 works up to 30 bits.
A slight modification works up to 31 bits.
[This is cosmetic only.]

Andries

--- /linux/2.4/linux-2.4.20/linux/drivers/scsi/sd.c	Sat Aug  3 02:39:44 2002
+++ ./sd.c	Fri Dec 13 00:12:00 2002
@@ -1001,7 +1001,7 @@
 			 */
 			int m;
 			int hard_sector = sector_size;
-			int sz = rscsi_disks[i].capacity * (hard_sector/256);
+			unsigned int sz = (rscsi_disks[i].capacity/2) * (hard_sector/256);
 
 			/* There are 16 minors allocated for each major device */
 			for (m = i << 4; m < ((i + 1) << 4); m++) {
@@ -1009,9 +1009,9 @@
 			}
 
 			printk("SCSI device %s: "
-			       "%d %d-byte hdwr sectors (%d MB)\n",
+			       "%u %d-byte hdwr sectors (%d MB)\n",
 			       nbuff, rscsi_disks[i].capacity,
-			       hard_sector, (sz/2 - sz/1250 + 974)/1950);
+			       hard_sector, (sz - sz/625 + 974)/1950);
 		}
 
 		/* Rescale capacity to 512-byte units */
