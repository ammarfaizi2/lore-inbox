Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTBLC5e>; Tue, 11 Feb 2003 21:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbTBLC4m>; Tue, 11 Feb 2003 21:56:42 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:14601 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S266347AbTBLCz7>; Tue, 11 Feb 2003 21:55:59 -0500
Date: Tue, 11 Feb 2003 21:03:16 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializer for arch/i386/kernel/setup.c
Message-ID: <20030212030316.GI914@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts the file to use C99 initializers to remove warnings
if '-W' is used and to aid readability.

Art Haas

===== arch/i386/kernel/setup.c 1.67 vs edited =====
--- 1.67/arch/i386/kernel/setup.c	Wed Feb  5 18:01:50 2003
+++ edited/arch/i386/kernel/setup.c	Tue Feb 11 09:38:59 2003
@@ -51,9 +51,17 @@
 
 char ignore_irq13;		/* set if exception 16 works */
 /* cpu data as detected by the assembly code in head.S */
-struct cpuinfo_x86 new_cpu_data __initdata = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
+struct cpuinfo_x86 new_cpu_data __initdata = {
+	.wp_works_ok	= -1,
+	.hlt_works_ok	= 1,
+	.cpuid_level	= -1
+};
 /* common cpu data for all cpus */
-struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
+struct cpuinfo_x86 boot_cpu_data = {
+	.wp_works_ok	= -1,
+	.hlt_works_ok	= 1,
+	.cpuid_level	= -1
+};
 
 unsigned long mmu_cr4_features;
 
@@ -104,31 +112,104 @@
        char saved_command_line[COMMAND_LINE_SIZE];
 
 struct resource standard_io_resources[] = {
-	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
-	{ "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
-	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
-	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
-	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
-	{ "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },
-	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
-	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
+	{ 
+		.name	= "dma1",
+		.start	= 0x00,
+		.end	= 0x1f,
+		.flags	= IORESOURCE_BUSY
+	},
+	{
+		.name	= "pic1",
+		.start	= 0x20,
+		.end	= 0x3f,
+		.flags	= IORESOURCE_BUSY
+	},
+	{
+		.name	= "timer",
+		.start	= 0x40,
+		.end	= 0x5f,
+		.flags	= IORESOURCE_BUSY
+	},
+	{
+		.name	= "keyboard",
+		.start	= 0x60,
+		.end	= 0x6f,
+		.flags	= IORESOURCE_BUSY
+	},
+	{
+		.name	= "dma page reg",
+		.start	= 0x80,
+		.end	= 0x8f,
+		.flags	= IORESOURCE_BUSY
+	},
+	{
+		.name	= "pic2",
+		.start	= 0xa0,
+		.end	= 0xbf,
+		.flags	= IORESOURCE_BUSY
+	},
+	{
+		.name	= "dma2",
+		.start	= 0xc0,
+		.end	= 0xdf,
+		.flags	= IORESOURCE_BUSY
+	},
+	{
+		.name	= "fpu",
+		.start	= 0xf0,
+		.end	= 0xff,
+		.flags	= IORESOURCE_BUSY
+	}
 };
 #ifdef CONFIG_MELAN
-standard_io_resources[1] = { "pic1", 0x20, 0x21, IORESOURCE_BUSY };
-standard_io_resources[5] = { "pic2", 0xa0, 0xa1, IORESOURCE_BUSY };
+standard_io_resources[1] = {
+	.name	= "pic1",
+	.start	= 0x20,
+	.end	= 0x21,
+	.flags	= IORESOURCE_BUSY
+};
+standard_io_resources[5] = {
+	.name	= "pic2",
+	.start	= 0xa0,
+	.end	= 0xa1,
+	.flags	= IORESOURCE_BUSY
+};
 #endif
 
 #define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
 
-static struct resource code_resource = { "Kernel code", 0x100000, 0 };
-static struct resource data_resource = { "Kernel data", 0, 0 };
-static struct resource vram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_BUSY };
+static struct resource code_resource = {
+	.name	= "Kernel code",
+	.start	= 0x100000,
+	.end	= 0
+};
+static struct resource data_resource = {
+	.name	= "Kernel data",
+	.start	= 0,
+	.end	= 0
+};
+static struct resource vram_resource = {
+	.name	= "Video RAM area",
+	.start	= 0xa0000,
+	.end	= 0xbffff,
+	.flags	= IORESOURCE_BUSY
+};
 
 /* System ROM resources */
 #define MAXROMS 6
 static struct resource rom_resources[MAXROMS] = {
-	{ "System ROM", 0xF0000, 0xFFFFF, IORESOURCE_BUSY },
-	{ "Video ROM", 0xc0000, 0xc7fff, IORESOURCE_BUSY }
+	{
+		.name	= "System ROM",
+		.start	= 0xF0000,
+		.end	= 0xFFFFF,
+		.flags	= IORESOURCE_BUSY
+	},
+	{
+		.name	= "Video ROM",
+		.start	= 0xc0000,
+		.end	= 0xc7fff,
+		.flags	= IORESOURCE_BUSY
+	}
 };
 
 #define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
