Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283310AbRLMEpv>; Wed, 12 Dec 2001 23:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283320AbRLMEpg>; Wed, 12 Dec 2001 23:45:36 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:37616 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S283310AbRLMEpR>; Wed, 12 Dec 2001 23:45:17 -0500
Subject: [RFC/PATCH] wide Configure.help entries (was Re: We're down to just 32...)
To: esr@thyrsus.com
Date: Wed, 12 Dec 2001 20:45:10 -0800 (PST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List), rmk@arm.linux.org.uk,
        linux-arm-kernel@lists.arm.linux.org.uk, bjornw@axis.com,
        dev-etrax@axis.com, hp@de.ibm.com (Hartmut Penner),
        schwidefsky@de.ibm.com (Martin Schwidefsky),
        rvdhei@iae.nl (Rob van der Heij), davidm@hpl.hp.com,
        linux-ia64@linuxia64.org
In-Reply-To: <20011212213307.A31039@thyrsus.com> from "Eric S. Raymond" at Dec 12, 2001 09:33:07 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011213044510.CC30A8A5A8@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We're down to just 32 missing Configure.help entries, thanks to excellent
> cooperation from the ARM developers and a siege of rooting through kernel 
> sources by yours truly.  That's a big improvement from 96 last week.

Speaking of Configure.help entries...

This morning I noticed, when configuring a kernel using menuconfig in
CML1, that one of the entries was wider than what menuconfig could
display. I then created and used the following script:

---cut here---
#!/bin/bash

# grep for: beginning of line, two spaces, at least 71 other characters
# (if we satisfy the expression up to this point then we're now at the
# maximum of 73 characters per description line that menuconfig can handle),
# and at least one non-space character (so that we only catch lines if
# they're too long *and* it's not just spaces at the end).

egrep '^  .{71,}[^ ]+' Configure.help
---cut here---

and I found that a whole bunch of entries are too wide. (It just
occurred to me now that I should mention that I'm assuming an
80-column-wide terminal, FWIW.)

I fixed most of the offending cases in the 2.4.17-pre8 Configure.help,
and the resulting patch is attached to this message.

Noticing this issue motivated me to try out CML2. I didn't use CML2's
menuconfig too much, but from what I saw it has a wider help area so the
wide Configure.help entries aren't a problem for it.

Which brings up the question of whether this problem (of entries being
too wide for menuconfig) should be fixed, and if so, for which kernel
versions/series. IMO, the problem should be fixed for the 2.4 kernels,
since (if I'm not mistaken) it's going to be a while before CML2 becomes
standard for 2.4 kernels, if it ever happens at all. For 2.5, OTOH,
perhaps the help entries should be left alone in this regard since
CML2's menuconfig isn't affected by this problem and CML2 is going to be
merged into 2.5.

Does anyone else have any ideas/opinions/reactions regarding this?

-Barry K. Nathan <barryn@pobox.com>

diff -urN linux-2.4.17-pre8/Documentation/Configure.help linux-2.4.17-pre8bknB1/Documentation/Configure.help
--- linux-2.4.17-pre8/Documentation/Configure.help	Mon Dec 10 16:54:15 2001
+++ linux-2.4.17-pre8bknB1/Documentation/Configure.help	Wed Dec 12 06:15:46 2001
@@ -237,9 +237,9 @@
 CONFIG_MULTIQUAD
   This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
   multiquad box. This changes the way that processors are bootstrapped,
-  and uses Clustered Logical APIC addressing mode instead of Flat Logical.
-  You will need a new lynxer.elf file to flash your firmware with - send
-  email to Martin.Bligh@us.ibm.com
+  and uses Clustered Logical APIC addressing mode instead of Flat
+  Logical.  You will need a new lynxer.elf file to flash your firmware
+  with - send email to Martin.Bligh@us.ibm.com
 
 IO-APIC support on uniprocessors
 CONFIG_X86_UP_IOAPIC
@@ -341,12 +341,12 @@
   "high memory".
 
   If you are compiling a kernel which will never run on a machine with
-  more than 960 megabytes of total physical RAM, answer "off" here (default
-  choice and suitable for most users). This will result in a "3GB/1GB"
-  split: 3GB are mapped so that each process sees a 3GB virtual memory
-  space and the remaining part of the 4GB virtual memory space is used
-  by the kernel to permanently map as much physical memory as
-  possible.
+  more than 960 megabytes of total physical RAM, answer "off" here
+  (default choice and suitable for most users). This will result in a
+  "3GB/1GB" split: 3GB are mapped so that each process sees a 3GB
+  virtual memory space and the remaining part of the 4GB virtual memory
+  space is used by the kernel to permanently map as much physical memory
+  as possible.
 
   If the machine has between 1 and 4 Gigabytes physical RAM, then
   answer "4GB" here.
@@ -1286,8 +1286,8 @@
 Amiga Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL)
 CONFIG_BLK_DEV_BUDDHA
   This is the IDE driver for the IDE interfaces on the Buddha, 
-  Catweasel and X-Surf expansion boards.  It supports up to two interfaces 
-  on the Buddha, three on the Catweasel and two on the X-Surf.
+  Catweasel and X-Surf expansion boards.  It supports up to two
+  interfaces on the Buddha, three on the Catweasel and two on the X-Surf.
 
   Say Y if you have a Buddha or Catweasel expansion board and want to
   use IDE devices (hard disks, CD-ROM drives, etc.) that are connected
@@ -2028,7 +2028,8 @@
 TURBOchannel support
 CONFIG_TC
   TurboChannel is a DEC (now Compaq) bus for Alpha and MIPS processors.
-  Documentation on writing device drivers for TurboChannel is available at:
+  Documentation on writing device drivers for TurboChannel is available
+  at:
   <http://www.cs.arizona.edu/computer.help/policy/DIGITAL_unix/AA-PS3HD-TET1_html/TITLE.html>.
 
 # Choice: galileo_clock
@@ -3200,7 +3201,8 @@
 Intel 440LX/BX/GX/815/820/830/840/845/850/860 support
 CONFIG_AGP_INTEL
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on Intel 440LX/BX/GX, 815, 820, 830, 840, 845, 850 and 860 chipsets.
+  XFree86 4.x on Intel 440LX/BX/GX, 815, 820, 830, 840, 845, 850 and 860
+  chipsets.
 
   You should say Y here if you use XFree86 3.3.6 or 4.x and want to
   use GLX or DRI.  If unsure, say N.
@@ -3208,8 +3210,8 @@
 Intel I810/I815 DC100/I810e support
 CONFIG_AGP_I810
   This option gives you AGP support for the Xserver on the Intel 810
-  815 and 830m chipset boards for their on-board integrated graphics. This
-  is required to do any useful video modes with these boards.
+  815 and 830m chipset boards for their on-board integrated graphics.
+  This is required to do any useful video modes with these boards.
 
 VIA chipset support
 CONFIG_AGP_VIA
@@ -3581,9 +3583,9 @@
 
 i82092 compatible bridge support
 CONFIG_I82092
-  This provides support for the Intel I82092AA PCI-to-PCMCIA bridge device,
-  found in some older laptops and more commonly in evaluation boards for the
-  chip.
+  This provides support for the Intel I82092AA PCI-to-PCMCIA bridge
+  device, found in some older laptops and more commonly in evaluation
+  boards for the chip.
 
 i82365 compatible host bridge support
 CONFIG_I82365
@@ -4094,7 +4096,8 @@
 CONFIG_FB_MAXINE
   Say Y here to directly support the on-board framebuffer in the
   Maxine (5000/20, /25, /33) version of the DECstation.  There is a
-  page dedicated to Linux on DECstations at <http://decstation.unix-ag.org/>.
+  page dedicated to Linux on DECstations at
+  <http://decstation.unix-ag.org/>.
 
 PMAG-BA TURBOchannel framebuffer support
 CONFIG_FB_PMAG_BA
@@ -4115,8 +4118,9 @@
 
 ANAKIN Vehicle Telematics Platform
 CONFIG_ARCH_ANAKIN
-  The Anakin is a StrongArm based SA110 - 2 DIN Vehicle Telematics Platform.
-  64MB SDRAM - 4 Mb Flash - Compact Flash Interface - 1 MB VRAM
+  The Anakin is a StrongArm based SA110 - 2 DIN Vehicle Telematics
+  Platform.  64MB SDRAM - 4 Mb Flash - Compact Flash Interface - 1 MB
+  VRAM
 
   On board peripherals:
         * Front display: 400x234 16 bit TFT touchscreen
@@ -5478,7 +5482,8 @@
 CONFIG_HAMRADIO
   If you want to connect your Linux box to an amateur radio, answer Y
   here. You want to read <http://www.tapr.org/tapr/html/pkthome.html> and
-  the AX25-HOWTO, available from <http://www.linuxdoc.org/docs.html#howto>.
+  the AX25-HOWTO, available from
+  <http://www.linuxdoc.org/docs.html#howto>.
 
   Note that the answer to this question won't directly affect the
   kernel: saying N will just cause the configurator to skip all
@@ -6502,8 +6507,8 @@
       SenseKey=2h (NOT READY); FRU=02h
       ASC/ASCQ=29h/00h "LOGICAL UNIT NOT READY, INITIALIZING CMD. REQUIRED"
 
-  Say M for "Enhanced SCSI error reporting" to compile this optional module,
-  creating a driver named: isense.o.
+  Say M for "Enhanced SCSI error reporting" to compile this optional
+  module, creating a driver named: isense.o.
 
   NOTE: Support for building this feature into the kernel is not
   available, due to kernel size considerations.
@@ -6702,8 +6707,8 @@
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
   say M here and read <file:Documentation/modules.txt> and
-  <file:Documentation/scsi.txt>. The module will be called sg.o. If unsure,
-  say N.
+  <file:Documentation/scsi.txt>. The module will be called sg.o. If
+  unsure, say N.
 
 Probe all LUNs on each SCSI device
 CONFIG_SCSI_MULTI_LUN
@@ -7265,8 +7270,8 @@
 
 use normal IO
 CONFIG_SCSI_SYM53C8XX_IOMAPPED
-  If you say Y here, the driver will preferently use normal IO rather than 
-  memory mapped IO.
+  If you say Y here, the driver will preferently use normal IO rather
+  than memory mapped IO.
 
 maximum number of queued commands
 CONFIG_SCSI_SYM53C8XX_MAX_TAGS
@@ -9559,8 +9564,8 @@
   up. Look at the <http://www.fi.muni.cz/~kas/cosa/> for more
   information about the cards (including the pointer to the user-space
   utilities). You can also read the comment at the top of the
-  <file:drivers/net/wan/cosa.c> for details about the cards and the driver
-  itself.
+  <file:drivers/net/wan/cosa.c> for details about the cards and the
+  driver itself.
 
   The driver will be compiled as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -12528,8 +12533,9 @@
 
 CFI Flash device mapped on Hitachi SolutionEngine
 CONFIG_MTD_SOLUTIONENGINE
-  This enables access to the flash chips on the Hitachi SolutionEngine and
-  similar boards. Say 'Y' if you are building a kernel for such a board.
+  This enables access to the flash chips on the Hitachi SolutionEngine
+  and similar boards. Say 'Y' if you are building a kernel for such a
+  board.
 
 CFI Flash device mapped on TQM8XXL PPC board
 CONFIG_MTD_TQM8XXL
@@ -14648,8 +14654,9 @@
 
 JFFS stats available in /proc filesystem
 CONFIG_JFFS_PROC_FS
-  Enabling this option will cause statistics from mounted JFFS file systems
-  to be made available to the user in the /proc/fs/jffs/ directory.
+  Enabling this option will cause statistics from mounted JFFS file
+  systems to be made available to the user in the /proc/fs/jffs/
+  directory.
 
 UFS file system support (read-only)
 CONFIG_UFS_FS
@@ -17290,8 +17297,8 @@
   The watchdog is usually used together with the watchdog daemon
   which is available from
   <ftp://ibiblio.org/pub/Linux/system/daemons/watchdog/>. This daemon can
-  also monitor NFS connections and can reboot the machine when the process
-  table is full.
+  also monitor NFS connections and can reboot the machine when the
+  process table is full.
 
   If unsure, say N.
 
@@ -17410,11 +17417,13 @@
 IB700 SBC Watchdog Timer
 CONFIG_IB700_WDT
   This is the driver for the hardware watchdog on the IB700 Single
-  Board Computer produced by TMC Technology (www.tmc-uk.com). This watchdog
-  simply watches your kernel to make sure it doesn't freeze, and if
-  it does, it reboots your computer after a certain amount of time.
+  Board Computer produced by TMC Technology (www.tmc-uk.com). This
+  watchdog simply watches your kernel to make sure it doesn't freeze,
+  and if it does, it reboots your computer after a certain amount of
+  time.
 
-  This driver is like the WDT501 driver but for slightly different hardware.
+  This driver is like the WDT501 driver but for slightly different
+  hardware.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -17754,7 +17763,8 @@
 CONFIG_INPUT_INTERACT
   Say Y hereif you have an InterAct gameport or joystick
   communicating digitally over the gameport.  For more information on
-  how to use the driver please read <file:Documentation/input/joystick.txt>.
+  how to use the driver please read
+  <file:Documentation/input/joystick.txt>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -17822,7 +17832,8 @@
 CONFIG_INPUT_MAGELLAN
   Say Y here if you have a Magellan or Space Mouse 6DOF controller
   connected to your computer's serial port.  For more information on
-  how to use the driver please read <file:Documentation/input/joystick.txt>.
+  how to use the driver please read
+  <file:Documentation/input/joystick.txt>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -17845,7 +17856,8 @@
 CONFIG_INPUT_SPACEBALL
   Say Y here if you have a SpaceTec SpaceBall 4000 FLX controller
   connected to your computer's serial port.  For more information on
-  how to use the driver please read <file:Documentation/input/joystick.txt>.
+  how to use the driver please read
+  <file:Documentation/input/joystick.txt>.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -20644,11 +20656,12 @@
 
 Average high and low temp
 CONFIG_TAU_AVERAGE
-  The TAU hardware can compare the temperature to an upper and lower bound.
-  The default behavior is to show both the upper and lower bound in
-  /proc/cpuinfo. If the range is large, the temperature is either changing
-  a lot, or the TAU hardware is broken (likely on some G4's). If the range
-  is small (around 4 degrees), the temperature is relatively stable.
+  The TAU hardware can compare the temperature to an upper and lower
+  bound.  The default behavior is to show both the upper and lower bound
+  in /proc/cpuinfo. If the range is large, the temperature is either
+  changing a lot, or the TAU hardware is broken (likely on some G4's). If
+  the range is small (around 4 degrees), the temperature is relatively
+  stable.
 
 Power management support for PowerBooks
 CONFIG_PMAC_PBOOK
@@ -22411,9 +22424,9 @@
 CONFIG_IRDA_ULTRA
   Say Y here to support the connectionless Ultra IRDA protocol.
   Ultra allows to exchange data over IrDA with really simple devices
-  (watch, beacon) without the overhead of the IrDA protocol (no handshaking,
-  no management frames, simple fixed header).
-  Ultra is available as a special socket : socket(AF_IRDA, SOCK_DGRAM, 1);
+  (watch, beacon) without the overhead of the IrDA protocol (no
+  handshaking, no management frames, simple fixed header).
+  Ultra is available as a special socket: socket(AF_IRDA, SOCK_DGRAM, 1);
 
 IrDA cache last LSAP
 CONFIG_IRDA_CACHE_LAST_LSAP
@@ -23683,7 +23696,8 @@
   IA64 identity-mapped regions use a large page size.  We'll call such
   large pages "granules".  If you can think of a better name that's
   unambiguous, let us know...  Unless your identity-mapped regions are
-  very large, select a granule size of 16MB.  (This is the "large" choice.)
+  very large, select a granule size of 16MB.  (This is the "large"
+  choice.)
 
 Enable SGI SN extra debugging code
 CONFIG_IA64_SGI_SN_DEBUG
@@ -23699,7 +23713,8 @@
 PCIBA Support
 CONFIG_PCIBA
   IRIX PCIBA-inspired user mode PCI interface for the SGI SN (Scalable
-  NUMA) platform for IA64.  Unless you are compiling a kernel for an              SGI SN IA64 box, say N.
+  NUMA) platform for IA64.  Unless you are compiling a kernel for an
+  SGI SN IA64 box, say N.
 
 Enable protocol mode for the L1 console
 SERIAL_SGI_L1_PROTOCOL
