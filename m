Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315608AbSEIEZW>; Thu, 9 May 2002 00:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315609AbSEIEZV>; Thu, 9 May 2002 00:25:21 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:33926 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315608AbSEIEZV>;
	Thu, 9 May 2002 00:25:21 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15577.63954.94547.51360@argo.ozlabs.ibm.com>
Date: Thu, 9 May 2002 14:23:46 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix drivers/scsi/sd.c for ppc32
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch fixes the compile errors in sd_find_target, which is only
used on 32-bit PPC systems, and changes the ifdef around from
CONFIG_PPC to CONFIG_PPC32 since ppc64 doesn't need this routine.

The patch is against 2.5.15.  Please apply it to your tree.

Thanks,
Paul.

diff -urN linux-2.5/drivers/scsi/sd.c pmac-2.5/drivers/scsi/sd.c
--- linux-2.5/drivers/scsi/sd.c	Sat May  4 09:24:38 2002
+++ pmac-2.5/drivers/scsi/sd.c	Thu May  9 14:05:26 2002
@@ -129,7 +129,7 @@
 static Scsi_Disk * sd_get_sdisk(int index);
 
 
-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PPC32)
 /**
  *	sd_find_target - find kdev_t of first scsi disk that matches
  *	given host and scsi_id. 
@@ -149,7 +149,7 @@
 {
 	Scsi_Disk *sdkp;
 	Scsi_Device *sdp;
-	Scsi_Host *shp = hp;
+	struct Scsi_Host *shp = hp;
 	int dsk_nr;
 	unsigned long iflags;
 
@@ -162,7 +162,7 @@
 		sdp = sdkp->device;
 		if (sdp && (sdp->host == shp) && (sdp->id == scsi_id)) {
 			read_unlock_irqrestore(&sd_dsk_arr_lock, iflags);
-			return MKDEV_SD(k);
+			return MKDEV_SD(dsk_nr);
 		}
 	}
 	read_unlock_irqrestore(&sd_dsk_arr_lock, iflags);
