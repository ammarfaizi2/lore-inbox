Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263627AbSJHUL1>; Tue, 8 Oct 2002 16:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSJHTMR>; Tue, 8 Oct 2002 15:12:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24848 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263249AbSJHTGa>; Tue, 8 Oct 2002 15:06:30 -0400
Subject: PATCH: make pas16 work with new NCR5380
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:03:39 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzdr-0004uO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/pas16.h linux.2.5.41-ac1/drivers/scsi/pas16.h
--- linux.2.5.41/drivers/scsi/pas16.h	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/pas16.h	2002-10-06 23:16:55.000000000 +0100
@@ -118,7 +118,9 @@
 int pas16_biosparam(Disk *, struct block_device *, int*);
 int pas16_detect(Scsi_Host_Template *);
 int pas16_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int pas16_reset(Scsi_Cmnd *, unsigned int);
+int pas16_bus_reset(Scsi_Cmnd *);
+int pas16_host_reset(Scsi_Cmnd *);
+int pas16_device_reset(Scsi_Cmnd *);
 int pas16_proc_info (char *buffer ,char **start, off_t offset,
 		     int length, int hostno, int inout);
 
@@ -144,8 +146,10 @@
 	name:           "Pro Audio Spectrum-16 SCSI", 	\
 	detect:         pas16_detect, 			\
 	queuecommand:   pas16_queue_command,		\
-	abort:          pas16_abort,			\
-	reset:          pas16_reset,			\
+	eh_abort_handler: pas16_abort,			\
+	eh_bus_reset_handler: pas16_bus_reset,		\
+	eh_device_reset_handler: pas16_device_reset,	\
+	eh_host_reset_handler: pas16_host_reset,	\
 	bios_param:     pas16_biosparam, 		\
 	can_queue:      CAN_QUEUE,			\
 	this_id:        7,				\
@@ -186,7 +190,9 @@
 #define do_NCR5380_intr do_pas16_intr
 #define NCR5380_queue_command pas16_queue_command
 #define NCR5380_abort pas16_abort
-#define NCR5380_reset pas16_reset
+#define NCR5380_device_reset pas16_device_reset
+#define NCR5380_bus_reset pas16_bus_reset
+#define NCR5380_host_reset pas16_host_reset
 #define NCR5380_proc_info pas16_proc_info
 
 /* 15 14 12 10 7 5 3 
