Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270484AbTGNB0f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 21:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270485AbTGNB0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 21:26:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53222 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270484AbTGNB02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 21:26:28 -0400
Date: Mon, 14 Jul 2003 03:41:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: [2.4 patch] Configure.help updates from -ac
Message-ID: <20030714014111.GJ12104@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the patch below adds some Configure.help entries that are in pre3-ac1
but are missing in -pre5.

Please apply
Adrian

--- linux.22-pre3/Documentation/Configure.help	2003-07-06 13:35:00.000000000 +0100
+++ linux.22-pre3-ac1/Documentation/Configure.help	2003-07-07 16:19:40.000000000 +0100
@@ -3611,6 +3654,14 @@
   Say Y here to support the Serverworks AGP card.  See
   <http://www.serverworks.com/> for product descriptions and images.

+NVIDIA chipset support
+CONFIG_AGP_NVIDIA
+  This option gives you AGP support for the GLX component of the
+  XFree86 4.x on NVIDIA nForce/nForce2 chipsets.
+
+  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
+  use GLX or DRI.  If unsure, say N.
+
 ALI chipset support
 CONFIG_AGP_ALI
   This option gives you AGP support for the GLX component of the
@@ -4797,27 +4845,46 @@
   packed pixel and 32 bpp packed pixel. You can also use font widths
   different from 8.
 
-Matrox G100/G200/G400/G450/G550 support
-CONFIG_FB_MATROX_G100
-  Say Y here if you have a Matrox G100, G200, G400, G450, or G550
-  based video card. If you select "Advanced lowlevel driver options",
-  you should check 8 bpp packed pixel, 16 bpp packed pixel, 24 bpp
-  packed pixel and 32 bpp packed pixel. You can also use font widths
+CONFIG_FB_MATROX_G450
+  Say Y here if you have a Matrox G100, G200, G400, G450 or G550 based
+  video card. If you select "Advanced lowlevel driver options", you
+  should check 8 bpp packed pixel, 16 bpp packed pixel, 24 bpp packed
+  pixel and 32 bpp packed pixel. You can also use font widths
   different from 8.
 
   If you need support for G400 secondary head, you must first say Y to
   "I2C support" and "I2C bit-banging support" in the character devices
   section, and then to "Matrox I2C support" and "G400 second head
-  support" here in the framebuffer section.
+  support" here in the framebuffer section. G450/G550 secondary head
+  and digital output are supported without additional modules.
   
-  If you have G550, you must also compile support for G450/G550 secondary
-  head into kernel, otherwise picture will be shown only on the output you
-  are probably not using...
+  The driver starts in monitor mode. You must use the matroxset tool 
+  (available at <ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/>) to 
+  swap primary and secondary head outputs, or to change output mode.  
+  Secondary head driver always start in 640x480 resolution and you 
+  must use fbset to change it.
 
-  If you need support for G450 or G550 secondary head, say Y to
-  "Matrox G450/G550 second head support" below.
+  Do not forget that second head supports only 16 and 32 bpp
+  packed pixels, so it is a good idea to compile them into the kernel
+  too. You can use only some font widths, as the driver uses generic
+  painting procedures (the secondary head does not use acceleration
+  engine).
+  
+  G450/G550 hardware can display TV picture only from secondary CRTC,
+  and it performs no scaling, so picture must have 525 or 625 lines.
+
+CONFIG_FB_MATROX_G100A
+  Say Y here if you have a Matrox G100, G200 or G400 based
+  video card. If you select "Advanced lowlevel driver options", you
+  should check 8 bpp packed pixel, 16 bpp packed pixel, 24 bpp packed
+  pixel and 32 bpp packed pixel. You can also use font widths
+  different from 8.
+
+  If you need support for G400 secondary head, you must first say Y to
+  "I2C support" and "I2C bit-banging support" in the character devices
+  section, and then to "Matrox I2C support" and "G400 second head
+  support" here in the framebuffer section.
 
-Matrox I2C support
 CONFIG_FB_MATROX_I2C
   This drivers creates I2C buses which are needed for accessing the
   DDC (I2C) bus present on all Matroxes, an I2C bus which
@@ -4860,32 +4926,14 @@
   painting procedures (the secondary head does not use acceleration
   engine).
 
-Matrox G450 second head support
-CONFIG_FB_MATROX_G450
-  Say Y or M here if you want to use a secondary head (meaning two
-  monitors in parallel) on G450, or if you are using analog output
-  of G550.
-
-  If you compile it as module, two modules are created,
-  matroxfb_crtc2.o and matroxfb_g450.o. Both modules are needed if you
-  want two independent display devices.
-
-  The driver starts in monitor mode and currently does not support
-  output in TV modes.  You must use the matroxset tool (available
-  at <ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/>) to swap
-  primary and secondary head outputs.  Secondary head driver always
-  start in 640x480 resolution and you must use fbset to change it.
-
-  Note on most G550 cards the analog output is the secondary head,
-  so you will need to say Y here to use it.
-
-  Also do not forget that second head supports only 16 and 32 bpp
-  packed pixels, so it is a good idea to compile them into the kernel
-  too. You can use only some font widths, as the driver uses generic
-  painting procedures (the secondary head does not use acceleration
-  engine).
-
-Matrox unified driver multihead support
+CONFIG_FB_MATROX_PROC
+  Say Y or M here if you want to access some informations about driver
+  state through /proc interface.
+  
+  You should download matrox_pins tool (available at
+  <ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/>) to get human
+  readable output.
+  
 CONFIG_FB_MATROX_MULTIHEAD
   Say Y here if you have more than one (supported) Matrox device in
   your computer and you want to use all of them for different monitors
@@ -18759,6 +19122,14 @@
   of verbosity. Saying Y enables these statements. This will increase
   your kernel size by around 50K.
 
+ACPI Relaxed AML Checking
+CONFIG_ACPI_RELAXED_AML
+  If you say `Y' here, the ACPI interpreter will relax its checking
+  for valid AML and will ignore some AML mistakes, such as off-by-one
+  errors in region sizes.  Some laptops may require this option.  In
+  particular, many Toshiba laptops require this for correct operation
+  of the AC module.
+
 ACPI Bus Manager
 CONFIG_ACPI_BUSMGR
   The ACPI Bus Manager enumerates devices in the ACPI namespace, and
@@ -26828,8 +27169,142 @@
 
   If compiled as a module, it will be called scx200_docflash.o.
 
+BIOS flash chip on AMD76x southbridge
+CONFIG_MTD_AMD76XROM
+  Support for treating the BIOS flash chip on AMD76x motherboards
+  as an MTD device - with this you can reprogram your BIOS.
+
+  BE VERY CAREFUL.
+
+  If compiled as a module, it will be called amd76xrom.o.
+
+BIOS flash chip on Intel Hub Controller 2
+CONFIG_MTD_ICH2ROM
+  Support for treating the BIOS flash chip on ICH2 motherboards
+  as an MTD device - with this you can reprogram your BIOS.
+
+  BE VERY CAREFUL.
+
+  If compiled as a module, it will be called ich2rom.o.
+
+BIOS flash chip on Intel SCB2 boards
+CONFIG_MTD_SCB2_FLASH
+  Support for treating the BIOS flash chip on Intel SCB2 boards
+  as an MTD device - with this you can reprogram your BIOS.
+
+  BE VERY CAREFUL.
+
+  If compiled as a module, it will be called scb2_flash.o.
+
+Flash chips on Tsunami TIG bus
+CONFIG_MTD_TSUNAMI
+  Support for the flash chip on Tsunami TIG bus.
+
+  If compiled as a module, it will be called tsunami_flash.o.
+
+Flash chips on LASAT board
+CONFIG_MTD_LASAT
+  Support for the flash chips on the Lasat 100 and 200 boards.
+
+  If compiled as a module, it will be called lasat.o.
+
+CFI flash device on SnapGear/SecureEdge
+CONFIG_MTD_NETtel
+  Support for flash chips on NETtel/SecureEdge/SnapGear boards.
+
+  If compiled as a module, it will be called nettel.o.
+
+CFI Flash device mapped on DIL/Net PC
+CONFIG_MTD_DILNETPC
+  MTD map driver for SSV DIL/Net PC Boards "DNP" and "ADNP".
+  For details, see <http://www.ssv-embedded.de/ssv/pc104/p169.htm>
+   and <http://www.ssv-embedded.de/ssv/pc104/p170.htm>
+
+  If compiled as a module, it will be called dilnetpc.o.
+
+Size of DIL/Net PC flash boot partition
+CONFIG_MTD_DILNETPC_BOOTSIZE
+  The amount of space taken up by the kernel or Etherboot
+  on the DIL/Net PC flash chips.
+
+CFI Flash device mapped on Epxa10db
+CONFIG_MTD_EPXA10DB
+  This enables support for the flash devices on the Altera
+  Excalibur XA10 Development Board. If you are building a kernel
+  for on of these boards then you should say 'Y' otherwise say 'N'.
+
+  If compiled as a module, it will be called epxa10db-flash.o.
+
+CFI Flash device mapped on the FortuNet board
+CONFIG_MTD_FORTUNET
+  This enables access to the Flash on the FortuNet board.  If you
+  have such a board, say 'Y'.
+
+  If compiled as a module, it will be called fortunet.o.
+
+NV-RAM mapping AUTCPU12 board
+CONFIG_MTD_AUTCPU12
+  This enables access to the NV-RAM on autronix autcpu12 board.
+  If you have such a board, say 'Y'.
+
+  If compiled as a module, it will be called autcpu12-nvram.o.
+
+CFI Flash device mapped on EDB7312
+CONFIG_MTD_EDB7312
+  This enables access to the CFI Flash on the Cogent EDB7312 board.
+  If you have such a board, say 'Y' here.
+
+  If compiled as a module, it will be called edb7312.o.
+
+JEDEC Flash device mapped on impA7
+CONFIG_MTD_IMPA7
+  This enables access to the NOR Flash on the impA7 board of
+  implementa GmbH. If you have such a board, say 'Y' here.
+
+  If compiled as a module, it will be called impa7.o.
+
+JEDEC Flash device mapped on Ceiva/Polaroid PhotoMax Digital Picture Frame
+CONFIG_MTD_CEIVA
+  This enables access to the flash chips on the Ceiva/Polaroid
+  PhotoMax Digital Picture Frame.
+  If you have such a device, say 'Y'.
+
+  If compiled as a module, it will be called ceiva.o.
+
+System flash on MBX860 board
+CONFIG_MTD_MBX860
+  This enables access routines for the flash chips on the Motorola
+  MBX860 board. If you have one of these boards and would like
+  to use the flash chips on it, say 'Y'.
+
+  If compiled as a module, it will be called mbx860.o.
+
+PCI MTD driver
+CONFIG_MTD_PCI
+  Mapping for accessing flash devices on add-in cards like the Intel XScale
+  IQ80310 card, and the Intel EBSA285 card in blank ROM programming mode
+  (please see the manual for the link settings).
+
+  If compiled as a module, it will be called pci.o.
+
+  If you are not sure, say N.
+
+PCMCIA MTD driver
+CONFIG_MTD_PCMCIA
+  Map driver for accessing PCMCIA linear flash memory cards. These
+  cards are usually around 4-16MiB in size. This does not include
+  Compact Flash cards which are treated as IDE devices.
+
+  If compiled as a module, it will be called pcmciamtd.o.
+
+Generic uClinux RAM/ROM filesystem support
+CONFIG_MTD_UCLINUX
+  Map driver to support image based filesystems for uClinux.
+
+  If compiled as a module, it will be called uclinux.o.
+
 NatSemi SCx200 I2C using GPIO pins
 CONFIG_SCx200_GPIO
   Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
 
   If you don't know what to do here, say N.
