Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264639AbSLLN5P>; Thu, 12 Dec 2002 08:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSLLN5P>; Thu, 12 Dec 2002 08:57:15 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:61198 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S264639AbSLLN5D>; Thu, 12 Dec 2002 08:57:03 -0500
Date: Thu, 12 Dec 2002 08:04:41 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initializers for drivers/scsi (1 of 4)
Message-ID: <20021212140441.GB1794@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a set of patches for converting drivers/scsi to use C99
initializers. The patches are against 2.5.51.

Art Haas

--- linux-2.5.51/drivers/scsi/3w-xxxx.h.old	2002-11-05 09:33:42.000000000 -0600
+++ linux-2.5.51/drivers/scsi/3w-xxxx.h	2002-12-10 14:28:33.000000000 -0600
@@ -474,23 +474,23 @@
 
 /* Scsi_Host_Template Initializer */
 #define TWXXXX {					\
-	proc_name : "3w-xxxx",				\
-	proc_info : tw_scsi_proc_info,			\
-	name : "3ware Storage Controller",		\
-	detect : tw_scsi_detect,			\
-	release : tw_scsi_release,			\
-	queuecommand : tw_scsi_queue,			\
-	eh_abort_handler : tw_scsi_eh_abort,		\
-	eh_host_reset_handler : tw_scsi_eh_reset,	\
-	bios_param : tw_scsi_biosparam,			\
-	can_queue : TW_Q_LENGTH-1,			\
-	this_id: -1,					\
-	sg_tablesize : TW_MAX_SGL_LENGTH,		\
-	cmd_per_lun: TW_MAX_CMDS_PER_LUN,		\
-	present : 0,					\
-	unchecked_isa_dma : 0,				\
-	use_clustering : ENABLE_CLUSTERING,		\
-	emulated : 1,					\
-	highmem_io : 1					\
+	.proc_name	= "3w-xxxx",			\
+	.proc_info	= tw_scsi_proc_info,		\
+	.name		= "3ware Storage Controller",	\
+	.detect		= tw_scsi_detect,		\
+	.release	= tw_scsi_release,		\
+	.queuecommand	= tw_scsi_queue,		\
+	.eh_abort_handler	= tw_scsi_eh_abort,	\
+	.eh_host_reset_handler	= tw_scsi_eh_reset,	\
+	.bios_param	= tw_scsi_biosparam,		\
+	.can_queue	= TW_Q_LENGTH-1,		\
+	.this_id	= -1,				\
+	.sg_tablesize	= TW_MAX_SGL_LENGTH,		\
+	.cmd_per_lun	= TW_MAX_CMDS_PER_LUN,		\
+	.present	= 0,				\
+	.unchecked_isa_dma	= 0,			\
+	.use_clustering	= ENABLE_CLUSTERING,		\
+	.emulated	= 1,				\
+	.highmem_io	= 1				\
 }
 #endif /* _3W_XXXX_H */
--- linux-2.5.51/drivers/scsi/53c7,8xx.h.old	2002-10-31 16:20:00.000000000 -0600
+++ linux-2.5.51/drivers/scsi/53c7,8xx.h	2002-12-10 14:28:34.000000000 -0600
@@ -59,16 +59,16 @@
 #endif
 
 #define NCR53c7xx {					\
-          name:           "NCR53c{7,8}xx (rel 17)",	\
-	  detect:         NCR53c7xx_detect,		\
-	  queuecommand:   NCR53c7xx_queue_command,	\
-	  abort:          NCR53c7xx_abort,		\
-	  reset:          NCR53c7xx_reset,		\
-	  can_queue:      24,				\
-	  this_id:        7,				\
-	  sg_tablesize:   127,				\
-	  cmd_per_lun:    3,				\
-	  use_clustering: DISABLE_CLUSTERING} 
+          .name           = "NCR53c{7,8}xx (rel 17)",	\
+	  .detect         = NCR53c7xx_detect,		\
+	  .queuecommand   = NCR53c7xx_queue_command,	\
+	  .abort          = NCR53c7xx_abort,		\
+	  .reset          = NCR53c7xx_reset,		\
+	  .can_queue      = 24,				\
+	  .this_id        = 7,				\
+	  .sg_tablesize   = 127,				\
+	  .cmd_per_lun    = 3,				\
+	  .use_clustering = DISABLE_CLUSTERING} 
 
 #ifndef HOSTS_C
 
--- linux-2.5.51/drivers/scsi/AM53C974.h.old	2002-10-31 16:20:00.000000000 -0600
+++ linux-2.5.51/drivers/scsi/AM53C974.h	2002-12-10 14:28:34.000000000 -0600
@@ -51,20 +51,20 @@
 };
 
 #define AM53C974 {				  \
-    proc_name:      "am53c974",    	          \
-    name:           "AM53C974",        		  \
-    detect:         AM53C974_pci_detect,	  \
-    release:        AM53C974_release,		  \
-    info:           AM53C974_info,     		  \
-    command:        AM53C974_command,  		  \
-    queuecommand:   AM53C974_queue_command,	  \
-    abort:          AM53C974_abort,    		  \
-    reset:          AM53C974_reset,    		  \
-    can_queue:      12,                 	  \
-    this_id:        -1,                           \
-    sg_tablesize:   SG_ALL,            		  \
-    cmd_per_lun:    1,                 		  \
-    use_clustering: DISABLE_CLUSTERING 		  \
+    .proc_name      = "am53c974",    	          \
+    .name           = "AM53C974",        		  \
+    .detect         = AM53C974_pci_detect,	  \
+    .release        = AM53C974_release,		  \
+    .info           = AM53C974_info,     		  \
+    .command        = AM53C974_command,  		  \
+    .queuecommand   = AM53C974_queue_command,	  \
+    .abort          = AM53C974_abort,    		  \
+    .reset          = AM53C974_reset,    		  \
+    .can_queue      = 12,                 	  \
+    .this_id        = -1,                           \
+    .sg_tablesize   = SG_ALL,            		  \
+    .cmd_per_lun    = 1,                 		  \
+    .use_clustering = DISABLE_CLUSTERING 		  \
     }
 
 static int AM53C974_pci_detect(Scsi_Host_Template * tpnt);
--- linux-2.5.51/drivers/scsi/BusLogic.h.old	2002-11-29 09:24:15.000000000 -0600
+++ linux-2.5.51/drivers/scsi/BusLogic.h	2002-12-10 14:28:34.000000000 -0600
@@ -65,18 +65,18 @@
 */
 
 #define BUSLOGIC							       \
-  { proc_name:      "BusLogic",			  /* ProcFS Directory Entry */ \
-    proc_info:      BusLogic_ProcDirectoryInfo,	  /* ProcFS Info Function   */ \
-    name:           "BusLogic",			  /* Driver Name            */ \
-    detect:         BusLogic_DetectHostAdapter,	  /* Detect Host Adapter    */ \
-    release:        BusLogic_ReleaseHostAdapter,  /* Release Host Adapter   */ \
-    info:           BusLogic_DriverInfo,	  /* Driver Info Function   */ \
-    queuecommand:   BusLogic_QueueCommand,	  /* Queue Command Function */ \
-    slave_configure:BusLogic_SlaveConfigure,	  /* Configure a SCSI_Device*/ \
-    bios_param:     BusLogic_BIOSDiskParameters,  /* BIOS Disk Parameters   */ \
-    unchecked_isa_dma: 1,			  /* Default Initial Value  */ \
-    max_sectors:    128,			  /* I/O queue len limit    */ \
-    use_clustering: ENABLE_CLUSTERING }		  /* Enable Clustering	    */
+  { .proc_name      = "BusLogic",			  /* ProcFS Directory Entry */ \
+    .proc_info      = BusLogic_ProcDirectoryInfo,	  /* ProcFS Info Function   */ \
+    .name           = "BusLogic",			  /* Driver Name            */ \
+    .detect         = BusLogic_DetectHostAdapter,	  /* Detect Host Adapter    */ \
+    .release        = BusLogic_ReleaseHostAdapter,  /* Release Host Adapter   */ \
+    .info           = BusLogic_DriverInfo,	  /* Driver Info Function   */ \
+    .queuecommand   = BusLogic_QueueCommand,	  /* Queue Command Function */ \
+    .slave_configure = BusLogic_SlaveConfigure,	  /* Configure a SCSI_Device*/ \
+    .bios_param     = BusLogic_BIOSDiskParameters,  /* BIOS Disk Parameters   */ \
+    .unchecked_isa_dma = 1,			  /* Default Initial Value  */ \
+    .max_sectors    = 128,			  /* I/O queue len limit    */ \
+    .use_clustering = ENABLE_CLUSTERING }		  /* Enable Clustering	    */
 
 
 /*
--- linux-2.5.51/drivers/scsi/a2091.h.old	2002-07-05 18:42:05.000000000 -0500
+++ linux-2.5.51/drivers/scsi/a2091.h	2002-12-10 14:28:33.000000000 -0600
@@ -30,18 +30,18 @@
 #define CAN_QUEUE 16
 #endif
 
-#define A2091_SCSI {  proc_name:	   "A2901", \
-		      name:                "Commodore A2091/A590 SCSI", \
-		      detect:              a2091_detect,    \
-		      release:             a2091_release,   \
-		      queuecommand:        wd33c93_queuecommand, \
-		      abort:               wd33c93_abort,   \
-		      reset:               wd33c93_reset,   \
-		      can_queue:           CAN_QUEUE,       \
-		      this_id:             7,               \
-		      sg_tablesize:        SG_ALL,          \
-		      cmd_per_lun:	   CMD_PER_LUN,     \
-		      use_clustering:      DISABLE_CLUSTERING }
+#define A2091_SCSI {  .proc_name	   = "A2901", \
+		      .name                = "Commodore A2091/A590 SCSI", \
+		      .detect              = a2091_detect,    \
+		      .release             = a2091_release,   \
+		      .queuecommand        = wd33c93_queuecommand, \
+		      .abort               = wd33c93_abort,   \
+		      .reset               = wd33c93_reset,   \
+		      .can_queue           = CAN_QUEUE,       \
+		      .this_id             = 7,               \
+		      .sg_tablesize        = SG_ALL,          \
+		      .cmd_per_lun	   = CMD_PER_LUN,     \
+		      .use_clustering      = DISABLE_CLUSTERING }
 
 /*
  * if the transfer address ANDed with this results in a non-zero
--- linux-2.5.51/drivers/scsi/a3000.h.old	2002-07-05 18:42:18.000000000 -0500
+++ linux-2.5.51/drivers/scsi/a3000.h	2002-12-10 14:28:33.000000000 -0600
@@ -30,19 +30,19 @@
 #define CAN_QUEUE 16
 #endif
 
-#define _A3000_SCSI { proc_name:	   "A3000",			\
-		      proc_info:           NULL,			\
-		      name:                "Amiga 3000 built-in SCSI",	\
-		      detect:              a3000_detect,		\
-		      release:             a3000_release,		\
-		      queuecommand:        wd33c93_queuecommand,	\
-		      abort:               wd33c93_abort,		\
-		      reset:               wd33c93_reset,		\
-		      can_queue:           CAN_QUEUE,			\
-		      this_id:             7,				\
-		      sg_tablesize:        SG_ALL,			\
-		      cmd_per_lun:	   CMD_PER_LUN,			\
-		      use_clustering:      ENABLE_CLUSTERING }
+#define _A3000_SCSI { .proc_name	   = "A3000",			\
+		      .proc_info           = NULL,			\
+		      .name                = "Amiga 3000 built-in SCSI",	\
+		      .detect              = a3000_detect,		\
+		      .release             = a3000_release,		\
+		      .queuecommand        = wd33c93_queuecommand,	\
+		      .abort               = wd33c93_abort,		\
+		      .reset               = wd33c93_reset,		\
+		      .can_queue           = CAN_QUEUE,			\
+		      .this_id             = 7,				\
+		      .sg_tablesize        = SG_ALL,			\
+		      .cmd_per_lun	   = CMD_PER_LUN,			\
+		      .use_clustering      = ENABLE_CLUSTERING }
 
 /*
  * if the transfer address ANDed with this results in a non-zero
--- linux-2.5.51/drivers/scsi/advansys.h.old	2002-11-29 09:24:16.000000000 -0600
+++ linux-2.5.51/drivers/scsi/advansys.h	2002-12-10 14:28:34.000000000 -0600
@@ -72,22 +72,22 @@
  */
 #if ASC_LINUX_KERNEL24
 #define ADVANSYS { \
-    proc_name:                  "advansys", \
-    proc_info:                  advansys_proc_info, \
-    name:                       "advansys", \
-    detect:                     advansys_detect, \
-    release:                    advansys_release, \
-    info:                       advansys_info, \
-    queuecommand:               advansys_queuecommand, \
-    eh_bus_reset_handler:	advansys_reset, \
-    bios_param:                 advansys_biosparam, \
-    slave_configure:		advansys_slave_configure, \
+    .proc_name                  = "advansys", \
+    .proc_info                  = advansys_proc_info, \
+    .name                       = "advansys", \
+    .detect                     = advansys_detect, \
+    .release                    = advansys_release, \
+    .info                       = advansys_info, \
+    .queuecommand               = advansys_queuecommand, \
+    .eh_bus_reset_handler	= advansys_reset, \
+    .bios_param                 = advansys_biosparam, \
+    .slave_configure		= advansys_slave_configure, \
     /* \
      * Because the driver may control an ISA adapter 'unchecked_isa_dma' \
      * must be set. The flag will be cleared in advansys_detect for non-ISA \
      * adapters. Refer to the comment in scsi_module.c for more information. \
      */ \
-    unchecked_isa_dma:          1, \
+    .unchecked_isa_dma          = 1, \
     /* \
      * All adapters controlled by this driver are capable of large \
      * scatter-gather lists. According to the mid-level SCSI documentation \
@@ -95,25 +95,25 @@
      * 'use_clustering'. But empirically while CPU utilization is increased \
      * by enabling clustering, I/O throughput increases as well. \
      */ \
-    use_clustering:             ENABLE_CLUSTERING, \
+    .use_clustering             = ENABLE_CLUSTERING, \
 }
 #elif ASC_LINUX_KERNEL22
 #define ADVANSYS { \
-    proc_info:                  advansys_proc_info, \
-    name:                       "advansys", \
-    detect:                     advansys_detect, \
-    release:                    advansys_release, \
-    info:                       advansys_info, \
-    queuecommand:               advansys_queuecommand, \
-    use_new_eh_code:		1, \
-    eh_bus_reset_handler:	advansys_reset, \
-    bios_param:                 advansys_biosparam, \
+    .proc_info                  = advansys_proc_info, \
+    .name                       = "advansys", \
+    .detect                     = advansys_detect, \
+    .release                    = advansys_release, \
+    .info                       = advansys_info, \
+    .queuecommand               = advansys_queuecommand, \
+    .use_new_eh_code		= 1, \
+    .eh_bus_reset_handler	= advansys_reset, \
+    .bios_param                 = advansys_biosparam, \
     /* \
      * Because the driver may control an ISA adapter 'unchecked_isa_dma' \
      * must be set. The flag will be cleared in advansys_detect for non-ISA \
      * adapters. Refer to the comment in scsi_module.c for more information. \
      */ \
-    unchecked_isa_dma:          1, \
+    .unchecked_isa_dma          = 1, \
     /* \
      * All adapters controlled by this driver are capable of large \
      * scatter-gather lists. According to the mid-level SCSI documentation \
@@ -121,7 +121,7 @@
      * 'use_clustering'. But empirically while CPU utilization is increased \
      * by enabling clustering, I/O throughput increases as well. \
      */ \
-    use_clustering:             ENABLE_CLUSTERING, \
+    .use_clustering             = ENABLE_CLUSTERING, \
 }
 #endif
 #endif /* _ADVANSYS_H */
--- linux-2.5.51/drivers/scsi/aha152x.h.old	2002-11-29 09:24:16.000000000 -0600
+++ linux-2.5.51/drivers/scsi/aha152x.h	2002-12-10 14:28:34.000000000 -0600
@@ -31,25 +31,25 @@
 #define AHA152X_REVID "Adaptec 152x SCSI driver; $Revision: 2.5 $"
 
 /* Initial value of Scsi_Host entry */
-#define AHA152X { proc_name:			"aha152x",		\
-                  proc_info:			aha152x_proc_info,	\
-                  name:				AHA152X_REVID,		\
-                  detect:			aha152x_detect,		\
-                  command:			aha152x_command,	\
-                  queuecommand:			aha152x_queue,		\
-		  eh_abort_handler:		aha152x_abort,		\
-		  eh_device_reset_handler:	aha152x_device_reset,	\
-		  eh_bus_reset_handler:		aha152x_bus_reset,	\
-		  eh_host_reset_handler:	aha152x_host_reset,	\
-                  release:			aha152x_release,	\
-                  bios_param:			aha152x_biosparam,	\
-                  can_queue:			1,			\
-                  this_id:			7,			\
-                  sg_tablesize:			SG_ALL,			\
-                  cmd_per_lun:			1,			\
-                  present:			0,			\
-                  unchecked_isa_dma:		0,			\
-                  use_clustering:		DISABLE_CLUSTERING }
+#define AHA152X { .proc_name			= "aha152x",		\
+                  .proc_info			= aha152x_proc_info,	\
+                  .name				= AHA152X_REVID,		\
+                  .detect			= aha152x_detect,		\
+                  .command			= aha152x_command,	\
+                  .queuecommand			= aha152x_queue,		\
+		  .eh_abort_handler		= aha152x_abort,		\
+		  .eh_device_reset_handler	= aha152x_device_reset,	\
+		  .eh_bus_reset_handler		= aha152x_bus_reset,	\
+		  .eh_host_reset_handler	= aha152x_host_reset,	\
+                  .release			= aha152x_release,	\
+                  .bios_param			= aha152x_biosparam,	\
+                  .can_queue			= 1,			\
+                  .this_id			= 7,			\
+                  .sg_tablesize			= SG_ALL,			\
+                  .cmd_per_lun			= 1,			\
+                  .present			= 0,			\
+                  .unchecked_isa_dma		= 0,			\
+                  .use_clustering		= DISABLE_CLUSTERING }
 #endif
 
 
--- linux-2.5.51/drivers/scsi/aha1542.h.old	2002-10-31 16:20:03.000000000 -0600
+++ linux-2.5.51/drivers/scsi/aha1542.h	2002-12-10 14:28:33.000000000 -0600
@@ -151,21 +151,21 @@
 	#define NULL 0
 #endif
 
-#define AHA1542 {    proc_name:			"aha1542",		\
-		     name:			"Adaptec 1542", 	\
-		     detect:			aha1542_detect,		\
-		     command:			aha1542_command,	\
-		     queuecommand:		aha1542_queuecommand,	\
-		     eh_abort_handler:		aha1542_abort,		\
-		     eh_device_reset_handler:	aha1542_dev_reset,	\
-		     eh_bus_reset_handler:	aha1542_bus_reset,	\
-		     eh_host_reset_handler:	aha1542_host_reset,	\
-		     bios_param:		aha1542_biosparam,      \
-		     can_queue:			AHA1542_MAILBOXES, 	\
-		     this_id:			7, 			\
-		     sg_tablesize:		AHA1542_SCATTER, 	\
-		     cmd_per_lun:		AHA1542_CMDLUN, 	\
-		     unchecked_isa_dma:		1, 			\
-		     use_clustering:		ENABLE_CLUSTERING	\
+#define AHA1542 {    .proc_name			= "aha1542",		\
+		     .name			= "Adaptec 1542", 	\
+		     .detect			= aha1542_detect,		\
+		     .command			= aha1542_command,	\
+		     .queuecommand		= aha1542_queuecommand,	\
+		     .eh_abort_handler		= aha1542_abort,		\
+		     .eh_device_reset_handler	= aha1542_dev_reset,	\
+		     .eh_bus_reset_handler	= aha1542_bus_reset,	\
+		     .eh_host_reset_handler	= aha1542_host_reset,	\
+		     .bios_param		= aha1542_biosparam,      \
+		     .can_queue			= AHA1542_MAILBOXES, 	\
+		     .this_id			= 7, 			\
+		     .sg_tablesize		= AHA1542_SCATTER, 	\
+		     .cmd_per_lun		= AHA1542_CMDLUN, 	\
+		     .unchecked_isa_dma		= 1, 			\
+		     .use_clustering		= ENABLE_CLUSTERING	\
 }
 #endif
--- linux-2.5.51/drivers/scsi/aha1740.h.old	2002-11-11 07:14:43.000000000 -0600
+++ linux-2.5.51/drivers/scsi/aha1740.h	2002-12-10 14:28:33.000000000 -0600
@@ -162,17 +162,17 @@
 #define AHA1740_SCATTER 16
 #define AHA1740_CMDLUN 1
 
-#define AHA1740 {  proc_name:      "aha1740",				\
-		   proc_info:      aha1740_proc_info,	                \
-		   name:           "Adaptec 174x (EISA)",		\
-		   detect:         aha1740_detect,			\
-		   command:        aha1740_command,			\
-		   queuecommand:   aha1740_queuecommand,		\
-		   bios_param:     aha1740_biosparam,                   \
-		   can_queue:      AHA1740_ECBS, 			\
-		   this_id:        7, 					\
-		   sg_tablesize:   AHA1740_SCATTER, 			\
-		   cmd_per_lun:    AHA1740_CMDLUN, 			\
-		   use_clustering: ENABLE_CLUSTERING}
+#define AHA1740 {  .proc_name      = "aha1740",				\
+		   .proc_info      = aha1740_proc_info,	                \
+		   .name           = "Adaptec 174x (EISA)",		\
+		   .detect         = aha1740_detect,			\
+		   .command        = aha1740_command,			\
+		   .queuecommand   = aha1740_queuecommand,		\
+		   .bios_param     = aha1740_biosparam,                   \
+		   .can_queue      = AHA1740_ECBS, 			\
+		   .this_id        = 7, 					\
+		   .sg_tablesize   = AHA1740_SCATTER, 			\
+		   .cmd_per_lun    = AHA1740_CMDLUN, 			\
+		   .use_clustering = ENABLE_CLUSTERING}
 
 #endif
--- linux-2.5.51/drivers/scsi/amiga7xx.h.old	2002-10-31 16:20:04.000000000 -0600
+++ linux-2.5.51/drivers/scsi/amiga7xx.h	2002-12-10 14:28:34.000000000 -0600
@@ -24,15 +24,15 @@
 
 #include <scsi/scsicam.h>
 
-#define AMIGA7XX_SCSI {name:                "Amiga NCR53c710 SCSI", \
-		       detect:              amiga7xx_detect,    \
-		       queuecommand:        NCR53c7xx_queue_command, \
-		       abort:               NCR53c7xx_abort,   \
-		       reset:               NCR53c7xx_reset,   \
-		       can_queue:           24,       \
-		       this_id:             7,               \
-		       sg_tablesize:        63,          \
-		       cmd_per_lun:	    3,     \
-		       use_clustering:      DISABLE_CLUSTERING }
+#define AMIGA7XX_SCSI {.name                = "Amiga NCR53c710 SCSI", \
+		       .detect              = amiga7xx_detect,    \
+		       .queuecommand        = NCR53c7xx_queue_command, \
+		       .abort               = NCR53c7xx_abort,   \
+		       .reset               = NCR53c7xx_reset,   \
+		       .can_queue           = 24,       \
+		       .this_id             = 7,               \
+		       .sg_tablesize        = 63,          \
+		       .cmd_per_lun	    = 3,     \
+		       .use_clustering      = DISABLE_CLUSTERING }
 
 #endif /* AMIGA7XX_H */
--- linux-2.5.51/drivers/scsi/atari_scsi.h.old	2002-07-24 19:42:28.000000000 -0500
+++ linux-2.5.51/drivers/scsi/atari_scsi.h	2002-12-10 14:28:34.000000000 -0600
@@ -51,19 +51,19 @@
 #define	DEFAULT_USE_TAGGED_QUEUING	0
 
 
-#define ATARI_SCSI {    proc_info:         atari_scsi_proc_info,	\
-			name:              "Atari native SCSI",		\
-			detect:            atari_scsi_detect,		\
-			release:           atari_scsi_release,		\
-			info:              atari_scsi_info,		\
-			queuecommand:      atari_scsi_queue_command,	\
-			abort:             atari_scsi_abort,		\
-			reset:             atari_scsi_reset,		\
-			can_queue:         0, /* initialized at run-time */	\
-			this_id:           0, /* initialized at run-time */	\
-			sg_tablesize:      0, /* initialized at run-time */	\
-			cmd_per_lun:       0, /* initialized at run-time */	\
-			use_clustering:	   DISABLE_CLUSTERING }
+#define ATARI_SCSI {    .proc_info         = atari_scsi_proc_info,	\
+			.name              = "Atari native SCSI",		\
+			.detect            = atari_scsi_detect,		\
+			.release           = atari_scsi_release,		\
+			.info              = atari_scsi_info,		\
+			.queuecommand      = atari_scsi_queue_command,	\
+			.abort             = atari_scsi_abort,		\
+			.reset             = atari_scsi_reset,		\
+			.can_queue         = 0, /* initialized at run-time */	\
+			.this_id           = 0, /* initialized at run-time */	\
+			.sg_tablesize      = 0, /* initialized at run-time */	\
+			.cmd_per_lun       = 0, /* initialized at run-time */	\
+			.use_clustering	   = DISABLE_CLUSTERING }
 
 #define	NCR5380_implementation_fields	/* none */
 
--- linux-2.5.51/drivers/scsi/atp870u.h.old	2002-10-31 16:20:04.000000000 -0600
+++ linux-2.5.51/drivers/scsi/atp870u.h	2002-12-10 14:28:32.000000000 -0600
@@ -38,21 +38,21 @@
 extern int atp870u_proc_info(char *, char **, off_t, int, int, int);
 
 #define ATP870U {						\
-	proc_info: atp870u_proc_info,				\
-	detect: atp870u_detect, 				\
-	release: atp870u_release,				\
-	info: atp870u_info,					\
-	command: atp870u_command,				\
-	queuecommand: atp870u_queuecommand,			\
-	eh_abort_handler: atp870u_abort, 			\
-	bios_param: atp870u_biosparam,				\
-	can_queue: qcnt,	 /* max simultaneous cmds      */\
-	this_id: 7,	       /* scsi id of host adapter    */\
-	sg_tablesize: ATP870U_SCATTER,	/* max scatter-gather cmds    */\
-	cmd_per_lun: ATP870U_CMDLUN,	/* cmds per lun (linked cmds) */\
-	present: 0,		/* number of 7xxx's present   */\
-	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
-	use_clustering: ENABLE_CLUSTERING,			\
+	.proc_info = atp870u_proc_info,				\
+	.detect = atp870u_detect, 				\
+	.release = atp870u_release,				\
+	.info = atp870u_info,					\
+	.command = atp870u_command,				\
+	.queuecommand = atp870u_queuecommand,			\
+	.eh_abort_handler = atp870u_abort, 			\
+	.bios_param = atp870u_biosparam,				\
+	.can_queue = qcnt,	 /* max simultaneous cmds      */\
+	.this_id = 7,	       /* scsi id of host adapter    */\
+	.sg_tablesize = ATP870U_SCATTER,	/* max scatter-gather cmds    */\
+	.cmd_per_lun = ATP870U_CMDLUN,	/* cmds per lun (linked cmds) */\
+	.present = 0,		/* number of 7xxx's present   */\
+	.unchecked_isa_dma = 0,	/* no memory DMA restrictions */\
+	.use_clustering = ENABLE_CLUSTERING,			\
 }
 
 #endif
--- linux-2.5.51/drivers/scsi/blz1230.h.old	2002-07-05 18:42:33.000000000 -0500
+++ linux-2.5.51/drivers/scsi/blz1230.h	2002-12-10 14:28:34.000000000 -0600
@@ -57,19 +57,19 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_BLZ1230      { proc_name:		"esp-blz1230", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Blizzard1230 SCSI IV", \
-			    detect:		blz1230_esp_detect, \
-			    release:		blz1230_esp_release, \
-			    command:		esp_command, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
+#define SCSI_BLZ1230      { .proc_name		= "esp-blz1230", \
+			    .proc_info		= esp_proc_info, \
+			    .name		= "Blizzard1230 SCSI IV", \
+			    .detect		= blz1230_esp_detect, \
+			    .release		= blz1230_esp_release, \
+			    .command		= esp_command, \
+			    .queuecommand	= esp_queue, \
+			    .abort		= esp_abort, \
+			    .reset		= esp_reset, \
+			    .can_queue          = 7, \
+			    .this_id		= 7, \
+			    .sg_tablesize	= SG_ALL, \
+			    .cmd_per_lun	= 1, \
+			    .use_clustering	= ENABLE_CLUSTERING }
 
 #endif /* BLZ1230_H */
--- linux-2.5.51/drivers/scsi/blz2060.h.old	2002-07-05 18:42:23.000000000 -0500
+++ linux-2.5.51/drivers/scsi/blz2060.h	2002-12-10 14:28:34.000000000 -0600
@@ -53,18 +53,18 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_BLZ2060      { proc_name:		"esp-blz2060", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Blizzard2060 SCSI", \
-			    detect:		blz2060_esp_detect, \
-			    release:		blz2060_esp_release, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
+#define SCSI_BLZ2060      { .proc_name		= "esp-blz2060", \
+			    .proc_info		= esp_proc_info, \
+			    .name		= "Blizzard2060 SCSI", \
+			    .detect		= blz2060_esp_detect, \
+			    .release		= blz2060_esp_release, \
+			    .queuecommand	= esp_queue, \
+			    .abort		= esp_abort, \
+			    .reset		= esp_reset, \
+			    .can_queue          = 7, \
+			    .this_id		= 7, \
+			    .sg_tablesize	= SG_ALL, \
+			    .cmd_per_lun	= 1, \
+			    .use_clustering	= ENABLE_CLUSTERING }
 
 #endif /* BLZ2060_H */
--- linux-2.5.51/drivers/scsi/bvme6000.h.old	2002-10-31 16:20:04.000000000 -0600
+++ linux-2.5.51/drivers/scsi/bvme6000.h	2002-12-10 14:28:34.000000000 -0600
@@ -25,15 +25,15 @@
 
 #include <scsi/scsicam.h>
 
-#define BVME6000_SCSI  {name:                "BVME6000 NCR53c710 SCSI", \
-		       detect:              bvme6000_scsi_detect,    \
-		       queuecommand:        NCR53c7xx_queue_command, \
-		       abort:               NCR53c7xx_abort,   \
-		       reset:               NCR53c7xx_reset,   \
-		       can_queue:           24,       \
-		       this_id:             7,               \
-		       sg_tablesize:        63,          \
-		       cmd_per_lun:	    3,     \
-		       use_clustering:      DISABLE_CLUSTERING }
+#define BVME6000_SCSI  {.name                = "BVME6000 NCR53c710 SCSI", \
+		       .detect              = bvme6000_scsi_detect,    \
+		       .queuecommand        = NCR53c7xx_queue_command, \
+		       .abort               = NCR53c7xx_abort,   \
+		       .reset               = NCR53c7xx_reset,   \
+		       .can_queue           = 24,       \
+		       .this_id             = 7,               \
+		       .sg_tablesize        = 63,          \
+		       .cmd_per_lun	    = 3,     \
+		       .use_clustering      = DISABLE_CLUSTERING }
 
 #endif /* BVME6000_SCSI_H */
--- linux-2.5.51/drivers/scsi/cpqfcTS.h.old	2002-10-31 16:20:04.000000000 -0600
+++ linux-2.5.51/drivers/scsi/cpqfcTS.h	2002-12-10 14:28:33.000000000 -0600
@@ -21,22 +21,22 @@
 // limited only by available physical memory) we use SG_ALL.
 
 #define CPQFCTS {                                \
- detect:                 cpqfcTS_detect,         \
- release:                cpqfcTS_release,        \
- info:                   cpqfcTS_info,           \
- proc_info:              cpqfcTS_proc_info,      \
- ioctl:                  cpqfcTS_ioctl,          \
- queuecommand:           cpqfcTS_queuecommand,   \
- eh_device_reset_handler:   cpqfcTS_eh_device_reset,   \
- eh_abort_handler:       cpqfcTS_eh_abort,       \
- bios_param:             cpqfcTS_biosparam,      \
- can_queue:              CPQFCTS_REQ_QUEUE_LEN,  \
- this_id:                -1,                     \
- sg_tablesize:           SG_ALL,                 \
- cmd_per_lun:            CPQFCTS_CMD_PER_LUN,    \
- present:                0,                      \
- unchecked_isa_dma:      0,                      \
- use_clustering:         ENABLE_CLUSTERING,      \
+ .detect                 = cpqfcTS_detect,         \
+ .release                = cpqfcTS_release,        \
+ .info                   = cpqfcTS_info,           \
+ .proc_info              = cpqfcTS_proc_info,      \
+ .ioctl                  = cpqfcTS_ioctl,          \
+ .queuecommand           = cpqfcTS_queuecommand,   \
+ .eh_device_reset_handler   = cpqfcTS_eh_device_reset,   \
+ .eh_abort_handler       = cpqfcTS_eh_abort,       \
+ .bios_param             = cpqfcTS_biosparam,      \
+ .can_queue              = CPQFCTS_REQ_QUEUE_LEN,  \
+ .this_id                = -1,                     \
+ .sg_tablesize           = SG_ALL,                 \
+ .cmd_per_lun            = CPQFCTS_CMD_PER_LUN,    \
+ .present                = 0,                      \
+ .unchecked_isa_dma      = 0,                      \
+ .use_clustering         = ENABLE_CLUSTERING,      \
 }
 
 #endif /* CPQFCTS_H */ 
--- linux-2.5.51/drivers/scsi/cyberstorm.h.old	2002-07-05 18:42:14.000000000 -0500
+++ linux-2.5.51/drivers/scsi/cyberstorm.h	2002-12-10 14:28:33.000000000 -0600
@@ -56,18 +56,18 @@
 			 int hostno, int inout);
 
 
-#define SCSI_CYBERSTORM   { proc_name:		"esp-cyberstorm", \
-			    proc_info:		esp_proc_info, \
-			    name:		"CyberStorm SCSI", \
-			    detect:		cyber_esp_detect, \
-			    release:		cyber_esp_release, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
+#define SCSI_CYBERSTORM   { .proc_name		= "esp-cyberstorm", \
+			    .proc_info		= esp_proc_info, \
+			    .name		= "CyberStorm SCSI", \
+			    .detect		= cyber_esp_detect, \
+			    .release		= cyber_esp_release, \
+			    .queuecommand	= esp_queue, \
+			    .abort		= esp_abort, \
+			    .reset		= esp_reset, \
+			    .can_queue          = 7, \
+			    .this_id		= 7, \
+			    .sg_tablesize	= SG_ALL, \
+			    .cmd_per_lun	= 1, \
+			    .use_clustering	= ENABLE_CLUSTERING }
 
 #endif /* CYBER_ESP_H */
--- linux-2.5.51/drivers/scsi/cyberstormII.h.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.51/drivers/scsi/cyberstormII.h	2002-12-10 14:28:33.000000000 -0600
@@ -43,18 +43,18 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_CYBERSTORMII { proc_name:		"esp-cyberstormII", \
-			    proc_info:		esp_proc_info, \
-			    name:		"CyberStorm Mk II SCSI", \
-			    detect:		cyberII_esp_detect, \
-			    release:		cyberII_esp_release, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
+#define SCSI_CYBERSTORMII { .proc_name		= "esp-cyberstormII", \
+			    .proc_info		= esp_proc_info, \
+			    .name		= "CyberStorm Mk II SCSI", \
+			    .detect		= cyberII_esp_detect, \
+			    .release		= cyberII_esp_release, \
+			    .queuecommand	= esp_queue, \
+			    .abort		= esp_abort, \
+			    .reset		= esp_reset, \
+			    .can_queue          = 7, \
+			    .this_id		= 7, \
+			    .sg_tablesize	= SG_ALL, \
+			    .cmd_per_lun	= 1, \
+			    .use_clustering	= ENABLE_CLUSTERING }
 
 #endif /* CYBERII_ESP_H */
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
