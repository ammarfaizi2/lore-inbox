Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbVLWCP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbVLWCP3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 21:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVLWCP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 21:15:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51464 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030354AbVLWCP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 21:15:28 -0500
Date: Fri, 23 Dec 2005 03:15:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: gmack@innerfire.net, wli@holomorphy.com, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [2.6 patch] introduce a SPARC Kconfig symbol
Message-ID: <20051223021526.GG27525@stusta.de>
References: <20051216222154.GK23349@stusta.de> <Pine.LNX.4.64.0512161908460.20531@innerfire.net> <20051217141049.GP23349@stusta.de> <20051219.145254.33863414.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219.145254.33863414.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 02:52:54PM -0800, David S. Miller wrote:
>...
> > BTW: @sparc maintainers:
> >      Is there any reason against introducing a SPARC Kconfig symbol
> >      that is set on both the sparc and sparc64 architectures?
> 
> That's a great idea, I thought we already did this in fact :)

Patch below.

cu
Adrian


<--  snip  -->


Introduce a Kconfig symbol SPARC that is defined on both the sparc and 
sparc64 architectures.

This symbol makes some dependencies more readable.

Except for all bugs this patch deliberately introduces ;-) it shouldn't 
cause any visible change.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/sparc/Kconfig            |    4 ++++
 arch/sparc64/Kconfig          |    4 ++++
 drivers/char/Kconfig          |    4 ++--
 drivers/char/keyboard.c       |   10 +++++-----
 drivers/fc4/Kconfig           |    8 ++++----
 drivers/input/misc/Kconfig    |    2 +-
 drivers/input/serio/i8042.h   |    2 +-
 drivers/mtd/maps/Kconfig      |    2 +-
 drivers/serial/Kconfig        |   10 +++++-----
 drivers/video/Kconfig         |   10 +++++-----
 drivers/video/console/Kconfig |   20 ++++++++++----------
 drivers/video/logo/Kconfig    |    2 +-
 fs/partitions/Kconfig         |    2 +-
 sound/sparc/Kconfig           |    2 +-
 14 files changed, 45 insertions(+), 37 deletions(-)

--- linux-git/arch/sparc/Kconfig.old	2005-12-23 01:59:27.000000000 +0100
+++ linux-git/arch/sparc/Kconfig	2005-12-23 01:59:45.000000000 +0100
@@ -55,6 +55,10 @@
 	depends on SMP
 	default "32"
 
+config SPARC
+	bool
+	default y
+
 # Identify this as a Sparc32 build
 config SPARC32
 	bool
--- linux-git/arch/sparc64/Kconfig.old	2005-12-23 01:59:55.000000000 +0100
+++ linux-git/arch/sparc64/Kconfig	2005-12-23 02:00:14.000000000 +0100
@@ -5,6 +5,10 @@
 
 mainmenu "Linux/UltraSPARC Kernel Configuration"
 
+config SPARC
+	bool
+	default y
+
 config SPARC64
 	bool
 	default y
--- linux-git/drivers/char/Kconfig.old	2005-12-23 02:02:05.000000000 +0100
+++ linux-git/drivers/char/Kconfig	2005-12-23 02:04:01.000000000 +0100
@@ -687,7 +687,7 @@
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64 && !M68K && (!(SPARC32 || SPARC64) || PCI)
+	depends on !PPC32 && !PARISC && !IA64 && !M68K && (!SPARC || PCI)
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -735,7 +735,7 @@
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC32 && !SPARC64
+	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
--- linux-git/drivers/char/keyboard.c.old	2005-12-23 02:02:56.000000000 +0100
+++ linux-git/drivers/char/keyboard.c	2005-12-23 02:16:03.000000000 +0100
@@ -930,8 +930,8 @@
 }
 
 #if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_ALPHA) ||\
-    defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_SPARC32) ||\
-    defined(CONFIG_SPARC64) || defined(CONFIG_PARISC) || defined(CONFIG_SUPERH) ||\
+    defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_SPARC) ||\
+    defined(CONFIG_PARISC) || defined(CONFIG_SUPERH) ||\
     (defined(CONFIG_ARM) && defined(CONFIG_KEYBOARD_ATKBD) && !defined(CONFIG_ARCH_RPC))
 
 #define HW_RAW(dev) (test_bit(EV_MSC, dev->evbit) && test_bit(MSC_RAW, dev->mscbit) &&\
@@ -958,7 +958,7 @@
 extern int mac_hid_mouse_emulate_buttons(int, int, int);
 #endif /* CONFIG_MAC_EMUMOUSEBTN */
 
-#if defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
+#ifdef CONFIG_SPARC
 static int sparc_l1_a_state = 0;
 extern void sun_do_break(void);
 #endif
@@ -1045,7 +1045,7 @@
 
 	if (keycode == KEY_LEFTALT || keycode == KEY_RIGHTALT)
 		sysrq_alt = down;
-#if defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
+#ifdef CONFIG_SPARC
 	if (keycode == KEY_STOP)
 		sparc_l1_a_state = down;
 #endif
@@ -1072,7 +1072,7 @@
 		return;
 	}
 #endif
-#if defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
+#ifdef CONFIG_SPARC
 	if (keycode == KEY_A && sparc_l1_a_state) {
 		sparc_l1_a_state = 0;
 		sun_do_break();
--- linux-git/drivers/fc4/Kconfig.old	2005-12-23 02:04:15.000000000 +0100
+++ linux-git/drivers/fc4/Kconfig	2005-12-23 02:04:40.000000000 +0100
@@ -26,7 +26,7 @@
 
 config FC4_SOC
 	tristate "Sun SOC/Sbus"
-	depends on FC4!=n && (SPARC32 || SPARC64)
+	depends on FC4!=n && SPARC
 	help
 	  Serial Optical Channel is an interface card with one or two Fibre
 	  Optic ports, each of which can be connected to a disk array. Note
@@ -38,7 +38,7 @@
 
 config FC4_SOCAL
 	tristate "Sun SOC+ (aka SOCAL)"
-	depends on FC4!=n && (SPARC32 || SPARC64)
+	depends on FC4!=n && SPARC
 	---help---
 	  Serial Optical Channel Plus is an interface card with up to two
 	  Fibre Optic ports. This card supports FC Arbitrated Loop (usually
@@ -62,7 +62,7 @@
 	  be called pluto.
 
 config SCSI_FCAL
-	tristate "Sun Enterprise Network Array (A5000 and EX500)" if SPARC32 || SPARC64
+	tristate "Sun Enterprise Network Array (A5000 and EX500)" if SPARC
 	depends on FC4!=n && SCSI
 	help
 	  This driver drives FC-AL disks connected through a Fibre Channel
@@ -75,7 +75,7 @@
 
 config SCSI_FCAL
 	prompt "Generic FC-AL disk driver"
-	depends on FC4!=n && SCSI && !SPARC32 && !SPARC64
+	depends on FC4!=n && SCSI && !SPARC
 
 endmenu
 
--- linux-git/drivers/input/misc/Kconfig.old	2005-12-23 02:04:49.000000000 +0100
+++ linux-git/drivers/input/misc/Kconfig	2005-12-23 02:04:56.000000000 +0100
@@ -26,7 +26,7 @@
 
 config INPUT_SPARCSPKR
 	tristate "SPARC Speaker support"
-	depends on PCI && (SPARC32 || SPARC64)
+	depends on PCI && SPARC
 	help
 	  Say Y here if you want the standard Speaker on Sparc PCI systems
 	  to be used for bells and whistles.
--- linux-git/drivers/input/serio/i8042.h.old	2005-12-23 02:05:07.000000000 +0100
+++ linux-git/drivers/input/serio/i8042.h	2005-12-23 02:05:19.000000000 +0100
@@ -21,7 +21,7 @@
 #include "i8042-ip22io.h"
 #elif defined(CONFIG_PPC)
 #include "i8042-ppcio.h"
-#elif defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
+#elif defined(CONFIG_SPARC)
 #include "i8042-sparcio.h"
 #elif defined(CONFIG_X86) || defined(CONFIG_IA64)
 #include "i8042-x86ia64io.h"
--- linux-git/drivers/mtd/maps/Kconfig.old	2005-12-23 02:05:31.000000000 +0100
+++ linux-git/drivers/mtd/maps/Kconfig	2005-12-23 02:05:57.000000000 +0100
@@ -62,7 +62,7 @@
 
 config MTD_SUN_UFLASH
 	tristate "Sun Microsystems userflash support"
-	depends on (SPARC32 || SPARC64) && MTD_CFI
+	depends on SPARC && MTD_CFI
 	help
 	  This provides a 'mapping' driver which supports the way in
 	  which user-programmable flash chips are connected on various
--- linux-git/drivers/serial/Kconfig.old	2005-12-23 02:06:27.000000000 +0100
+++ linux-git/drivers/serial/Kconfig	2005-12-23 02:06:59.000000000 +0100
@@ -10,7 +10,7 @@
 # The new 8250/16550 serial drivers
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
-	depends on (BROKEN || !(SPARC64 || SPARC32))
+	depends on (BROKEN || !SPARC)
 	select SERIAL_CORE
 	---help---
 	  This selects whether you want to include the driver for the standard
@@ -469,14 +469,14 @@
 
 config SERIAL_SUNCORE
 	bool
-	depends on SPARC32 || SPARC64
+	depends on SPARC
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	default y
 
 config SERIAL_SUNZILOG
 	tristate "Sun Zilog8530 serial support"
-	depends on SPARC32 || SPARC64
+	depends on SPARC
 	help
 	  This driver supports the Zilog8530 serial ports found on many Sparc
 	  systems.  Say Y or M if you want to be able to these serial ports.
@@ -491,7 +491,7 @@
 
 config SERIAL_SUNSU
 	tristate "Sun SU serial support"
-	depends on (SPARC32 || SPARC64) && PCI
+	depends on SPARC && PCI
 	help
 	  This driver supports the 8250 serial ports that run the keyboard and
 	  mouse on (PCI) UltraSPARC systems.  Say Y or M if you want to be able
@@ -547,7 +547,7 @@
 
 config SERIAL_SUNSAB
 	tristate "Sun Siemens SAB82532 serial support"
-	depends on (SPARC32 || SPARC64) && PCI
+	depends on SPARC && PCI
 	help
 	  This driver supports the Siemens SAB82532 DUSCC serial ports on newer
 	  (PCI) UltraSPARC systems.  Say Y or M if you want to be able to these
--- linux-git/drivers/video/Kconfig.old	2005-12-23 02:07:15.000000000 +0100
+++ linux-git/drivers/video/Kconfig	2005-12-23 02:07:56.000000000 +0100
@@ -536,13 +536,13 @@
 
 config FB_SBUS
 	bool "SBUS and UPA framebuffers"
-	depends on (FB = y) && (SPARC32 || SPARC64)
+	depends on (FB = y) && SPARC
 	help
 	  Say Y if you want support for SBUS or UPA based frame buffer device.
 
 config FB_BW2
 	bool "BWtwo support"
-	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
+	depends on (FB = y) && (SPARC && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -551,7 +551,7 @@
 
 config FB_CG3
 	bool "CGthree support"
-	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
+	depends on (FB = y) && (SPARC && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -560,7 +560,7 @@
 
 config FB_CG6
 	bool "CGsix (GX,TurboGX) support"
-	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
+	depends on (FB = y) && (SPARC && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	help
@@ -1268,7 +1268,7 @@
 
 config FB_PCI
 	bool "PCI framebuffers"
-	depends on (FB = y) && PCI && (SPARC64 || SPARC32)
+	depends on (FB = y) && PCI && SPARC
 
 config FB_IGA
 	bool "IGA 168x display support"
--- linux-git/drivers/video/console/Kconfig.old	2005-12-23 02:08:08.000000000 +0100
+++ linux-git/drivers/video/console/Kconfig	2005-12-23 02:18:30.000000000 +0100
@@ -6,7 +6,7 @@
 
 config VGA_CONSOLE
 	bool "VGA text console" if EMBEDDED || !X86
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32 && !SPARC64 && !M68K && !PARISC && !ARCH_VERSATILE
+	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !ARCH_VERSATILE
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
@@ -68,7 +68,7 @@
 
 config PROM_CONSOLE
 	bool "PROM console"
-	depends on SPARC32 || SPARC64
+	depends on SPARC
 	help
 	  Say Y to build a console driver for Sun machines that uses the
 	  terminal emulation built into their console PROMS.
@@ -136,7 +136,7 @@
 config FONT_8x8
 	bool "VGA 8x8 font" if FONTS
 	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE
-	default y if !SPARC32 && !SPARC64 && !FONTS
+	default y if !SPARC && !FONTS
 	help
 	  This is the "high resolution" font for the VGA frame buffer (the one
 	  provided by the text console 80x50 (and higher) modes).
@@ -150,7 +150,7 @@
 config FONT_8x16
 	bool "VGA 8x16 font" if FONTS
 	depends on FRAMEBUFFER_CONSOLE || SGI_NEWPORT_CONSOLE=y || STI_CONSOLE || USB_SISUSBVGA_CON 
-	default y if !SPARC32 && !SPARC64 && !FONTS
+	default y if !SPARC && !FONTS
 	help
 	  This is the "high resolution" font for the VGA frame buffer (the one
 	  provided by the VGA text console 80x25 mode.
@@ -160,7 +160,7 @@
 config FONT_6x11
 	bool "Mac console 6x11 font (not supported by all drivers)" if FONTS
 	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE
-	default y if !SPARC32 && !SPARC64 && !FONTS && MAC
+	default y if !SPARC && !FONTS && MAC
 	help
 	  Small console font with Macintosh-style high-half glyphs.  Some Mac
 	  framebuffer drivers don't support this one at all.
@@ -176,7 +176,7 @@
 config FONT_PEARL_8x8
 	bool "Pearl (old m68k) console 8x8 font" if FONTS
 	depends on FRAMEBUFFER_CONSOLE
-	default y if !SPARC32 && !SPARC64 && !FONTS && AMIGA
+	default y if !SPARC && !FONTS && AMIGA
 	help
 	  Small console font with PC-style control-character and high-half
 	  glyphs.
@@ -184,24 +184,24 @@
 config FONT_ACORN_8x8
 	bool "Acorn console 8x8 font" if FONTS
 	depends on FRAMEBUFFER_CONSOLE
-	default y if !SPARC32 && !SPARC64 && !FONTS && ARM && ARCH_ACORN
+	default y if !SPARC && !FONTS && ARM && ARCH_ACORN
 	help
 	  Small console font with PC-style control characters and high-half
 	  glyphs.
 
 config FONT_MINI_4x6
 	bool "Mini 4x6 font"
-	depends on !SPARC32 && !SPARC64 && FONTS
+	depends on !SPARC && FONTS
 
 config FONT_SUN8x16
 	bool "Sparc console 8x16 font"
-	depends on FRAMEBUFFER_CONSOLE && (!SPARC32 && !SPARC64 && FONTS || SPARC32 || SPARC64)
+	depends on FRAMEBUFFER_CONSOLE && (!SPARC && FONTS || SPARC)
 	help
 	  This is the high resolution console font for Sun machines. Say Y.
 
 config FONT_SUN12x22
 	bool "Sparc console 12x22 font (not supported by all drivers)"
-	depends on FRAMEBUFFER_CONSOLE && (!SPARC32 && !SPARC64 && FONTS || SPARC32 || SPARC64)
+	depends on FRAMEBUFFER_CONSOLE && (!SPARC && FONTS || SPARC)
 	help
 	  This is the high resolution console font for Sun machines with very
 	  big letters (like the letters used in the SPARC PROM). If the
--- linux-git/drivers/video/logo/Kconfig.old	2005-12-23 02:12:31.000000000 +0100
+++ linux-git/drivers/video/logo/Kconfig	2005-12-23 02:12:40.000000000 +0100
@@ -47,7 +47,7 @@
 
 config LOGO_SUN_CLUT224
 	bool "224-color Sun Linux logo"
-	depends on LOGO && (SPARC32 || SPARC64)
+	depends on LOGO && SPARC
 	default y
 
 config LOGO_SUPERH_MONO
--- linux-git/fs/partitions/Kconfig.old	2005-12-23 02:12:50.000000000 +0100
+++ linux-git/fs/partitions/Kconfig	2005-12-23 02:13:00.000000000 +0100
@@ -203,7 +203,7 @@
 
 config SUN_PARTITION
 	bool "Sun partition tables support" if PARTITION_ADVANCED
-	default y if (SPARC32 || SPARC64 || SUN3 || SUN3X)
+	default y if (SPARC || SUN3 || SUN3X)
 	---help---
 	  Like most systems, SunOS uses its own hard disk partition table
 	  format, incompatible with all others. Saying Y here allows you to
--- linux-git/sound/sparc/Kconfig.old	2005-12-23 02:13:11.000000000 +0100
+++ linux-git/sound/sparc/Kconfig	2005-12-23 02:13:18.000000000 +0100
@@ -1,7 +1,7 @@
 # ALSA Sparc drivers
 
 menu "ALSA Sparc devices"
-	depends on SND!=n && (SPARC32 || SPARC64)
+	depends on SND!=n && SPARC
 
 config SND_SUN_AMD7930
 	tristate "Sun AMD7930"

