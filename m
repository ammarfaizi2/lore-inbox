Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUBTMtc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUBTMse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:48:34 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:35123 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S261187AbUBTMq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:46:58 -0500
Date: Fri, 20 Feb 2004 13:46:42 +0100
Message-Id: <200402201246.i1KCkgvU004223@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 399] M68k uses drivers/Kconfig
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Use drivers/Kconfig and fix up some remaining dependencies:
  - M68k no longer uses rtc.c
  - M68k never has AGP
  - CONFIG_ZORRO depends on CONFIG_AMIGA

--- linux-2.6.3/arch/m68k/Kconfig	2004-01-01 20:23:30.000000000 +0100
+++ linux-m68k-2.6.3/arch/m68k/Kconfig	2004-01-10 00:12:00.000000000 +0100
@@ -423,105 +423,6 @@
 	  including the model, CPU, MMU, clock speed, BogoMIPS rating,
 	  and memory size.
 
-config PARPORT
-	tristate "Parallel port support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	---help---
-	  If you want to use devices connected to your machine's parallel port
-	  (the connector at the computer with 25 holes), e.g. printer, ZIP
-	  drive, PLIP link (Parallel Line Internet Protocol is mainly used to
-	  create a mini network by connecting the parallel ports of two local
-	  machines) etc., then you need to say Y here; please read
-	  <file:Documentation/parport.txt> and
-	  <file:drivers/parport/BUGS-parport>.
-
-	  For extensive information about drivers for many devices attaching
-	  to the parallel port see <http://www.torque.net/linux-pp.html> on
-	  the WWW.
-
-	  It is possible to share a single parallel port among several devices
-	  and it is safe to compile all the corresponding drivers into the
-	  kernel. To compile parallel port support as a module, choose M here:
-	  the module will be called parport.
-	  If you have more than one parallel port and want to specify which
-	  port and IRQ to be used by this driver at module load time, take a
-	  look at <file:Documentation/parport.txt>.
-
-	  If unsure, say Y.
-
-config PARPORT_AMIGA
-	tristate "Amiga builtin port"
-	depends on AMIGA && PARPORT
-	help
-	  Say Y here if you need support for the parallel port hardware on
-	  Amiga machines. This code is also available as a module (say M),
-	  called parport_amiga. If in doubt, saying N is the safe plan.
-
-config PARPORT_MFC3
-	tristate "Multiface III parallel port"
-	depends on ZORRO && PARPORT
-	help
-	  Say Y here if you need parallel port support for the MFC3 card.
-	  This code is also available as a module (say M), called
-	  parport_mfc3. If in doubt, saying N is the safe plan.
-
-config PARPORT_PC
-	bool
-	depends on Q40 && PARPORT
-	default y
-	---help---
-	  You should say Y here if you have a PC-style parallel port. All IBM
-	  PC compatible computers and some Alphas have PC-style parallel
-	  ports.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called parport_pc.
-
-	  If unsure, say Y.
-
-config PARPORT_ATARI
-	tristate "Atari builtin port"
-	depends on ATARI && PARPORT
-	help
-	  Say Y here if you need support for the parallel port hardware on
-	  Atari machines. This code is also available as a module (say M),
-	  called parport_atari. If in doubt, saying N is the safe plan.
-
-config PRINTER
-	tristate "Parallel printer support"
-	depends on PARPORT
-	---help---
-	  If you intend to attach a printer to the parallel port of your Linux
-	  box (as opposed to using a serial printer; if the connector at the
-	  printer has 9 or 25 holes ["female"], then it's serial), say Y.
-	  Also read the Printing-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  It is possible to share one parallel port among several devices
-	  (e.g. printer and ZIP drive) and it is safe to compile the
-	  corresponding drivers into the kernel.
-	  To compile this driver as a module, choose M here and read
-	  <file:Documentation/parport.txt>.  The module will be called lp.
-
-	  If you have several parallel ports, you can specify which ports to
-	  use with the "lp" kernel command line option.  (Try "man bootparam"
-	  or see the documentation of your boot loader (lilo or loadlin) about
-	  how to pass options to the kernel at boot time.)  The syntax of the
-	  "lp" command line option can be found in <file:drivers/char/lp.c>.
-
-	  If you have more than 8 printers, you need to increase the LP_NO
-	  macro in lp.c and the PARPORT_MAX macro in parport.h.
-
-config PARPORT_1284
-	bool "IEEE 1284 transfer modes"
-	depends on PRINTER
-	help
-	  If you have a printer that supports status readback or device ID, or
-	  want to use a device that uses enhanced parallel port transfer modes
-	  such as EPP and ECP, say Y here to enable advanced IEEE 1284
-	  transfer modes. Also say Y if you want device ID information to
-	  appear in /proc/sys/dev/parport/*/autoprobe*. It is safe to say N.
-
 config ISA
 	bool
 	depends on Q40 || AMIGA_PCMCIA || GG2
@@ -560,192 +461,13 @@
 
 source "drivers/zorro/Kconfig"
 
-if Q40
-source "drivers/pnp/Kconfig"
-endif
-
 endmenu
 
-source "drivers/base/Kconfig"
-
-source "drivers/mtd/Kconfig"
-
-source "drivers/block/Kconfig"
-
-source "drivers/md/Kconfig"
-
-source "drivers/input/Kconfig"
-
-source "drivers/ide/Kconfig"
-
-source "drivers/scsi/Kconfig"
-
-source "net/Kconfig"
+source "drivers/Kconfig"
 
 
 menu "Character devices"
 
-config SERIAL
-	tristate "Q40 Standard/generic serial support" if Q40
-	default DN_SERIAL if APOLLO
-	---help---
-	  This selects whether you want to include the driver for the standard
-	  serial ports.  The standard answer is Y.  People who might say N
-	  here are those that are setting up dedicated Ethernet WWW/FTP
-	  servers, or users that have one of the various bus mice instead of a
-	  serial mouse and don't intend to use their machine's standard serial
-	  port for anything.  (Note that the Cyclades and Stallion multi
-	  serial port drivers do not need this driver built in for them to
-	  work.)
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called serial.
-	  [WARNING: Do not compile this driver as a module if you are using
-	  non-standard serial ports, since the configuration information will
-	  be lost when the driver is unloaded.  This limitation may be lifted
-	  in the future.]
-
-	  BTW1: If you have a mouseman serial mouse which is not recognized by
-	  the X window system, try running gpm first.
-
-	  BTW2: If you intend to use a software modem (also called Winmodem)
-	  under Linux, forget it.  These modems are crippled and require
-	  proprietary drivers which are only available under Windows.
-
-	  Most people will say Y or M here, so that they can use serial mice,
-	  modems and similar devices connecting to the standard serial ports.
-
-config SERIAL_EXTENDED
-	bool "Extended dumb serial driver options"
-	depends on SERIAL=y
-	help
-	  If you wish to use any non-standard features of the standard "dumb"
-	  driver, say Y here. This includes HUB6 support, shared serial
-	  interrupts, special multiport support, support for more than the
-	  four COM 1/2/3/4 boards, etc.
-
-	  Note that the answer to this question won't directly affect the
-	  kernel: saying N will just cause the configurator to skip all
-	  the questions about serial driver options. If unsure, say N.
-
-config SERIAL_MANY_PORTS
-	bool "Support more than 4 serial ports"
-	depends on SERIAL_EXTENDED
-	help
-	  Say Y here if you have dumb serial boards other than the four
-	  standard COM 1/2/3/4 ports. This may happen if you have an AST
-	  FourPort, Accent Async, Boca (read the Boca mini-HOWTO, available
-	  from <http://www.tldp.org/docs.html#howto>), or other custom
-	  serial port hardware which acts similar to standard serial port
-	  hardware. If you only use the standard COM 1/2/3/4 ports, you can
-	  say N here to save some memory. You can also say Y if you have an
-	  "intelligent" multiport card such as Cyclades, Digiboards, etc.
-
-config SERIAL_SHARE_IRQ
-	bool "Support for sharing serial interrupts"
-	depends on SERIAL_EXTENDED
-	help
-	  Some serial boards have hardware support which allows multiple dumb
-	  serial ports on the same board to share a single IRQ. To enable
-	  support for this in the serial driver, say Y here.
-
-config SERIAL_MULTIPORT
-	bool "Support special multiport boards"
-	depends on SERIAL_EXTENDED
-	help
-	  Some multiport serial ports have special ports which are used to
-	  signal when there are any serial ports on the board which need
-	  servicing. Say Y here to enable the serial driver to take advantage
-	  of those special I/O ports.
-
-config HUB6
-	bool "Support the Bell Technologies HUB6 card"
-	depends on SERIAL_EXTENDED
-	help
-	  Say Y here to enable support in the dumb serial driver to support
-	  the HUB6 card.
-
-config VT
-	bool "Virtual terminal"
-	---help---
-	  If you say Y here, you will get support for terminal devices with
-	  display and keyboard devices. These are called "virtual" because you
-	  can run several virtual terminals (also called virtual consoles) on
-	  one physical terminal. This is rather useful, for example one
-	  virtual terminal can collect system messages and warnings, another
-	  one can be used for a text-mode user session, and a third could run
-	  an X session, all in parallel. Switching between virtual terminals
-	  is done with certain key combinations, usually Alt-<function key>.
-
-	  The setterm command ("man setterm") can be used to change the
-	  properties (such as colors or beeping) of a virtual terminal. The
-	  man page console_codes(4) ("man console_codes") contains the special
-	  character sequences that can be used to change those properties
-	  directly. The fonts used on virtual terminals can be changed with
-	  the setfont ("man setfont") command and the key bindings are defined
-	  with the loadkeys ("man loadkeys") command.
-
-	  You need at least one virtual terminal device in order to make use
-	  of your keyboard and monitor. Therefore, only people configuring an
-	  embedded system would want to say N here in order to save some
-	  memory; the only way to log into such a system is then via a serial
-	  or network connection.
-
-	  If unsure, say Y, or else you won't be able to do much with your new
-	  shiny Linux system :-)
-
-config VT_CONSOLE
-	bool "Support for console on virtual terminal"
-	depends on VT
-	---help---
-	  The system console is the device which receives all kernel messages
-	  and warnings and which allows logins in single user mode. If you
-	  answer Y here, a virtual terminal (the device used to interact with
-	  a physical terminal) can be used as system console. This is the most
-	  common mode of operations, so you should say Y here unless you want
-	  the kernel messages be output only to a serial port (in which case
-	  you should say Y to "Console on serial port", below).
-
-	  If you do say Y here, by default the currently visible virtual
-	  terminal (/dev/tty0) will be used as system console. You can change
-	  that with a kernel command line option such as "console=tty3" which
-	  would use the third virtual terminal as system console. (Try "man
-	  bootparam" or see the documentation of your boot loader (lilo or
-	  loadlin) about how to pass options to the kernel at boot time.)
-
-	  If unsure, say Y.
-
-config HW_CONSOLE
-	bool
-	depends on VT
-	default y
-
-config NVRAM
-	bool
-	depends on ATARI
-	default y
-	---help---
-	  If you say Y here and create a character special file /dev/nvram
-	  with major number 10 and minor number 144 using mknod ("man mknod"),
-	  you get read and write access to the 50 bytes of non-volatile memory
-	  in the real time clock (RTC), which is contained in every PC and
-	  most Ataris.
-
-	  This memory is conventionally called "CMOS RAM" on PCs and "NVRAM"
-	  on Ataris. /dev/nvram may be used to view settings there, or to
-	  change them (with some utility). It could also be used to frequently
-	  save a few bits of very important data that may not be lost over
-	  power-off and for which writing to disk is too insecure. Note
-	  however that most NVRAM space in a PC belongs to the BIOS and you
-	  should NEVER idly tamper with it. See Ralf Brown's interrupt list
-	  for a guide to the use of CMOS bytes by your BIOS.
-
-	  On Atari machines, /dev/nvram is always configured and does not need
-	  to be selected.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called nvram.
-
 config ATARI_MFPSER
 	tristate "Atari MFP serial support"
 	depends on ATARI
@@ -824,22 +546,6 @@
 
 	  To compile this driver as a module, choose M here.
 
-config A2232
-	tristate "Commodore A2232 serial support (EXPERIMENTAL)"
-	depends on AMIGA && EXPERIMENTAL
-	---help---
-	  This option supports the 2232 7-port serial card shipped with the
-	  Amiga 2000 and other Zorro-bus machines, dating from 1989.  At
-	  a max of 19,200 bps, the ports are served by a 6551 ACIA UART chip
-	  each, plus a 8520 CIA, and a master 6502 CPU and buffer as well. The
-	  ports were connected with 8 pin DIN connectors on the card bracket,
-	  for which 8 pin to DB25 adapters were supplied. The card also had
-	  jumpers internally to toggle various pinning configurations.
-
-	  This driver can be built as a module; but then "generic_serial"
-	  will also be built as a module. This has to be loaded before
-	  "ser_a2232". If you want to do this, answer M here.
-
 config GVPIOEXT
 	tristate "GVP IO-Extender support"
 	depends on PARPORT=n && ZORRO
@@ -960,87 +666,10 @@
 
 	  If unsure, say N.
 
-config USERIAL
-	bool "Support for user serial device modules"
-
-source "drivers/char/watchdog/Kconfig"
-
-config GEN_RTC
-	tristate "Generic /dev/rtc emulation" if !SUN3
-	default y if SUN3
-	---help---
-	  If you say Y here and create a character special file /dev/rtc with
-	  major number 10 and minor number 135 using mknod ("man mknod"), you
-	  will get access to the real time clock (or hardware clock) built
-	  into your computer.
-
-	  It reports status information via the file /proc/driver/rtc and its
-	  behaviour is set by various ioctls on /dev/rtc. If you enable the
-	  "extended RTC operation" below it will also provide an emulation
-	  for RTC_UIE which is required by some programs and may improve
-	  precision in some cases.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called genrtc. To load the module automatically
-	  add 'alias char-major-10-135 genrtc' to your /etc/modules.conf
-
-config GEN_RTC_X
-	bool "Extended RTC operation"
-	depends on GEN_RTC
-	help
-	  Provides an emulation for RTC_UIE which is required by some programs
-	  and may improve precision of the generic RTC support in some cases.
-
-config UNIX98_PTYS
-	bool "Unix98 PTY support"
-	---help---
-	  A pseudo terminal (PTY) is a software device consisting of two
-	  halves: a master and a slave. The slave device behaves identical to
-	  a physical terminal; the master device is used by a process to
-	  read data from and write data to the slave, thereby emulating a
-	  terminal. Typical programs for the master side are telnet servers
-	  and xterms.
-
-	  Linux has traditionally used the BSD-like names /dev/ptyxx for
-	  masters and /dev/ttyxx for slaves of pseudo terminals. This scheme
-	  has a number of problems. The GNU C library glibc 2.1 and later,
-	  however, supports the Unix98 naming standard: in order to acquire a
-	  pseudo terminal, a process opens /dev/ptmx; the number of the pseudo
-	  terminal is then made available to the process and the pseudo
-	  terminal slave can be accessed as /dev/pts/<number>. What was
-	  traditionally /dev/ttyp2 will then be /dev/pts/2, for example.
-
-	  The entries in /dev/pts/ are created on the fly by a virtual
-	  file system; therefore, if you say Y here you should say Y to
-	  "/dev/pts file system for Unix98 PTYs" as well.
-
-	  If you want to say Y here, you need to have the C library glibc 2.1
-	  or later (equal to libc-6.1, check with "ls -l /lib/libc.so.*").
-	  Read the instructions in <file:Documentation/Changes> pertaining to
-	  pseudo terminals. It's safe to say N.
-
-config UNIX98_PTY_COUNT
-	int "Maximum number of Unix98 PTYs in use (0-2048)"
-	depends on UNIX98_PTYS
-	default "256"
-	help
-	  The maximum number of Unix98 PTYs that can be used at any one time.
-	  The default is 256, and should be enough for desktop systems. Server
-	  machines which support incoming telnet/rlogin/ssh connections and/or
-	  serve several X terminals may want to increase this: every incoming
-	  connection and every xterm uses up one PTY.
-
-	  When not in use, each additional set of 256 PTYs occupy
-	  approximately 8 KB of kernel memory on 32-bit architectures.
-
 endmenu
 
-source "sound/Kconfig"
-
 source "fs/Kconfig"
 
-source "drivers/video/Kconfig"
-
 menu "Kernel hacking"
 
 config DEBUG_KERNEL
--- linux-2.6.3/drivers/char/Kconfig	2004-01-21 22:03:22.000000000 +0100
+++ linux-m68k-2.6.3/drivers/char/Kconfig	2004-01-25 17:15:03.000000000 +0100
@@ -754,7 +754,7 @@
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64 && !X86_PC9800
+	depends on !PPC32 && !PARISC && !IA64 && !X86_PC9800 && !M68K
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
--- linux-2.6.3/drivers/char/agp/Kconfig	2003-09-28 09:35:49.000000000 +0200
+++ linux-m68k-2.6.3/drivers/char/agp/Kconfig	2004-01-10 04:33:05.000000000 +0100
@@ -1,5 +1,5 @@
 config AGP
-	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
+	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU && !M68K
 	default y if GART_IOMMU
 	---help---
 	  AGP (Accelerated Graphics Port) is a bus system mainly used to
--- linux-2.6.3/drivers/parport/Kconfig	2003-09-28 09:36:12.000000000 +0200
+++ linux-m68k-2.6.3/drivers/parport/Kconfig	2004-01-10 00:12:23.000000000 +0100
@@ -102,7 +102,7 @@
 
 config PARPORT_MFC3
 	tristate "Multiface III parallel port"
-	depends on AMIGA && ZORRO && PARPORT
+	depends on ZORRO && PARPORT
 	help
 	  Say Y here if you need parallel port support for the MFC3 card.
 	  This code is also available as a module (say M), called

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
