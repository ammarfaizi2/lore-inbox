Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbSJHTNn>; Tue, 8 Oct 2002 15:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbSJHTNc>; Tue, 8 Oct 2002 15:13:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26384 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263254AbSJHTHr>; Tue, 8 Oct 2002 15:07:47 -0400
Subject: PATCH: fix t128 for new NCR5380
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:04:42 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzes-0004uk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/t128.h linux.2.5.41-ac1/drivers/scsi/t128.h
--- linux.2.5.41/drivers/scsi/t128.h	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/t128.h	2002-10-06 23:17:50.000000000 +0100
@@ -95,7 +95,9 @@
 int t128_biosparam(Disk *, struct block_device *, int*);
 int t128_detect(Scsi_Host_Template *);
 int t128_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int t128_reset(Scsi_Cmnd *, unsigned int reset_flags);
+int t128_host_reset(Scsi_Cmnd *);
+int t128_bus_reset(Scsi_Cmnd *);
+int t128_device_reset(Scsi_Cmnd *);
 int t128_proc_info (char *buffer, char **start, off_t offset,
 		   int length, int hostno, int inout);
 
@@ -121,8 +123,10 @@
 	name:           "Trantor T128/T128F/T228",	\
 	detect:         t128_detect,			\
 	queuecommand:   t128_queue_command,		\
-	abort:          t128_abort,			\
-	reset:          t128_reset,			\
+	eh_abort_handler: t128_abort,			\
+	eh_bus_reset_handler:    t128_bus_reset,	\
+	eh_host_reset_handler:   t128_host_reset,	\
+	eh_device_reset_handler: t128_device_reset,	\
 	bios_param:     t128_biosparam,			\
 	can_queue:      CAN_QUEUE,			\
         this_id:        7,				\
@@ -162,7 +166,9 @@
 #define do_NCR5380_intr do_t128_intr
 #define NCR5380_queue_command t128_queue_command
 #define NCR5380_abort t128_abort
-#define NCR5380_reset t128_reset
+#define NCR5380_host_reset t128_hostreset
+#define NCR5380_device_reset t128_device_reset
+#define NCR5380_bus_reset t128_bus_reset
 #define NCR5380_proc_info t128_proc_info
 
 /* 15 14 12 10 7 5 3 
