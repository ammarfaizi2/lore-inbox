Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbSLPH6d>; Mon, 16 Dec 2002 02:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbSLPH6d>; Mon, 16 Dec 2002 02:58:33 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:6456
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265661AbSLPH6b>; Mon, 16 Dec 2002 02:58:31 -0500
Date: Mon, 16 Dec 2002 03:09:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch][2.5] fix NULL Scsi_Host_Template.name entry + C99 initializers
 for aic7xxx
Message-ID: <Pine.LNX.4.50.0212160305380.12535-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initializes the ->name member and switches the struct over to C99
initializers whilst i'm there.

Please apply

Index: linux-2.5.52/drivers/scsi/aic7xxx/aic7xxx_linux_host.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.52/drivers/scsi/aic7xxx/aic7xxx_linux_host.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 aic7xxx_linux_host.h
--- linux-2.5.52/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	16 Dec 2002 05:16:13 -0000	1.1.1.1
+++ linux-2.5.52/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	16 Dec 2002 07:57:13 -0000
@@ -64,24 +64,25 @@
  * to do with card config are filled in after the card is detected.
  */
 #define AIC7XXX	{						\
-	proc_info: ahc_linux_proc_info,				\
-	detect: ahc_linux_detect,				\
-	release: ahc_linux_release,				\
-	info: ahc_linux_info,					\
-	queuecommand: ahc_linux_queue,				\
-	eh_abort_handler: ahc_linux_abort,			\
-	eh_device_reset_handler: ahc_linux_dev_reset,		\
-	eh_bus_reset_handler: ahc_linux_bus_reset,		\
-	slave_configure: ahc_linux_slave_configure,		\
-	bios_param: AIC7XXX_BIOSPARAM,				\
-	can_queue: 253,		/* max simultaneous cmds      */\
-	this_id: -1,		/* scsi id of host adapter    */\
-	sg_tablesize: 0,	/* max scatter-gather cmds    */\
-	cmd_per_lun: 2,		/* cmds per lun		      */\
-	present: 0,		/* number of 7xxx's present   */\
-	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
-	use_clustering: ENABLE_CLUSTERING,			\
-	highmem_io: 1						\
+	.name = "aic7xxx",					\
+	.proc_info = ahc_linux_proc_info,			\
+	.detect = ahc_linux_detect,				\
+	.release = ahc_linux_release,				\
+	.info = ahc_linux_info,					\
+	.queuecommand = ahc_linux_queue,			\
+	.eh_abort_handler = ahc_linux_abort,			\
+	.eh_device_reset_handler = ahc_linux_dev_reset,		\
+	.eh_bus_reset_handler = ahc_linux_bus_reset,		\
+	.slave_configure = ahc_linux_slave_configure,		\
+	.bios_param = AIC7XXX_BIOSPARAM,			\
+	.can_queue = 253,		/* max simultaneous cmds      */\
+	.this_id = -1,		/* scsi id of host adapter    */\
+	.sg_tablesize = 0,	/* max scatter-gather cmds    */\
+	.cmd_per_lun = 2,		/* cmds per lun	      */\
+	.present = 0,		/* number of 7xxx's present   */\
+	.unchecked_isa_dma = 0,	/* no memory DMA restrictions */\
+	.use_clustering = ENABLE_CLUSTERING,			\
+	.highmem_io = 1						\
 }

 #endif /* _AIC7XXX_LINUX_HOST_H_ */
Index: linux-2.5.52/drivers/scsi/aic7xxx_old/aic7xxx.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.52/drivers/scsi/aic7xxx_old/aic7xxx.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 aic7xxx.h
--- linux-2.5.52/drivers/scsi/aic7xxx_old/aic7xxx.h	16 Dec 2002 05:16:13 -0000	1.1.1.1
+++ linux-2.5.52/drivers/scsi/aic7xxx_old/aic7xxx.h	16 Dec 2002 07:52:15 -0000
@@ -30,25 +30,26 @@
  * to do with card config are filled in after the card is detected.
  */
 #define AIC7XXX	{						\
-	proc_info: aic7xxx_proc_info,				\
-	detect: aic7xxx_detect,					\
-	release: aic7xxx_release,				\
-	info: aic7xxx_info,					\
-	queuecommand: aic7xxx_queue,				\
-	slave_alloc: aic7xxx_slave_alloc,			\
-	slave_configure: aic7xxx_slave_configure,		\
-	slave_destroy: aic7xxx_slave_destroy,			\
-	bios_param: aic7xxx_biosparam,				\
-	eh_abort_handler: aic7xxx_abort,			\
-	eh_device_reset_handler: aic7xxx_bus_device_reset,	\
-	eh_host_reset_handler: aic7xxx_reset,			\
-	can_queue: 255,		/* max simultaneous cmds      */\
-	this_id: -1,		/* scsi id of host adapter    */\
-	sg_tablesize: 0,	/* max scatter-gather cmds    */\
-	cmd_per_lun: 3,		/* cmds per lun (linked cmds) */\
-	present: 0,		/* number of 7xxx's present   */\
-	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
-	use_clustering: ENABLE_CLUSTERING,			\
+	.name = "aic7xxx_old",					\
+	.proc_info = aic7xxx_proc_info,				\
+	.detect = aic7xxx_detect,				\
+	.release = aic7xxx_release,				\
+	.info = aic7xxx_info,					\
+	.queuecommand = aic7xxx_queue,				\
+	.slave_alloc = aic7xxx_slave_alloc,			\
+	.slave_configure = aic7xxx_slave_configure,		\
+	.slave_destroy = aic7xxx_slave_destroy,			\
+	.bios_param = aic7xxx_biosparam,			\
+	.eh_abort_handler = aic7xxx_abort,			\
+	.eh_device_reset_handler = aic7xxx_bus_device_reset,	\
+	.eh_host_reset_handler = aic7xxx_reset,			\
+	.can_queue = 255,		/* max simultaneous cmds      */\
+	.this_id = -1,		/* scsi id of host adapter    */\
+	.sg_tablesize = 0,	/* max scatter-gather cmds    */\
+	.cmd_per_lun = 3,		/* cmds per lun (linked cmds) */\
+	.present = 0,		/* number of 7xxx's present   */\
+	.unchecked_isa_dma = 0,	/* no memory DMA restrictions */\
+	.use_clustering = ENABLE_CLUSTERING,			\
 }

 extern int aic7xxx_queue(Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
-- 
function.linuxpower.ca
