Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261419AbSJHTK7>; Tue, 8 Oct 2002 15:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbSJHTKZ>; Tue, 8 Oct 2002 15:10:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22800 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263243AbSJHTF2>; Tue, 8 Oct 2002 15:05:28 -0400
Subject: PATCH: make dmx1391 work with new 5380
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:02:37 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzcr-0004tv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/dmx3191d.h linux.2.5.41-ac1/drivers/scsi/dmx3191d.h
--- linux.2.5.41/drivers/scsi/dmx3191d.h	2002-07-20 20:11:20.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/dmx3191d.h	2002-10-06 23:19:44.000000000 +0100
@@ -27,7 +27,9 @@
 int dmx3191d_proc_info(char *, char **, off_t, int, int, int);
 int dmx3191d_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 int dmx3191d_release_resources(struct Scsi_Host *);
-int dmx3191d_reset(Scsi_Cmnd *, unsigned int);
+int dmx3191d_bus_reset(Scsi_Cmnd *);
+int dmx3191d_host_reset(Scsi_Cmnd *);
+int dmx3191d_device_reset(Scsi_Cmnd *);
 
 
 #define DMX3191D {				\
@@ -37,8 +39,10 @@
 	release:	dmx3191d_release_resources,	\
 	info:		dmx3191d_info,			\
 	queuecommand:	dmx3191d_queue_command,		\
-	abort:		dmx3191d_abort,			\
-	reset:		dmx3191d_reset, 		\
+	eh_abort_handler:	dmx3191d_abort,		\
+	eh_bus_reset_handler:	dmx3191d_bus_reset, 	\
+	eh_device_reset_handler:dmx3191d_device_reset, 	\
+	eh_host_reset_handler:	dmx3191d_host_reset, 	\
 	bios_param:	NULL,				\
 	can_queue:	32,				\
         this_id:	7,				\
