Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTJ1JsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 04:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTJ1JsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 04:48:14 -0500
Received: from verein.lst.de ([212.34.189.10]:494 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263891AbTJ1Jrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 04:47:53 -0500
Date: Tue, 28 Oct 2003 10:47:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill scsi_obsolete.h
Message-ID: <20031028094750.GA8039@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 2.6.0 is very near it's time to kill the leftovers of the old
EH code and mark all drivers still relying on it broken.  The
host_template methods were already removed in the last patch
accidentally.


--- 1.42/drivers/scsi/Kconfig	Wed Oct 22 01:27:24 2003
+++ edited/drivers/scsi/Kconfig	Mon Oct 27 12:01:40 2003
@@ -457,7 +457,7 @@
 
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
-	depends on (PCI || ISA) && SCSI
+	depends on (PCI || ISA) && SCSI && BROKEN
 	---help---
 	  This is support for BusLogic MultiMaster and FlashPoint SCSI Host
 	  Adapters. Consult the SCSI-HOWTO, available from
@@ -481,7 +481,7 @@
 
 config SCSI_CPQFCTS
 	tristate "Compaq Fibre Channel 64-bit/66Mhz HBA support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && BROKEN
 	help
 	  Say Y here to compile in support for the Compaq StorageWorks Fibre
 	  Channel 64-bit/66Mhz Host Bus Adapter.
@@ -603,7 +603,7 @@
 
 config SCSI_GDTH
 	tristate "Intel/ICP (former GDT SCSI Disk Array) RAID Controller support"
-	depends on (ISA || EISA || PCI) && SCSI
+	depends on (ISA || EISA || PCI) && SCSI && BROKEN
 	---help---
 	  Formerly called GDT SCSI Disk Array Controller Support.
 
@@ -1127,7 +1127,7 @@
 
 config SCSI_PSI240I
 	tristate "PSI240i support"
-	depends on ISA && SCSI
+	depends on ISA && SCSI && BROKEN
 	help
 	  This is support for the PSI240i EIDE interface card which acts as a
 	  SCSI host adapter.  Please read the SCSI-HOWTO, available from
@@ -1158,7 +1158,7 @@
 
 config SCSI_QLOGIC_ISP
 	tristate "Qlogic ISP SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && BROKEN
 	---help---
 	  This driver works for all QLogic PCI SCSI host adapters (IQ-PCI,
 	  IQ-PCI-10, IQ_PCI-D) except for the PCI-basic card.  (This latter
@@ -1176,7 +1176,7 @@
 
 config SCSI_QLOGIC_FC
 	tristate "Qlogic ISP FC SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && BROKEN
 	help
 	  This is a driver for the QLogic ISP2100 SCSI-FCP host adapter.
 
@@ -1414,7 +1414,7 @@
 
 config SCSI_MESH
 	tristate "MESH (Power Mac internal SCSI) support"
-	depends on PPC_PMAC && SCSI
+	depends on PPC_PMAC && SCSI && BROKEN
 	help
 	  Many Power Macintoshes and clones have a MESH (Macintosh Enhanced
 	  SCSI Hardware) SCSI bus adaptor (the 7200 doesn't, but all of the
@@ -1445,7 +1445,7 @@
 
 config SCSI_MAC53C94
 	tristate "53C94 (Power Mac external SCSI) support"
-	depends on PPC_PMAC && SCSI
+	depends on PPC_PMAC && SCSI && BROKEN
 	help
 	  On Power Macintoshes (and clones) with two SCSI buses, the external
 	  SCSI bus is usually controlled by a 53C94 SCSI bus adaptor. Older
--- 1.91/drivers/scsi/scsi.h	Sat Sep 20 13:50:50 2003
+++ edited/drivers/scsi/scsi.h	Mon Oct 27 12:01:41 2003
@@ -116,12 +116,6 @@
 #define scsi_to_pci_dma_dir(scsi_dir)	((int)(scsi_dir))
 #define scsi_to_sbus_dma_dir(scsi_dir)	((int)(scsi_dir))
 
-/*
- * This is the crap from the old error handling code.  We have it in a special
- * place so that we can more easily delete it later on.
- */
-#include "scsi_obsolete.h"
-
 /* obsolete typedef junk. */
 #include "scsi_typedefs.h"
 
--- drivers/scsi/scsi_obsolete.h	Tue Oct 28 10:45:10 2003
+++ /dev/null	Wed Jan  8 21:05:49 2003
@@ -1,106 +0,0 @@
-/*
- *  scsi_obsolete.h Copyright (C) 1997 Eric Youngdale
- *
- */
-
-#ifndef _SCSI_OBSOLETE_H
-#define _SCSI_OBSOLETE_H
-
-/*
- * These are the return codes for the abort and reset functions.  The mid-level
- * code uses these to decide what to do next.  Each of the low level abort
- * and reset functions must correctly indicate what it has done.
- * The descriptions are written from the point of view of the mid-level code,
- * so that the return code is telling the mid-level drivers exactly what
- * the low level driver has already done, and what remains to be done.
- */
-
-/* We did not do anything.  
- * Wait some more for this command to complete, and if this does not work, 
- * try something more serious. */
-#define SCSI_ABORT_SNOOZE 0
-
-/* This means that we were able to abort the command.  We have already
- * called the mid-level done function, and do not expect an interrupt that 
- * will lead to another call to the mid-level done function for this command */
-#define SCSI_ABORT_SUCCESS 1
-
-/* We called for an abort of this command, and we should get an interrupt 
- * when this succeeds.  Thus we should not restore the timer for this
- * command in the mid-level abort function. */
-#define SCSI_ABORT_PENDING 2
-
-/* Unable to abort - command is currently on the bus.  Grin and bear it. */
-#define SCSI_ABORT_BUSY 3
-
-/* The command is not active in the low level code. Command probably
- * finished. */
-#define SCSI_ABORT_NOT_RUNNING 4
-
-/* Something went wrong.  The low level driver will indicate the correct
- * error condition when it calls scsi_done, so the mid-level abort function
- * can simply wait until this comes through */
-#define SCSI_ABORT_ERROR 5
-
-/* We do not know how to reset the bus, or we do not want to.  Bummer.
- * Anyway, just wait a little more for the command in question, and hope that
- * it eventually finishes.  If it never finishes, the SCSI device could
- * hang, so use this with caution. */
-#define SCSI_RESET_SNOOZE 0
-
-/* We do not know how to reset the bus, or we do not want to.  Bummer.
- * We have given up on this ever completing.  The mid-level code will
- * request sense information to decide how to proceed from here. */
-#define SCSI_RESET_PUNT 1
-
-/* This means that we were able to reset the bus.  We have restarted all of
- * the commands that should be restarted, and we should be able to continue
- * on normally from here.  We do not expect any interrupts that will return
- * DID_RESET to any of the other commands in the host_queue, and the mid-level
- * code does not need to do anything special to keep the commands alive. 
- * If a hard reset was performed then all outstanding commands on the
- * bus have been restarted. */
-#define SCSI_RESET_SUCCESS 2
-
-/* We called for a reset of this bus, and we should get an interrupt 
- * when this succeeds.  Each command should get its own status
- * passed up to scsi_done, but this has not happened yet. 
- * If a hard reset was performed, then we expect an interrupt
- * for *each* of the outstanding commands that will have the
- * effect of restarting the commands.
- */
-#define SCSI_RESET_PENDING 3
-
-/* We did a reset, but do not expect an interrupt to signal DID_RESET.
- * This tells the upper level code to request the sense info, and this
- * should keep the command alive. */
-#define SCSI_RESET_WAKEUP 4
-
-/* The command is not active in the low level code. Command probably
-   finished. */
-#define SCSI_RESET_NOT_RUNNING 5
-
-/* Something went wrong, and we do not know how to fix it. */
-#define SCSI_RESET_ERROR 6
-
-#define SCSI_RESET_SYNCHRONOUS		0x01
-#define SCSI_RESET_ASYNCHRONOUS		0x02
-#define SCSI_RESET_SUGGEST_BUS_RESET	0x04
-#define SCSI_RESET_SUGGEST_HOST_RESET	0x08
-/*
- * This is a bitmask that is ored with one of the above codes.
- * It tells the mid-level code that we did a hard reset.
- */
-#define SCSI_RESET_BUS_RESET 0x100
-/*
- * This is a bitmask that is ored with one of the above codes.
- * It tells the mid-level code that we did a host adapter reset.
- */
-#define SCSI_RESET_HOST_RESET 0x200
-/*
- * Used to mask off bits and to obtain the basic action that was
- * performed.  
- */
-#define SCSI_RESET_ACTION   0xff
-
-#endif				/* SCSI_OBSOLETE_H */
