Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133019AbRDRF0U>; Wed, 18 Apr 2001 01:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133020AbRDRF0B>; Wed, 18 Apr 2001 01:26:01 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:27653 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S133019AbRDRFZw>;
	Wed, 18 Apr 2001 01:25:52 -0400
Date: Wed, 18 Apr 2001 01:26:48 -0400
Message-Id: <200104180526.f3I5Qmr14004@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Supplying missing entries for Configure.help, part 4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supplies seventeen more missing entries for the
Configure.help file, for a total of 65 so far.  It also corrects some
places where I omitted a CONFIG_ prefix.  It should be applied after my
previous patches 1, 2, and 3 under the same title.

--- Configure.help	2001/04/18 03:04:27	1.4
+++ Configure.help	2001/04/18 05:23:14
@@ -93,6 +93,12 @@
   you say Y here, you will be offered the choice of using features or
   drivers that are currently considered to be in the alpha-test phase.
 
+Prompt for drivers for obsolete features and hardware
+CONFIG_OBSOLETE
+  Obsolete drivers have usually been replaced by more recent software that
+  can talk to the same hardware.  Obsolerte hardware is things like MGA 
+  monitors that you are very unlikely to see on today's systems.
+
 Symmetric Multi Processing
 CONFIG_SMP
   This enables support for systems with more than one CPU. If you have
@@ -1598,8 +1604,9 @@
 
 Baget AMD LANCE support
 CONFIG_BAGETLANCE
-  Say Y to enable kernel support for Lance ethernet cards on the 
-  MIPS-32-based Baget embedded system.
+  Say Y to enable kernel support for AMD Lance ethernet cards on the 
+  MIPS-32-based Baget embedded system.  This chipset is better known
+  via the NE2100 cards.
 
 Support for DECstations
 CONFIG_DECSTATION
@@ -1622,6 +1629,20 @@
   This enables support for the VR5000-based NEC DDB Vrc-5074
   evaluation board.
 
+Support for Cobalt Micro Server
+CONFIG_COBALT_MICRO_SERVER
+  Support for ARM-based Cobalt boxes (they have been bought by Sun and
+  are now the "Server Appliance Business Unit") including the 2700 series
+  -- versions 1 of the Qube and Raq.  To compile a Linux kernel for this
+  hardware, say Y here.
+
+Support for Cobalt 2800
+CONFIG_COBALT_28
+  Support for the second generation of ARM-based Cobalt boxes (they have
+  been bought by Sun and are now the "Server Appliance Business Unit")
+  including the 2800 series -- versions 2 of the Qube and Raq.  To compile
+  a Linux kernel for this hardware, say Y here.
+
 Support for Mips Magnum 4000
 CONFIG_MIPS_MAGNUM_4000
   This is a machine with a R4000 100 MHz CPU. To compile a Linux
@@ -5473,6 +5494,20 @@
 
   If you don't understand what's going on, go with the default.
 
+Extra SCSI Tapes
+CONFIG_ST_EXTRA_DEVS
+  This controls the amount of additional space allocated in tables for
+  drivers that are loaded as modules after the kernel is booted.  In
+  the event that the SCSI core itself was loaded as a module, this
+  value is the number of additional tapes that can be loaded after the
+  first host driver is loaded.
+
+  Admittedly this isn't pretty, but there are tons of race conditions
+  involved with resizing the internal arrays on the fly.  Someday this
+  flag will go away, and everything will work automatically.
+
+  If you don't understand what's going on, go with the default.
+
 SCSI tape support
 CONFIG_CHR_DEV_ST
   If you want to use a SCSI tape drive under Linux, say Y and read the
@@ -6985,6 +7020,11 @@
   say M here and read Documentation/modules.txt. The module will be
   called ohci1394.o.
 
+Video1394 support
+CONFIG_IEEE1394_VIDEO1394
+  Say Y here if you want support for IEEE1394 FireWire interfacing 
+  to digital cameras using the video1394 conventions.
+
 Raw IEEE 1394 I/O support
 CONFIG_IEEE1394_RAWIO
   Say Y here if you want support for the raw device. This is generally
@@ -9613,6 +9653,12 @@
   More specific information and updates are available from
   http://www.scyld.com/network/epic100.html
 
+DEC LANCE ethernet controller support
+CONFIG_DECLANCE
+  This driver is for the series of Ethernet controllers produced by 
+  DEC (now Compaq) based on the AMD Lance chipset, including the
+  DEPCA series.  (This chipset is better known via the NE2100 cards.)
+
 SGI Seeq ethernet controller support
 CONFIG_SGISEEQ
   Say Y here if you have an Seeq based Ethernet network card. This is
@@ -9850,7 +9896,9 @@
 Sun Lance support
 CONFIG_SUNLANCE
   This driver supports the "le" interface present on all 32-bit Sparc
-  systems, on some older Ultra systems and as an Sbus option.
+  systems, on some older Ultra systems and as an Sbus option.  These
+  cards are based on the AMD Lance chipset, which is better known
+  via the NE2100 cards.
 
   This support is also available as a module called sunlance.o ( =
   code which can be inserted in and removed from the running kernel
@@ -10143,6 +10191,22 @@
   include/linux/sbpcd.h before compiling the new kernel. Read
   the file Documentation/cdrom/sbpcd.
 
+Matsushita/Panasonic, ... third CDROM controller support
+CONFIG_SBPCD3
+  Say Y here only if you have three CDROM controller cards of this type
+  (usually only if you have more than six drives). You should enter
+  the parameters for the second, third and fourth interface card into
+  include/linux/sbpcd.h before compiling the new kernel. Read
+  the file Documentation/cdrom/sbpcd.
+
+Matsushita/Panasonic, ... fourth CDROM controller support
+CONFIG_SBPCD4
+  Say Y here only if you have four CDROM controller cards of this type
+  (usually only if you have more than eight drives). You should enter
+  the parameters for the second, third and fourth interface card into
+  include/linux/sbpcd.h before compiling the new kernel. Read
+  the file Documentation/cdrom/sbpcd.
+
 Aztech/Orchid/Okano/Wearnes/TXC/CyDROM CDROM support
 CONFIG_AZTCD
   This is your driver if you have an Aztech CDA268-01A, Orchid
@@ -12521,6 +12585,17 @@
   only, not to the file contents. You can include several codepages;
   say Y here if you want to include the DOS codepage for Thai.
 
+Windows CP1251 (Bulgarian, Belarussian)
+CONFIG_NLS_CODEPAGE_1251
+  The Microsoft FAT file system family can deal with filenames in
+  native language character sets. These character sets are stored in
+  so-called DOS codepages. You need to include the appropriate
+  codepage if you want to be able to read/write these filenames on
+  DOS/Windows partitions correctly. This does apply to the filenames
+  only, not to the file contents. You can include several codepages;
+  say Y here if you want to include the DOS codepage Bulgarian and
+  Belorussian.
+
 nls codepage 932
 CONFIG_NLS_CODEPAGE_932
   The Microsoft FAT file system family can deal with filenames in
@@ -12657,6 +12732,14 @@
   letters that were missing in Latin 4 to cover the entire Nordic
   area.
 
+NLS ISO 8859-13 (Latin 7; Baltic)
+CONFIG_NLS_ISO8859_13
+  If you want to display filenames with native language characters
+  from the Microsoft FAT file system family or from JOLIET CDROMs
+  correctly on the screen, you need to include the appropriate
+  input/output character sets. Say Y here for the Latin 7 character
+  set, which supports modern Baltic languages including Latvian.
+
 NLS ISO 8859-14 (Latin 8; Celtic)
 CONFIG_NLS_ISO8859_14
   If you want to display filenames with native language characters
@@ -12690,6 +12773,14 @@
   input/output character sets. Say Y here for the preferred Russian
   character set.
 
+NLS UTF8
+CONFIG_NLS_UTF8
+  If you want to display filenames with native language characters
+  from the Microsoft FAT file system family or from JOLIET CDROMs
+  correctly on the screen, you need to include the appropriate
+  input/output character sets. Say Y here for the UTF-8 encoding of
+  the Unicode/ISO9646 universal character set.
+
 Virtual terminal
 CONFIG_VT
   If you say Y here, you will get support for terminal devices with
@@ -13688,6 +13779,13 @@
   is selected, the module will be called r128.o.  AGP support for
   this card is strongly suggested (unless you have a PCI version).
 
+ATI Radeon
+CONFIG_DRM_RADEON
+  Choose this option if you have an ATI Radeon graphics card.  There
+  are both PCI and AGP versions.  You don't need to choose this to
+  run the Radeon in plain VGA mode.  There is a product page at
+  http://www.ati.com/na/pages/products/pc/radeon32/index.html .
+
 Intel I810
 CONFIG_DRM_I810
   Choose this option if you have an Intel I810 graphics card.  If M is
@@ -13700,6 +13798,12 @@
   is selected, the module will be called mga.o.  AGP support is required
   for this driver to work.
 
+Creator/Creator3D/Elite3D
+CONFIG_DRM_FFB
+  Choose this option if you have one of Sun's Creator3D-based graphics 
+  and frame buffer cards.  Product page at 
+  http://www.sun.com/desktop/products/Graphics/creator3d.html .
+
 MTRR control and configuration
 CONFIG_MTRR
   On Intel P6 family processors (Pentium Pro, Pentium II and later)
@@ -15949,7 +16053,7 @@
   If you don't want to compile a kernel for a Sun 3x, say N.
 
 Sun3x builtin serial support
-SUN3X_ZS
+CONFIG_SUN3X_ZS
   ZS refers to a type of asynchronous serial port built in to the Sun3
   and Sun3x workstations; if you have a Sun 3, you probably have these.
   Say 'Y' to support ZS ports directly.
@@ -16179,6 +16283,12 @@
   If you have the Phase5 Fastlane Z3 SCSI controller, or plan to use
   one in the near future, say Y to this question. Otherwise, say N.
 
+BSC Oktagon SCSI support
+OKTAGON_SCSI
+  If you have the BSC Oktagon SCSI disk controller for the Amiga, say Y to
+  this question.  If you're in doubt about whether you have one, see the
+  picture at http://amiga.multigraph.com/photos/oktagon.html . 
+
 Atari native SCSI support
 CONFIG_ATARI_SCSI
   If you have an Atari with built-in NCR5380 SCSI controller (TT,
@@ -16373,7 +16483,7 @@
   GVP IO-Extender card, N otherwise
 
 GVP IO-Extender PLIP support
-GVPIOEXT_PLIP
+CONFIG_GVPIOEXT_PLIP
   Say Y to enable doing IP over the parallel port on your  GVP IO-Extender
   card, N otherwise
 
@@ -16915,6 +17025,22 @@
   whenever you want). If you want to compile it as a module, say M
   here and read Documentation/modules.txt.
 
+Stradis 4:2:2 MPEG-2 video driver
+CONFIG_VIDEO_STRADIS
+  Say Y here to enable support for the Stradis 4:2:2 MPEG-2 video driver
+  for PCI.  There is a product page at http://www.stradis.com/decoder.html .
+
+Zoran ZR36057/36060 Video For Linux
+CONFIG_VIDEO_ZORAN
+  Say Y here to include support for video cards based on the the Zoran 
+  ZR36057/36060 encoder/decoder chip (including the Iomega Buz and the
+  Miro DC10 and DC30 video capture cards).
+
+Include support for Iomega Buz
+CONFIG_VIDEO_BUZ
+  Say Y here to include support for the Iomega Buz video card.  There is
+  a Buz/Linux homepage at http://www.lysator.liu.se/~gz/buz/ .
+
 ZR36120/36125 Video for Linux
 CONFIG_VIDEO_ZR36120
   Support for ZR36120/ZR36125 based frame grabber/overlay boards.
@@ -17321,6 +17447,14 @@
   experimental; if this sounds frightening, say N and sleep in peace.
   You can also say M here to compile this support as a module (which
   will be called arthur.o).
+
+RTAS (RunTime Abstraction Services) in /proc
+CONFIG_RTAS
+  Certain hardware devices, such as custom I/O controllers, differ from
+  Macintosh to Macintosh, but provide similar functions. RTAS communicates
+  with the underlying hardware to provide services such as accessing the
+  real-time clock, nonvolatile RAM (NVRAM), restart, shutdown, and PCI
+  configuration cycles.
 
 Initial kernel command line
 CONFIG_CMDLINE
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"If I must write the truth, I am disposed to avoid every assembly 
of bishops; for of no synod have I seen a profitable end, but
rather an addition to than a diminution of evils; for the love 
of strife and the thirst for superiority are beyond the power 
of words to express."
	-- Father Gregory Nazianzen, 381 AD
