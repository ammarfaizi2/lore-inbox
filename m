Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317276AbSFCFa1>; Mon, 3 Jun 2002 01:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317277AbSFCFa0>; Mon, 3 Jun 2002 01:30:26 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:39087 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317276AbSFCFa0>; Mon, 3 Jun 2002 01:30:26 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mec@shout.net
Subject: [PATCH] TRIVIAL Brad Hards <bhards@bigpond.net.au>: "General options" - begone
Date: Mon, 03 Jun 2002 15:34:05 +1000
Message-Id: <E17EkTl-0005kT-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me.  Any complaints?

Brad Hards <bhards@bigpond.net.au>: "General options" - begone.:
  There is more of this janitorial work to come (eg General setup). I'm just 
  piecemealing it
  
  Brad
  -- 
  http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.diff -Naur -X dontdiff linux-2.5.19-clean/arch/i386/config.in linux-2.5.19/arch/i386/config.in

--- trivial-2.5.20/arch/i386/config.in.orig	Mon Jun  3 15:24:58 2002
+++ trivial-2.5.20/arch/i386/config.in	Mon Jun  3 15:24:58 2002
@@ -209,9 +209,26 @@
 endmenu
 
 mainmenu_option next_comment
-comment 'General options'
+comment 'Power management options (ACPI, APM)'
 
 source drivers/acpi/Config.in
+bool 'Power Management support' CONFIG_PM
+
+dep_tristate '  Advanced Power Management BIOS support' CONFIG_APM $CONFIG_PM
+if [ "$CONFIG_APM" != "n" ]; then
+   bool '    Ignore USER SUSPEND' CONFIG_APM_IGNORE_USER_SUSPEND
+   bool '    Enable PM at boot time' CONFIG_APM_DO_ENABLE
+   bool '    Make CPU Idle calls when idle' CONFIG_APM_CPU_IDLE
+   bool '    Enable console blanking using APM' CONFIG_APM_DISPLAY_BLANK
+   bool '    RTC stores time in GMT' CONFIG_APM_RTC_IS_GMT
+   bool '    Allow interrupts during APM BIOS calls' CONFIG_APM_ALLOW_INTS
+   bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
+fi
+
+endmenu
+
+mainmenu_option next_comment
+comment 'Bus options (PCI, PCMCIA, EISA, MCA, ISA)'
 
 # Visual Workstation support is utterly broken.
 # If you want to see it working mail an VW540 to hch@infradead.org 8)
@@ -260,6 +277,11 @@
    define_bool CONFIG_HOTPLUG_PCI n
 fi
 
+endmenu
+
+mainmenu_option next_comment
+comment 'Executable file formats'
+
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
 	"ELF		CONFIG_KCORE_ELF	\
@@ -268,19 +290,6 @@
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
-
-bool 'Power Management support' CONFIG_PM
-
-dep_tristate '  Advanced Power Management BIOS support' CONFIG_APM $CONFIG_PM
-if [ "$CONFIG_APM" != "n" ]; then
-   bool '    Ignore USER SUSPEND' CONFIG_APM_IGNORE_USER_SUSPEND
-   bool '    Enable PM at boot time' CONFIG_APM_DO_ENABLE
-   bool '    Make CPU Idle calls when idle' CONFIG_APM_CPU_IDLE
-   bool '    Enable console blanking using APM' CONFIG_APM_DISPLAY_BLANK
-   bool '    RTC stores time in GMT' CONFIG_APM_RTC_IS_GMT
-   bool '    Allow interrupts during APM BIOS calls' CONFIG_APM_ALLOW_INTS
-   bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
-fi
 
 endmenu
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
