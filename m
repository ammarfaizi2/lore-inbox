Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUCLJyo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUCLJyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:54:43 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:53155 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S262051AbUCLJwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:52:55 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: linux-kernel@vger.kernel.org
Subject: PATCH: modular out of memory base patch for 2.4.25
Date: Fri, 12 Mar 2004 10:56:53 +0100
User-Agent: KMail/1.6.1
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_llYUAo/R+mvxM5J"
Message-Id: <200403121056.53071.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_llYUAo/R+mvxM5J
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hello!

This patch enables modular oom killer infrastructure. With this base patch, 
functionality and behavior is unchanged from vanilla 2.4.25.

Comments?

--Boundary-00=_llYUAo/R+mvxM5J
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="moom-2.4.25-base.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="moom-2.4.25-base.patch"

diff -Naur linux-2.4.25/arch/alpha/config.in linux-2.4.25-moom/arch/alpha/config.in
--- linux-2.4.25/arch/alpha/config.in	2004-03-12 09:44:27.000000000 +0100
+++ linux-2.4.25-moom/arch/alpha/config.in	2004-03-12 10:27:54.000000000 +0100
@@ -317,6 +317,7 @@
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 tristate 'Kernel support for Linux/Intel ELF binaries' CONFIG_BINFMT_EM86
+source mm/Config.in
 source drivers/parport/Config.in
 endmenu
 
diff -Naur linux-2.4.25/arch/alpha/defconfig linux-2.4.25-moom/arch/alpha/defconfig
--- linux-2.4.25/arch/alpha/defconfig	2004-03-12 09:44:27.000000000 +0100
+++ linux-2.4.25-moom/arch/alpha/defconfig	2004-03-12 10:27:54.000000000 +0100
@@ -74,6 +74,8 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_BINFMT_EM86 is not set
+# CONFIG_OOM_KILL is not set
+
 
 #
 # Parallel port support
diff -Naur linux-2.4.25/arch/arm/config.in linux-2.4.25-moom/arch/arm/config.in
--- linux-2.4.25/arch/arm/config.in	2004-03-12 09:44:27.000000000 +0100
+++ linux-2.4.25-moom/arch/arm/config.in	2004-03-12 09:59:23.000000000 +0100
@@ -500,6 +500,7 @@
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+source mm/Config.in
 dep_bool 'Power Management support (experimental)' CONFIG_PM $CONFIG_EXPERIMENTAL
 dep_tristate 'RISC OS personality' CONFIG_ARTHUR $CONFIG_CPU_32
 string 'Default kernel command string' CONFIG_CMDLINE ""
diff -Naur linux-2.4.25/arch/arm/defconfig linux-2.4.25-moom/arch/arm/defconfig
--- linux-2.4.25/arch/arm/defconfig	2004-03-12 09:44:28.000000000 +0100
+++ linux-2.4.25-moom/arch/arm/defconfig	2004-03-12 10:27:54.000000000 +0100
@@ -93,6 +93,7 @@
 CONFIG_LEDS_TIMER=y
 CONFIG_LEDS_CPU=y
 CONFIG_ALIGNMENT_TRAP=y
+# CONFIG_OOM_KILL is not set
 
 #
 # Parallel port support
diff -Naur linux-2.4.25/arch/cris/config.in linux-2.4.25-moom/arch/cris/config.in
--- linux-2.4.25/arch/cris/config.in	2004-03-12 09:44:28.000000000 +0100
+++ linux-2.4.25-moom/arch/cris/config.in	2004-03-12 09:59:36.000000000 +0100
@@ -31,6 +31,7 @@
 bool 'Sysctl support' CONFIG_SYSCTL
 
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+source mm/Config.in
 
 string 'Kernel command line' CONFIG_ETRAX_CMDLINE "root=/dev/mtdblock3"
 
diff -Naur linux-2.4.25/arch/cris/defconfig linux-2.4.25-moom/arch/cris/defconfig
--- linux-2.4.25/arch/cris/defconfig	2004-03-12 09:44:28.000000000 +0100
+++ linux-2.4.25-moom/arch/cris/defconfig	2004-03-12 10:27:54.000000000 +0100
@@ -20,6 +20,7 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_ETRAX_KGDB is not set
 # CONFIG_ETRAX_WATCHDOG is not set
+# CONFIG_OOM_KILL is not set
 
 #
 # Hardware setup
diff -Naur linux-2.4.25/arch/i386/config.in linux-2.4.25-moom/arch/i386/config.in
--- linux-2.4.25/arch/i386/config.in	2004-03-12 09:44:28.000000000 +0100
+++ linux-2.4.25-moom/arch/i386/config.in	2004-03-12 09:56:17.000000000 +0100
@@ -328,7 +328,7 @@
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
-bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
+source mm/Config.in
 
 bool 'Power Management support' CONFIG_PM
 
diff -Naur linux-2.4.25/arch/i386/defconfig linux-2.4.25-moom/arch/i386/defconfig
--- linux-2.4.25/arch/i386/defconfig	2004-03-12 09:44:28.000000000 +0100
+++ linux-2.4.25-moom/arch/i386/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -83,6 +83,7 @@
 # CONFIG_EISA is not set
 # CONFIG_MCA is not set
 CONFIG_HOTPLUG=y
+# CONFIG_OOM_KILL is not set
 
 #
 # PCMCIA/CardBus support
diff -Naur linux-2.4.25/arch/ia64/config.in linux-2.4.25-moom/arch/ia64/config.in
--- linux-2.4.25/arch/ia64/config.in	2004-03-12 09:44:28.000000000 +0100
+++ linux-2.4.25-moom/arch/ia64/config.in	2004-03-12 09:59:48.000000000 +0100
@@ -125,6 +125,7 @@
 bool 'Sysctl support' CONFIG_SYSCTL
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+source mm/Config.in
 
 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
   define_bool CONFIG_ACPI y
diff -Naur linux-2.4.25/arch/ia64/defconfig linux-2.4.25-moom/arch/ia64/defconfig
--- linux-2.4.25/arch/ia64/defconfig	2004-03-12 09:44:28.000000000 +0100
+++ linux-2.4.25-moom/arch/ia64/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -65,6 +65,7 @@
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
 CONFIG_ACPI_KERNEL_CONFIG=y
+# CONFIG_OOM_KILL is not set
 
 #
 # ACPI Support
diff -Naur linux-2.4.25/arch/m68k/config.in linux-2.4.25-moom/arch/m68k/config.in
--- linux-2.4.25/arch/m68k/config.in	2004-03-12 09:44:28.000000000 +0100
+++ linux-2.4.25-moom/arch/m68k/config.in	2004-03-12 10:00:01.000000000 +0100
@@ -100,6 +100,7 @@
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+source mm/Config.in
 
 if [ "$CONFIG_AMIGA" = "y" ]; then
   bool 'Amiga Zorro (AutoConfig) bus support' CONFIG_ZORRO
diff -Naur linux-2.4.25/arch/m68k/defconfig linux-2.4.25-moom/arch/m68k/defconfig
--- linux-2.4.25/arch/m68k/defconfig	2004-03-12 09:44:28.000000000 +0100
+++ linux-2.4.25-moom/arch/m68k/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -53,6 +53,7 @@
 CONFIG_PROC_HARDWARE=y
 # CONFIG_PARPORT is not set
 # CONFIG_PRINTER is not set
+# CONFIG_OOM_KILL is not set
 
 #
 # Loadable module support
diff -Naur linux-2.4.25/arch/mips/config-shared.in linux-2.4.25-moom/arch/mips/config-shared.in
--- linux-2.4.25/arch/mips/config-shared.in	2004-03-12 09:44:28.000000000 +0100
+++ linux-2.4.25-moom/arch/mips/config-shared.in	2004-03-12 09:56:44.000000000 +0100
@@ -955,7 +955,7 @@
 fi
 
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
-bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
+source mm/Config.in
 
 if [ "$CONFIG_SOC_AU1X00" = "y" ]; then
    bool 'Power Management support' CONFIG_PM
diff -Naur linux-2.4.25/arch/mips/defconfig linux-2.4.25-moom/arch/mips/defconfig
--- linux-2.4.25/arch/mips/defconfig	2004-03-12 09:44:28.000000000 +0100
+++ linux-2.4.25-moom/arch/mips/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -144,7 +144,7 @@
 # CONFIG_MIPS32_N32 is not set
 # CONFIG_BINFMT_ELF32 is not set
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_OOM_KILLER is not set
+# CONFIG_OOM_KILL is not set
 
 #
 # Memory Technology Devices (MTD)
diff -Naur linux-2.4.25/arch/mips64/defconfig linux-2.4.25-moom/arch/mips64/defconfig
--- linux-2.4.25/arch/mips64/defconfig	2004-03-12 09:44:29.000000000 +0100
+++ linux-2.4.25-moom/arch/mips64/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -142,7 +142,7 @@
 # CONFIG_MIPS32_N32 is not set
 CONFIG_BINFMT_ELF32=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_OOM_KILLER is not set
+# CONFIG_OOM_KILL is not set
 
 #
 # Memory Technology Devices (MTD)
diff -Naur linux-2.4.25/arch/parisc/config.in linux-2.4.25-moom/arch/parisc/config.in
--- linux-2.4.25/arch/parisc/config.in	2004-03-12 09:44:29.000000000 +0100
+++ linux-2.4.25-moom/arch/parisc/config.in	2004-03-12 10:00:26.000000000 +0100
@@ -91,6 +91,7 @@
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for SOM binaries' CONFIG_BINFMT_SOM
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+source mm/Config.in
 
 # anyone want to get ACPI working on PA/RISC?
 define_bool CONFIG_PM n
diff -Naur linux-2.4.25/arch/parisc/defconfig linux-2.4.25-moom/arch/parisc/defconfig
--- linux-2.4.25/arch/parisc/defconfig	2004-03-12 09:44:29.000000000 +0100
+++ linux-2.4.25-moom/arch/parisc/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -45,6 +45,7 @@
 CONFIG_IOMMU_SBA=y
 CONFIG_SUPERIO=y
 CONFIG_PCI_NAMES=y
+# CONFIG_OOM_KILL is not set
 
 #
 # General setup
diff -Naur linux-2.4.25/arch/ppc/config.in linux-2.4.25-moom/arch/ppc/config.in
--- linux-2.4.25/arch/ppc/config.in	2004-03-12 09:44:29.000000000 +0100
+++ linux-2.4.25-moom/arch/ppc/config.in	2004-03-12 09:55:34.000000000 +0100
@@ -352,7 +352,7 @@
 define_bool CONFIG_BINFMT_ELF y
 define_bool CONFIG_KERNEL_ELF y
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
-bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
+source mm/Config.in
 
 source drivers/pci/Config.in
 
diff -Naur linux-2.4.25/arch/ppc/defconfig linux-2.4.25-moom/arch/ppc/defconfig
--- linux-2.4.25/arch/ppc/defconfig	2004-03-12 09:44:29.000000000 +0100
+++ linux-2.4.25-moom/arch/ppc/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -60,9 +60,9 @@
 CONFIG_BINFMT_ELF=y
 CONFIG_KERNEL_ELF=y
 CONFIG_BINFMT_MISC=m
-# CONFIG_OOM_KILLER is not set
 CONFIG_PCI_NAMES=y
 CONFIG_HOTPLUG=y
+# CONFIG_OOM_KILL is not set
 
 #
 # PCMCIA/CardBus support
diff -Naur linux-2.4.25/arch/ppc64/config.in linux-2.4.25-moom/arch/ppc64/config.in
--- linux-2.4.25/arch/ppc64/config.in	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/ppc64/config.in	2004-03-12 10:00:47.000000000 +0100
@@ -1,4 +1,4 @@
-# 
+#
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
@@ -86,6 +86,7 @@
 tristate 'Kernel support for 32 bit ELF binaries' CONFIG_BINFMT_ELF32
 
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+source mm/Config.in
 
 source drivers/pci/Config.in
 
diff -Naur linux-2.4.25/arch/ppc64/defconfig linux-2.4.25-moom/arch/ppc64/defconfig
--- linux-2.4.25/arch/ppc64/defconfig	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/ppc64/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -60,6 +60,7 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_PCI_NAMES=y
 # CONFIG_HOTPLUG is not set
+# CONFIG_OOM_KILL is not set
 
 #
 # Parallel port support
diff -Naur linux-2.4.25/arch/s390/config.in linux-2.4.25-moom/arch/s390/config.in
--- linux-2.4.25/arch/s390/config.in	2004-03-12 09:44:14.000000000 +0100
+++ linux-2.4.25-moom/arch/s390/config.in	2004-03-12 10:01:03.000000000 +0100
@@ -59,6 +59,7 @@
 define_bool CONFIG_KCORE_ELF y
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+source mm/Config.in
 bool 'Show crashed user process info' CONFIG_PROCESS_DEBUG
 bool 'Pseudo page fault support' CONFIG_PFAULT
 bool 'VM shared kernel support' CONFIG_SHARED_KERNEL
diff -Naur linux-2.4.25/arch/s390/defconfig linux-2.4.25-moom/arch/s390/defconfig
--- linux-2.4.25/arch/s390/defconfig	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/s390/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -50,6 +50,7 @@
 # CONFIG_PROCESS_DEBUG is not set
 CONFIG_PFAULT=y
 # CONFIG_SHARED_KERNEL is not set
+# CONFIG_OOM_KILL is not set
 
 #
 # Block device drivers
diff -Naur linux-2.4.25/arch/s390x/config.in linux-2.4.25-moom/arch/s390x/config.in
--- linux-2.4.25/arch/s390x/config.in	2004-03-12 09:44:14.000000000 +0100
+++ linux-2.4.25-moom/arch/s390x/config.in	2004-03-12 10:01:14.000000000 +0100
@@ -62,6 +62,7 @@
 define_bool CONFIG_KCORE_ELF y
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+source mm/Config.in
 bool 'Show crashed user process info' CONFIG_PROCESS_DEBUG
 bool 'Pseudo page fault support' CONFIG_PFAULT
 bool 'VM shared kernel support' CONFIG_SHARED_KERNEL
diff -Naur linux-2.4.25/arch/s390x/defconfig linux-2.4.25-moom/arch/s390x/defconfig
--- linux-2.4.25/arch/s390x/defconfig	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/s390x/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -51,6 +51,7 @@
 # CONFIG_PROCESS_DEBUG is not set
 CONFIG_PFAULT=y
 # CONFIG_SHARED_KERNEL is not set
+# CONFIG_OOM_KILL is not set
 
 #
 # Block device drivers
diff -Naur linux-2.4.25/arch/sh/config.in linux-2.4.25-moom/arch/sh/config.in
--- linux-2.4.25/arch/sh/config.in	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/sh/config.in	2004-03-12 09:55:46.000000000 +0100
@@ -284,8 +284,7 @@
 fi
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
-
-bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
+source mm/Config.in
 
 source drivers/parport/Config.in
 
@@ -492,4 +491,4 @@
 endmenu
 
 source crypto/Config.in
-source lib/Config.in
+source lib/Config.in
\ No newline at end of file
diff -Naur linux-2.4.25/arch/sh/defconfig linux-2.4.25-moom/arch/sh/defconfig
--- linux-2.4.25/arch/sh/defconfig	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/sh/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -49,6 +49,7 @@
 # CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+# CONFIG_OOM_KILL is not set
 
 #
 # Parallel port support
diff -Naur linux-2.4.25/arch/sh64/config.in linux-2.4.25-moom/arch/sh64/config.in
--- linux-2.4.25/arch/sh64/config.in	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/sh64/config.in	2004-03-12 09:57:18.000000000 +0100
@@ -154,8 +154,7 @@
 fi
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
-
-bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
+source mm/Config.in
 
 # source drivers/parport/Config.in
 
diff -Naur linux-2.4.25/arch/sh64/defconfig linux-2.4.25-moom/arch/sh64/defconfig
--- linux-2.4.25/arch/sh64/defconfig	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/sh64/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -84,6 +84,7 @@
 # CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+# CONFIG_OOM_KILL is not set
 
 #
 # Block devices
diff -Naur linux-2.4.25/arch/sparc/config.in linux-2.4.25-moom/arch/sparc/config.in
--- linux-2.4.25/arch/sparc/config.in	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/sparc/config.in	2004-03-12 09:57:55.000000000 +0100
@@ -76,7 +76,7 @@
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 bool 'SunOS binary emulation' CONFIG_SUNOS_EMUL
-bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
+source mm/Config.in
 source drivers/parport/Config.in
 dep_tristate '  Parallel printer support' CONFIG_PRINTER $CONFIG_PARPORT
 endmenu
diff -Naur linux-2.4.25/arch/sparc/defconfig linux-2.4.25-moom/arch/sparc/defconfig
--- linux-2.4.25/arch/sparc/defconfig	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/sparc/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -53,7 +53,7 @@
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
 CONFIG_SUNOS_EMUL=y
-# CONFIG_OOM_KILLER is not set
+# CONFIG_OOM_KILL is not set
 
 #
 # Parallel port support
diff -Naur linux-2.4.25/arch/sparc64/config.in linux-2.4.25-moom/arch/sparc64/config.in
--- linux-2.4.25/arch/sparc64/config.in	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/sparc64/config.in	2004-03-12 09:58:10.000000000 +0100
@@ -82,7 +82,7 @@
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
    tristate 'Solaris binary emulation (EXPERIMENTAL)' CONFIG_SOLARIS_EMUL
 fi
-bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
+source mm/Config.in
 source drivers/parport/Config.in
 dep_tristate '  Parallel printer support' CONFIG_PRINTER $CONFIG_PARPORT
 if [ "$CONFIG_PCI" = "y" ]; then
diff -Naur linux-2.4.25/arch/sparc64/defconfig linux-2.4.25-moom/arch/sparc64/defconfig
--- linux-2.4.25/arch/sparc64/defconfig	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/sparc64/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -59,7 +59,7 @@
 CONFIG_BINFMT_MISC=m
 # CONFIG_SUNOS_EMUL is not set
 CONFIG_SOLARIS_EMUL=m
-# CONFIG_OOM_KILLER is not set
+# CONFIG_OOM_KILL is not set
 
 #
 # Parallel port support
diff -Naur linux-2.4.25/arch/x86_64/config.in linux-2.4.25-moom/arch/x86_64/config.in
--- linux-2.4.25/arch/x86_64/config.in	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/x86_64/config.in	2004-03-12 10:01:32.000000000 +0100
@@ -110,6 +110,7 @@
 #tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+source mm/Config.in
 
 bool 'Power Management support' CONFIG_PM
 
diff -Naur linux-2.4.25/arch/x86_64/defconfig linux-2.4.25-moom/arch/x86_64/defconfig
--- linux-2.4.25/arch/x86_64/defconfig	2004-03-12 09:44:30.000000000 +0100
+++ linux-2.4.25-moom/arch/x86_64/defconfig	2004-03-12 10:27:55.000000000 +0100
@@ -68,6 +68,7 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_PM=y
 CONFIG_IA32_EMULATION=y
+# CONFIG_OOM_KILL is not set
 
 #
 # ACPI Support
diff -Naur linux-2.4.25/Documentation/Configure.help linux-2.4.25-moom/Documentation/Configure.help
--- linux-2.4.25/Documentation/Configure.help	2004-03-12 09:44:27.000000000 +0100
+++ linux-2.4.25-moom/Documentation/Configure.help	2004-03-12 10:27:54.000000000 +0100
@@ -412,20 +412,6 @@
   Otherwise low memory pages are used as bounce buffers causing a
   degrade in performance.
 
-OOM killer support
-CONFIG_OOM_KILLER
-   This option selects the kernel behaviour during total out of memory
-   condition. 
-
-   The default behaviour is to, as soon as no freeable memory and no swap
-   space are available, kill the task which tries to allocate memory. 
-   The default behaviour is very reliable.
-
-   If you select this option, as soon as no freeable memory is available, 
-   the kernel will try to select the "best" task to be killed.
-
-   If unsure, say N.
-
 Normal floppy disk support
 CONFIG_BLK_DEV_FD
   If you want to use the floppy disk drive(s) of your PC under Linux,
@@ -440,6 +426,21 @@
   The module will be called floppy.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
+Classic out of memory killer
+CONFIG_OOM_KILL
+  This option enables the traditional oom_kill.c mechanism for
+  killing processes in an attempt to recover from an out-of-memory
+  condition.
+
+  The default behaviour is to, as soon as no freeable memory and no swap
+  space are available, kill the task which tries to allocate memory. 
+  The default behaviour is very reliable.
+
+  If you select this option, as soon as no freeable memory is available, 
+  the kernel will try to select the "best" task to be killed.
+  
+  If unsure, say N.
+
 iSeries Virtual I/O Disk Support
 CONFIG_VIODASD
   If you are running on an iSeries system and you want to use
diff -Naur linux-2.4.25/include/linux/mm.h linux-2.4.25-moom/include/linux/mm.h
--- linux-2.4.25/include/linux/mm.h	2004-03-12 09:44:20.000000000 +0100
+++ linux-2.4.25-moom/include/linux/mm.h	2004-03-12 09:52:36.000000000 +0100
@@ -338,6 +338,8 @@
 struct zone_struct;
 extern struct zone_struct *zone_table[];
 
+extern int get_nr_swap_pages (void);
+
 static inline zone_t *page_zone(struct page *page)
 {
 	return zone_table[page->flags >> ZONE_SHIFT];
diff -Naur linux-2.4.25/include/linux/notifier.h linux-2.4.25-moom/include/linux/notifier.h
--- linux-2.4.25/include/linux/notifier.h	2003-10-07 11:18:07.000000000 +0200
+++ linux-2.4.25-moom/include/linux/notifier.h	2004-03-12 09:52:36.000000000 +0100
@@ -60,5 +60,8 @@
 
 #define NETLINK_URELEASE	0x0001	/* Unicast netlink socket released */
 
+#define OUT_OF_MEMORY  0x00001 /* Notify of critical memory shortage */
+
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
diff -Naur linux-2.4.25/include/linux/oom_notifier.h linux-2.4.25-moom/include/linux/oom_notifier.h
--- linux-2.4.25/include/linux/oom_notifier.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.25-moom/include/linux/oom_notifier.h	2004-03-12 09:52:36.000000000 +0100
@@ -0,0 +1,40 @@
+#ifndef _LINUX_OOM_NOTIFIER_H
+#define _LINUX_OOM_NOTIFIER_H
+
+
+#ifdef debug
+#undef dbg
+#endif
+#define dbg(format, arg...)					\
+do {							\
+		printk (KERN_DEBUG "Out of memory: " format "\n",	## arg);                        \
+} while(0)
+
+#ifdef warn
+#undef warn
+#endif
+#define warn(format, arg...)					  \
+do {							  \
+		printk (KERN_WARNING "Out of memory: " format "\n", ## arg);                          \
+} while(0)
+
+#ifdef info
+#undef info
+#endif
+#define info(format, arg...)					  \
+do {							  \
+		printk (KERN_INFO "Out of Memory: " format "\n", ## arg);                          \
+} while(0)
+
+#ifdef error
+#undef error
+#endif
+#define error(format, arg...)					        \
+do {							        \
+		printk (KERN_ERR "Out of Memory: " format "\n",	## arg);                                \
+} while(0)
+
+int register_oom_notifier(struct notifier_block * nb);
+int unregister_oom_notifier(struct notifier_block * nb);
+
+#endif /* _LINUX_OOM_NOTIFIER_H */
diff -Naur linux-2.4.25/include/linux/sysctl.h linux-2.4.25-moom/include/linux/sysctl.h
--- linux-2.4.25/include/linux/sysctl.h	2004-03-12 09:44:34.000000000 +0100
+++ linux-2.4.25-moom/include/linux/sysctl.h	2004-03-12 10:10:10.000000000 +0100
@@ -156,6 +156,7 @@
 	VM_MAPPED_RATIO=20,     /* amount of unfreeable pages that triggers swapout */
 	VM_LAPTOP_MODE=21,	/* kernel in laptop flush mode */
 	VM_BLOCK_DUMP=22,	/* dump fs activity to log */
+	VM_OOM=23,   /* Out of memory */
 };
 
 
@@ -810,7 +811,7 @@
 	struct list_head ctl_entry;
 };
 
-struct ctl_table_header * register_sysctl_table(ctl_table * table, 
+struct ctl_table_header * register_sysctl_table(ctl_table * table,
 						int insert_at_head);
 void unregister_sysctl_table(struct ctl_table_header * table);
 
diff -Naur linux-2.4.25/mm/Config.in linux-2.4.25-moom/mm/Config.in
--- linux-2.4.25/mm/Config.in	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.25-moom/mm/Config.in	2004-03-12 10:28:30.000000000 +0100
@@ -0,0 +1,6 @@
+mainmenu_option next_comment
+comment 'Out of memory killer'
+
+tristate 'Classic' CONFIG_OOM_KILL
+
+endmenu
diff -Naur linux-2.4.25/mm/Makefile linux-2.4.25-moom/mm/Makefile
--- linux-2.4.25/mm/Makefile	2002-08-06 09:10:56.000000000 +0200
+++ linux-2.4.25-moom/mm/Makefile	2004-03-12 10:27:54.000000000 +0100
@@ -9,13 +9,15 @@
 
 O_TARGET := mm.o
 
-export-objs := shmem.o filemap.o memory.o page_alloc.o
+export-objs := shmem.o filemap.o memory.o page_alloc.o oom_notifier.o
 
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
-	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \
-	    shmem.o
+	    page_alloc.o swap_state.o swapfile.o numa.o \
+	    shmem.o oom_notifier.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
 
+obj-$(CONFIG_OOM_KILL)  += oom_kill.o
+
 include $(TOPDIR)/Rules.make
diff -Naur linux-2.4.25/mm/oom_kill.c linux-2.4.25-moom/mm/oom_kill.c
--- linux-2.4.25/mm/oom_kill.c	2004-03-12 09:44:34.000000000 +0100
+++ linux-2.4.25-moom/mm/oom_kill.c	2004-03-12 10:27:54.000000000 +0100
@@ -13,16 +13,28 @@
  *  machine) this file will double as a 'coding guide' and a signpost
  *  for newbie kernel hackers. It features several pointers to major
  *  kernel subsystems and hints as to where to find out what things do.
+ *
+ * Modularized by using notifies by --rustyl <rusty@linux.intel.com>
+ * Final modularization (C) 2003,2004  Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
  */
 
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
 #include <linux/swapctl.h>
 #include <linux/timex.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/oom_notifier.h>
 
 /* #define DEBUG */
 
+#ifndef DEBUG
+#define dbg(format, arg...)
+#endif
+
 /**
  * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
  * @x: integer of which to calculate the sqrt
@@ -105,10 +117,7 @@
 	 */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
 		points /= 4;
-#ifdef DEBUG
-	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
-	p->pid, p->comm, points);
-#endif
+	dbg("Task %d (%s) got %d points", p->pid, p->comm, points);
 	return points;
 }
 
@@ -143,7 +152,7 @@
  */
 void oom_kill_task(struct task_struct *p)
 {
-	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
+	error("Killed process %d (%s).", p->pid, p->comm);
 
 	/*
 	 * We give our sacrificial lamb high priority and access to
@@ -199,7 +208,7 @@
 /**
  * out_of_memory - is the system out of memory?
  */
-void out_of_memory(void)
+void out_of_memory_killer(void)
 {
 	/*
 	 * oom_lock protects out_of_memory()'s static variables.
@@ -212,7 +221,7 @@
 	/*
 	 * Enough swap space left?  Not OOM.
 	 */
-	if (nr_swap_pages > 0)
+	if ( get_nr_swap_pages() > 0)
 		return;
 
 	spin_lock(&oom_lock);
@@ -270,3 +279,36 @@
 out_unlock:
 	spin_unlock(&oom_lock);
 }
+
+static int oom_notify(struct notifier_block * s, unsigned long v, void * d)
+{
+	out_of_memory_killer();
+	return 0;
+}
+
+static struct notifier_block oom_nb = {
+	.notifier_call = oom_notify,
+};
+
+static int __init init_oom_kill(void)
+{
+	int err;
+
+	info("Installing oom_kill handler");
+	err = register_oom_notifier(&oom_nb);
+	if (err)
+		error("Error installing oom_kill handler!");
+
+	return err;
+}
+
+static void __exit exit_oom_kill(void)
+{
+	unregister_oom_notifier(&oom_nb);
+	info("Unregistered oom_kill handler");
+}
+
+MODULE_LICENSE("GPL");
+
+module_init(init_oom_kill);
+module_exit(exit_oom_kill);
diff -Naur linux-2.4.25/mm/oom_notifier.c linux-2.4.25-moom/mm/oom_notifier.c
--- linux-2.4.25/mm/oom_notifier.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.25-moom/mm/oom_notifier.c	2004-03-12 10:27:54.000000000 +0100
@@ -0,0 +1,44 @@
+/*
+ * linux/mm/oom_notifier.c
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <asm/semaphore.h>
+
+static DECLARE_MUTEX(notify_mutex);
+static struct notifier_block * oom_notify_list = 0;
+
+int register_oom_notifier(struct notifier_block * nb)
+{
+	int err;
+
+	down(&notify_mutex);
+	err = notifier_chain_register(&oom_notify_list, nb);
+	up(&notify_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL(register_oom_notifier);
+
+int unregister_oom_notifier(struct notifier_block * nb)
+{
+	int err;
+
+	down(&notify_mutex);
+	err = notifier_chain_unregister(&oom_notify_list, nb);
+	up(&notify_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL(unregister_oom_notifier);
+
+void out_of_memory(void)
+{
+	down(&notify_mutex);
+	notifier_call_chain(&oom_notify_list, OUT_OF_MEMORY, 0);
+	up(&notify_mutex);
+}
+EXPORT_SYMBOL(out_of_memory);
diff -Naur linux-2.4.25/mm/page_alloc.c linux-2.4.25-moom/mm/page_alloc.c
--- linux-2.4.25/mm/page_alloc.c	2004-03-12 09:44:34.000000000 +0100
+++ linux-2.4.25-moom/mm/page_alloc.c	2004-03-12 10:27:54.000000000 +0100
@@ -495,6 +495,15 @@
 }
 
 /*
+ * Total amount of swap pages
+ */
+int get_nr_swap_pages (void)
+{
+	return nr_swap_pages;	
+}
+EXPORT_SYMBOL(get_nr_swap_pages);
+
+/*
  * Amount of free RAM allocatable as buffer memory:
  */
 unsigned int nr_free_buffer_pages (void)

--Boundary-00=_llYUAo/R+mvxM5J--
