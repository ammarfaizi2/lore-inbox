Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbSL0QIy>; Fri, 27 Dec 2002 11:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbSL0QIA>; Fri, 27 Dec 2002 11:08:00 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:16198 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265066AbSL0QEm>; Fri, 27 Dec 2002 11:04:42 -0500
Date: Fri, 27 Dec 2002 17:12:18 +0100
Message-Id: <200212271612.gBRGCInS008165@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k SCSI host templates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move more M68k SCSI host template definitions from the device-specific header
files to the source files:
  - Amiga A3000, A2091/A590, A4000, A4091, GVP II, and WarpEngine SCSI
  - Atari NCR5380 SCSI
  - MVME147, MVME16x, and BVME6000 SCSI
  - Mac NCR5380 SCSI
  - Sun-3/3x OBIO and VME SCSI

--- linux-2.5.53/drivers/scsi/a2091.c	Fri Dec 27 14:17:35 2002
+++ linux-m68k-2.5.53/drivers/scsi/a2091.c	Wed Nov 20 11:36:29 2002
@@ -231,7 +231,21 @@
 
 #define HOSTS_C
 
-static Scsi_Host_Template driver_template = A2091_SCSI;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "A2901",
+	.name			= "Commodore A2091/A590 SCSI",
+	.detect			= a2091_detect,
+	.release		= a2091_release,
+	.queuecommand		= wd33c93_queuecommand,
+	.abort			= wd33c93_abort,
+	.reset			= wd33c93_reset,
+	.can_queue		= CAN_QUEUE,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= CMD_PER_LUN,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.53/drivers/scsi/a2091.h	Fri Dec 20 11:42:34 2002
+++ linux-m68k-2.5.53/drivers/scsi/a2091.h	Fri Dec 20 14:27:06 2002
@@ -30,19 +30,6 @@
 #define CAN_QUEUE 16
 #endif
 
-#define A2091_SCSI {  .proc_name	   = "A2901", \
-		      .name                = "Commodore A2091/A590 SCSI", \
-		      .detect              = a2091_detect,    \
-		      .release             = a2091_release,   \
-		      .queuecommand        = wd33c93_queuecommand, \
-		      .abort               = wd33c93_abort,   \
-		      .reset               = wd33c93_reset,   \
-		      .can_queue           = CAN_QUEUE,       \
-		      .this_id             = 7,               \
-		      .sg_tablesize        = SG_ALL,          \
-		      .cmd_per_lun	   = CMD_PER_LUN,     \
-		      .use_clustering      = DISABLE_CLUSTERING }
-
 /*
  * if the transfer address ANDed with this results in a non-zero
  * result, then we can't use DMA.
--- linux-2.5.53/drivers/scsi/a3000.c	Fri Dec 27 14:17:35 2002
+++ linux-m68k-2.5.53/drivers/scsi/a3000.c	Wed Nov 20 11:36:29 2002
@@ -207,7 +207,21 @@
 
 #define HOSTS_C
 
-static Scsi_Host_Template driver_template = _A3000_SCSI;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "A3000",
+	.name			= "Amiga 3000 built-in SCSI",
+	.detect			= a3000_detect,
+	.release		= a3000_release,
+	.queuecommand		= wd33c93_queuecommand,
+	.abort			= wd33c93_abort,
+	.reset			= wd33c93_reset,
+	.can_queue		= CAN_QUEUE,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= CMD_PER_LUN,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.53/drivers/scsi/a3000.h	Fri Dec 20 11:42:34 2002
+++ linux-m68k-2.5.53/drivers/scsi/a3000.h	Fri Dec 20 14:27:46 2002
@@ -30,20 +30,6 @@
 #define CAN_QUEUE 16
 #endif
 
-#define _A3000_SCSI { .proc_name	   = "A3000",			\
-		      .proc_info           = NULL,			\
-		      .name                = "Amiga 3000 built-in SCSI",	\
-		      .detect              = a3000_detect,		\
-		      .release             = a3000_release,		\
-		      .queuecommand        = wd33c93_queuecommand,	\
-		      .abort               = wd33c93_abort,		\
-		      .reset               = wd33c93_reset,		\
-		      .can_queue           = CAN_QUEUE,			\
-		      .this_id             = 7,				\
-		      .sg_tablesize        = SG_ALL,			\
-		      .cmd_per_lun	   = CMD_PER_LUN,			\
-		      .use_clustering      = ENABLE_CLUSTERING }
-
 /*
  * if the transfer address ANDed with this results in a non-zero
  * result, then we can't use DMA.
--- linux-2.5.53/drivers/scsi/amiga7xx.c	Mon May 13 10:55:33 2002
+++ linux-m68k-2.5.53/drivers/scsi/amiga7xx.c	Wed Nov 20 11:36:29 2002
@@ -134,5 +134,18 @@
     return num;
 }
 
-static Scsi_Host_Template driver_template = AMIGA7XX_SCSI;
+static Scsi_Host_Template driver_template = {
+	.name			= "Amiga NCR53c710 SCSI",
+	.detect			= amiga7xx_detect,
+	.queuecommand		= NCR53c7xx_queue_command,
+	.abort			= NCR53c7xx_abort,
+	.reset			= NCR53c7xx_reset,
+	.can_queue		= 24,
+	.this_id		= 7,
+	.sg_tablesize		= 63,
+	.cmd_per_lun		= 3,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
+
 #include "scsi_module.c"
--- linux-2.5.53/drivers/scsi/amiga7xx.h	Fri Dec 20 11:42:34 2002
+++ linux-m68k-2.5.53/drivers/scsi/amiga7xx.h	Fri Dec 20 14:28:14 2002
@@ -24,15 +24,4 @@
 
 #include <scsi/scsicam.h>
 
-#define AMIGA7XX_SCSI {.name                = "Amiga NCR53c710 SCSI", \
-		       .detect              = amiga7xx_detect,    \
-		       .queuecommand        = NCR53c7xx_queue_command, \
-		       .abort               = NCR53c7xx_abort,   \
-		       .reset               = NCR53c7xx_reset,   \
-		       .can_queue           = 24,       \
-		       .this_id             = 7,               \
-		       .sg_tablesize        = 63,          \
-		       .cmd_per_lun	    = 3,     \
-		       .use_clustering      = DISABLE_CLUSTERING }
-
 #endif /* AMIGA7XX_H */
--- linux-2.5.53/drivers/scsi/atari_scsi.c	Fri Dec 27 14:17:42 2002
+++ linux-m68k-2.5.53/drivers/scsi/atari_scsi.c	Wed Nov 20 11:36:29 2002
@@ -1139,7 +1139,23 @@
 
 #include "atari_NCR5380.c"
 
-static Scsi_Host_Template driver_template = ATARI_SCSI;
+static Scsi_Host_Template driver_template = {
+	.proc_info		= atari_scsi_proc_info,
+	.name			= "Atari native SCSI",
+	.detect			= atari_scsi_detect,
+	.release		= atari_scsi_release,
+	.info			= atari_scsi_info,
+	.queuecommand		= atari_scsi_queue_command,
+	.abort			= atari_scsi_abort,
+	.reset			= atari_scsi_reset,
+	.can_queue		= 0, /* initialized at run-time */
+	.this_id		= 0, /* initialized at run-time */
+	.sg_tablesize		= 0, /* initialized at run-time */
+	.cmd_per_lun		= 0, /* initialized at run-time */
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
+
 #include "scsi_module.c"
 
 MODULE_LICENSE("GPL");
--- linux-2.5.53/drivers/scsi/atari_scsi.h	Fri Dec 20 11:42:34 2002
+++ linux-m68k-2.5.53/drivers/scsi/atari_scsi.h	Fri Dec 20 14:28:58 2002
@@ -51,20 +51,6 @@
 #define	DEFAULT_USE_TAGGED_QUEUING	0
 
 
-#define ATARI_SCSI {    .proc_info         = atari_scsi_proc_info,	\
-			.name              = "Atari native SCSI",		\
-			.detect            = atari_scsi_detect,		\
-			.release           = atari_scsi_release,		\
-			.info              = atari_scsi_info,		\
-			.queuecommand      = atari_scsi_queue_command,	\
-			.abort             = atari_scsi_abort,		\
-			.reset             = atari_scsi_reset,		\
-			.can_queue         = 0, /* initialized at run-time */	\
-			.this_id           = 0, /* initialized at run-time */	\
-			.sg_tablesize      = 0, /* initialized at run-time */	\
-			.cmd_per_lun       = 0, /* initialized at run-time */	\
-			.use_clustering	   = DISABLE_CLUSTERING }
-
 #define	NCR5380_implementation_fields	/* none */
 
 #define NCR5380_read(reg)		  atari_scsi_reg_read( reg )
--- linux-2.5.53/drivers/scsi/bvme6000.c	Thu Jul 25 12:53:54 2002
+++ linux-m68k-2.5.53/drivers/scsi/bvme6000.c	Wed Nov 20 11:36:29 2002
@@ -51,5 +51,18 @@
     return 1;
 }
 
-static Scsi_Host_Template driver_template = BVME6000_SCSI;
+static Scsi_Host_Template driver_template = {
+	.name			= "BVME6000 NCR53c710 SCSI",
+	.detect			= bvme6000_scsi_detect,
+	.queuecommand		= NCR53c7xx_queue_command,
+	.abort			= NCR53c7xx_abort,
+	.reset			= NCR53c7xx_reset,
+	.can_queue		= 24,
+	.this_id		= 7,
+	.sg_tablesize		= 63,
+	.cmd_per_lun		= 3,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
+
 #include "scsi_module.c"
--- linux-2.5.53/drivers/scsi/bvme6000.h	Fri Dec 20 11:42:34 2002
+++ linux-m68k-2.5.53/drivers/scsi/bvme6000.h	Fri Dec 20 14:31:43 2002
@@ -25,15 +25,4 @@
 
 #include <scsi/scsicam.h>
 
-#define BVME6000_SCSI  {.name                = "BVME6000 NCR53c710 SCSI", \
-		       .detect              = bvme6000_scsi_detect,    \
-		       .queuecommand        = NCR53c7xx_queue_command, \
-		       .abort               = NCR53c7xx_abort,   \
-		       .reset               = NCR53c7xx_reset,   \
-		       .can_queue           = 24,       \
-		       .this_id             = 7,               \
-		       .sg_tablesize        = 63,          \
-		       .cmd_per_lun	    = 3,     \
-		       .use_clustering      = DISABLE_CLUSTERING }
-
 #endif /* BVME6000_SCSI_H */
--- linux-2.5.53/drivers/scsi/gvp11.c	Fri Dec 27 14:17:35 2002
+++ linux-m68k-2.5.53/drivers/scsi/gvp11.c	Wed Nov 20 11:36:29 2002
@@ -356,7 +356,21 @@
 
 #include "gvp11.h"
 
-static Scsi_Host_Template driver_template = GVP11_SCSI;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "GVP11",
+	.name			= "GVP Series II SCSI",
+	.detect			= gvp11_detect,
+	.release		= gvp11_release,
+	.queuecommand		= wd33c93_queuecommand,
+	.abort			= wd33c93_abort,
+	.reset			= wd33c93_reset,
+	.can_queue		= CAN_QUEUE,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= CMD_PER_LUN,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.53/drivers/scsi/gvp11.h	Fri Dec 20 11:42:34 2002
+++ linux-m68k-2.5.53/drivers/scsi/gvp11.h	Fri Dec 20 14:35:20 2002
@@ -30,21 +30,7 @@
 #define CAN_QUEUE 16
 #endif
 
-#ifdef HOSTS_C
-
-#define GVP11_SCSI {  .proc_name	   = "GVP11", \
-		      .name                = "GVP Series II SCSI", \
-		      .detect              = gvp11_detect,    \
-		      .release             = gvp11_release,   \
-		      .queuecommand        = wd33c93_queuecommand, \
-		      .abort               = wd33c93_abort,   \
-		      .reset               = wd33c93_reset,   \
-		      .can_queue           = CAN_QUEUE,       \
-		      .this_id             = 7,               \
-		      .sg_tablesize        = SG_ALL,          \
-		      .cmd_per_lun	   = CMD_PER_LUN,     \
-		      .use_clustering      = DISABLE_CLUSTERING }
-#else
+#ifndef HOSTS_C
 
 /*
  * if the transfer address ANDed with this results in a non-zero
--- linux-2.5.53/drivers/scsi/mac_NCR5380.c	Fri Dec 27 14:17:42 2002
+++ linux-m68k-2.5.53/drivers/scsi/mac_NCR5380.c	Wed Nov 20 11:36:30 2002
@@ -3117,7 +3117,21 @@
 #endif /* 1 */
 }
 
-static Scsi_Host_Template driver_template = MAC_NCR5380;
+static Scsi_Host_Template driver_template = {
+	.name			= "Macintosh NCR5380 SCSI",
+	.detect			= macscsi_detect,
+	.release		= macscsi_release,
+	.info			= macscsi_info,
+	.queuecommand		= macscsi_queue_command,
+	.abort			= macscsi_abort,
+	.reset			= macscsi_reset,
+	.can_queue		= CAN_QUEUE,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= CMD_PER_LUN,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.53/drivers/scsi/mvme147.c	Fri Dec 27 14:17:35 2002
+++ linux-m68k-2.5.53/drivers/scsi/mvme147.c	Wed Nov 20 11:36:30 2002
@@ -116,7 +116,21 @@
 
 #include "mvme147.h"
 
-static Scsi_Host_Template driver_template = MVME147_SCSI;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "MVME147",
+	.name			= "MVME147 built-in SCSI",
+	.detect			= mvme147_detect,
+	.release		= mvme147_release,
+	.queuecommand		= wd33c93_queuecommand,
+	.abort			= wd33c93_abort,
+	.reset			= wd33c93_reset,
+	.can_queue		= CAN_QUEUE,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= CMD_PER_LUN,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.53/drivers/scsi/mvme147.h	Fri Dec 20 11:42:35 2002
+++ linux-m68k-2.5.53/drivers/scsi/mvme147.h	Fri Dec 20 14:38:40 2002
@@ -29,22 +29,4 @@
 #define CAN_QUEUE 16
 #endif
 
-#ifdef HOSTS_C
-
-#define MVME147_SCSI {.proc_name	   = "MVME147",			\
-		      .proc_info           = NULL,			\
-		      .name                = "MVME147 built-in SCSI",	\
-		      .detect              = mvme147_detect,		\
-		      .release             = mvme147_release,		\
-		      .queuecommand        = wd33c93_queuecommand,	\
-		      .abort               = wd33c93_abort,		\
-		      .reset               = wd33c93_reset,		\
-		      .can_queue           = CAN_QUEUE,			\
-		      .this_id             = 7,				\
-		      .sg_tablesize        = SG_ALL,			\
-		      .cmd_per_lun	   = CMD_PER_LUN,			\
-		      .use_clustering      = ENABLE_CLUSTERING }
-
-#endif /* else def HOSTS_C */
-
 #endif /* MVME147_H */
--- linux-2.5.53/drivers/scsi/mvme16x.c	Thu Jul 25 12:53:56 2002
+++ linux-m68k-2.5.53/drivers/scsi/mvme16x.c	Wed Nov 20 11:36:31 2002
@@ -53,5 +53,18 @@
     return 1;
 }
 
-static Scsi_Host_Template driver_template = MVME16x_SCSI;
+static Scsi_Host_Template driver_template = {
+	.name			= "MVME16x NCR53c710 SCSI",
+	.detect			= mvme16x_scsi_detect,
+	.queuecommand		= NCR53c7xx_queue_command,
+	.abort			= NCR53c7xx_abort,
+	.reset			= NCR53c7xx_reset,
+	.can_queue		= 24,
+	.this_id		= 7,
+	.sg_tablesize		= 63,
+	.cmd_per_lun		= 3,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
+
 #include "scsi_module.c"
--- linux-2.5.53/drivers/scsi/mvme16x.h	Fri Dec 20 11:42:35 2002
+++ linux-m68k-2.5.53/drivers/scsi/mvme16x.h	Fri Dec 20 14:39:02 2002
@@ -25,15 +25,4 @@
 
 #include <scsi/scsicam.h>
 
-#define MVME16x_SCSI  {.name                = "MVME16x NCR53c710 SCSI", \
-		       .detect              = mvme16x_scsi_detect,    \
-		       .queuecommand        = NCR53c7xx_queue_command, \
-		       .abort               = NCR53c7xx_abort,   \
-		       .reset               = NCR53c7xx_reset,   \
-		       .can_queue           = 24,       \
-		       .this_id             = 7,               \
-		       .sg_tablesize        = 63,          \
-		       .cmd_per_lun	    = 3,     \
-		       .use_clustering      = DISABLE_CLUSTERING }
-
 #endif /* MVME16x_SCSI_H */
--- linux-2.5.53/drivers/scsi/sun3_scsi.c	Fri Dec 27 14:17:42 2002
+++ linux-m68k-2.5.53/drivers/scsi/sun3_scsi.c	Wed Nov 20 11:36:31 2002
@@ -615,7 +615,21 @@
 	
 #include "sun3_NCR5380.c"
 
-static Scsi_Host_Template driver_template = SUN3_NCR5380;
+static Scsi_Host_Template driver_template = {
+	.name			= SUN3_SCSI_NAME,
+	.detect			= sun3scsi_detect,
+	.release		= sun3scsi_release,
+	.info			= sun3scsi_info,
+	.queuecommand		= sun3scsi_queue_command,
+	.abort			= sun3scsi_abort,
+	.reset			= sun3scsi_reset,
+	.can_queue		= CAN_QUEUE,
+	.this_id		= 7,
+	.sg_tablesize		= SG_TABLESIZE,
+	.cmd_per_lun		= CMD_PER_LUN,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.53/drivers/scsi/sun3_scsi.h	Tue Nov  5 10:10:06 2002
+++ linux-m68k-2.5.53/drivers/scsi/sun3_scsi.h	Wed Nov 20 11:36:31 2002
@@ -93,22 +93,6 @@
 #define SUN3_SCSI_NAME "Sun3 NCR5380 SCSI"
 #endif
 
-#define SUN3_NCR5380 {							\
-.name =			SUN3_SCSI_NAME,					\
-.detect =		sun3scsi_detect,				\
-.release =		sun3scsi_release,	/* Release */		\
-.info =			sun3scsi_info,					\
-.queuecommand =		sun3scsi_queue_command,				\
-.abort =		sun3scsi_abort,					\
-.reset =		sun3scsi_reset,					\
-.can_queue =		CAN_QUEUE,		/* can queue */		\
-.this_id =		7,			/* id */		\
-.sg_tablesize =		SG_TABLESIZE,		/* sg_tablesize */	\
-.cmd_per_lun =		CMD_PER_LUN,		/* cmd per lun */	\
-.unchecked_isa_dma =	0,			/* unchecked_isa_dma */	\
-.use_clustering =	DISABLE_CLUSTERING				\
-	}
-
 #ifndef HOSTS_C
 
 #define NCR5380_implementation_fields \
--- linux-2.5.53/drivers/scsi/sun3_scsi_vme.c	Fri Dec 27 14:17:42 2002
+++ linux-m68k-2.5.53/drivers/scsi/sun3_scsi_vme.c	Wed Nov 20 11:36:31 2002
@@ -560,7 +560,21 @@
 
 #include "sun3_NCR5380.c"
 
-static Scsi_Host_Template driver_template = SUN3_NCR5380;
+static Scsi_Host_Template driver_template = {
+	.name			= SUN3_SCSI_NAME,
+	.detect			= sun3scsi_detect,
+	.release		= sun3scsi_release,
+	.info			= sun3scsi_info,
+	.queuecommand		= sun3scsi_queue_command,
+	.abort			= sun3scsi_abort,
+	.reset			= sun3scsi_reset,
+	.can_queue		= CAN_QUEUE,
+	.this_id		= 7,
+	.sg_tablesize		= SG_TABLESIZE,
+	.cmd_per_lun		= CMD_PER_LUN,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
