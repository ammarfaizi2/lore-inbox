Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161171AbWF0QhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWF0QhI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161174AbWF0QhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:37:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:35306 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161171AbWF0QhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:05 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/17] [PATCH] 64bit resource: C99 changes for struct resource declarations
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:37 -0700
Message-Id: <11514260331421-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <20060627163317.GA31073@kroah.com>
References: <20060627163317.GA31073@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Based on an original patch from Ralf Baechle <ralf@linux-mips.org> and
Vivek Goyal <vgoyal@in.ibm.com>.  This is needed in order to prepare for
changing the size of resources.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/arm/kernel/setup.c        |   42 ++++++++++++++++++++++++++++++++++------
 drivers/video/console/vgacon.c |   12 ++++++-----
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 9fc9af8..d694127 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -119,9 +119,24 @@ DEFINE_PER_CPU(struct cpuinfo_arm, cpu_d
  * Standard memory resources
  */
 static struct resource mem_res[] = {
-	{ "Video RAM",   0,     0,     IORESOURCE_MEM			},
-	{ "Kernel text", 0,     0,     IORESOURCE_MEM			},
-	{ "Kernel data", 0,     0,     IORESOURCE_MEM			}
+	{
+		.name = "Video RAM",
+		.start = 0,
+		.end = 0,
+		.flags = IORESOURCE_MEM
+	},
+	{
+		.name = "Kernel text",
+		.start = 0,
+		.end = 0,
+		.flags = IORESOURCE_MEM
+	},
+	{
+		.name = "Kernel data",
+		.start = 0,
+		.end = 0,
+		.flags = IORESOURCE_MEM
+	}
 };
 
 #define video_ram   mem_res[0]
@@ -129,9 +144,24 @@ #define kernel_code mem_res[1]
 #define kernel_data mem_res[2]
 
 static struct resource io_res[] = {
-	{ "reserved",    0x3bc, 0x3be, IORESOURCE_IO | IORESOURCE_BUSY },
-	{ "reserved",    0x378, 0x37f, IORESOURCE_IO | IORESOURCE_BUSY },
-	{ "reserved",    0x278, 0x27f, IORESOURCE_IO | IORESOURCE_BUSY }
+	{
+		.name = "reserved",
+		.start = 0x3bc,
+		.end = 0x3be,
+		.flags = IORESOURCE_IO | IORESOURCE_BUSY
+	},
+	{
+		.name = "reserved",
+		.start = 0x378,
+		.end = 0x37f,
+		.flags = IORESOURCE_IO | IORESOURCE_BUSY
+	},
+	{
+		.name = "reserved",
+		.start = 0x278,
+		.end = 0x27f,
+		.flags = IORESOURCE_IO | IORESOURCE_BUSY
+	}
 };
 
 #define lp0 io_res[0]
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index f32b590..01401cd 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -390,7 +390,7 @@ #endif
 		vga_video_port_val = VGA_CRT_DM;
 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10) {
 			static struct resource ega_console_resource =
-			    { "ega", 0x3B0, 0x3BF };
+			    { .name = "ega", .start = 0x3B0, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_EGAM;
 			vga_vram_size = 0x8000;
 			display_desc = "EGA+";
@@ -398,9 +398,9 @@ #endif
 					 &ega_console_resource);
 		} else {
 			static struct resource mda1_console_resource =
-			    { "mda", 0x3B0, 0x3BB };
+			    { .name = "mda", .start = 0x3B0, .end = 0x3BB };
 			static struct resource mda2_console_resource =
-			    { "mda", 0x3BF, 0x3BF };
+			    { .name = "mda", .start = 0x3BF, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_MDA;
 			vga_vram_size = 0x2000;
 			display_desc = "*MDA";
@@ -423,14 +423,14 @@ #endif
 
 			if (!ORIG_VIDEO_ISVGA) {
 				static struct resource ega_console_resource
-				    = { "ega", 0x3C0, 0x3DF };
+				    = { .name = "ega", .start = 0x3C0, .end = 0x3DF };
 				vga_video_type = VIDEO_TYPE_EGAC;
 				display_desc = "EGA";
 				request_resource(&ioport_resource,
 						 &ega_console_resource);
 			} else {
 				static struct resource vga_console_resource
-				    = { "vga+", 0x3C0, 0x3DF };
+				    = { .name = "vga+", .start = 0x3C0, .end = 0x3DF };
 				vga_video_type = VIDEO_TYPE_VGAC;
 				display_desc = "VGA+";
 				request_resource(&ioport_resource,
@@ -474,7 +474,7 @@ #endif
 			}
 		} else {
 			static struct resource cga_console_resource =
-			    { "cga", 0x3D4, 0x3D5 };
+			    { .name = "cga", .start = 0x3D4, .end = 0x3D5 };
 			vga_video_type = VIDEO_TYPE_CGA;
 			vga_vram_size = 0x2000;
 			display_desc = "*CGA";
-- 
1.4.0

