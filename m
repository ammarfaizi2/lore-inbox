Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132413AbRDJQTm>; Tue, 10 Apr 2001 12:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132402AbRDJQTS>; Tue, 10 Apr 2001 12:19:18 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:34832 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132399AbRDJQTK>;
	Tue, 10 Apr 2001 12:19:10 -0400
Date: Tue, 10 Apr 2001 10:53:46 -0400
Message-Id: <200104101453.f3AErkq30339@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: torvalds@transmeta.com, axel@uni-paderborn.de,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Garbage-collection patches for Configure.help
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auditing of the CML1 configuration system reveals that the following entries
in Configure.help are orphans -- that is, they correspond to configuration
symbols not in use in 2.4.3.  

The patch following the list garbage-collects the Configure.help file.  
Symbols marked 'removed' are removed; symbols marked 'kept' are retained 
because they are commented out in the CML1 sources but might become
active again.  In three cases I have identified and fixed entries
corresponding to renamed symbols.

CONFIG_ARCH_EBSA285				CONFIG_ARCH_EBSA285_HOST
CONFIG_ARCH_L7200				kept
CONFIG_ARCNET_ETH				removed
CONFIG_AX25_DAMA_MASTER				kept
CONFIG_FRAME_POINTER				removed
CONFIG_HOST_FOOTBRIDGE				removed
CONFIG_IEEE1394_AIC5800				removed
CONFIG_INET_PCTCP				removed
CONFIG_IP6_NF_MATCH_MAC				kept
CONFIG_ISDN_DRV_EICON_STANDALONE		CONFIG_ISDN_DRV_EICON_DIVAS
CONFIG_MAC_KEYBOARD				CONFIG_ADB_KEYBOARD
CONFIG_MIXCOMWD 				kept
CONFIG_NCPFS_MOUNT_SUBDIR			removed
CONFIG_NCPFS_NDS_DOMAINS			removed
CONFIG_NET_PROFILE				kept
CONFIG_NFSD_TCP					removed
CONFIG_NLS_ISO8859_10				kept
CONFIG_PARPORT_AX				removed
CONFIG_PATH_MTU_DISCOVERY			removed
CONFIG_PCMCIA_APA1480				kept
CONFIG_PCMCIA_SERIAL_CB				removed
CONFIG_PMAC					removed
CONFIG_PPSCSI					removed
CONFIG_PPSCSI_EPSA2				removed
CONFIG_PPSCSI_EPST				removed
CONFIG_PPSCSI_ONSCSI				removed
CONFIG_PPSCSI_SPARCSI				removed
CONFIG_PPSCSI_T348				removed
CONFIG_PPSCSI_T358				removed
CONFIG_PPSCSI_VPI0				removed
CONFIG_SERIAL_L7200				removed
CONFIG_SERIAL_L7200_CONSOLE			removed
CONFIG_SERIAL_SA1100				removed
CONFIG_SERIAL_SA1100_CONSOLE			removed
CONFIG_SKB_BELOW_4GB				removed
CONFIG_SKB_LARGE				removed
CONFIG_SPX					kept
CONFIG_TCP_NAGLE_OFF				removed
CONFIG_TEXT_SECTIONS				kept
CONFIG_USB_UHCI_ALT_UNLINK_OPTIMIZE		removed
CONFIG_USB_WMFORCE				removed
CONFIG_VIA82CXXX_TUNING				removed

--- Configure.help	2001/04/10 14:05:14	1.1
+++ Configure.help	2001/04/10 14:29:54
@@ -986,12 +986,6 @@
 
   If unsure, say N.
 
-VIA82CXXX Tuning support (WIP)
-CONFIG_VIA82CXXX_TUNING
-  Please read the comments at the top of drivers/ide/via82cxxx.c
-
-  If unsure, say N.
-
 Other IDE chipset support
 CONFIG_IDE_CHIPSETS
   Say Y here if you want to include enhanced support for various IDE
@@ -2433,20 +2427,6 @@
   a module, say M here and read Documentation/modules.txt. If unsure,
   say N.
 
-CardBus serial device support
-CONFIG_PCMCIA_SERIAL_CB
-  Say Y here to enable support for CardBus serial devices, including
-  serial port cards, modems, and the modem functions of multi-function
-  ethernet/modem devices. (CardBus cards are the newer and better 
-  version of PCMCIA- or PC-cards: credit card size devices often 
-  used with laptops.)
-
-  This driver is also available as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want).
-  The module will be called serial_cb.o. If you want to compile it as
-  a module, say M here and read Documentation/modules.txt. If unsure,
-  say N.
-
 /dev/agpgart (AGP Support) (EXPERIMENTAL)
 CONFIG_AGP
   AGP (Accelerated Graphics Port) is a bus system mainly used to
@@ -3700,12 +3680,6 @@
   other non-standard types of parallel ports. This causes a
   performance loss, so most people say N.
 
-Sun Ultra/AX-style hardware 
-CONFIG_PARPORT_AX
-  Say Y here if you need support for the parallel port hardware on Sun
-  Ultra/AX machines. This code is also available as a module (say M),
-  called parport_ax.o. If in doubt, saying N is the safe plan.
-
 Amiga built-in parallel port support
 CONFIG_PARPORT_AMIGA
   Say Y here if you need support for the parallel port hardware on
@@ -4036,55 +4010,6 @@
   gated-5). This routing protocol is not used widely, so say N unless
   you want to play with it.
 
-PC/TCP compatibility mode
-CONFIG_INET_PCTCP
-  If you have been having difficulties telnetting to your Linux
-  machine from a DOS system that uses (broken) PC/TCP networking
-  software (all versions up to OnNet 2.0) over your local Ethernet try
-  saying Y here. Everyone else says N. 
-
-  People having problems with NCSA telnet should see the file
-  Documentation/networking/ncsa-telnet.
-
-Path MTU Discovery (normally enabled)
-CONFIG_PATH_MTU_DISCOVERY
-  MTU (maximal transfer unit) is the size of the chunks we send out
-  over the net. "Path MTU Discovery" means that, instead of always
-  sending very small chunks, we start out sending big ones and if we
-  then discover that some host along the way likes its chunks smaller,
-  we adjust to a smaller size. This is good, so most people say Y
-  here.
-
-  However, some DOS software (versions of DOS NCSA telnet and Trumpet
-  Winsock in PPP mode) is broken and won't be able to connect to your
-  Linux machine correctly in all cases (especially through a terminal
-  server) unless you say N here. See
-  Documentation/networking/ncsa-telnet for the location of fixed NCSA
-  telnet clients. If in doubt, say Y.
-
-Disable NAGLE algorithm (normally enabled)
-CONFIG_TCP_NAGLE_OFF
-  The NAGLE algorithm works by requiring an acknowledgment before
-  sending small IP frames (packets). This keeps tiny telnet and
-  rlogin packets from congesting Wide Area Networks. Most people
-  strongly recommend to say N here, thereby leaving NAGLE
-  enabled. Those programs that would benefit from disabling this
-  facility can do it on a per connection basis themselves.
-
-IP: Allow large windows (not recommended if <16 MB of memory)
-CONFIG_SKB_LARGE
-  On high speed, long distance networks the performance limit on
-  networking becomes the amount of data the sending machine can buffer
-  until the other end confirms its reception. (At 45 Mbit/second there
-  are a lot of bits between New York and London ...). If you say Y
-  here, bigger buffers can be used which allows larger amounts of data
-  to be "in flight" at any given time. It also means a user process
-  can require a lot more memory for network buffers and thus this
-  option is best used only on machines with 16 MB of memory or higher.
-  Unless you are using long links with end to end speeds of over 2
-  Mbit a second or satellite links this option will make no difference
-  to performance.
-
 Unix domain sockets
 CONFIG_UNIX
   If you say Y here, you will include support for Unix domain sockets;
@@ -6613,66 +6538,6 @@
 
   Generally, saying N is fine.
 
-Parallel port SCSI device support
-CONFIG_PPSCSI
-  There are many external CD-ROM and disk devices that connect through
-  your computer's parallel port. Lots of them are actually SCSI
-  devices using a parallel port SCSI adapter. This option enables the
-  ppSCSI subsystem which contains drivers for many of these external
-  drives. You may also want to look at CONFIG_PARIDE (Parallel port
-  IDE device support).
-
-  If you built ppSCSI support into your kernel, you may still build
-  the individual protocol modules and high-level drivers as loadable
-  modules. If you build this support as a module, it will be called
-  ppscsi.o.
-
-  To use the ppSCSI support, you must say Y or M here and also to at
-  least one protocol driver (e.g. "Shuttle EPST adapter", "Iomega VPI0
-  adapter", "Shining ScarSCI adapter" etc.).
-
-Adaptec APA-348 adapter
-CONFIG_PPSCSI_T348
-  This option enables support for the APA-348 adapter from Adaptec
-  (also known as Trantor T348).  If you build this as a module it will
-  be called t348.o.
-
-Adaptec APA-358 adapter
-CONFIG_PPSCSI_T358
-  This option enables support for the APA-358 adapter from Adaptec
-  (also known as Trantor T358).  If you build this as a module it will
-  be called t358.o.
-
-Iomega VPI0 adapter
-CONFIG_PPSCSI_VPI0
-  This option enables support for the Iomega VPI0 adapter found in the
-  original ZIP-100 drives and the Jaz Traveller.  If you build this as
-  a module it will be called vpi0.o.
-
-OnSpec 90c26 adapter
-CONFIG_PPSCSI_ONSCSI
-  This option enables support for the OnSpec 90c26 in its SCSI adapter
-  mode.  If you build this as a module it will be called onscsi.o.
-
-Shining SparSCI adapter
-CONFIG_PPSCSI_SPARCSI
-  This option enables support for the WBS-11A parallel port SCSI
-  adapter.  This adapter has been marketed by LinkSys as the
-  "ParaSCSI+" and by Shining Technologies as the "SparCSI".  If you
-  build this as a module it will be called sparcsi.o.
-
-Shuttle EPSA-2 adapter
-CONFIG_PPSCSI_EPSA2
-  This option enables support for the Shuttle Technologies EPSA2
-  parallel port SCSI adapter.  EPAS2 is a predecessor to the EPST.  If
-  you build this as a module it will be called epsa2.o.
-
-Shuttle EPST adapter
-CONFIG_PPSCSI_EPST
-  This option enables support for the Shuttle Technologies EPST
-  parallel port SCSI adapter.  If you build this as a module is will
-  be called epst.o.
-
 SCSI Debug host simulator. (EXPERIMENTAL)
 CONFIG_SCSI_DEBUG
   This is a host adapter simulator that can be programmed to simulate
@@ -6849,17 +6714,6 @@
   
   If unsure, say N.
 
-Adaptec AIC-5800 IEEE 1394 support
-CONFIG_IEEE1394_AIC5800
-  Say Y here if you have a IEEE 1394 controller using the Adaptec
-  AIC-5800 chip. All Adaptec host adapters (89xx series) use this
-  chip, as well as miro's DV boards.
-
-  If you want to compile this as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want),
-  say M here and read Documentation/modules.txt. The module will be
-  called aic5800.o.
-
 OHCI (Open Host Controller Interface) support
 CONFIG_IEEE1394_OHCI1394
   Say Y here if you have a IEEE 1394 controller based on OHCI.
@@ -8870,18 +8724,6 @@
   module, say M here and read Documentation/modules.txt as well as
   Documentation/networking/net-modules.txt.
 
-Enable arc0e (ARCnet "ether-encap" packet format)
-CONFIG_ARCNET_ETH
-  This allows you to use "Ethernet encapsulation" with your ARCnet
-  card via the virtual arc0e device. You only need arc0e if you want
-  to talk to nonstandard ARCnet software, specifically,
-  DOS/Windows-style "NDIS" drivers. You do not need to say Y here to
-  communicate with industry-standard RFC1201 implementations, like the
-  arcether.com packet driver or most DOS/Windows ODI drivers. RFC1201
-  is included automatically as the arc0 device. Please read the
-  ARCnet documentation in Documentation/networking/arcnet.txt for more
-  information about using arc0e and arc0s.
-
 Enable old ARCNet packet format (RFC 1051)
 CONFIG_ARCNET_1051
   This allows you to use RFC1051 with your ARCnet card via the virtual
@@ -10300,10 +10142,6 @@
   The module will be called uhci.o. If you want to compile it as a
   module, say M here and read Documentation/modules.txt.
 
-UHCI unlink optimizations (EXPERIMENTAL)
-CONFIG_USB_UHCI_ALT_UNLINK_OPTIMIZE
-  This option currently does nothing. You may say Y or N.
-
 OHCI (Compaq, iMacs, OPTi, SiS, ALi, ...) support
 CONFIG_USB_OHCI
   The Open Host Controller Interface is a standard by
@@ -10374,17 +10212,6 @@
   The module will be called wacom.o. If you want to compile it as a
   module, say M here and read Documentation/modules.txt.
 
-Logitech WingMan Force joystick support
-CONFIG_USB_WMFORCE
-  Say Y here if you want to use the Logitech WingMan Force with Linux
-  on the USB port. No force-feedback support yet, but other than that
-  it should work like a normal joystick.
-
-  This driver is also available as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want).
-  The module will be called wmforce.o. If you want to compile it as a
-  module, say M here and read Documentation/modules.txt.
-
 Use input layer for ADB devices
 CONFIG_INPUT_ADBHID
   Say Y here if you want to have ADB (Apple Desktop Bus) HID devices
@@ -11410,13 +11237,6 @@
   If you would like to include the NFSv3 server as well as the NFSv2
   server, say Y here.  If unsure, say Y.
 
-Provide NFS over TCP server support DEVELOPER ONLY
-CONFIG_NFSD_TCP
-  If you are a developer and want to work on fixing problems with
-  NFS server over TCP support, say Y here.  If unsure, say N.
-
-  Some problems can be found by looking for FIXME in net/sunrpc/svcsock.c
-
 OS/2 HPFS file system support
 CONFIG_HPFS_FS
   OS/2 is IBM's operating system for PC's, the same as Warp, and HPFS
@@ -11960,24 +11780,6 @@
   effects by saying Y to "Allow using of Native Language Support"
   below.
 
-Allow mounting of volume subdirectories
-CONFIG_NCPFS_MOUNT_SUBDIR
-  Allows you to mount not only whole servers or whole volumes, but
-  also subdirectories from a volume. It can be used to reexport data
-  and so on. There is no reason to say N, so Y is recommended unless
-  you count every byte.
-
-  To utilize this feature you must use ncpfs-2.0.12 or newer.
-
-NDS authentication support
-CONFIG_NCPFS_NDS_DOMAINS
-  This allows storing NDS private keys in kernel space where they
-  can be used to authenticate another server as interserver NDS
-  accesses need it. You must use ncpfs-2.0.12.1 or newer to utilize
-  this feature. Say Y if you are using NDS connections to NetWare
-  servers. Do not say Y if security is primary for you because root
-  can read your session key (from /proc/kcore).
-
 Allow using of Native Language Support
 CONFIG_NCPFS_NLS
   Allows you to use codepages and I/O charsets for file name
@@ -12402,7 +12204,7 @@
   If unsure, say Y.
 
 Support for PowerMac keyboard
-CONFIG_MAC_KEYBOARD
+CONFIG_ADB_KEYBOARD
   This option allows you to use an ADB keyboard attached to your
   machine. Note that this disables any other (ie. PS/2) keyboard
   support, even if your machine is physically capable of using both at
@@ -15235,7 +15037,7 @@
   Documentation/isdn/README.eicon for more information.
 
 Eicon driver type standalone
-CONFIG_ISDN_DRV_EICON_STANDALONE
+CONFIG_ISDN_DRV_EICON_DIVAS
   Enable this option if you want the eicon driver as standalone
   version with no interface to the ISDN4Linux isdn module. If you
   say Y here, the eicon module only supports the Diva Server PCI
@@ -15988,16 +15790,6 @@
   processor systems, or a 64 bit IBM RS/6000, choose 6xx.  Note that
   the kernel runs in 32-bit mode even on 64-bit chips.
 
-Machine Type
-CONFIG_PMAC
-  Linux currently supports several different kinds of PowerPC-based
-  machines: Apple Power Macintoshes and clones (such as the Motorola
-  Starmax series), PReP (PowerPC Reference Platform) machines such as
-  the Motorola PowerStack, Amiga Power-Up systems (APUS), CHRP and the
-  embedded MBX boards from Motorola. Currently, a single kernel binary
-  only supports one type or the other. However, there is very early
-  work on support for CHRP, PReP and PowerMac's from a single binary.
-
 Power management support for PowerBooks
 CONFIG_PMAC_PBOOK
   This provides support for putting a PowerBook to sleep; it also
@@ -16559,7 +16351,7 @@
   Saying N will reduce the size of the Footbridge kernel.
 
 Include support for the EBSA285
-CONFIG_ARCH_EBSA285
+CONFIG_ARCH_EBSA285_HOST
   Say Y here if you intend to run this kernel on the EBSA285 card
   in host ("central function") mode.
 
@@ -16721,12 +16513,6 @@
   you are concerned with the code size or don't want to see these
   messages.
 
-Compile kernel with frame pointer
-CONFIG_FRAME_POINTER
-  If you say Y here, the resulting kernel will be slightly larger and
-  slower, but it will give useful debugging information. If you don't
-  debug the kernel, you can say N.
-
 User fault debugging
 CONFIG_DEBUG_USER
   When a user program crashes due to an exception, the kernel can
@@ -16810,36 +16596,6 @@
   If you have enabled the serial port on the 21285 footbridge you can
   make it the console by answering Y to this option.
 
-SA1100 serial port support
-CONFIG_SERIAL_SA1100
-  If you have a machine based on a SA1100/SA1110 StrongARM CPU you can
-  enable its onboard serial port by enabling this option.
-  Please read Documentation/arm/SA1100/serial_UART for further info.
-
-Console on SA1100 serial port
-CONFIG_SERIAL_SA1100_CONSOLE
-  If you have enabled the serial port on the SA1100/SA1110 StrongARM
-  CPU you can make it the console by answering Y to this option.
-
-L7200 serial port support
-CONFIG_SERIAL_L7200
-  If you have a LinkUp Systems L7200 board you can enable its two
-  onboard serial ports by enabling this option. The device numbers
-  are major ID 4 with minor 64 and 65 respectively.
-
-Console on L7200 serial port
-CONFIG_SERIAL_L7200_CONSOLE
-  If you have enabled the serial ports on the L7200 development board
-  you can make the first serial port the console by answering Y to
-  this option.
-
-Footbridge Mode
-CONFIG_HOST_FOOTBRIDGE
-  The 21285 Footbridge chip can operate in either `host mode' or
-  `add-in' mode.  Say Y if your 21285 is in host mode, and therefore
-  is the configuration master, otherwise say N. This must not be
-  set to Y if the card is used in 'add-in' mode.
-
 MFM hard disk support
 CONFIG_BLK_DEV_MFM
   Support the MFM hard drives on the Acorn Archimedes both
@@ -17293,17 +17049,6 @@
   Say Y here to enable hacks to make the kernel work on the NEC
   AzusA platform.  Select N here if you're unsure.
 
-Force socket buffers below 4GB?
-CONFIG_SKB_BELOW_4GB
-  Most of today's network interface cards (NICs) support DMA to
-  the low 32 bits of the address space only.  On machines with
-  more then 4GB of memory, this can cause the system to slow
-  down if there is no I/O TLB hardware.  Turning this option on
-  avoids the slow-down by forcing socket buffers to be allocated
-  from memory below 4GB.  The downside is that your system could
-  run out of memory below 4GB before all memory has been used up.
-  If you're unsure how to answer this question, answer Y.
-
 Enable IA-64 Machine Check Abort
 CONFIG_IA64_MCA
   Say Y here to enable machine check support for IA-64.  If you're
@@ -17348,7 +17093,7 @@
 # LocalWords:  netscape gcc LD CC toplevel MODVERSIONS insmod rmmod modprobe IP
 # LocalWords:  genksyms INET loopback gatewaying ethernet PPP ARP Arp MEMSIZE
 # LocalWords:  howto multicasting MULTICAST MBONE firewalling ipfw ACCT resp ip
-# LocalWords:  proc acct IPIP encapsulator decapsulator klogd PCTCP RARP EXT PS
+# LocalWords:  proc acct IPIP encapsulator decapsulator klogd RARP EXT PS
 # LocalWords:  telnetting subnetted NAGLE rlogin NOSR ttyS TGA techinfo mbone nl
 # LocalWords:  Mb SKB IPX Novell dosemu Appletalk DDP ATALK vmalloc visar ehome
 # LocalWords:  SD CHR scsi thingy SG CD LUNs LUN jukebox Adaptec BusLogic EATA

-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>


Yes, the president should resign.  He has lied to the American people, time
and time again, and betrayed their trust.  Since he has admitted guilt,
there is no reason to put the American people through an impeachment.  He
will serve absolutely no purpose in finishing out his term, the only
possible solution is for the president to save some dignity and resign.
	-- 12th Congressional District hopeful Bill Clinton, during Watergate
