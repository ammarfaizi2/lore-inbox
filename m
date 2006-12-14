Return-Path: <linux-kernel-owner+w=401wt.eu-S1751833AbWLNIfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWLNIfZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWLNIfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:35:24 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:40156 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbWLNIfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:35:00 -0500
X-Originating-Ip: 74.109.98.100
Date: Thu, 14 Dec 2006 03:31:06 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] Make entries in the "Device drivers" menu individually
 selectable
Message-ID: <Pine.LNX.4.64.0612140325340.13847@localhost.localdomain>
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


  i've posted on this before so here's a slightly-updated patch that
uses the kbuild "menuconfig" feature to make numerous entries under
the Device drivers menu selectable on the spot.  if folks think this
is a good idea, what's the best way to get it in?

  i could officially submit the patch as is or, if that's too
wide-sweeping since it hits a lot of subsystems, leave it up to the
individual subsystem maintainers to decide for themselves and submit
their own patch.

  (the patch below modifies those entries for which a "menuconfig"
entry was immediately obvious and shouldn't affect any of the
underlying logic.  that's why some entries were deliberately left out
of the patch, at least for now.)


 drivers/ata/Kconfig         |    8 ++------
 drivers/connector/Kconfig   |    8 ++++----
 drivers/dma/Kconfig         |   10 +++++-----
 drivers/edac/Kconfig        |    8 ++++----
 drivers/hwmon/Kconfig       |    8 ++++----
 drivers/i2c/Kconfig         |    9 ++++-----
 drivers/ide/Kconfig         |    6 +-----
 drivers/ieee1394/Kconfig    |    7 ++++---
 drivers/infiniband/Kconfig  |   10 +++++-----
 drivers/isdn/Kconfig        |    9 ++++-----
 drivers/leds/Kconfig        |    9 +++------
 drivers/md/Kconfig          |    8 ++++----
 drivers/message/i2o/Kconfig |   12 +++++-------
 drivers/mmc/Kconfig         |    8 ++++----
 drivers/mtd/Kconfig         |    8 ++++----
 drivers/parport/Kconfig     |    8 ++++----
 drivers/pnp/Kconfig         |    8 ++++----
 drivers/spi/Kconfig         |    8 ++++----
 drivers/telephony/Kconfig   |    9 ++++-----
 drivers/w1/Kconfig          |    8 ++++----
 20 files changed, 77 insertions(+), 92 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 984ab28..a3bdf04 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -2,10 +2,8 @@
 # SATA/PATA driver configuration
 #

-menu "Serial ATA (prod) and Parallel ATA (experimental) drivers"
-
-config ATA
-	tristate "ATA device support"
+menuconfig ATA
+	tristate "Serial ATA (prod) and Parallel ATA (experimental) drivers"
 	depends on BLOCK
 	depends on !(M32R || M68K) || BROKEN
 	depends on !SUN4 || BROKEN
@@ -519,5 +517,3 @@ config PATA_IXP4XX_CF
 	  If unsure, say N.

 endif
-endmenu
-
diff --git a/drivers/connector/Kconfig b/drivers/connector/Kconfig
index e0bdc0d..9a5a061 100644
--- a/drivers/connector/Kconfig
+++ b/drivers/connector/Kconfig
@@ -1,6 +1,4 @@
-menu "Connector - unified userspace <-> kernelspace linker"
-
-config CONNECTOR
+menuconfig CONNECTOR
 	tristate "Connector - unified userspace <-> kernelspace linker"
 	depends on NET
 	---help---
@@ -10,6 +8,8 @@ config CONNECTOR
 	  Connector support can also be built as a module.  If so, the module
 	  will be called cn.ko.

+if CONNECTOR
+
 config PROC_EVENTS
 	boolean "Report process events to userspace"
 	depends on CONNECTOR=y
@@ -18,4 +18,4 @@ config PROC_EVENTS
 	  Provide a connector that reports process events to userspace. Send
 	  events such as fork, exec, id change (uid, gid, suid, etc), and exit.

-endmenu
+endif
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 30d021d..b1fb8c0 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -2,14 +2,14 @@
 # DMA engine configuration
 #

-menu "DMA Engine support"
-
-config DMA_ENGINE
-	bool "Support for DMA engines"
+menuconfig DMA_ENGINE
+	bool "DMA engine support"
 	---help---
 	  DMA engines offload copy operations from the CPU to dedicated
 	  hardware, allowing the copies to happen asynchronously.

+if DMA_ENGINE
+
 comment "DMA Clients"

 config NET_DMA
@@ -31,4 +31,4 @@ config INTEL_IOATDMA
 	---help---
 	  Enable support for the Intel(R) I/OAT DMA engine.

-endmenu
+endif
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 4f08984..e52e9b0 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -6,10 +6,9 @@
 # $Id: Kconfig,v 1.4.2.7 2005/07/08 22:05:38 dsp_llnl Exp $
 #

-menu 'EDAC - error detection and reporting (RAS) (EXPERIMENTAL)'

-config EDAC
-	tristate "EDAC core system error reporting (EXPERIMENTAL)"
+menuconfig EDAC
+	tristate 'EDAC - error detection and reporting (RAS) (EXPERIMENTAL)'
 	depends on X86 && EXPERIMENTAL
 	help
 	  EDAC is designed to report errors in the core system.
@@ -29,6 +28,7 @@ config EDAC
 	  There is also a mailing list for the EDAC project, which can
 	  be found via the sourceforge page.

+if EDAC

 comment "Reporting subsystems"
 	depends on EDAC
@@ -110,4 +110,4 @@ config EDAC_POLL

 endchoice

-endmenu
+endif
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 891ef6d..7a8afaa 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2,9 +2,7 @@
 # Hardware monitoring chip drivers configuration
 #

-menu "Hardware Monitoring support"
-
-config HWMON
+menuconfig HWMON
 	tristate "Hardware Monitoring support"
 	default y
 	help
@@ -23,6 +21,8 @@ config HWMON
 	  This support can also be built as a module.  If so, the module
 	  will be called hwmon.

+if HWMON
+
 config HWMON_VID
 	tristate
 	default n
@@ -592,4 +592,4 @@ config HWMON_DEBUG_CHIP
 	  a problem with I2C support and want to see more of what is going
 	  on.

-endmenu
+endif
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 11935f6..af35094 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -2,9 +2,7 @@
 # I2C subsystem configuration
 #

-menu "I2C support"
-
-config I2C
+menuconfig I2C
 	tristate "I2C support"
 	---help---
 	  I2C (pronounce: I-square-C) is a slow serial bus protocol used in
@@ -22,6 +20,8 @@ config I2C
 	  This I2C support can also be built as a module.  If so, the module
 	  will be called i2c-core.

+if I2C
+
 config I2C_CHARDEV
 	tristate "I2C device interface"
 	depends on I2C
@@ -73,5 +73,4 @@ config I2C_DEBUG_CHIP
 	  a problem with I2C support and want to see more of what is going
 	  on.

-endmenu
-
+endif
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 3f82805..cef34d3 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -6,9 +6,7 @@

 if BLOCK

-menu "ATA/ATAPI/MFM/RLL support"
-
-config IDE
+menuconfig IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
 	---help---
 	  If you say Y here, your kernel will be able to manage low cost mass
@@ -1080,6 +1078,4 @@ config BLK_DEV_HD

 endif

-endmenu
-
 endif
diff --git a/drivers/ieee1394/Kconfig b/drivers/ieee1394/Kconfig
index e7d5657..75d07e5 100644
--- a/drivers/ieee1394/Kconfig
+++ b/drivers/ieee1394/Kconfig
@@ -1,8 +1,7 @@
 # -*- shell-script -*-

-menu "IEEE 1394 (FireWire) support"

-config IEEE1394
+menuconfig IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
 	depends on PCI || BROKEN
 	select NET
@@ -19,6 +18,8 @@ config IEEE1394
 	  To compile this driver as a module, say M here: the
 	  module will be called ieee1394.

+if IEEE1394
+
 comment "Subsystem Options"
 	depends on IEEE1394

@@ -175,4 +176,4 @@ config IEEE1394_RAWIO
 	  To compile this driver as a module, say M here: the
 	  module will be called raw1394.

-endmenu
+endif
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 9edface..6582f51 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -1,13 +1,13 @@
-menu "InfiniBand support"
-
-config INFINIBAND
-	depends on PCI || BROKEN
+menuconfig INFINIBAND
 	tristate "InfiniBand support"
+	depends on PCI || BROKEN
 	---help---
 	  Core support for InfiniBand (IB).  Make sure to also select
 	  any protocols you wish to use as well as drivers for your
 	  InfiniBand hardware.

+if INFINIBAND
+
 config INFINIBAND_USER_MAD
 	tristate "InfiniBand userspace MAD support"
 	depends on INFINIBAND
@@ -45,4 +45,4 @@ source "drivers/infiniband/ulp/srp/Kconfig"

 source "drivers/infiniband/ulp/iser/Kconfig"

-endmenu
+endif
diff --git a/drivers/isdn/Kconfig b/drivers/isdn/Kconfig
index c90afee..f7bf323 100644
--- a/drivers/isdn/Kconfig
+++ b/drivers/isdn/Kconfig
@@ -2,9 +2,7 @@
 # ISDN device configuration
 #

-menu "ISDN subsystem"
-
-config ISDN
+menuconfig ISDN
 	tristate "ISDN support"
 	depends on NET
 	---help---
@@ -20,6 +18,8 @@ config ISDN

 	  Select this option if you want your kernel to support ISDN.

+if ISDN
+

 menu "Old ISDN4Linux"
 	depends on NET && ISDN
@@ -63,5 +63,4 @@ source "drivers/isdn/capi/Kconfig"

 source "drivers/isdn/hardware/Kconfig"

-endmenu
-
+endif
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 7399ba7..94ebdf5 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -1,7 +1,4 @@
-
-menu "LED devices"
-
-config NEW_LEDS
+menuconfig NEW_LEDS
 	bool "LED Support"
 	help
 	  Say Y to enable Linux LED support.  This allows control of supported
@@ -9,6 +6,7 @@ config NEW_LEDS

 	  This is not related to standard keyboard LEDs which are controlled
 	  via the input system.
+if NEW_LEDS

 config LEDS_CLASS
 	tristate "LED Class Support"
@@ -115,5 +113,4 @@ config LEDS_TRIGGER_HEARTBEAT
 	  load average.
 	  If unsure, say Y.

-endmenu
-
+endif
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 4540ade..b12b33b 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -4,14 +4,14 @@

 if BLOCK

-menu "Multi-device support (RAID and LVM)"
-
-config MD
+menuconfig MD
 	bool "Multiple devices driver support (RAID and LVM)"
 	help
 	  Support multiple physical spindles through a single logical device.
 	  Required for RAID and logical volume management.

+if MD
+
 config BLK_DEV_MD
 	tristate "RAID support"
 	depends on MD
@@ -262,6 +262,6 @@ config DM_MULTIPATH_EMC
 	---help---
 	  Multipath support for EMC CX/AX series hardware.

-endmenu
+endif

 endif
diff --git a/drivers/message/i2o/Kconfig b/drivers/message/i2o/Kconfig
index 6443392..6177faa 100644
--- a/drivers/message/i2o/Kconfig
+++ b/drivers/message/i2o/Kconfig
@@ -1,8 +1,5 @@
-
-menu "I2O device support"
-
-config I2O
-	tristate "I2O support"
+menuconfig I2O
+	tristate "I2O device support"
 	depends on PCI
 	---help---
 	  The Intelligent Input/Output (I2O) architecture allows hardware
@@ -24,6 +21,8 @@ config I2O

 	  If unsure, say N.

+if I2O
+
 config I2O_LCT_NOTIFY_ON_CHANGES
 	bool "Enable LCT notification"
 	depends on I2O
@@ -122,5 +121,4 @@ config I2O_PROC
 	  To compile this support as a module, choose M here: the
 	  module will be called i2o_proc.

-endmenu
-
+endif
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 4224686..841524a 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -2,15 +2,15 @@
 # MMC subsystem configuration
 #

-menu "MMC/SD Card support"

-config MMC
-	tristate "MMC support"
+menuconfig MMC
+	tristate "MMC/SD Card support"
 	help
 	  MMC is the "multi-media card" bus protocol.

 	  If you want MMC support, you should say Y here and also
 	  to the specific driver for your MMC interface.
+if MMC

 config MMC_DEBUG
 	bool "MMC debugging"
@@ -125,4 +125,4 @@ config MMC_TIFM_SD
           To compile this driver as a module, choose M here: the
 	  module will be called tifm_sd.

-endmenu
+endif
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index a304b34..3c9ae5b 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -1,8 +1,6 @@
 # $Id: Kconfig,v 1.11 2005/11/07 11:14:19 gleixner Exp $

-menu "Memory Technology Devices (MTD)"
-
-config MTD
+menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
@@ -13,6 +11,8 @@ config MTD
 	  them. It will also allow you to select individual drivers for
 	  particular hardware and users of MTD devices. If unsure, say N.

+if MTD
+
 config MTD_DEBUG
 	bool "Debugging"
 	depends on MTD
@@ -281,5 +281,5 @@ source "drivers/mtd/nand/Kconfig"

 source "drivers/mtd/onenand/Kconfig"

-endmenu
+endif

diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
index 36c6a1b..7a3ed1c 100644
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -5,9 +5,7 @@
 # Parport configuration.
 #

-menu "Parallel port support"
-
-config PARPORT
+menuconfig PARPORT
 	tristate "Parallel port support"
 	---help---
 	  If you want to use devices connected to your machine's parallel port
@@ -32,6 +30,8 @@ config PARPORT

 	  If unsure, say Y.

+if PARPORT
+
 config PARPORT_PC
 	tristate "PC-style hardware"
 	depends on PARPORT && (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV
@@ -158,5 +158,5 @@ config PARPORT_1284
 config PARPORT_NOT_PC
 	bool

-endmenu
+endif

diff --git a/drivers/pnp/Kconfig b/drivers/pnp/Kconfig
index c514320..ec7ab40 100644
--- a/drivers/pnp/Kconfig
+++ b/drivers/pnp/Kconfig
@@ -2,9 +2,7 @@
 # Plug and Play configuration
 #

-menu "Plug and Play support"
-
-config PNP
+menuconfig PNP
 	bool "Plug and Play support"
 	depends on ISA || ACPI
 	---help---
@@ -21,6 +19,8 @@ config PNP

 	  If unsure, say Y.

+if PNP
+
 config PNP_DEBUG
 	bool "PnP Debug Messages"
 	depends on PNP
@@ -37,5 +37,5 @@ source "drivers/pnp/pnpbios/Kconfig"

 source "drivers/pnp/pnpacpi/Kconfig"

-endmenu
+endif

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d895a1a..1b44244 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -5,9 +5,7 @@
 # nobody's needed a slave side API yet.  The master-role API is not
 # fully appropriate there, so it'd need some thought to do well.
 #
-menu "SPI support"
-
-config SPI
+menuconfig SPI
 	bool "SPI support"
 	help
 	  The "Serial Peripheral Interface" is a low level synchronous
@@ -27,6 +25,8 @@ config SPI
 	  (half duplex), SSP, SSI, and PSP.  This driver framework should
 	  work with most such devices and controllers.

+if SPI
+
 config SPI_DEBUG
 	boolean "Debug support for SPI drivers"
 	depends on SPI && DEBUG_KERNEL
@@ -129,5 +129,5 @@ comment "SPI Protocol Masters"

 # (slave support would go here)

-endmenu # "SPI support"
+endif

diff --git a/drivers/telephony/Kconfig b/drivers/telephony/Kconfig
index 7625b18..d123fa1 100644
--- a/drivers/telephony/Kconfig
+++ b/drivers/telephony/Kconfig
@@ -2,9 +2,7 @@
 # Telephony device configuration
 #

-menu "Telephony Support"
-
-config PHONE
+menuconfig PHONE
 	tristate "Linux telephony support"
 	---help---
 	  Say Y here if you have a telephony card, which for example allows
@@ -16,6 +14,8 @@ config PHONE
 	  To compile this driver as a module, choose M here: the
 	  module will be called phonedev.

+if PHONE
+
 config PHONE_IXJ
 	tristate "QuickNet Internet LineJack/PhoneJack support"
 	depends on PHONE
@@ -43,5 +43,4 @@ config PHONE_IXJ_PCMCIA
 	  cards manufactured by Quicknet Technologies, Inc.  This changes the
 	  card initialization code to work with the card manager daemon.

-endmenu
-
+endif
diff --git a/drivers/w1/Kconfig b/drivers/w1/Kconfig
index c287a9a..63c9c82 100644
--- a/drivers/w1/Kconfig
+++ b/drivers/w1/Kconfig
@@ -1,6 +1,4 @@
-menu "Dallas's 1-wire bus"
-
-config W1
+menuconfig W1
 	tristate "Dallas's 1-wire support"
 	---help---
 	  Dallas' 1-wire bus is useful to connect slow 1-pin devices
@@ -11,6 +9,8 @@ config W1
 	  This W1 support can also be built as a module.  If so, the module
 	  will be called wire.ko.

+if W1
+
 config W1_CON
 	depends on CONNECTOR && W1
 	bool "Userspace communication over connector"
@@ -26,4 +26,4 @@ config W1_CON
 source drivers/w1/masters/Kconfig
 source drivers/w1/slaves/Kconfig

-endmenu
+endif
