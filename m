Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264267AbUEDI3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUEDI3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 04:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbUEDI3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 04:29:55 -0400
Received: from host16.apollohosting.com ([209.239.37.142]:14727 "EHLO
	host16.apollohosting.com") by vger.kernel.org with ESMTP
	id S264267AbUEDI31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 04:29:27 -0400
To: backblue <backblue@netcabo.pt>, linux-kernel@vger.kernel.org
Cc: bvermeul@blackstar.xs4all.nl
Subject: Re: [ERROR] in ini9100.c scsi driver
References: <20040502212548.2fe2370a@fork.ketic.com>
Message-ID: <opr7gu9q0apsnffn@mail.mcaserta.com>
Date: Tue, 04 May 2004 10:30:52 +0200
From: "Mirko Caserta" <mirko@mcaserta.com>
Content-Type: multipart/mixed; boundary=----------3S6Kde8o0IkCYkcuWQXqpC
MIME-Version: 1.0
In-Reply-To: <20040502212548.2fe2370a@fork.ketic.com>
User-Agent: Opera M2/7.50 (Linux, build 663)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------3S6Kde8o0IkCYkcuWQXqpC
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Try this patch some clever guy sent to the list a couple days ago. I had  
the same issue and this patch fixed it.

This is against 2.6.5. Who takes care of merging this scsi driver into the  
mainstream kernel? I couldn't find anyone in the MAINTAINERS file. Thanks.

Mirko

On Sun, 2 May 2004 21:25:48 +0100, backblue <backblue@netcabo.pt> wrote:

> Hi,
>
> I'm with linux-2.6.5, i have re-compiled the kernel, to get suport to  
> another scsi controler in my workstation. Attached it's the all dmesg  
> file, and here it's the debug output that the kernel show's me! i dont  
> know who have changed the kernel to have new DMA suporte, if someone  
> know's say me please, so i can mail him directly.
>
>
>
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>         <Adaptec 2940A Ultra SCSI adapter>
>         aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs
>
> (scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 8)
>   Vendor: PIONEER   Model: DVD-ROM DVD-303F  Rev: 2.00
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> PCI: Enabling device 0000:01:09.0 (0006 -> 0007)
> PCI: Unable to reserve mem region #2:1000@e3001000 for device  
> 0000:01:09.0
> aic7xxx: <Adaptec AHA-2940A Ultra SCSI host adapter> at PCI 1/9/0
> aic7xxx: I/O ports already in use, ignoring.
> i91u: PCI Base=0xC000, IRQ=11, BIOS=0xFF000, SCSI ID=2
> i91u: Reset SCSI Bus ...
> ERROR: SCSI host `INI9100U' has no error handling
> ERROR: This is not a safe way to run your SCSI host
> ERROR: The error handling must be added to this driver
> Call Trace:
>  [<c02ad5bc>] scsi_host_alloc+0x2ac/0x2c0
>  [<c02e8653>] init_tulip+0x2b3/0x2d0
>  [<c02ad5ee>] scsi_register+0x1e/0x70
>  [<c02e7715>] i91u_detect+0x1b5/0x2c0
>  [<c05081a0>] init_this_scsi_driver+0x40/0x100
>  [<c04ee7fc>] do_initcalls+0x2c/0xc0
>  [<c01297b2>] init_workqueues+0x12/0x60
>  [<c01030cf>] init+0x2f/0x120
>  [<c01030a0>] init+0x0/0x120
>  [<c0106d31>] kernel_thread_helper+0x5/0x14
>
> scsi1 : Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g
>   Vendor: YAMAHA    Model: CRW8424S          Rev: 1.0j
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> sr1: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
> Attached scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0
> Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
> Attached scsi generic sg1 at scsi1, channel 0, id 1, lun 0,  type 5
>
> Tks


------------3S6Kde8o0IkCYkcuWQXqpC
Content-Disposition: attachment; filename=initio.patch
Content-Type: application/octet-stream; name=initio.patch
Content-Transfer-Encoding: 8bit

diff -ruN linux-2.6.5.orig/drivers/scsi/ini9100u.c linux-2.6.5/drivers/scsi/ini9100u.c
--- linux-2.6.5.orig/drivers/scsi/ini9100u.c	2004-04-30 19:36:05.000000000 +0100
+++ linux-2.6.5/drivers/scsi/ini9100u.c	2004-04-30 19:40:06.000000000 +0100
@@ -106,6 +106,8 @@
  *		- Changed the assumption that HZ = 100
  * 10/17/03 mc	- v1.04
  *		- added new DMA API support
+ * 06/01/04 jmd	- v1.04a
+ *		- Re-add reset_bus support
  **************************************************************************/
 
 #define CVT_LINUX_VERSION(V,P,S)        (V * 65536 + P * 256 + S)
@@ -149,6 +151,7 @@
 	.queuecommand	= i91u_queue,
 //	.abort		= i91u_abort,
 //	.reset		= i91u_reset,
+	.eh_bus_reset_handler = i91u_bus_reset,
 	.bios_param	= i91u_biosparam,
 	.can_queue	= 1,
 	.this_id	= 1,
@@ -161,7 +164,7 @@
 char *i91uCopyright = "Copyright (C) 1996-98";
 char *i91uInitioName = "by Initio Corporation";
 char *i91uProductName = "INI-9X00U/UW";
-char *i91uVersion = "v1.04";
+char *i91uVersion = "v1.04a";
 
 #define TULSZ(sz)     (sizeof(sz) / sizeof(sz[0]))
 #define TUL_RDWORD(x,y)         (short)(inl((int)((ULONG)((ULONG)x+(UCHAR)y)) ))
@@ -550,6 +553,15 @@
 		return tul_device_reset(pHCB, (ULONG) SCpnt, SCpnt->device->id, reset_flags);
 }
 
+int i91u_bus_reset(Scsi_Cmnd * SCpnt)
+{
+	HCS *pHCB;
+
+	pHCB = (HCS *) SCpnt->device->host->base;
+	tul_reset_scsi(pHCB, 0);
+	return SUCCESS;
+}
+
 /*
  * Return the "logical geometry"
  */
diff -ruN linux-2.6.5.orig/drivers/scsi/ini9100u.h linux-2.6.5/drivers/scsi/ini9100u.h
--- linux-2.6.5.orig/drivers/scsi/ini9100u.h	2003-12-18 02:58:56.000000000 +0000
+++ linux-2.6.5/drivers/scsi/ini9100u.h	2004-04-30 19:39:30.000000000 +0100
@@ -82,10 +82,11 @@
 extern int i91u_queue(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
 extern int i91u_abort(Scsi_Cmnd *);
 extern int i91u_reset(Scsi_Cmnd *, unsigned int);
+extern int i91u_bus_reset(Scsi_Cmnd *);
 extern int i91u_biosparam(struct scsi_device *, struct block_device *,
 		sector_t, int *);
 
-#define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g"
+#define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 1.04a"
 
 #define VIRT_TO_BUS(i)  (unsigned int) virt_to_bus((void *)(i))
 #define ULONG   unsigned long

------------3S6Kde8o0IkCYkcuWQXqpC--

