Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVAPCDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVAPCDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVAPCCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:02:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21774 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262387AbVAPCBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:01:20 -0500
Date: Sun, 16 Jan 2005 03:01:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill aux_device_present (fwd)
Message-ID: <20050116020117.GG4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below (slghtly adapted to an unrelated context 
change) still applies and compiles against 2.6.11-rc1-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 11 Dec 2004 23:00:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill aux_device_present

There's no reason for keeping a write-only variable.


diffstat output:
 arch/alpha/kernel/setup.c  |    2 --
 arch/arm/kernel/setup.c    |    2 --
 arch/arm26/kernel/setup.c  |    1 -
 arch/cris/kernel/setup.c   |    2 --
 arch/i386/kernel/setup.c   |    3 ---
 arch/ia64/kernel/setup.c   |    2 --
 arch/ppc/kernel/setup.c    |    1 -
 arch/sh/kernel/setup.c     |    1 -
 arch/sh64/kernel/setup.c   |    4 ----
 arch/x86_64/kernel/setup.c |    3 ---
 10 files changed, 21 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/ppc/kernel/setup.c.old	2004-12-11 21:50:07.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/ppc/kernel/setup.c	2004-12-11 21:50:13.000000000 +0100
@@ -55,7 +55,6 @@
 extern void power4_idle(void);
 
 extern boot_infos_t *boot_infos;
-unsigned char aux_device_present;
 struct ide_machdep_calls ppc_ide_md;
 char *sysmap;
 unsigned long sysmap_size;
--- linux-2.6.10-rc2-mm4-full/arch/arm/kernel/setup.c.old	2004-12-11 21:50:33.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/arm/kernel/setup.c	2004-12-11 21:50:37.000000000 +0100
@@ -91,8 +91,6 @@
 struct cpu_cache_fns cpu_cache;
 #endif
 
-unsigned char aux_device_present;
-
 char elf_platform[ELF_PLATFORM_SIZE];
 EXPORT_SYMBOL(elf_platform);
 
--- linux-2.6.10-rc2-mm4-full/arch/sh/kernel/setup.c.old	2004-12-11 21:50:44.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/sh/kernel/setup.c	2004-12-11 21:50:47.000000000 +0100
@@ -43,7 +43,6 @@
  */
 struct sh_cpuinfo boot_cpu_data = { CPU_SH_NONE, 0, 10000000, };
 struct screen_info screen_info;
-unsigned char aux_device_present = 0xaa;
 
 #if defined(CONFIG_SH_UNKNOWN)
 struct sh_machine_vector sh_mv;
--- linux-2.6.10-rc2-mm4-full/arch/cris/kernel/setup.c.old	2004-12-11 21:50:54.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/cris/kernel/setup.c	2004-12-11 21:50:58.000000000 +0100
@@ -26,8 +26,6 @@
 struct drive_info_struct { char dummy[32]; } drive_info;
 struct screen_info screen_info;
 
-unsigned char aux_device_present;
-
 extern int root_mountflags;
 extern char _etext, _edata, _end;
 
--- linux-2.6.10-rc2-mm4-full/arch/arm26/kernel/setup.c.old	2004-12-11 21:51:07.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/arm26/kernel/setup.c	2004-12-11 21:51:12.000000000 +0100
@@ -74,7 +74,6 @@
 
 struct processor processor;
 
-unsigned char aux_device_present;
 char elf_platform[ELF_PLATFORM_SIZE];
 
 unsigned long phys_initrd_start __initdata = 0;
--- linux-2.6.10-rc2-mm4-full/arch/ia64/kernel/setup.c.old	2004-12-11 21:51:21.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/ia64/kernel/setup.c	2004-12-11 21:51:27.000000000 +0100
@@ -75,8 +75,6 @@
 EXPORT_SYMBOL(io_space);
 unsigned int num_io_spaces;
 
-unsigned char aux_device_present = 0xaa;        /* XXX remove this when legacy I/O is gone */
-
 /*
  * The merge_mask variable needs to be set to (max(iommu_page_size(iommu)) - 1).  This
  * mask specifies a mask of address bits that must be 0 in order for two buffers to be
--- linux-2.6.10-rc2-mm4-full/arch/alpha/kernel/setup.c.old	2004-12-11 21:51:34.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/alpha/kernel/setup.c	2004-12-11 21:51:45.000000000 +0100
@@ -110,8 +110,6 @@
 int alpha_using_srm;
 #endif
 
-unsigned char aux_device_present = 0xaa;
-
 #define N(a) (sizeof(a)/sizeof(a[0]))
 
 static struct alpha_machine_vector *get_sysvec(unsigned long, unsigned long,
--- linux-2.6.10-rc2-mm4-full/arch/sh64/kernel/setup.c.old	2004-12-11 21:51:53.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/sh64/kernel/setup.c	2004-12-11 21:51:59.000000000 +0100
@@ -61,10 +61,6 @@
 
 struct screen_info screen_info;
 
-/* On a PC this would be initialised as a result of the BIOS detecting the
- * mouse. */
-unsigned char aux_device_present = 0xaa;
-
 #ifdef CONFIG_BLK_DEV_RAM
 extern int rd_doload;		/* 1 = load ramdisk, 0 = don't load */
 extern int rd_prompt;		/* 1 = prompt for ramdisk, 0 = don't prompt */
--- linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/setup.c.old	2004-12-11 21:52:07.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/setup.c	2004-12-11 21:52:12.000000000 +0100
@@ -100,8 +100,6 @@
 struct edid_info edid_info;
 struct e820map e820;
 
-unsigned char aux_device_present;
-
 extern int root_mountflags;
 extern char _text, _etext, _edata, _end;
 
@@ -452,7 +450,6 @@
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
 	edid_info = EDID_INFO;
-	aux_device_present = AUX_DEVICE_INFO;
 	saved_video_mode = SAVED_VIDEO_MODE;
 
 #ifdef CONFIG_BLK_DEV_RAM

--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/setup.c.old	2005-01-16 00:29:48.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/setup.c	2005-01-16 00:30:17.000000000 +0100
@@ -120,8 +120,6 @@
 struct ist_info ist_info;
 struct e820map e820;
 
-unsigned char aux_device_present;
-
 extern void early_cpu_init(void);
 extern void dmi_scan_machine(void);
 extern void generic_apic_probe(char *);
@@ -1368,7 +1366,6 @@
 		machine_submodel_id = SYS_DESC_TABLE.table[1];
 		BIOS_revision = SYS_DESC_TABLE.table[2];
 	}
-	aux_device_present = AUX_DEVICE_INFO;
 	bootloader_type = LOADER_TYPE;
 
 #ifdef CONFIG_BLK_DEV_RAM
