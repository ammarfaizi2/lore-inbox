Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131615AbQLRCPy>; Sun, 17 Dec 2000 21:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132018AbQLRCPo>; Sun, 17 Dec 2000 21:15:44 -0500
Received: from gear.torque.net ([204.138.244.1]:56080 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S131615AbQLRCPg>;
	Sun, 17 Dec 2000 21:15:36 -0500
Message-ID: <3A3D6278.F3B126AB@torque.net>
Date: Sun, 17 Dec 2000 20:03:52 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mohammad A. Haque" <mhaque@haque.net>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohammad A. Haque wrote:
>
> Weird. The modules just give me unresolved symbol errors instead of the
> loop.
> 
> Mathias Wiklander wrote:
> > 
> > Sorry I've forgot that. It is 2.4.0-test12
> >

There was a SCSI Makefile bug in test12 that caused
those unresoved symbols. This patch from Bob Tracy
fixes it.

Doug Gilbert

--- linux/drivers/scsi/Makefile Tue Dec 12 10:49:32 2000
+++ linux/drivers/scsi/Makefile.t12bt   Tue Dec 12 22:46:27 2000
@@ -30,7 +30,7 @@
 CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ -DGDTH_STATISTICS
 CFLAGS_seagate.o =   -DARBITRATE -DPARITY -DSEAGATE_USE_ASM
 
-obj-$(CONFIG_SCSI)             += scsi_mod.o
+obj-$(CONFIG_SCSI)             += scsi_mod.o scsi_syms.o
 
 obj-$(CONFIG_A4000T_SCSI)      += amiga7xx.o   53c7xx.o
 obj-$(CONFIG_A4091_SCSI)       += amiga7xx.o   53c7xx.o
@@ -122,8 +122,7 @@
 scsi_mod-objs  := scsi.o hosts.o scsi_ioctl.o constants.o \
                        scsicam.o scsi_proc.o scsi_error.o \
                        scsi_obsolete.o scsi_queue.o scsi_lib.o \
-                       scsi_merge.o scsi_dma.o scsi_scan.o \
-                       scsi_syms.o
+                       scsi_merge.o scsi_dma.o scsi_scan.o
 
 sr_mod-objs    := sr.o sr_ioctl.o sr_vendor.o
 initio-objs    := ini9100u.o i91uscsi.o

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
