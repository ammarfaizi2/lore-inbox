Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264675AbSJ3OHV>; Wed, 30 Oct 2002 09:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264682AbSJ3OHV>; Wed, 30 Oct 2002 09:07:21 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:32994 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S264675AbSJ3OHS>; Wed, 30 Oct 2002 09:07:18 -0500
Date: Wed, 30 Oct 2002 15:13:38 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux1394-devel@lists.sourceforge.net
Subject: [PATCH 2.5.bk] allow sbp2 driver to compile again
Message-ID: <20021030141338.GF17103@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux1394-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch is required to make the sbp2 compile again.

Note however that, until 2.5.45 is released, one should tweak 
the Makefile to manually change the version in order to get
the KERNEL_VERSION tests work...

Stelian.

===== drivers/ieee1394/sbp2.h 1.10 vs edited =====
--- 1.10/drivers/ieee1394/sbp2.h	Sat Oct 12 23:40:06 2002
+++ edited/drivers/ieee1394/sbp2.h	Wed Oct 30 12:32:39 2002
@@ -549,10 +549,11 @@
 static int sbp2scsi_detect (Scsi_Host_Template *tpnt);
 static const char *sbp2scsi_info (struct Scsi_Host *host);
 void sbp2scsi_setup(char *str, int *ints);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,28)
-static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int geom[]);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,44)
+static int sbp2scsi_biosparam (struct scsi_device *sdev,
+		struct block_device *dev, sector_t capacity, int geom[]);
 #else
-static int sbp2scsi_biosparam (Scsi_Disk *disk, struct block_device *dev, int geom[]);
+static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int geom[]);
 #endif
 static int sbp2scsi_abort (Scsi_Cmnd *SCpnt); 
 static int sbp2scsi_reset (Scsi_Cmnd *SCpnt); 
===== drivers/ieee1394/sbp2.c 1.16 vs edited =====
--- 1.16/drivers/ieee1394/sbp2.c	Tue Oct 29 01:27:33 2002
+++ edited/drivers/ieee1394/sbp2.c	Wed Oct 30 12:32:58 2002
@@ -3139,12 +3139,12 @@
  */
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,44)
 static int sbp2scsi_biosparam (struct scsi_device *sdev,
-		struct block_device *dev, sector_t capacy, int geom[]) 
+		struct block_device *dev, sector_t capacity, int geom[]) 
 {
 #else
 static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int geom[]) 
 {
-	sector_t capacy = disk->capacity;
+	sector_t capacity = disk->capacity;
 #endif
 	int heads, sectors, cylinders;
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
