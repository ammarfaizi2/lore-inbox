Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSLLOAT>; Thu, 12 Dec 2002 09:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbSLLOAT>; Thu, 12 Dec 2002 09:00:19 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:63759 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S264643AbSLLN7y>; Thu, 12 Dec 2002 08:59:54 -0500
Date: Thu, 12 Dec 2002 08:07:36 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/scsi (3 of 4)
Message-ID: <20021212140736.GE1794@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here are yet more patches for converting drivers/scsi to C99
initializers. The patches are against 2.5.51.

Art Haas

--- linux-2.5.51/drivers/scsi/jazz_esp.h.old	2002-07-05 18:42:37.000000000 -0500
+++ linux-2.5.51/drivers/scsi/jazz_esp.h	2002-12-10 14:28:34.000000000 -0600
@@ -21,19 +21,19 @@
 			 int hostno, int inout);
 
 #define SCSI_JAZZ_ESP {                                         \
-		proc_name:      "esp",				\
-		proc_info:      &esp_proc_info,			\
-		name:           "ESP 100/100a/200",		\
-		detect:         jazz_esp_detect,		\
-		info:           esp_info,			\
-		command:        esp_command,			\
-		queuecommand:   esp_queue,			\
-		abort:          esp_abort,			\
-		reset:          esp_reset,			\
-		can_queue:      7,				\
-		this_id:        7,				\
-		sg_tablesize:   SG_ALL,				\
-		cmd_per_lun:    1,				\
-		use_clustering: DISABLE_CLUSTERING, }
+		.proc_name      = "esp",				\
+		.proc_info      = &esp_proc_info,			\
+		.name           = "ESP 100/100a/200",		\
+		.detect         = jazz_esp_detect,		\
+		.info           = esp_info,			\
+		.command        = esp_command,			\
+		.queuecommand   = esp_queue,			\
+		.abort          = esp_abort,			\
+		.reset          = esp_reset,			\
+		.can_queue      = 7,				\
+		.this_id        = 7,				\
+		.sg_tablesize   = SG_ALL,				\
+		.cmd_per_lun    = 1,				\
+		.use_clustering = DISABLE_CLUSTERING, }
 
 #endif /* JAZZ_ESP_H */
--- linux-2.5.51/drivers/scsi/lasi700.h.old	2002-07-05 18:42:05.000000000 -0500
+++ linux-2.5.51/drivers/scsi/lasi700.h	2002-12-10 14:28:33.000000000 -0600
@@ -31,34 +31,34 @@
 
 
 #define LASI700_SCSI {				\
-	name:		"LASI SCSI 53c700",	\
-	proc_name:	"lasi700",		\
-	detect:		lasi700_detect,		\
-	release:	lasi700_release,	\
-	this_id:	7,			\
+	.name		= "LASI SCSI 53c700",	\
+	.proc_name	= "lasi700",		\
+	.detect		= lasi700_detect,		\
+	.release	= lasi700_release,	\
+	.this_id	= 7,			\
 }
 
 #define LASI_710_SVERSION	0x082
 #define LASI_700_SVERSION	0x071
 
 #define LASI700_ID_TABLE {			\
-	hw_type:	HPHW_FIO,		\
-	sversion:	LASI_700_SVERSION,	\
-	hversion:	HVERSION_ANY_ID,	\
-	hversion_rev:	HVERSION_REV_ANY_ID,	\
+	.hw_type	= HPHW_FIO,		\
+	.sversion	= LASI_700_SVERSION,	\
+	.hversion	= HVERSION_ANY_ID,	\
+	.hversion_rev	= HVERSION_REV_ANY_ID,	\
 }
 
 #define LASI710_ID_TABLE {			\
-	hw_type:	HPHW_FIO,		\
-	sversion:	LASI_710_SVERSION,	\
-	hversion:	HVERSION_ANY_ID,	\
-	hversion_rev:	HVERSION_REV_ANY_ID,	\
+	.hw_type	= HPHW_FIO,		\
+	.sversion	= LASI_710_SVERSION,	\
+	.hversion	= HVERSION_ANY_ID,	\
+	.hversion_rev	= HVERSION_REV_ANY_ID,	\
 }
 
 #define LASI700_DRIVER {			\
-	name:		"Lasi SCSI",		\
-	id_table:	lasi700_scsi_tbl,	\
-	probe:		lasi700_driver_callback,\
+	.name		= "Lasi SCSI",		\
+	.id_table	= lasi700_scsi_tbl,	\
+	.probe		= lasi700_driver_callback,\
 }
 
 #define LASI700_CLOCK	25
--- linux-2.5.51/drivers/scsi/mac53c94.h.old	2002-07-05 18:42:21.000000000 -0500
+++ linux-2.5.51/drivers/scsi/mac53c94.h	2002-12-10 14:28:33.000000000 -0600
@@ -15,19 +15,19 @@
 int mac53c94_reset(Scsi_Cmnd *, unsigned int);
 
 #define SCSI_MAC53C94 {					\
-	proc_name:	"53c94",			\
-	name:		"53C94",			\
-	detect:		mac53c94_detect,		\
-	release:	mac53c94_release,		\
-	command:	mac53c94_command,		\
-	queuecommand:	mac53c94_queue,			\
-	abort:		mac53c94_abort,			\
-	reset:		mac53c94_reset,			\
-	can_queue:	1,				\
-	this_id:	7,				\
-	sg_tablesize:	SG_ALL,				\
-	cmd_per_lun:	1,				\
-	use_clustering:	DISABLE_CLUSTERING,		\
+	.proc_name	= "53c94",			\
+	.name		= "53C94",			\
+	.detect		= mac53c94_detect,		\
+	.release	= mac53c94_release,		\
+	.command	= mac53c94_command,		\
+	.queuecommand	= mac53c94_queue,			\
+	.abort		= mac53c94_abort,			\
+	.reset		= mac53c94_reset,			\
+	.can_queue	= 1,				\
+	.this_id	= 7,				\
+	.sg_tablesize	= SG_ALL,				\
+	.cmd_per_lun	= 1,				\
+	.use_clustering	= DISABLE_CLUSTERING,		\
 }
 
 /*
--- linux-2.5.51/drivers/scsi/mac_esp.h.old	2002-07-05 18:42:22.000000000 -0500
+++ linux-2.5.51/drivers/scsi/mac_esp.h	2002-12-10 14:28:33.000000000 -0600
@@ -21,20 +21,20 @@
 extern int esp_reset(Scsi_Cmnd *, unsigned int);
 
 
-#define SCSI_MAC_ESP      { proc_name:		"esp", \
-			    name:		"Mac 53C9x SCSI", \
-			    detect:		mac_esp_detect, \
-			    release:		NULL, \
-			    info:		esp_info, \
+#define SCSI_MAC_ESP      { .proc_name		= "esp", \
+			    .name		= "Mac 53C9x SCSI", \
+			    .detect		= mac_esp_detect, \
+			    .release		= NULL, \
+			    .info		= esp_info, \
 			    /* command:		esp_command, */ \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	DISABLE_CLUSTERING }
+			    .queuecommand	= esp_queue, \
+			    .abort		= esp_abort, \
+			    .reset		= esp_reset, \
+			    .can_queue          = 7, \
+			    .this_id		= 7, \
+			    .sg_tablesize	= SG_ALL, \
+			    .cmd_per_lun	= 1, \
+			    .use_clustering	= DISABLE_CLUSTERING }
 
 #endif /* MAC_ESP_H */
 
--- linux-2.5.51/drivers/scsi/mac_scsi.h.old	2002-10-31 16:20:05.000000000 -0600
+++ linux-2.5.51/drivers/scsi/mac_scsi.h	2002-12-10 14:28:34.000000000 -0600
@@ -65,19 +65,19 @@
 #include <scsi/scsicam.h>
 
 #define MAC_NCR5380 {						\
-name:			"Macintosh NCR5380 SCSI",			\
-detect:			macscsi_detect,					\
-release:		macscsi_release,	/* Release */		\
-info:			macscsi_info,					\
-queuecommand:		macscsi_queue_command,				\
-abort:			macscsi_abort,			 		\
-reset:			macscsi_reset,					\
-can_queue:		CAN_QUEUE,		/* can queue */		\
-this_id:		7,			/* id */		\
-sg_tablesize:		SG_ALL,			/* sg_tablesize */	\
-cmd_per_lun:		CMD_PER_LUN,		/* cmd per lun */	\
-unchecked_isa_dma:	0,			/* unchecked_isa_dma */	\
-use_clustering:		DISABLE_CLUSTERING				\
+.name			= "Macintosh NCR5380 SCSI",			\
+.detect			= macscsi_detect,					\
+.release		= macscsi_release,	/* Release */		\
+.info			= macscsi_info,					\
+.queuecommand		= macscsi_queue_command,				\
+.abort			= macscsi_abort,			 		\
+.reset			= macscsi_reset,					\
+.can_queue		= CAN_QUEUE,		/* can queue */		\
+.this_id		= 7,			/* id */		\
+.sg_tablesize		= SG_ALL,			/* sg_tablesize */	\
+.cmd_per_lun		= CMD_PER_LUN,		/* cmd per lun */	\
+.unchecked_isa_dma	= 0,			/* unchecked_isa_dma */	\
+.use_clustering		= DISABLE_CLUSTERING				\
 	}
 
 #ifndef HOSTS_C
--- linux-2.5.51/drivers/scsi/mca_53c9x.h.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.51/drivers/scsi/mca_53c9x.h	2002-12-10 14:28:33.000000000 -0600
@@ -31,18 +31,18 @@
 			 int hostno, int inout);
 
 
-#define MCA_53C9X         { proc_name:		"esp", \
-			    name:		"NCR 53c9x SCSI", \
-			    detect:		mca_esp_detect, \
-			    release:		mca_esp_release, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-                            unchecked_isa_dma:  1, \
-			    use_clustering:	DISABLE_CLUSTERING }
+#define MCA_53C9X         { .proc_name		= "esp", \
+			    .name		= "NCR 53c9x SCSI", \
+			    .detect		= mca_esp_detect, \
+			    .release		= mca_esp_release, \
+			    .queuecommand	= esp_queue, \
+			    .abort		= esp_abort, \
+			    .reset		= esp_reset, \
+			    .can_queue          = 7, \
+			    .sg_tablesize	= SG_ALL, \
+			    .cmd_per_lun	= 1, \
+                            .unchecked_isa_dma  = 1, \
+			    .use_clustering	= DISABLE_CLUSTERING }
 
 /* Ports the ncr's 53c94 can be put at; indexed by pos register value */
 
--- linux-2.5.51/drivers/scsi/megaraid.h.old	2002-11-29 09:24:19.000000000 -0600
+++ linux-2.5.51/drivers/scsi/megaraid.h	2002-12-10 14:28:34.000000000 -0600
@@ -207,22 +207,22 @@
 #else
 #define MEGARAID \
   {\
-    name:	    	"MegaRAID",		/* Driver Name			*/\
-    proc_info:		megaraid_proc_info,     /* /proc driver info		*/\
-    detect:		megaraid_detect,	/* Detect Host Adapter		*/\
-    release:	  	megaraid_release,	/* Release Host Adapter		*/\
-    info:	     	megaraid_info,	   	/* Driver Info Function		*/\
-    command:	  	megaraid_command,	/* Command Function		*/\
-    queuecommand:  	megaraid_queue,		/* Queue Command Function	*/\
-    bios_param:     	megaraid_biosparam, 	/* Disk BIOS Parameters		*/\
-    can_queue:		MAX_COMMANDS,	    	/* Can Queue			*/\
-    this_id:	  	7,		       	/* HBA Target ID		*/\
-    sg_tablesize:   	MAX_SGLIST,	  	/* Scatter/Gather Table Size	*/\
-    cmd_per_lun:    	MAX_CMD_PER_LUN,	/* SCSI Commands per LUN	*/\
-    present:	  	0,		       	/* Present			*/\
-    unchecked_isa_dma:	0,		       	/* Default Unchecked ISA DMA	*/\
-    use_clustering:   	ENABLE_CLUSTERING,  	/* Enable Clustering		*/\
-	highmem_io:		1,													\
+    .name	    	= "MegaRAID",		/* Driver Name			*/\
+    .proc_info		= megaraid_proc_info,     /* /proc driver info		*/\
+    .detect		= megaraid_detect,	/* Detect Host Adapter		*/\
+    .release	  	= megaraid_release,	/* Release Host Adapter		*/\
+    .info	     	= megaraid_info,	   	/* Driver Info Function		*/\
+    .command	  	= megaraid_command,	/* Command Function		*/\
+    .queuecommand  	= megaraid_queue,		/* Queue Command Function	*/\
+    .bios_param     	= megaraid_biosparam, 	/* Disk BIOS Parameters		*/\
+    .can_queue		= MAX_COMMANDS,	    	/* Can Queue			*/\
+    .this_id	  	= 7,		       	/* HBA Target ID		*/\
+    .sg_tablesize   	= MAX_SGLIST,	  	/* Scatter/Gather Table Size	*/\
+    .cmd_per_lun    	= MAX_CMD_PER_LUN,	/* SCSI Commands per LUN	*/\
+    .present	  	= 0,		       	/* Present			*/\
+    .unchecked_isa_dma	= 0,		       	/* Default Unchecked ISA DMA	*/\
+    .use_clustering   	= ENABLE_CLUSTERING,  	/* Enable Clustering		*/\
+	.highmem_io		= 1,													\
   }
 #endif
 
--- linux-2.5.51/drivers/scsi/mesh.h.old	2002-07-05 18:42:18.000000000 -0500
+++ linux-2.5.51/drivers/scsi/mesh.h	2002-12-10 14:28:33.000000000 -0600
@@ -14,21 +14,21 @@
 int mesh_host_reset(Scsi_Cmnd *);
 
 #define SCSI_MESH {						\
-	proc_name:			"mesh",			\
-	name:				"MESH",			\
-	detect:				mesh_detect,		\
-	release:			mesh_release,		\
-	command:			NULL,			\
-	queuecommand:			mesh_queue,		\
-	eh_abort_handler:		mesh_abort,		\
-	eh_device_reset_handler:	NULL,			\
-	eh_bus_reset_handler:		NULL,			\
-	eh_host_reset_handler:		mesh_host_reset,	\
-	can_queue:			20,			\
-	this_id:			7,			\
-	sg_tablesize:			SG_ALL,			\
-	cmd_per_lun:			2,			\
-	use_clustering:			DISABLE_CLUSTERING,	\
+	.proc_name			= "mesh",			\
+	.name				= "MESH",			\
+	.detect				= mesh_detect,		\
+	.release			= mesh_release,		\
+	.command			= NULL,			\
+	.queuecommand			= mesh_queue,		\
+	.eh_abort_handler		= mesh_abort,		\
+	.eh_device_reset_handler	= NULL,			\
+	.eh_bus_reset_handler		= NULL,			\
+	.eh_host_reset_handler		= mesh_host_reset,	\
+	.can_queue			= 20,			\
+	.this_id			= 7,			\
+	.sg_tablesize			= SG_ALL,			\
+	.cmd_per_lun			= 2,			\
+	.use_clustering			= DISABLE_CLUSTERING,	\
 }
 
 /*
--- linux-2.5.51/drivers/scsi/mvme147.h.old	2002-07-05 18:42:04.000000000 -0500
+++ linux-2.5.51/drivers/scsi/mvme147.h	2002-12-10 14:28:33.000000000 -0600
@@ -31,19 +31,19 @@
 
 #ifdef HOSTS_C
 
-#define MVME147_SCSI {proc_name:	   "MVME147",			\
-		      proc_info:           NULL,			\
-		      name:                "MVME147 built-in SCSI",	\
-		      detect:              mvme147_detect,		\
-		      release:             mvme147_release,		\
-		      queuecommand:        wd33c93_queuecommand,	\
-		      abort:               wd33c93_abort,		\
-		      reset:               wd33c93_reset,		\
-		      can_queue:           CAN_QUEUE,			\
-		      this_id:             7,				\
-		      sg_tablesize:        SG_ALL,			\
-		      cmd_per_lun:	   CMD_PER_LUN,			\
-		      use_clustering:      ENABLE_CLUSTERING }
+#define MVME147_SCSI {.proc_name	   = "MVME147",			\
+		      .proc_info           = NULL,			\
+		      .name                = "MVME147 built-in SCSI",	\
+		      .detect              = mvme147_detect,		\
+		      .release             = mvme147_release,		\
+		      .queuecommand        = wd33c93_queuecommand,	\
+		      .abort               = wd33c93_abort,		\
+		      .reset               = wd33c93_reset,		\
+		      .can_queue           = CAN_QUEUE,			\
+		      .this_id             = 7,				\
+		      .sg_tablesize        = SG_ALL,			\
+		      .cmd_per_lun	   = CMD_PER_LUN,			\
+		      .use_clustering      = ENABLE_CLUSTERING }
 
 #endif /* else def HOSTS_C */
 
--- linux-2.5.51/drivers/scsi/mvme16x.h.old	2002-10-31 16:20:05.000000000 -0600
+++ linux-2.5.51/drivers/scsi/mvme16x.h	2002-12-10 14:28:34.000000000 -0600
@@ -25,15 +25,15 @@
 
 #include <scsi/scsicam.h>
 
-#define MVME16x_SCSI  {name:                "MVME16x NCR53c710 SCSI", \
-		       detect:              mvme16x_scsi_detect,    \
-		       queuecommand:        NCR53c7xx_queue_command, \
-		       abort:               NCR53c7xx_abort,   \
-		       reset:               NCR53c7xx_reset,   \
-		       can_queue:           24,       \
-		       this_id:             7,               \
-		       sg_tablesize:        63,          \
-		       cmd_per_lun:	    3,     \
-		       use_clustering:      DISABLE_CLUSTERING }
+#define MVME16x_SCSI  {.name                = "MVME16x NCR53c710 SCSI", \
+		       .detect              = mvme16x_scsi_detect,    \
+		       .queuecommand        = NCR53c7xx_queue_command, \
+		       .abort               = NCR53c7xx_abort,   \
+		       .reset               = NCR53c7xx_reset,   \
+		       .can_queue           = 24,       \
+		       .this_id             = 7,               \
+		       .sg_tablesize        = 63,          \
+		       .cmd_per_lun	    = 3,     \
+		       .use_clustering      = DISABLE_CLUSTERING }
 
 #endif /* MVME16x_SCSI_H */
--- linux-2.5.51/drivers/scsi/ncr53c8xx.h.old	2002-11-29 09:24:19.000000000 -0600
+++ linux-2.5.51/drivers/scsi/ncr53c8xx.h	2002-12-10 14:28:33.000000000 -0600
@@ -70,19 +70,19 @@
 
 #if	LINUX_VERSION_CODE >= LinuxVersionCode(2,1,75)
 
-#define NCR53C8XX {     name:           "",			\
-			detect:         ncr53c8xx_detect,	\
-			release:        ncr53c8xx_release,	\
-			info:           ncr53c8xx_info, 	\
-			queuecommand:   ncr53c8xx_queue_command,\
-			slave_configure:ncr53c8xx_slave_configure,\
-			abort:          ncr53c8xx_abort,	\
-			reset:          ncr53c8xx_reset,	\
-			can_queue:      SCSI_NCR_CAN_QUEUE,	\
-			this_id:        7,			\
-			sg_tablesize:   SCSI_NCR_SG_TABLESIZE,	\
-			cmd_per_lun:    SCSI_NCR_CMD_PER_LUN,	\
-			use_clustering: DISABLE_CLUSTERING} 
+#define NCR53C8XX {     .name           = "",			\
+			.detect         = ncr53c8xx_detect,	\
+			.release        = ncr53c8xx_release,	\
+			.info           = ncr53c8xx_info, 	\
+			.queuecommand   = ncr53c8xx_queue_command,\
+			.slave_configure = ncr53c8xx_slave_configure,\
+			.abort          = ncr53c8xx_abort,	\
+			.reset          = ncr53c8xx_reset,	\
+			.can_queue      = SCSI_NCR_CAN_QUEUE,	\
+			.this_id        = 7,			\
+			.sg_tablesize   = SCSI_NCR_SG_TABLESIZE,	\
+			.cmd_per_lun    = SCSI_NCR_CMD_PER_LUN,	\
+			.use_clustering = DISABLE_CLUSTERING} 
 
 #else
 
--- linux-2.5.51/drivers/scsi/oktagon_esp.h.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.51/drivers/scsi/oktagon_esp.h	2002-12-10 14:28:33.000000000 -0600
@@ -40,18 +40,18 @@
 			int hostno, int inout);
 
 #define SCSI_OKTAGON_ESP {                       \
-   proc_name:           "esp-oktagon",           \
-   proc_info:           &esp_proc_info,          \
-   name:                "BSC Oktagon SCSI",      \
-   detect:              oktagon_esp_detect,      \
-   release:             oktagon_esp_release,     \
-   queuecommand:        esp_queue,               \
-   abort:               esp_abort,               \
-   reset:               esp_reset,               \
-   can_queue:           7,                       \
-   this_id:             7,                       \
-   sg_tablesize:        SG_ALL,                  \
-   cmd_per_lun:         1,                       \
-   use_clustering:      ENABLE_CLUSTERING }
+   .proc_name           = "esp-oktagon",           \
+   .proc_info           = &esp_proc_info,          \
+   .name                = "BSC Oktagon SCSI",      \
+   .detect              = oktagon_esp_detect,      \
+   .release             = oktagon_esp_release,     \
+   .queuecommand        = esp_queue,               \
+   .abort               = esp_abort,               \
+   .reset               = esp_reset,               \
+   .can_queue           = 7,                       \
+   .this_id             = 7,                       \
+   .sg_tablesize        = SG_ALL,                  \
+   .cmd_per_lun         = 1,                       \
+   .use_clustering      = ENABLE_CLUSTERING }
 
 #endif /* OKTAGON_ESP_H */
--- linux-2.5.51/drivers/scsi/pas16.h.old	2002-10-31 16:20:06.000000000 -0600
+++ linux-2.5.51/drivers/scsi/pas16.h	2002-12-10 14:28:34.000000000 -0600
@@ -144,19 +144,19 @@
  */
 
 #define MV_PAS16 {					\
-	name:           "Pro Audio Spectrum-16 SCSI", 	\
-	detect:         pas16_detect, 			\
-	queuecommand:   pas16_queue_command,		\
-	eh_abort_handler: pas16_abort,			\
-	eh_bus_reset_handler: pas16_bus_reset,		\
-	eh_device_reset_handler: pas16_device_reset,	\
-	eh_host_reset_handler: pas16_host_reset,	\
-	bios_param:     pas16_biosparam, 		\
-	can_queue:      CAN_QUEUE,			\
-	this_id:        7,				\
-	sg_tablesize:   SG_ALL,				\
-	cmd_per_lun:    CMD_PER_LUN ,			\
-	use_clustering: DISABLE_CLUSTERING}
+	.name           = "Pro Audio Spectrum-16 SCSI", 	\
+	.detect         = pas16_detect, 			\
+	.queuecommand   = pas16_queue_command,		\
+	.eh_abort_handler = pas16_abort,			\
+	.eh_bus_reset_handler = pas16_bus_reset,		\
+	.eh_device_reset_handler = pas16_device_reset,	\
+	.eh_host_reset_handler = pas16_host_reset,	\
+	.bios_param     = pas16_biosparam, 		\
+	.can_queue      = CAN_QUEUE,			\
+	.this_id        = 7,				\
+	.sg_tablesize   = SG_ALL,				\
+	.cmd_per_lun    = CMD_PER_LUN ,			\
+	.use_clustering = DISABLE_CLUSTERING}
 
 #ifndef HOSTS_C
 
--- linux-2.5.51/drivers/scsi/pci2000.h.old	2002-10-31 16:20:06.000000000 -0600
+++ linux-2.5.51/drivers/scsi/pci2000.h	2002-12-10 14:28:33.000000000 -0600
@@ -203,22 +203,22 @@
 
 /* screen is 80 columns wide, damnit! */
 #define PCI2000 {				\
-	proc_name:	"pci2000",					\
-	name:		"PCI-2000 SCSI Intelligent Disk Controller",	\
-	detect:		Pci2000_Detect,					\
-	release:	Pci2000_Release,				\
-	command:	Pci2000_Command,				\
-	queuecommand:	Pci2000_QueueCommand,				\
-	abort:		Pci2000_Abort,					\
-	reset:		Pci2000_Reset,					\
-	bios_param:	Pci2000_BiosParam,				\
-	can_queue:	16,						\
-	this_id:	-1,						\
-	sg_tablesize:	16,						\
-	cmd_per_lun:	1,						\
-	present:	0,						\
-	unchecked_isa_dma:0,						\
-	use_clustering:	DISABLE_CLUSTERING,				\
+	.proc_name	= "pci2000",					\
+	.name		= "PCI-2000 SCSI Intelligent Disk Controller",	\
+	.detect		= Pci2000_Detect,					\
+	.release	= Pci2000_Release,				\
+	.command	= Pci2000_Command,				\
+	.queuecommand	= Pci2000_QueueCommand,				\
+	.abort		= Pci2000_Abort,					\
+	.reset		= Pci2000_Reset,					\
+	.bios_param	= Pci2000_BiosParam,				\
+	.can_queue	= 16,						\
+	.this_id	= -1,						\
+	.sg_tablesize	= 16,						\
+	.cmd_per_lun	= 1,						\
+	.present	= 0,						\
+	.unchecked_isa_dma = 0,						\
+	.use_clustering	= DISABLE_CLUSTERING,				\
 }
 
 #endif
--- linux-2.5.51/drivers/scsi/pci2220i.h.old	2002-10-31 16:20:06.000000000 -0600
+++ linux-2.5.51/drivers/scsi/pci2220i.h	2002-12-10 14:28:34.000000000 -0600
@@ -42,21 +42,21 @@
 #endif
 
 #define PCI2220I {					\
-	proc_name:		"pci2220i",		\
-	name:			"PCI-2220I/PCI-2240I",	\
-	detect:			Pci2220i_Detect,	\
-	release:		Pci2220i_Release,	\
-	command:		Pci2220i_Command,	\
-	queuecommand:		Pci2220i_QueueCommand,	\
-	abort:			Pci2220i_Abort,		\
-	reset:			Pci2220i_Reset,		\
-	bios_param:		Pci2220i_BiosParam,	\
-	can_queue:		1,			\
-	this_id:		-1,			\
-	sg_tablesize:		SG_ALL,			\
-	cmd_per_lun:		1,			\
-	present:		0,			\
-	unchecked_isa_dma:	0,			\
-	use_clustering:		DISABLE_CLUSTERING,	\
+	.proc_name		= "pci2220i",		\
+	.name			= "PCI-2220I/PCI-2240I",	\
+	.detect			= Pci2220i_Detect,	\
+	.release		= Pci2220i_Release,	\
+	.command		= Pci2220i_Command,	\
+	.queuecommand		= Pci2220i_QueueCommand,	\
+	.abort			= Pci2220i_Abort,		\
+	.reset			= Pci2220i_Reset,		\
+	.bios_param		= Pci2220i_BiosParam,	\
+	.can_queue		= 1,			\
+	.this_id		= -1,			\
+	.sg_tablesize		= SG_ALL,			\
+	.cmd_per_lun		= 1,			\
+	.present		= 0,			\
+	.unchecked_isa_dma	= 0,			\
+	.use_clustering		= DISABLE_CLUSTERING,	\
 }
 #endif
--- linux-2.5.51/drivers/scsi/pluto.h.old	2002-11-29 09:24:20.000000000 -0600
+++ linux-2.5.51/drivers/scsi/pluto.h	2002-12-10 14:28:34.000000000 -0600
@@ -44,21 +44,21 @@
 int pluto_slave_configure(Scsi_Device *);
 
 #define PLUTO {							\
-	name:			"Sparc Storage Array 100/200",	\
-	detect:			pluto_detect,			\
-	release:		pluto_release,			\
-	info:			pluto_info,			\
-	queuecommand:		fcp_scsi_queuecommand,		\
-	slave_configure:	pluto_slave_configure,		\
-	can_queue:		PLUTO_CAN_QUEUE,		\
-	this_id:		-1,				\
-	sg_tablesize:		1,				\
-	cmd_per_lun:		1,				\
-	use_clustering:		ENABLE_CLUSTERING,		\
-	eh_abort_handler:	fcp_scsi_abort,			\
-	eh_device_reset_handler:fcp_scsi_dev_reset,		\
-	eh_bus_reset_handler:	fcp_scsi_bus_reset,		\
-	eh_host_reset_handler:	fcp_scsi_host_reset,		\
+	.name			= "Sparc Storage Array 100/200",	\
+	.detect			= pluto_detect,			\
+	.release		= pluto_release,			\
+	.info			= pluto_info,			\
+	.queuecommand		= fcp_scsi_queuecommand,		\
+	.slave_configure	= pluto_slave_configure,		\
+	.can_queue		= PLUTO_CAN_QUEUE,		\
+	.this_id		= -1,				\
+	.sg_tablesize		= 1,				\
+	.cmd_per_lun		= 1,				\
+	.use_clustering		= ENABLE_CLUSTERING,		\
+	.eh_abort_handler	= fcp_scsi_abort,			\
+	.eh_device_reset_handler = fcp_scsi_dev_reset,		\
+	.eh_bus_reset_handler	= fcp_scsi_bus_reset,		\
+	.eh_host_reset_handler	= fcp_scsi_host_reset,		\
 }	
 
 #endif /* !(_PLUTO_H) */
--- linux-2.5.51/drivers/scsi/ppa.h.old	2002-10-31 16:20:07.000000000 -0600
+++ linux-2.5.51/drivers/scsi/ppa.h	2002-12-10 14:28:33.000000000 -0600
@@ -171,21 +171,21 @@
 int ppa_biosparam(struct scsi_device *, struct block_device *,
 		sector_t, int *);
 
-#define PPA {	proc_name:			"ppa",		\
-		proc_info:			ppa_proc_info,		\
-		name:				"Iomega VPI0 (ppa) interface",\
-		detect:				ppa_detect,		\
-		release:			ppa_release,		\
-		command:			ppa_command,		\
-		queuecommand:			ppa_queuecommand,	\
-		eh_abort_handler:		ppa_abort,		\
-		eh_device_reset_handler:	NULL,			\
-		eh_bus_reset_handler:		ppa_reset,		\
-		eh_host_reset_handler:		ppa_reset,		\
-		bios_param:			ppa_biosparam,		\
-		this_id:			-1,			\
-		sg_tablesize:			SG_ALL,			\
-		cmd_per_lun:			1,			\
-		use_clustering:			ENABLE_CLUSTERING	\
+#define PPA {	.proc_name			= "ppa",		\
+		.proc_info			= ppa_proc_info,		\
+		.name				= "Iomega VPI0 (ppa) interface",\
+		.detect				= ppa_detect,		\
+		.release			= ppa_release,		\
+		.command			= ppa_command,		\
+		.queuecommand			= ppa_queuecommand,	\
+		.eh_abort_handler		= ppa_abort,		\
+		.eh_device_reset_handler	= NULL,			\
+		.eh_bus_reset_handler		= ppa_reset,		\
+		.eh_host_reset_handler		= ppa_reset,		\
+		.bios_param			= ppa_biosparam,		\
+		.this_id			= -1,			\
+		.sg_tablesize			= SG_ALL,			\
+		.cmd_per_lun			= 1,			\
+		.use_clustering			= ENABLE_CLUSTERING	\
 }
 #endif				/* _PPA_H */
--- linux-2.5.51/drivers/scsi/psi240i.h.old	2002-10-31 16:20:07.000000000 -0600
+++ linux-2.5.51/drivers/scsi/psi240i.h	2002-12-10 14:28:33.000000000 -0600
@@ -321,18 +321,18 @@
 	#define NULL 0
 #endif
 
-#define PSI240I { proc_name:      "psi240i", \
-		  name:           "PSI-240I EIDE Disk Controller",\
-		  detect:         Psi240i_Detect,			\
-		  command:	  Psi240i_Command,			\
-		  queuecommand:	  Psi240i_QueueCommand,		\
-		  abort:	  Psi240i_Abort,			\
-		  reset:	  Psi240i_Reset,			\
-		  bios_param:	  Psi240i_BiosParam,                 	\
-		  can_queue:	  1, 					\
-		  this_id:	  -1, 					\
-		  sg_tablesize:	  SG_NONE,		 		\
-		  cmd_per_lun:	  1, 					\
-		  use_clustering: DISABLE_CLUSTERING }
+#define PSI240I { .proc_name      = "psi240i", \
+		  .name           = "PSI-240I EIDE Disk Controller",\
+		  .detect         = Psi240i_Detect,			\
+		  .command	  = Psi240i_Command,			\
+		  .queuecommand	  = Psi240i_QueueCommand,		\
+		  .abort	  = Psi240i_Abort,			\
+		  .reset	  = Psi240i_Reset,			\
+		  .bios_param	  = Psi240i_BiosParam,                 	\
+		  .can_queue	  = 1, 					\
+		  .this_id	  = -1, 					\
+		  .sg_tablesize	  = SG_NONE,		 		\
+		  .cmd_per_lun	  = 1, 					\
+		  .use_clustering = DISABLE_CLUSTERING }
 
 #endif
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
