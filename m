Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbSKCOXR>; Sun, 3 Nov 2002 09:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbSKCOXR>; Sun, 3 Nov 2002 09:23:17 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:15288 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261893AbSKCOXK>;
	Sun, 3 Nov 2002 09:23:10 -0500
Date: Sun, 3 Nov 2002 15:28:55 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
In-Reply-To: <20021103131339.A22465@infradead.org>
Message-ID: <Pine.GSO.4.21.0211031526050.12573-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Christoph Hellwig wrote:
> On Sun, Nov 03, 2002 at 11:46:48AM +0100, Geert Uytterhoeven wrote:
> > NCR53C9x ESP: C99 designated initializers
> 
> Please move the host template to the C file instead of the header
> if you touch it.  Having them in the header and the methods exported
> was needed in 2.2, but that's long ago..

At your service :-)
Except for the MIPS JAZZ driver, since SCSI_JAZZ_ESP is not actually used
anymore, probably due to bit rot.

Subject: [PATCH] NCR53C9x ESP: C99 designated initializers and host templates

NCR53C9x ESP:
  - C99 designated initializers
  - Move NCR53C9x ESP host templates from the header files to the source files.

--- linux-2.5.45/drivers/scsi/blz1230.c	Mon May 13 10:55:33 2002
+++ linux-m68k-2.5.45/drivers/scsi/blz1230.c	Sun Nov  3 15:15:59 2002
@@ -281,7 +281,23 @@
 
 #include "blz1230.h"
 
-static Scsi_Host_Template driver_template = SCSI_BLZ1230;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-blz1230",
+	.proc_info		= esp_proc_info,
+	.name			= "Blizzard1230 SCSI IV",
+	.detect			= blz1230_esp_detect,
+	.release		= blz1230_esp_release,
+	.command		= esp_command,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.45/drivers/scsi/blz1230.h	Sun Nov  3 15:21:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/blz1230.h	Sun Nov  3 15:15:59 2002
@@ -57,19 +57,4 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_BLZ1230      { proc_name:		"esp-blz1230", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Blizzard1230 SCSI IV", \
-			    detect:		blz1230_esp_detect, \
-			    release:		blz1230_esp_release, \
-			    command:		esp_command, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
-
 #endif /* BLZ1230_H */
--- linux-2.5.45/drivers/scsi/blz2060.c	Mon May 13 10:55:33 2002
+++ linux-m68k-2.5.45/drivers/scsi/blz2060.c	Sun Nov  3 15:15:59 2002
@@ -238,7 +238,22 @@
 
 #include "blz2060.h"
 
-static Scsi_Host_Template driver_template = SCSI_BLZ2060;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-blz2060",
+	.proc_info		= esp_proc_info,
+	.name			= "Blizzard2060 SCSI",
+	.detect			= blz2060_esp_detect,
+	.release		= blz2060_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.45/drivers/scsi/blz2060.h	Sun Nov  3 15:21:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/blz2060.h	Sun Nov  3 15:15:59 2002
@@ -53,18 +53,4 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_BLZ2060      { proc_name:		"esp-blz2060", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Blizzard2060 SCSI", \
-			    detect:		blz2060_esp_detect, \
-			    release:		blz2060_esp_release, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
-
 #endif /* BLZ2060_H */
--- linux-2.5.45/drivers/scsi/cyberstorm.c	Mon May 13 10:55:33 2002
+++ linux-m68k-2.5.45/drivers/scsi/cyberstorm.c	Sun Nov  3 15:15:59 2002
@@ -304,7 +304,22 @@
 
 #include "cyberstorm.h"
 
-static Scsi_Host_Template driver_template = SCSI_CYBERSTORM;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-cyberstorm",
+	.proc_info		= esp_proc_info,
+	.name			= "CyberStorm SCSI",
+	.detect			= cyber_esp_detect,
+	.release		= cyber_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.45/drivers/scsi/cyberstorm.h	Sun Nov  3 15:21:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/cyberstorm.h	Sun Nov  3 15:15:59 2002
@@ -55,19 +55,4 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-
-#define SCSI_CYBERSTORM   { proc_name:		"esp-cyberstorm", \
-			    proc_info:		esp_proc_info, \
-			    name:		"CyberStorm SCSI", \
-			    detect:		cyber_esp_detect, \
-			    release:		cyber_esp_release, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
-
 #endif /* CYBER_ESP_H */
--- linux-2.5.45/drivers/scsi/cyberstormII.c	Mon May 13 10:55:33 2002
+++ linux-m68k-2.5.45/drivers/scsi/cyberstormII.c	Sun Nov  3 15:15:59 2002
@@ -254,7 +254,22 @@
 
 #include "cyberstormII.h"
 
-static Scsi_Host_Template driver_template = SCSI_CYBERSTORMII;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-cyberstormII",
+	.proc_info		= esp_proc_info,
+	.name			= "CyberStorm Mk II SCSI",
+	.detect			= cyberII_esp_detect,
+	.release		= cyberII_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.45/drivers/scsi/cyberstormII.h	Sun Nov  3 15:21:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/cyberstormII.h	Sun Nov  3 15:15:59 2002
@@ -43,18 +43,4 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_CYBERSTORMII { proc_name:		"esp-cyberstormII", \
-			    proc_info:		esp_proc_info, \
-			    name:		"CyberStorm Mk II SCSI", \
-			    detect:		cyberII_esp_detect, \
-			    release:		cyberII_esp_release, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
-
 #endif /* CYBERII_ESP_H */
--- linux-2.5.45/drivers/scsi/dec_esp.c	Fri Feb  1 09:36:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/dec_esp.c	Sun Nov  3 15:15:59 2002
@@ -103,7 +103,23 @@
 
 static void scsi_dma_int(int, void *, struct pt_regs *);
 
-static Scsi_Host_Template driver_template = SCSI_DEC_ESP;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp",
+	.proc_info		= &esp_proc_info,
+	.name			= "NCR53C94",
+	.detect			= dec_esp_detect,
+	.info			= esp_info,
+	.command		= esp_command,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= DISABLE_CLUSTERING,
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.45/drivers/scsi/dec_esp.h	Sun Nov  3 15:21:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/dec_esp.h	Sun Nov  3 15:15:59 2002
@@ -26,20 +26,4 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_DEC_ESP {                                         \
-		proc_name:      "esp",				\
-		proc_info:      &esp_proc_info,			\
-		name:           "NCR53C94",			\
-		detect:         dec_esp_detect,			\
-		info:           esp_info,			\
-		command:        esp_command,			\
-		queuecommand:   esp_queue,			\
-		eh_abort_handler:          esp_abort,			\
-		eh_bus_reset_handler:          esp_reset,			\
-		can_queue:      7,				\
-		this_id:        7,				\
-		sg_tablesize:   SG_ALL,				\
-		cmd_per_lun:    1,				\
-		use_clustering: DISABLE_CLUSTERING, }
-
 #endif /* DEC_ESP_H */
--- linux-2.5.45/drivers/scsi/fastlane.c	Mon May 13 10:55:33 2002
+++ linux-m68k-2.5.45/drivers/scsi/fastlane.c	Sun Nov  3 15:15:59 2002
@@ -358,7 +358,23 @@
 
 #include "fastlane.h"
 
-static Scsi_Host_Template driver_template = SCSI_FASTLANE;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-fastlane",
+	.proc_info		= esp_proc_info,
+	.name			= "Fastlane SCSI",
+	.detect			= fastlane_esp_detect,
+	.release		= fastlane_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
+
 #include "scsi_module.c"
 
 int fastlane_esp_release(struct Scsi_Host *instance)
--- linux-2.5.45/drivers/scsi/fastlane.h	Sun Nov  3 15:21:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/fastlane.h	Sun Nov  3 15:15:59 2002
@@ -48,18 +48,4 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_FASTLANE     { proc_name:		"esp-fastlane", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Fastlane SCSI", \
-			    detect:		fastlane_esp_detect, \
-			    release:		fastlane_esp_release, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
-
 #endif /* FASTLANE_H */
--- linux-2.5.45/drivers/scsi/jazz_esp.h	Sun Nov  3 15:21:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/jazz_esp.h	Sun Nov  3 11:07:28 2002
@@ -20,20 +20,21 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_JAZZ_ESP {                                         \
-		proc_name:      "esp",				\
-		proc_info:      &esp_proc_info,			\
-		name:           "ESP 100/100a/200",		\
-		detect:         jazz_esp_detect,		\
-		info:           esp_info,			\
-		command:        esp_command,			\
-		queuecommand:   esp_queue,			\
-		eh_abort_handler:          esp_abort,			\
-		eh_bus_reset_handler:          esp_reset,			\
-		can_queue:      7,				\
-		this_id:        7,				\
-		sg_tablesize:   SG_ALL,				\
-		cmd_per_lun:    1,				\
-		use_clustering: DISABLE_CLUSTERING, }
+#define SCSI_JAZZ_ESP	{					\
+		.proc_name		= "esp",		\
+		.proc_info		= &esp_proc_info,	\
+		.name			= "ESP 100/100a/200",	\
+		.detect			= jazz_esp_detect,	\
+		.info			= esp_info,		\
+		.command		= esp_command,		\
+		.queuecommand		= esp_queue,		\
+		.eh_abort_handler	= esp_abort,		\
+		.eh_bus_reset_handler	= esp_reset,		\
+		.can_queue		= 7,			\
+		.this_id		= 7,			\
+		.sg_tablesize		= SG_ALL,		\
+		.cmd_per_lun		= 1,			\
+		.use_clustering		= DISABLE_CLUSTERING,	\
+}
 
 #endif /* JAZZ_ESP_H */
--- linux-2.5.45/drivers/scsi/mac_esp.c	Thu Jul 25 12:53:56 2002
+++ linux-m68k-2.5.45/drivers/scsi/mac_esp.c	Sun Nov  3 15:15:59 2002
@@ -710,7 +710,23 @@
 #endif
 }
 
-static Scsi_Host_Template driver_template = SCSI_MAC_ESP;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp",
+	.name			= "Mac 53C9x SCSI",
+	.detect			= mac_esp_detect,
+	.release		= NULL,
+	.info			= esp_info,
+	/* .command		= esp_command, */
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.45/drivers/scsi/mac_esp.h	Sun Nov  3 15:21:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/mac_esp.h	Sun Nov  3 15:15:59 2002
@@ -20,21 +20,5 @@
 extern int esp_abort(Scsi_Cmnd *);
 extern int esp_reset(Scsi_Cmnd *);
 
-
-#define SCSI_MAC_ESP      { proc_name:		"esp", \
-			    name:		"Mac 53C9x SCSI", \
-			    detect:		mac_esp_detect, \
-			    release:		NULL, \
-			    info:		esp_info, \
-			    /* command:		esp_command, */ \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	DISABLE_CLUSTERING }
-
 #endif /* MAC_ESP_H */
 
--- linux-2.5.45/drivers/scsi/mca_53c9x.c	Mon Feb 11 09:14:40 2002
+++ linux-m68k-2.5.45/drivers/scsi/mca_53c9x.c	Sun Nov  3 15:15:59 2002
@@ -419,7 +419,22 @@
 	outb(inb(PS2_SYS_CTR) & 0x3f, PS2_SYS_CTR);
 }
 
-static Scsi_Host_Template driver_template = MCA_53C9X;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp",
+	.name			= "NCR 53c9x SCSI",
+	.detect			= mca_esp_detect,
+	.release		= mca_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.unchecked_isa_dma	= 1,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
+
 #include "scsi_module.c"
 
 /*
--- linux-2.5.45/drivers/scsi/mca_53c9x.h	Sun Nov  3 15:21:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/mca_53c9x.h	Sun Nov  3 15:15:59 2002
@@ -31,19 +31,6 @@
 			 int hostno, int inout);
 
 
-#define MCA_53C9X         { proc_name:		"esp", \
-			    name:		"NCR 53c9x SCSI", \
-			    detect:		mca_esp_detect, \
-			    release:		mca_esp_release, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-                            unchecked_isa_dma:  1, \
-			    use_clustering:	DISABLE_CLUSTERING }
-
 /* Ports the ncr's 53c94 can be put at; indexed by pos register value */
 
 #define MCA_53C9X_IO_PORTS {                             \
--- linux-2.5.45/drivers/scsi/oktagon_esp.c	Mon Oct  7 22:04:40 2002
+++ linux-m68k-2.5.45/drivers/scsi/oktagon_esp.c	Sun Nov  3 15:15:59 2002
@@ -573,7 +573,22 @@
 
 #include "oktagon_esp.h"
 
-static Scsi_Host_Template driver_template = SCSI_OKTAGON_ESP;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-oktagon",
+	.proc_info		= &esp_proc_info,
+	.name			= "BSC Oktagon SCSI",
+	.detect			= oktagon_esp_detect,
+	.release		= oktagon_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.45/drivers/scsi/oktagon_esp.h	Sun Nov  3 15:21:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/oktagon_esp.h	Sun Nov  3 15:15:59 2002
@@ -39,19 +39,4 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			int hostno, int inout);
 
-#define SCSI_OKTAGON_ESP {                       \
-   proc_name:           "esp-oktagon",           \
-   proc_info:           &esp_proc_info,          \
-   name:                "BSC Oktagon SCSI",      \
-   detect:              oktagon_esp_detect,      \
-   release:             oktagon_esp_release,     \
-   queuecommand:        esp_queue,               \
-   eh_abort_handler:               esp_abort,               \
-   eh_bus_reset_handler:               esp_reset,               \
-   can_queue:           7,                       \
-   this_id:             7,                       \
-   sg_tablesize:        SG_ALL,                  \
-   cmd_per_lun:         1,                       \
-   use_clustering:      ENABLE_CLUSTERING }
-
 #endif /* OKTAGON_ESP_H */
--- linux-2.5.45/drivers/scsi/sun3x_esp.c	Sun Nov  3 15:22:00 2002
+++ linux-m68k-2.5.45/drivers/scsi/sun3x_esp.c	Sun Nov  3 15:15:59 2002
@@ -374,7 +374,23 @@
     sp->SCp.ptr = (char *)((unsigned long)sp->SCp.buffer->dvma_address);
 }
 
-static Scsi_Host_Template driver_template = SCSI_SUN3X_ESP;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp",
+	.proc_info		= &esp_proc_info,
+	.name			= "Sun ESP 100/100a/200",
+	.detect			= sun3x_esp_detect,
+	.info			= esp_info,
+	.command		= esp_command,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= DISABLE_CLUSTERING,
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.45/drivers/scsi/sun3x_esp.h	Sun Nov  3 15:21:52 2002
+++ linux-m68k-2.5.45/drivers/scsi/sun3x_esp.h	Sun Nov  3 15:15:59 2002
@@ -20,20 +20,4 @@
 
 #define DMA_PORTS_P        (dregs->cond_reg & DMA_INT_ENAB)
 
-#define SCSI_SUN3X_ESP {                                        \
-		proc_name:      "esp",  			\
-		proc_info:      &esp_proc_info,			\
-		name:           "Sun ESP 100/100a/200",		\
-		detect:         sun3x_esp_detect,		\
-		info:           esp_info,			\
-		command:        esp_command,			\
-		queuecommand:   esp_queue,			\
-		eh_abort_handler:          esp_abort,			\
-		eh_bus_reset_handler:          esp_reset,			\
-		can_queue:      7,				\
-		this_id:        7,				\
-		sg_tablesize:   SG_ALL,				\
-		cmd_per_lun:    1,				\
-		use_clustering: DISABLE_CLUSTERING, }
-
 #endif /* !(_SUN3X_ESP_H) */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

