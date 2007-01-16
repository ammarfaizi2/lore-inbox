Return-Path: <linux-kernel-owner+w=401wt.eu-S1750855AbXAPL1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbXAPL1O (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 06:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbXAPL1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 06:27:14 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:50221 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbXAPL1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 06:27:13 -0500
X-Originating-Ip: 74.109.98.130
Date: Tue, 16 Jan 2007 06:18:40 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH][REVISED] Remove "dead" kernel config variables.
Message-ID: <Pine.LNX.4.64.0701160614210.17321@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove what appear to be a number of dead kernel config variables,
that apparently have no effect on the build process.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  whoops, ignore that last patch.  it contained a single line change
to a defconfig file, which is a silly thing to do.  and this patch
adds a few more dead variables.  the dead pool:

USB_SERIAL_SAFE_PADDED
AEDSP16_MPU401
X86_XADD
PARIDE_PARPORT
AIC7XXX_PROBE_EISA_VL
AIC79XX_ENABLE_RD_STRM
SCSI_NCR53C8XX_PROFILE
53C700_IO_MAPPED
ZISOFS_FS
DLCI_COUNT
MOUSE_ATIXL
LCD_DEVICE
VIDEO_VIDEOBUF
USB_USBNET_MII
DEBUG_RWSEMS

  as before, this patch has been compile tested on x86 with "make
allyesconfig".

 Documentation/scsi/ncr53c8xx.txt     |    5 -----
 arch/i386/Kconfig.cpu                |    5 -----
 arch/um/config.release               |    1 -
 drivers/block/paride/Kconfig         |    8 +-------
 drivers/input/mouse/Kconfig          |    6 ------
 drivers/media/common/Kconfig         |    4 ----
 drivers/net/wan/Kconfig              |   11 -----------
 drivers/scsi/Kconfig                 |   16 ----------------
 drivers/scsi/aic7xxx/Kconfig.aic79xx |   12 ------------
 drivers/scsi/aic7xxx/Kconfig.aic7xxx |   10 ----------
 drivers/usb/net/Kconfig              |    6 ------
 drivers/usb/serial/Kconfig           |    4 ----
 drivers/video/backlight/Kconfig      |    5 -----
 fs/Kconfig                           |    6 ------
 lib/Kconfig.debug                    |    9 ---------
 sound/oss/Kconfig                    |   12 ------------
 16 files changed, 1 insertion(+), 119 deletions(-)

diff --git a/Documentation/scsi/ncr53c8xx.txt b/Documentation/scsi/ncr53c8xx.txt
index caf10b1..88ef88b 100644
--- a/Documentation/scsi/ncr53c8xx.txt
+++ b/Documentation/scsi/ncr53c8xx.txt
@@ -562,11 +562,6 @@ if only one has a flaw for some SCSI feature, you can disable the
 support by the driver of this feature at linux start-up and enable
 this feature after boot-up only for devices that support it safely.

-CONFIG_SCSI_NCR53C8XX_PROFILE_SUPPORT  (default answer: n)
-    This option must be set for profiling information to be gathered
-    and printed out through the proc file system. This features may
-    impact performances.
-
 CONFIG_SCSI_NCR53C8XX_IOMAPPED       (default answer: n)
     Answer "y" if you suspect your mother board to not allow memory mapped I/O.
     May slow down performance a little.  This option is required by
diff --git a/arch/i386/Kconfig.cpu b/arch/i386/Kconfig.cpu
index 2aecfba..b99c0e2 100644
--- a/arch/i386/Kconfig.cpu
+++ b/arch/i386/Kconfig.cpu
@@ -226,11 +226,6 @@ config X86_CMPXCHG
 	depends on !M386
 	default y

-config X86_XADD
-	bool
-	depends on !M386
-	default y
-
 config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || X86_GENERIC
diff --git a/arch/um/config.release b/arch/um/config.release
index fc68bcb..861b59b 100644
--- a/arch/um/config.release
+++ b/arch/um/config.release
@@ -253,7 +253,6 @@ CONFIG_LOCKD_V4=y
 # CONFIG_NCPFS_SMALLDOS is not set
 # CONFIG_NCPFS_NLS is not set
 # CONFIG_NCPFS_EXTRAS is not set
-# CONFIG_ZISOFS_FS is not set
 CONFIG_ZLIB_FS_INFLATE=m

 #
diff --git a/drivers/block/paride/Kconfig b/drivers/block/paride/Kconfig
index c0d2854..28cf308 100644
--- a/drivers/block/paride/Kconfig
+++ b/drivers/block/paride/Kconfig
@@ -2,14 +2,8 @@
 # PARIDE configuration
 #
 # PARIDE doesn't need PARPORT, but if PARPORT is configured as a module,
-# PARIDE must also be a module.  The bogus CONFIG_PARIDE_PARPORT option
-# controls the choices given to the user ...
+# PARIDE must also be a module.
 # PARIDE only supports PC style parports. Tough for USB or other parports...
-config PARIDE_PARPORT
-	tristate
-	depends on PARIDE!=n
-	default m if PARPORT_PC=m
-	default y if PARPORT_PC!=m

 comment "Parallel IDE high-level drivers"
 	depends on PARIDE
diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 35d998c..0befb49 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -60,12 +60,6 @@ config MOUSE_INPORT
 	  To compile this driver as a module, choose M here: the
 	  module will be called inport.

-config MOUSE_ATIXL
-	bool "ATI XL variant"
-	depends on MOUSE_INPORT
-	help
-	  Say Y here if your mouse is of the ATI XL variety.
-
 config MOUSE_LOGIBM
 	tristate "Logitech busmouse"
 	depends on ISA
diff --git a/drivers/media/common/Kconfig b/drivers/media/common/Kconfig
index f33e5d9..c120114 100644
--- a/drivers/media/common/Kconfig
+++ b/drivers/media/common/Kconfig
@@ -5,8 +5,4 @@ config VIDEO_SAA7146
 config VIDEO_SAA7146_VV
 	tristate
 	select VIDEO_BUF
-	select VIDEO_VIDEOBUF
 	select VIDEO_SAA7146
-
-config VIDEO_VIDEOBUF
-	tristate
diff --git a/drivers/net/wan/Kconfig b/drivers/net/wan/Kconfig
index 21f76f5..b550b51 100644
--- a/drivers/net/wan/Kconfig
+++ b/drivers/net/wan/Kconfig
@@ -344,17 +344,6 @@ config DLCI
 	  To compile this driver as a module, choose M here: the
 	  module will be called dlci.

-config DLCI_COUNT
-	int "Max open DLCI"
-	depends on DLCI
-	default "24"
-	help
-	  Maximal number of logical point-to-point frame relay connections
-	  (the identifiers of which are called DCLIs) that the driver can
-	  handle.
-
-	  The default is probably fine.
-
 config DLCI_MAX
 	int "Max DLCI per device"
 	depends on DLCI
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 60f5827..043a4af 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1184,17 +1184,6 @@ config SCSI_NCR53C8XX_SYNC
 	  There is no safe option other than using good cabling, right
 	  terminations and SCSI conformant devices.

-config SCSI_NCR53C8XX_PROFILE
-	bool "enable profiling"
-	depends on SCSI_ZALON || SCSI_NCR_Q720
-	help
-	  This option allows you to enable profiling information gathering.
-	  These statistics are not very accurate due to the low frequency
-	  of the kernel clock (100 Hz on i386) and have performance impact
-	  on systems that use very fast devices.
-
-	  The normal answer therefore is N.
-
 config SCSI_NCR53C8XX_NO_DISCONNECT
 	bool "not allow targets to disconnect"
 	depends on (SCSI_ZALON || SCSI_NCR_Q720) && SCSI_NCR53C8XX_DEFAULT_TAGS=0
@@ -1324,11 +1313,6 @@ config SCSI_SIM710

 	  It currently supports Compaq EISA cards and NCR MCA cards

-config 53C700_IO_MAPPED
-	bool
-	depends on SCSI_SIM710
-	default y
-
 config SCSI_SYM53C416
 	tristate "Symbios 53c416 SCSI support"
 	depends on ISA && SCSI
diff --git a/drivers/scsi/aic7xxx/Kconfig.aic79xx b/drivers/scsi/aic7xxx/Kconfig.aic79xx
index 911ea17..5e6620f 100644
--- a/drivers/scsi/aic7xxx/Kconfig.aic79xx
+++ b/drivers/scsi/aic7xxx/Kconfig.aic79xx
@@ -57,18 +57,6 @@ config AIC79XX_BUILD_FIRMWARE
 	or modify the assembler Makefile or the files it includes if your
 	build environment is different than that of the author.

-config AIC79XX_ENABLE_RD_STRM
-	bool "Enable Read Streaming for All Targets"
-	depends on SCSI_AIC79XX
-	default n
-	help
-	Read Streaming is a U320 protocol option that should enhance
-	performance.  Early U320 drive firmware actually performs slower
-	with read streaming enabled so it is disabled by default.  Read
-	Streaming can be configured in much the same way as tagged queueing
-	using the "rd_strm" command line option.  See
-	drivers/scsi/aic7xxx/README.aic79xx for details.
-
 config AIC79XX_DEBUG_ENABLE
 	bool "Compile in Debugging Code"
 	depends on SCSI_AIC79XX
diff --git a/drivers/scsi/aic7xxx/Kconfig.aic7xxx b/drivers/scsi/aic7xxx/Kconfig.aic7xxx
index cd93f9a..88da670 100644
--- a/drivers/scsi/aic7xxx/Kconfig.aic7xxx
+++ b/drivers/scsi/aic7xxx/Kconfig.aic7xxx
@@ -50,16 +50,6 @@ config AIC7XXX_RESET_DELAY_MS

 	Default: 5000 (5 seconds)

-config AIC7XXX_PROBE_EISA_VL
-	bool "Probe for EISA and VL AIC7XXX Adapters"
-	depends on SCSI_AIC7XXX && EISA
-	help
-	Probe for EISA and VLB Aic7xxx controllers.  In many newer systems,
-	the invasive probes necessary to detect these controllers can cause
-	other devices to fail.  For this reason, the non-PCI probe code is
-	disabled by default.  The current value of this option can be "toggled"
-	via the no_probe kernel command line option.
-
 config AIC7XXX_BUILD_FIRMWARE
 	bool "Build Adapter Firmware with Kernel Build"
 	depends on SCSI_AIC7XXX && !PREVENT_FIRMWARE_BUILD
diff --git a/drivers/usb/net/Kconfig b/drivers/usb/net/Kconfig
index e081836..93270f9 100644
--- a/drivers/usb/net/Kconfig
+++ b/drivers/usb/net/Kconfig
@@ -92,10 +92,6 @@ config USB_RTL8150
 	  To compile this driver as a module, choose M here: the
 	  module will be called rtl8150.

-config USB_USBNET_MII
-	tristate
-	default n
-
 config USB_USBNET
 	tristate "Multi-purpose USB Networking Framework"
 	select MII if USBNET_MII != n
@@ -134,7 +130,6 @@ config USB_NET_AX8817X
 	tristate "ASIX AX88xxx Based USB 2.0 Ethernet Adapters"
 	depends on USB_USBNET && NET_ETHERNET
 	select CRC32
-	select USB_USBNET_MII
 	default y
 	help
 	  This option adds support for ASIX AX88xxx based USB 2.0
@@ -215,7 +210,6 @@ config USB_NET_PLUSB
 config USB_NET_MCS7830
 	tristate "MosChip MCS7830 based Ethernet adapters"
 	depends on USB_USBNET
-	select USB_USBNET_MII
 	help
 	  Choose this option if you're using a 10/100 Ethernet USB2
 	  adapter based on the MosChip 7830 controller. This includes
diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 2f4d303..76b2d7b 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -477,10 +477,6 @@ config USB_SERIAL_SAFE
 	tristate "USB Safe Serial (Encapsulated) Driver (EXPERIMENTAL)"
 	depends on USB_SERIAL && EXPERIMENTAL

-config USB_SERIAL_SAFE_PADDED
-	bool "USB Secure Encapsulated Driver - Padded"
-	depends on USB_SERIAL_SAFE
-
 config USB_SERIAL_SIERRAWIRELESS
 	tristate "USB Sierra Wireless Driver"
 	depends on USB_SERIAL
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 02f1529..c406f58 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -37,11 +37,6 @@ config LCD_CLASS_DEVICE
 	  To have support for your specific LCD panel you will have to
 	  select the proper drivers which depend on this option.

-config LCD_DEVICE
-	bool
-	depends on LCD_CLASS_DEVICE
-	default y
-
 config BACKLIGHT_CORGI
 	tristate "Sharp Corgi Backlight Driver (SL Series)"
 	depends on BACKLIGHT_DEVICE && PXA_SHARPSL
diff --git a/fs/Kconfig b/fs/Kconfig
index 8cd2417..5fb82af 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -675,12 +675,6 @@ config ZISOFS
 	  necessary to create such a filesystem.  Say Y here if you want to be
 	  able to read such compressed CD-ROMs.

-config ZISOFS_FS
-# for fs/nls/Config.in
-	tristate
-	depends on ZISOFS
-	default ISO9660_FS
-
 config UDF_FS
 	tristate "UDF file system support"
 	help
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5c26818..356a5ab 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -181,19 +181,11 @@ config DEBUG_MUTEXES
 	 This feature allows mutex semantics violations to be detected and
 	 reported.

-config DEBUG_RWSEMS
-	bool "RW-sem debugging: basic checks"
-	depends on DEBUG_KERNEL
-	help
-	 This feature allows read-write semaphore semantics violations to
-	 be detected and reported.
-
 config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
-	select DEBUG_RWSEMS
 	select LOCKDEP
 	help
 	 This feature will check whether any held lock (spinlock, rwlock,
@@ -209,7 +201,6 @@ config PROVE_LOCKING
 	select LOCKDEP
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
-	select DEBUG_RWSEMS
 	select DEBUG_LOCK_ALLOC
 	default n
 	help
diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
index a0588c2..18ef936 100644
--- a/sound/oss/Kconfig
+++ b/sound/oss/Kconfig
@@ -705,18 +705,6 @@ config AEDSP16_SBPRO

 endchoice

-config AEDSP16_MPU401
-	bool "Audio Excel DSP 16 (MPU401 emulation)"
-	depends on SOUND_AEDSP16 && SOUND_MPU401
-	help
-	  Answer Y if you want your audio card to emulate the MPU-401 midi
-	  interface. You should then also say Y to "MPU-401 support".
-
-	  Note that the I/O base for MPU-401 support of aedsp16 is the same
-	  you have selected for "MPU-401 support". If you are using this
-	  driver as a module you have to specify the MPU I/O base address with
-	  the parameter 'mpu_base=0xNNN'.
-
 config SOUND_VIDC
 	tristate "VIDC 16-bit sound"
 	depends on ARM && (ARCH_ACORN || ARCH_CLPS7500) && SOUND_OSS
