Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131538AbRBJTj1>; Sat, 10 Feb 2001 14:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131641AbRBJTjR>; Sat, 10 Feb 2001 14:39:17 -0500
Received: from ns.caldera.de ([212.34.180.1]:51464 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131538AbRBJTi5>;
	Sat, 10 Feb 2001 14:38:57 -0500
Date: Sat, 10 Feb 2001 20:38:18 +0100
From: Christoph Hellwig <hch@caldera.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix config.in bugs
Message-ID: <20010210203818.B8973@caldera.de>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this patch fixes a bunch of wrong uses of the config language.
Remaining problems are:

  - cris uses a 'hwaddr' symbol (MAC address?) that is not supported
    by any interpreter
  - a few symbols do not yet have the CONFIG_ prefix (also mostly cris)
  - ppc does some strange stuff with define_bool and choices.

Please consisder applying for 2.4.2.

	Christoph


-- 
Of course it doesn't work. We've performed a software upgrade.


diff -uNr linux-2.4.2-pre3/arch/cris/config.in linux/arch/cris/config.in
--- linux-2.4.2-pre3/arch/cris/config.in	Sat Feb 10 20:03:13 2001
+++ linux/arch/cris/config.in	Sat Feb 10 20:08:07 2001
@@ -14,21 +14,21 @@
 mainmenu_option next_comment
 comment 'General setup'
 
-bool 'Networking support' CONFIG_NET y
-bool 'System V IPC' CONFIG_SYSVIPC y
+bool 'Networking support' CONFIG_NET
+bool 'System V IPC' CONFIG_SYSVIPC
 
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF y
+tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
   tristate 'Kernel support for JAVA binaries' CONFIG_BINFMT_JAVA
 fi
 
-bool 'Use kernel gdb debugger' CONFIG_KGDB n
+bool 'Use kernel gdb debugger' CONFIG_KGDB
 
-bool 'Enable Etrax100 watchdog' CONFIG_ETRAX_WATCHDOG y
+bool 'Enable Etrax100 watchdog' CONFIG_ETRAX_WATCHDOG
 
-bool 'Use serial console (on the debug port)' CONFIG_USE_SERIAL_CONSOLE y
+bool 'Use serial console (on the debug port)' CONFIG_USE_SERIAL_CONSOLE
 
-bool 'Use in-kernel ifconfig/route setup' CONFIG_KERNEL_IFCONFIG n
+bool 'Use in-kernel ifconfig/route setup' CONFIG_KERNEL_IFCONFIG
 
 endmenu
 
diff -uNr linux-2.4.2-pre3/arch/ia64/config.in linux/arch/ia64/config.in
--- linux-2.4.2-pre3/arch/ia64/config.in	Thu Jan  4 21:50:17 2001
+++ linux/arch/ia64/config.in	Sat Feb 10 20:08:53 2001
@@ -70,7 +70,7 @@
 	if [ "$CONFIG_ITANIUM_BSTEP_SPECIFIC" = "y" ]; then
 	  bool '    Enable Itanium B0-step specific code' CONFIG_ITANIUM_B0_SPECIFIC
 	fi
-	bool '  Enable SGI Medusa Simulator Support' CONFIG_IA64_SGI_SN1_SIM n
+	bool '  Enable SGI Medusa Simulator Support' CONFIG_IA64_SGI_SN1_SIM
 	define_bool CONFIG_DEVFS_DEBUG y
 	define_bool CONFIG_DEVFS_FS y
 	define_bool CONFIG_IA64_BRL_EMU y
@@ -79,8 +79,8 @@
 	define_bool CONFIG_SGI_IOC3_ETH y
 	define_bool CONFIG_PERCPU_IRQ y
 	define_int  CONFIG_CACHE_LINE_SHIFT 7
-	bool '  Enable DISCONTIGMEM support' CONFIG_DISCONTIGMEM y
-	bool '	Enable NUMA support' CONFIG_NUMA y
+	bool '  Enable DISCONTIGMEM support' CONFIG_DISCONTIGMEM
+	bool '	Enable NUMA support' CONFIG_NUMA
 fi
 
 define_bool CONFIG_KCORE_ELF y	# On IA-64, we always want an ELF /proc/kcore.
diff -uNr linux-2.4.2-pre3/arch/m68k/config.in linux/arch/m68k/config.in
--- linux-2.4.2-pre3/arch/m68k/config.in	Thu Jan  4 22:00:55 2001
+++ linux/arch/m68k/config.in	Sat Feb 10 20:11:25 2001
@@ -487,8 +487,10 @@
    fi
 fi
 if [ "$CONFIG_APOLLO" = "y" ]; then
-   bool 'Support for DN serial port (dummy)' CONFIG_SERIAL
+   bool 'Support for DN serial port (dummy)' CONFIG_DN_SERIAL
    bool 'Support for serial port console' CONFIG_SERIAL_CONSOLE
+
+   define_tristate CONFIG_SERIAL $CONFIG_DN_SERIAL
 fi 
 bool 'Support for user serial device modules' CONFIG_USERIAL
 bool 'Watchdog Timer Support'	CONFIG_WATCHDOG
diff -uNr linux-2.4.2-pre3/arch/mips/config.in linux/arch/mips/config.in
--- linux-2.4.2-pre3/arch/mips/config.in	Thu Nov 16 21:51:28 2000
+++ linux/arch/mips/config.in	Sat Feb 10 20:12:01 2001
@@ -329,7 +329,10 @@
 #   if [ "$CONFIG_ACCESSBUS" = "y" ]; then
 #      bool 'MAXINE Access.Bus mouse (VSXXX-BB/GB) support' CONFIG_DTOP_MOUSE
 #   fi
-   bool 'Enhanced Real Time Clock Support' CONFIG_RTC
+   bool 'Enhanced Real Time Clock Support' CONFIG_MIPS_RTC
+
+   define_tristate CONFIG_RTC $CONFIG_MIPS_RTC
+
    endmenu
 fi
 
diff -uNr linux-2.4.2-pre3/arch/parisc/config.in linux/arch/parisc/config.in
--- linux-2.4.2-pre3/arch/parisc/config.in	Tue Dec  5 21:29:39 2000
+++ linux/arch/parisc/config.in	Sat Feb 10 20:09:22 2001
@@ -25,14 +25,14 @@
 # bool 'GSC/Gecko bus support' CONFIG_GSC y
 define_bool CONFIG_GSC y
 
-bool 'U2/Uturn I/O MMU' CONFIG_IOMMU_CCIO y
-bool 'LASI I/O support' CONFIG_GSC_LASI y
+bool 'U2/Uturn I/O MMU' CONFIG_IOMMU_CCIO
+bool 'LASI I/O support' CONFIG_GSC_LASI
 
-bool 'PCI bus support' CONFIG_PCI y
+bool 'PCI bus support' CONFIG_PCI
 
 if [ "$CONFIG_PCI" = "y" ]; then
-	bool 'GSCtoPCI/DINO PCI support' CONFIG_GSC_DINO y
-	bool 'LBA/Elroy PCI support' CONFIG_PCI_LBA n
+	bool 'GSCtoPCI/DINO PCI support' CONFIG_GSC_DINO
+	bool 'LBA/Elroy PCI support' CONFIG_PCI_LBA
 fi 
 
 if [ "$CONFIG_PCI_LBA" = "y" ]; then
diff -uNr linux-2.4.2-pre3/arch/sparc/config.in linux/arch/sparc/config.in
--- linux-2.4.2-pre3/arch/sparc/config.in	Sat Feb  3 14:51:11 2001
+++ linux/arch/sparc/config.in	Sat Feb 10 20:09:50 2001
@@ -183,8 +183,8 @@
    mainmenu_option next_comment
    comment 'SCSI low-level drivers'
 
-   tristate 'Sparc ESP Scsi Driver' CONFIG_SCSI_SUNESP $CONFIG_SCSI
-   tristate 'PTI Qlogic,ISP Driver' CONFIG_SCSI_QLOGICPTI $CONFIG_SCSI
+   dep_tristate 'Sparc ESP Scsi Driver' CONFIG_SCSI_SUNESP $CONFIG_SCSI
+   dep_tristate 'PTI Qlogic,ISP Driver' CONFIG_SCSI_QLOGICPTI $CONFIG_SCSI
    endmenu
 fi
 endmenu
diff -uNr linux-2.4.2-pre3/arch/sparc64/config.in linux/arch/sparc64/config.in
--- linux-2.4.2-pre3/arch/sparc64/config.in	Sat Feb  3 14:51:11 2001
+++ linux/arch/sparc64/config.in	Sat Feb 10 20:10:26 2001
@@ -161,15 +161,15 @@
    mainmenu_option next_comment
    comment 'SCSI low-level drivers'
 
-   tristate 'Sparc ESP Scsi Driver' CONFIG_SCSI_SUNESP $CONFIG_SCSI
-   tristate 'PTI Qlogic, ISP Driver' CONFIG_SCSI_QLOGICPTI $CONFIG_SCSI
+   dep_tristate 'Sparc ESP Scsi Driver' CONFIG_SCSI_SUNESP $CONFIG_SCSI
+   dep_tristate 'PTI Qlogic, ISP Driver' CONFIG_SCSI_QLOGICPTI $CONFIG_SCSI
 
    if [ "$CONFIG_PCI" != "n" ]; then
       dep_tristate 'Adaptec AIC7xxx support' CONFIG_SCSI_AIC7XXX $CONFIG_SCSI
       if [ "$CONFIG_SCSI_AIC7XXX" != "n" ]; then
 	 bool '  Enable tagged command queueing (TCQ) by default' CONFIG_AIC7XXX_TAGGED_QUEUEING
 	 int  '  Maximum number of TCQ commands per device' CONFIG_AIC7XXX_CMDS_PER_DEVICE 8
-  	 bool '  Collect statistics to report in /proc' CONFIG_AIC7XXX_PROC_STATS N
+  	 bool '  Collect statistics to report in /proc' CONFIG_AIC7XXX_PROC_STATS
 	 int  '  Delay in seconds after SCSI bus reset' CONFIG_AIC7XXX_RESET_DELAY 5
       fi
       dep_tristate 'NCR53C8XX SCSI support' CONFIG_SCSI_NCR53C8XX $CONFIG_SCSI
diff -uNr linux-2.4.2-pre3/drivers/atm/Config.in linux/drivers/atm/Config.in
--- linux-2.4.2-pre3/drivers/atm/Config.in	Fri Dec 29 23:35:47 2000
+++ linux/drivers/atm/Config.in	Sat Feb 10 20:06:10 2001
@@ -56,7 +56,7 @@
   tristate 'FORE Systems 200E-series' CONFIG_ATM_FORE200E_MAYBE
   if [ "$CONFIG_ATM_FORE200E_MAYBE" != "n" ]; then
     if [ "$CONFIG_PCI" = "y" ]; then
-      bool '  PCA-200E support' CONFIG_ATM_FORE200E_PCA y
+      bool '  PCA-200E support' CONFIG_ATM_FORE200E_PCA
       if [ "$CONFIG_ATM_FORE200E_PCA" = "y" ]; then
 	bool '   Use default PCA-200E firmware (normally enabled)' CONFIG_ATM_FORE200E_PCA_DEFAULT_FW
         if [ "$CONFIG_ATM_FORE200E_PCA_DEFAULT_FW" = "n" ]; then
@@ -65,7 +65,7 @@
       fi
     fi
     if [ "$CONFIG_SBUS" = "y" ]; then
-      bool '  SBA-200E support' CONFIG_ATM_FORE200E_SBA y
+      bool '  SBA-200E support' CONFIG_ATM_FORE200E_SBA
       if [ "$CONFIG_ATM_FORE200E_SBA" = "y" ]; then
         bool '   Use default SBA-200E firmware (normally enabled)' CONFIG_ATM_FORE200E_SBA_DEFAULT_FW
         if [ "$CONFIG_ATM_FORE200E_SBA_DEFAULT_FW" = "n" ]; then
diff -uNr linux-2.4.2-pre3/drivers/char/Config.in linux/drivers/char/Config.in
--- linux-2.4.2-pre3/drivers/char/Config.in	Fri Dec 29 23:07:21 2000
+++ linux/drivers/char/Config.in	Sat Feb 10 20:06:21 2001
@@ -176,7 +176,7 @@
 fi
 endmenu
 
-tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
+dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
 if [ "$CONFIG_AGP" != "n" ]; then
    bool '  Intel 440LX/BX/GX and I815/I840/I850 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815 (on-board) support' CONFIG_AGP_I810
diff -uNr linux-2.4.2-pre3/drivers/media/video/Config.in linux/drivers/media/video/Config.in
--- linux-2.4.2-pre3/drivers/media/video/Config.in	Wed Aug 23 23:59:55 2000
+++ linux/drivers/media/video/Config.in	Sat Feb 10 20:06:41 2001
@@ -23,7 +23,7 @@
 fi
 dep_tristate '  CPiA Video For Linux' CONFIG_VIDEO_CPIA $CONFIG_VIDEO_DEV
 if [ "$CONFIG_VIDEO_CPIA" != "n" ]; then
-  if [ "CONFIG_PARPORT_1284" != "n" ]; then
+  if [ "$CONFIG_PARPORT_1284" != "n" ]; then
     dep_tristate '    CPiA Parallel Port Lowlevel Support' CONFIG_VIDEO_CPIA_PP $CONFIG_VIDEO_CPIA $CONFIG_PARPORT
   fi
   if [ "$CONFIG_USB" != "n" ]; then
diff -uNr linux-2.4.2-pre3/drivers/usb/serial/Config.in linux/drivers/usb/serial/Config.in
--- linux-2.4.2-pre3/drivers/usb/serial/Config.in	Sat Feb  3 14:51:13 2001
+++ linux/drivers/usb/serial/Config.in	Sat Feb 10 20:06:58 2001
@@ -4,7 +4,7 @@
 mainmenu_option next_comment
 comment 'USB Serial Converter support'
 
-tristate 'USB Serial Converter support' CONFIG_USB_SERIAL $CONFIG_USB
+dep_tristate 'USB Serial Converter support' CONFIG_USB_SERIAL $CONFIG_USB
 if [ "$CONFIG_USB_SERIAL" != "n" ]; then
   bool '  USB Serial Converter verbose debug' CONFIG_USB_SERIAL_DEBUG
   bool '  USB Generic Serial Driver' CONFIG_USB_SERIAL_GENERIC
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
