Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVANULn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVANULn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVANULn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:11:43 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:23228 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261834AbVANUGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:06:46 -0500
Date: Fri, 14 Jan 2005 12:06:27 -0800
From: Dave Jiang <dave.jiang@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, smaurer@teja.com, dsaxena@plexity.net,
       linux@arm.linux.org.uk, drew.moseley@intel.com,
       mporter@kernel.crashing.org, greg@kroah.com
Subject: [PATCH 2/5] resource: some driver updates for u64 resource
Message-ID: <20050114200627.GB19386@plexity.net>
Reply-To: dave.jiang@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Corp.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some driver updates for changing resource from unsigned long to u64.
Mostly printk updates. Also applied suggestion by Andreas Dilger to
remove the case where u64 division would occur in 8250 UART code.

Signed-off-by: Dave Jiang (dave.jiang@gmail.com)


diff -Naur linux-2.6.11-rc1/drivers/ide/pci/cmd64x.c linux-2.6.11-rc1-u64/drivers/ide/pci/cmd64x.c
--- linux-2.6.11-rc1/drivers/ide/pci/cmd64x.c	2005-01-13 14:39:55.967192424 -0700
+++ linux-2.6.11-rc1-u64/drivers/ide/pci/cmd64x.c	2005-01-13 17:38:33.244918560 -0700
@@ -560,7 +560,7 @@
 #ifdef __i386__
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_byte(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%16llx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 #endif
 
diff -Naur linux-2.6.11-rc1/drivers/ide/pci/hpt34x.c linux-2.6.11-rc1-u64/drivers/ide/pci/hpt34x.c
--- linux-2.6.11-rc1/drivers/ide/pci/hpt34x.c	2005-01-13 14:39:56.013185432 -0700
+++ linux-2.6.11-rc1-u64/drivers/ide/pci/hpt34x.c	2005-01-13 17:39:14.007721672 -0700
@@ -175,7 +175,7 @@
 		if (pci_resource_start(dev, PCI_ROM_RESOURCE)) {
 			pci_write_config_byte(dev, PCI_ROM_ADDRESS,
 				dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-			printk(KERN_INFO "HPT345: ROM enabled at 0x%08lx\n",
+			printk(KERN_INFO "HPT345: ROM enabled at 0x%16llx\n",
 				dev->resource[PCI_ROM_RESOURCE].start);
 		}
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0xF0);
diff -Naur linux-2.6.11-rc1/drivers/ide/pci/pdc202xx_new.c linux-2.6.11-rc1-u64/drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.11-rc1/drivers/ide/pci/pdc202xx_new.c	2005-01-13 14:39:56.561102136 -0700
+++ linux-2.6.11-rc1-u64/drivers/ide/pci/pdc202xx_new.c	2005-01-13 17:39:39.295877288 -0700
@@ -277,7 +277,7 @@
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
+		printk(KERN_INFO "%s: ROM enabled at 0x%16llx\n",
 			name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
diff -Naur linux-2.6.11-rc1/drivers/ide/pci/pdc202xx_old.c linux-2.6.11-rc1-u64/drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.11-rc1/drivers/ide/pci/pdc202xx_old.c	2005-01-13 14:39:56.562101984 -0700
+++ linux-2.6.11-rc1-u64/drivers/ide/pci/pdc202xx_old.c	2005-01-13 17:44:28.367931656 -0700
@@ -528,7 +528,7 @@
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
+		printk(KERN_INFO "%s: ROM enabled at 0x%16llx\n",
 			name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 

diff -Naur linux-2.6.11-rc1/drivers/serial/8250_pci.c linux-2.6.11-rc1-u64/drivers/serial/8250_pci.c
--- linux-2.6.11-rc1/drivers/serial/8250_pci.c	2004-12-24 14:35:23.000000000 -0700
+++ linux-2.6.11-rc1-u64/drivers/serial/8250_pci.c	2005-01-14 09:32:32.850175896 -0700
@@ -589,8 +589,8 @@
 	else
 		offset += idx * board->uart_offset;
 
-	maxnr = (pci_resource_len(dev, bar) - board->first_offset) /
-		(8 << board->reg_shift);
+	maxnr = (pci_resource_len(dev, bar) - board->first_offset) >>
+		(board->reg_shift + 3);
 
 	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
 		return 1;
diff -Naur linux-2.6.11-rc1/drivers/video/console/vgacon.c linux-2.6.11-rc1-u64/drivers/video/console/vgacon.c
--- linux-2.6.11-rc1/drivers/video/console/vgacon.c	2005-01-13 14:40:05.305772744 -0700
+++ linux-2.6.11-rc1-u64/drivers/video/console/vgacon.c	2005-01-13 11:45:41.842460952 -0700
@@ -190,7 +190,7 @@
 		vga_video_port_val = VGA_CRT_DM;
 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10) {
 			static struct resource ega_console_resource =
-			    { "ega", 0x3B0, 0x3BF };
+			    { .name = "ega", .start = 0x3B0, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_EGAM;
 			vga_vram_end = 0xb8000;
 			display_desc = "EGA+";
@@ -198,9 +198,9 @@
 					 &ega_console_resource);
 		} else {
 			static struct resource mda1_console_resource =
-			    { "mda", 0x3B0, 0x3BB };
+			    { .name = "mda", .start = 0x3B0, .end = 0x3BB };
 			static struct resource mda2_console_resource =
-			    { "mda", 0x3BF, 0x3BF };
+			    { .name = "mda", .start = 0x3BF, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_MDA;
 			vga_vram_end = 0xb2000;
 			display_desc = "*MDA";
@@ -223,14 +223,14 @@
 
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
@@ -274,7 +274,7 @@
 			}
 		} else {
 			static struct resource cga_console_resource =
-			    { "cga", 0x3D4, 0x3D5 };
+			    { .name = "cga", .start = 0x3D4, .end = 0x3D5 };
 			vga_video_type = VIDEO_TYPE_CGA;
 			vga_vram_end = 0xba000;
 			display_desc = "*CGA";
