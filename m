Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbTAAVvr>; Wed, 1 Jan 2003 16:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTAAVvr>; Wed, 1 Jan 2003 16:51:47 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:19904 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264836AbTAAVvZ>; Wed, 1 Jan 2003 16:51:25 -0500
Date: Wed, 1 Jan 2003 22:59:49 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Pete Zaitcev <zaitcev@redhat.com>, davem@redhat.com
Cc: lkml <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org
Subject: Re: sparc32 net devices
Message-ID: <20030101215949.GG17053@louise.pinerecords.com>
References: <20030101204954.GD17053@louise.pinerecords.com> <20030101155849.A20852@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030101155849.A20852@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [zaitcev@redhat.com]
> 
> > Date: Wed, 1 Jan 2003 21:49:54 +0100
> > From: Tomas Szepe <szepe@pinerecords.com>
> 
> > Would you be ok with my possible moving of sparc32 specific net driver
> > configuration from arch/sparc/Kconfig to drivers/net/Kconfig just like
> > sparc64 and all other architectures (except m68k) have been for a long
> > time now?
> > 
> > Of course this would be 2.5-only.
> 
> Be my guest. Everything that makes us match sparc64 better
> is welcome.

Here's a first stab then.  No need to include sbus devices
in drivers/net/Kconfig, they're all there already.  Unfortunately
this has to tune a lot of drivers' bus dependencies, I'm quite sure
I've missed some.

diff -urN a/arch/sparc/Kconfig b/arch/sparc/Kconfig
--- a/arch/sparc/Kconfig	2002-12-16 07:01:46.000000000 +0100
+++ b/arch/sparc/Kconfig	2003-01-01 22:16:54.000000000 +0100
@@ -918,357 +918,12 @@
 	  Guide", to be found in <http://www.linuxdoc.org/docs.html#guide>. If
 	  unsure, say Y.
 
-config DUMMY
-	tristate "Dummy net driver support"
-	depends on NETDEVICES
-	---help---
-	  This is essentially a bit-bucket device (i.e. traffic you send to
-	  this device is consigned into oblivion) with a configurable IP
-	  address. It is most commonly used in order to make your currently
-	  inactive SLIP address seem like a real address for local programs.
-	  If you use SLIP or PPP, you might want to say Y here. Since this
-	  thing often comes in handy, the default is Y. It won't enlarge your
-	  kernel either. What a deal. Read about it in the Network
-	  Administrator's Guide, available from
-	  <http://www.linuxdoc.org/docs.html#guide>.
-
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called dummy.o.  If you want to use more than one dummy
-	  device at a time, you need to compile this driver as a module.
-	  Instead of 'dummy', the devices will then be called 'dummy0',
-	  'dummy1' etc.
-
-config BONDING
-	tristate "Bonding driver support"
-	depends on NETDEVICES
-	---help---
-	  Say 'Y' or 'M' if you wish to be able to 'bond' multiple Ethernet
-	  Channels together. This is called 'Etherchannel' by Cisco,
-	  'Trunking' by Sun, and 'Bonding' in Linux.
-
-	  If you have two Ethernet connections to some other computer, you can
-	  make them behave like one double speed connection using this driver.
-	  Naturally, this has to be supported at the other end as well, either
-	  with a similar Bonding Linux driver, a Cisco 5500 switch or a
-	  SunTrunking SunSoft driver.
-
-	  This is similar to the EQL driver, but it merges Ethernet segments
-	  instead of serial lines.
-
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called bonding.o.
-
-config TUN
-	tristate "Universal TUN/TAP device driver support"
-	depends on NETDEVICES
-	---help---
-	  TUN/TAP provides packet reception and transmission for user space
-	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
-	  device, which instead of receiving packets from a physical media,
-	  receives them from user space program and instead of sending packets
-	  via physical media writes them to the user space program.
-
-	  When a program opens /dev/net/tun, driver creates and registers
-	  corresponding net device tunX or tapX.  After a program closed above
-	  devices, driver will automatically delete tunXX or tapXX device and
-	  all routes corresponding to it.
-
-	  Please read <file:Documentation/networking/tuntap.txt> for more
-	  information.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called tun.o.  If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
-
-	  If you don't know what to use this for, you don't need it.
-
-config ETHERTAP
-	tristate "Ethertap network tap (OBSOLETE)"
-	depends on NETDEVICES && EXPERIMENTAL && NETLINK
-	---help---
-	  If you say Y here (and have said Y to "Kernel/User network link
-	  driver", above) and create a character special file /dev/tap0 with
-	  major number 36 and minor number 16 using mknod ("man mknod"), you
-	  will be able to have a user space program read and write raw
-	  Ethernet frames from/to that special file.  tap0 can be configured
-	  with ifconfig and route like any other Ethernet device but it is not
-	  connected to any physical LAN; everything written by the user to
-	  /dev/tap0 is treated by the kernel as if it had come in from a LAN
-	  to the device tap0; everything the kernel wants to send out over the
-	  device tap0 can instead be read by the user from /dev/tap0: the user
-	  mode program replaces the LAN that would be attached to an ordinary
-	  Ethernet device. Please read the file
-	  <file:Documentation/networking/ethertap.txt> for more information.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called ethertap.o. If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
-
-	  If you don't know what to use this for, you don't need it.
-
-config PPP
-	tristate "PPP (point-to-point protocol) support"
-	depends on NETDEVICES
-	---help---
-	  PPP (Point to Point Protocol) is a newer and better SLIP.  It serves
-	  the same purpose: sending Internet traffic over telephone (and other
-	  serial) lines.  Ask your access provider if they support it, because
-	  otherwise you can't use it; most Internet access providers these
-	  days support PPP rather than SLIP.
-
-	  To use PPP, you need an additional program called pppd as described
-	  in the PPP-HOWTO, available at
-	  <http://www.linuxdoc.org/docs.html#howto>.  Make sure that you have
-	  the version of pppd recommended in <file:Documentation/Changes>.
-	  The PPP option enlarges your kernel by about 16 KB.
-
-	  There are actually two versions of PPP: the traditional PPP for
-	  asynchronous lines, such as regular analog phone lines, and
-	  synchronous PPP which can be used over digital ISDN lines for
-	  example.  If you want to use PPP over phone lines or other
-	  asynchronous serial lines, you need to say Y (or M) here and also to
-	  the next option, "PPP support for async serial ports".  For PPP over
-	  synchronous lines, you should say Y (or M) here and to "Support
-	  synchronous PPP", below.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  If you said Y to "Version information on all symbols" above, then
-	  you cannot compile the PPP driver into the kernel; you can then only
-	  compile it as a module.  The module will be called ppp_generic.o.
-	  If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt> as well as
-	  <file:Documentation/networking/net-modules.txt>.
-
-config PPP_ASYNC
-	tristate "PPP support for async serial ports"
-	depends on PPP
-	---help---
-	  Say Y (or M) here if you want to be able to use PPP over standard
-	  asynchronous serial ports, such as COM1 or COM2 on a PC.  If you use
-	  a modem (not a synchronous or ISDN modem) to contact your ISP, you
-	  need this option.
-
-	  This code is also available as a module (code which can be inserted
-	  into and removed from the running kernel).  If you want to compile
-	  it as a module, say M here and read <file:Documentation/modules.txt>.
-
-	  If unsure, say Y.
-
-config PPP_SYNC_TTY
-	tristate "PPP support for sync tty ports"
-	depends on PPP
-	help
-	  Say Y (or M) here if you want to be able to use PPP over synchronous
-	  (HDLC) tty devices, such as the SyncLink adapter. These devices
-	  are often used for high-speed leased lines like T1/E1.
-
-	  This code is also available as a module (code which can be inserted
-	  into and removed from the running kernel).  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
-
-config PPP_DEFLATE
-	tristate "PPP Deflate compression"
-	depends on PPP
-	---help---
-	  Support for the Deflate compression method for PPP, which uses the
-	  Deflate algorithm (the same algorithm that gzip uses) to compress
-	  each PPP packet before it is sent over the wire.  The machine at the
-	  other end of the PPP link (usually your ISP) has to support the
-	  Deflate compression method as well for this to be useful.  Even if
-	  they don't support it, it is safe to say Y here.
-
-	  This code is also available as a module (code which can be inserted
-	  into and removed from the running kernel).  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
-
-config PPP_BSDCOMP
-	tristate "PPP BSD-Compress compression"
-	depends on NETDEVICES && PPP!=n && m
-	---help---
-	  Support for the BSD-Compress compression method for PPP, which uses
-	  the LZW compression method to compress each PPP packet before it is
-	  sent over the wire. The machine at the other end of the PPP link
-	  (usually your ISP) has to support the BSD-Compress compression
-	  method as well for this to be useful. Even if they don't support it,
-	  it is safe to say Y here.
-
-	  The PPP Deflate compression method ("PPP Deflate compression",
-	  above) is preferable to BSD-Compress, because it compresses better
-	  and is patent-free.
-
-	  Note that the BSD compression code will always be compiled as a
-	  module; it is called bsd_comp.o and will show up in the directory
-	  modules once you have said "make modules". If unsure, say N.
-
-config SLIP
-	tristate "SLIP (serial line) support"
-	depends on NETDEVICES
-	---help---
-	  Say Y if you intend to use SLIP or CSLIP (compressed SLIP) to
-	  connect to your Internet service provider or to connect to some
-	  other local Unix box or if you want to configure your Linux box as a
-	  Slip/CSlip server for other people to dial in. SLIP (Serial Line
-	  Internet Protocol) is a protocol used to send Internet traffic over
-	  serial connections such as telephone lines or null modem cables;
-	  nowadays, the protocol PPP is more commonly used for this same
-	  purpose.
-
-	  Normally, your access provider has to support SLIP in order for you
-	  to be able to use it, but there is now a SLIP emulator called SLiRP
-	  around (available from
-	  <ftp://ibiblio.org/pub/Linux/system/network/serial/>) which
-	  allows you to use SLIP over a regular dial up shell connection. If
-	  you plan to use SLiRP, make sure to say Y to CSLIP, below. The
-	  NET-3-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>, explains how to
-	  configure SLIP. Note that you don't need this option if you just
-	  want to run term (term is a program which gives you almost full
-	  Internet connectivity if you have a regular dial up shell account on
-	  some Internet connected Unix computer. Read
-	  <http://www.bart.nl/~patrickr/term-howto/Term-HOWTO.html>). SLIP
-	  support will enlarge your kernel by about 4 KB. If unsure, say N.
-
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt> as well as
-	  <file:Documentation/networking/net-modules.txt>. The module will be
-	  called slip.o.
-
-config SLIP_COMPRESSED
-	bool "CSLIP compressed headers"
-	depends on SLIP
-	---help---
-	  This protocol is faster than SLIP because it uses compression on the
-	  TCP/IP headers (not on the data itself), but it has to be supported
-	  on both ends. Ask your access provider if you are not sure and
-	  answer Y, just in case. You will still be able to use plain SLIP. If
-	  you plan to use SLiRP, the SLIP emulator (available from
-	  <ftp://ibiblio.org/pub/Linux/system/network/serial/>) which
-	  allows you to use SLIP over a regular dial up shell connection, you
-	  definitely want to say Y here. The NET-3-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>, explains how to configure
-	  CSLIP. This won't enlarge your kernel.
-
-config SLIP_SMART
-	bool "Keepalive and linefill"
-	depends on SLIP
-	help
-	  Adds additional capabilities to the SLIP driver to support the
-	  RELCOM line fill and keepalive monitoring. Ideal on poor quality
-	  analogue lines.
-
-config SLIP_MODE_SLIP6
-	bool "Six bit SLIP encapsulation"
-	depends on SLIP
-	help
-	  Just occasionally you may need to run IP over hostile serial
-	  networks that don't pass all control characters or are only seven
-	  bit. Saying Y here adds an extra mode you can use with SLIP:
-	  "slip6". In this mode, SLIP will only send normal ASCII symbols over
-	  the serial device. Naturally, this has to be supported at the other
-	  end of the link as well. It's good enough, for example, to run IP
-	  over the async ports of a Camtec JNT Pad. If unsure, say N.
-
-config SUNLANCE
-	tristate "Sun LANCE support"
-	depends on NETDEVICES
-	help
-	  This driver supports the "le" interface present on all 32-bit Sparc
-	  systems, on some older Ultra systems and as an Sbus option.  These
-	  cards are based on the AMD Lance chipset, which is better known
-	  via the NE2100 cards.
-
-	  This support is also available as a module called sunlance.o ( =
-	  code which can be inserted in and removed from the running kernel
-	  whenever you want). If you want to compile it as a module, say M
-	  here and read <file:Documentation/modules.txt>.
-
-config HAPPYMEAL
-	tristate "Sun Happy Meal 10/100baseT support"
-	depends on NETDEVICES
-	help
-	  This driver supports the "hme" interface present on most Ultra
-	  systems and as an option on older Sbus systems. This driver supports
-	  both PCI and Sbus devices. This driver also supports the "qfe" quad
-	  100baseT device available in both PCI and Sbus configurations.
-
-	  This support is also available as a module called sunhme.o ( = code
-	  which can be inserted in and removed from the running kernel
-	  whenever you want). If you want to compile it as a module, say M
-	  here and read <file:Documentation/modules.txt>.
-
-config SUNBMAC
-	tristate "Sun BigMAC 10/100baseT support (EXPERIMENTAL)"
-	depends on NETDEVICES && EXPERIMENTAL
-	help
-	  This driver supports the "be" interface available as an Sbus option.
-	  This is Sun's older 100baseT Ethernet device.
-
-	  This support is also available as a module called sunbmac.o ( = code
-	  which can be inserted in and removed from the running kernel
-	  whenever you want). If you want to compile it as a module, say M
-	  here and read <file:Documentation/modules.txt>.
-
-config SUNQE
-	tristate "Sun QuadEthernet support"
-	depends on NETDEVICES
-	help
-	  This driver supports the "qe" 10baseT Ethernet device, available as
-	  an Sbus option. Note that this is not the same as Quad FastEthernet
-	  "qfe" which is supported by the Happy Meal driver instead.
-
-	  This support is also available as a module called sunqe.o ( = code
-	  which can be inserted in and removed from the running kernel
-	  whenever you want). If you want to compile it as a module, say M
-	  here and read <file:Documentation/modules.txt>.
-
-config MYRI_SBUS
-	tristate "MyriCOM Gigabit Ethernet support"
-	depends on NETDEVICES
-	help
-	  This driver supports MyriCOM Sbus gigabit Ethernet cards.
-
-	  If you want to compile this driver as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  This is
-	  recommended.  The module will be called myri_sbus.o.
-
-config VORTEX
-	tristate "3c590/3c900 series (592/595/597) \"Vortex/Boomerang\" support"
-	depends on NETDEVICES && PCI
-	---help---
-	  This option enables driver support for a large number of 10mbps and
-	  10/100mbps EISA, PCI and PCMCIA 3Com network cards:
-
-	  "Vortex"    (Fast EtherLink 3c590/3c592/3c595/3c597) EISA and PCI
-	  "Boomerang" (EtherLink XL 3c900 or 3c905)            PCI
-	  "Cyclone"   (3c540/3c900/3c905/3c980/3c575/3c656)    PCI and Cardbus
-	  "Tornado"   (3c905)                                  PCI
-	  "Hurricane" (3c555/3cSOHO)                           PCI
-
-	  If you have such a card, say Y and read the Ethernet-HOWTO,
-	  available from <http://www.linuxdoc.org/docs.html#howto>. More
-	  specific information is in
-	  <file:Documentation/networking/vortex.txt> and in the comments at
-	  the beginning of <file:drivers/net/3c59x.c>.
-
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt> as well as
-	  <file:Documentation/networking/net-modules.txt>.
-
 #      bool '  FDDI driver support' CONFIG_FDDI
 #      if [ "$CONFIG_FDDI" = "y" ]; then
 #      fi
+
+source "drivers/net/Kconfig"
+
 source "drivers/atm/Kconfig"
 
 endmenu
diff -urN a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2002-12-24 10:45:39.000000000 +0100
+++ b/drivers/net/Kconfig	2003-01-01 22:45:57.000000000 +0100
@@ -384,7 +384,7 @@
 
 config NET_VENDOR_3COM
 	bool "3COM cards"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && (ISA || EISA || MCA || PCI)
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y
 	  and read the Ethernet-HOWTO, available from
@@ -555,7 +555,7 @@
 
 config NET_VENDOR_SMC
 	bool "Western Digital/SMC cards"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && (ISA || MCA || EISA)
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y
 	  and read the Ethernet-HOWTO, available from
@@ -648,7 +648,7 @@
 
 config NET_VENDOR_RACAL
 	bool "Racal-Interlan (Micom) NI cards"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && ISA
 	help
 	  If you have a network (Ethernet) card belonging to this class, such
 	  as the NI5010, NI5210 or NI6210, say Y and read the Ethernet-HOWTO,
@@ -1459,7 +1459,7 @@
 
 config NET_POCKET
 	bool "Pocket and portable adapters"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && ISA
 	---help---
 	  Cute little network (Ethernet) devices which attach to the parallel
 	  port ("pocket adapters"), commonly used with laptops. If you have
@@ -1777,7 +1777,7 @@
 
 config FDDI
 	bool "FDDI driver support"
-	depends on NETDEVICES
+	depends on NETDEVICES && (PCI || EISA)
 	help
 	  Fiber Distributed Data Interface is a high speed local area network
 	  design; essentially a replacement for high speed Ethernet. FDDI can
@@ -1828,7 +1828,7 @@
 
 config HIPPI
 	bool "HIPPI driver support (EXPERIMENTAL)"
-	depends on NETDEVICES && EXPERIMENTAL && INET
+	depends on NETDEVICES && EXPERIMENTAL && INET && PCI
 	help
 	  HIgh Performance Parallel Interface (HIPPI) is a 800Mbit/sec and
 	  1600Mbit/sec dual-simplex switched or point-to-point network. HIPPI
@@ -2181,7 +2181,7 @@
 
 config AIRONET4500
 	tristate "Aironet 4500/4800 series adapters"
-	depends on NET_RADIO
+	depends on NET_RADIO && (PCI || ISA || PCMCIA)
 	---help---
 	  www.aironet.com (recently bought by Cisco) makes these 802.11 DS
 	  adapters.  Driver by Elmer Joandi (elmer@ylenurme.ee).
@@ -2286,7 +2286,7 @@
 
 config NET_FC
 	bool "Fibre Channel driver support"
-	depends on NETDEVICES
+	depends on NETDEVICES && SCSI && PCI
 	help
 	  Fibre Channel is a high speed serial protocol mainly used to connect
 	  large storage devices to the computer; it is compatible with and
diff -urN a/drivers/net/arcnet/Kconfig b/drivers/net/arcnet/Kconfig
--- a/drivers/net/arcnet/Kconfig	2002-10-31 02:33:49.000000000 +0100
+++ b/drivers/net/arcnet/Kconfig	2003-01-01 22:40:42.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 menu "ARCnet devices"
-	depends on NETDEVICES
+	depends on NETDEVICES && (ISA || PCI)
 
 config ARCNET
 	tristate "ARCnet support"
diff -urN a/drivers/net/tokenring/Kconfig b/drivers/net/tokenring/Kconfig
--- a/drivers/net/tokenring/Kconfig	2002-12-08 20:06:34.000000000 +0100
+++ b/drivers/net/tokenring/Kconfig	2003-01-01 22:38:15.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 menu "Token Ring devices (depends on LLC=y)"
-	depends on NETDEVICES
+	depends on NETDEVICES && (PCI || ISA || MCA)
 
 # So far, we only have PCI, ISA, and MCA token ring devices
 config TR
@@ -91,7 +91,7 @@
 
 config TMS380TR
 	tristate "Generic TMS380 Token Ring ISA/PCI adapter support"
-	depends on TR
+	depends on TR && (PCI || ISA)
 	---help---
 	  This driver provides generic support for token ring adapters
 	  based on the Texas Instruments TMS380 series chipsets.  This
diff -urN a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
--- a/drivers/net/wireless/Kconfig	2002-10-31 02:33:50.000000000 +0100
+++ b/drivers/net/wireless/Kconfig	2003-01-01 22:42:38.000000000 +0100
@@ -2,12 +2,12 @@
 # Wireless LAN device configuration
 #
 comment "Wireless ISA/PCI cards support"
-	depends on NET_RADIO
+	depends on NET_RADIO && (ISA || PCI || ALL_PPC || PCMCIA)
 
 # Good old obsolete Wavelan.
 config WAVELAN
 	tristate "AT&T/Lucent old WaveLAN & DEC RoamAbout DS ISA support"
-	depends on NET_RADIO
+	depends on NET_RADIO && ISA
 	---help---
 	  The Lucent WaveLAN (formerly NCR and AT&T; or DEC RoamAbout DS) is
 	  a Radio LAN (wireless Ethernet-like Local Area Network) using the
@@ -54,7 +54,7 @@
 
 config HERMES
 	tristate "Hermes chipset 802.11b support (Orinoco/Prism2/Symbol)"
-	depends on NET_RADIO
+	depends on NET_RADIO && (ALL_PPC || PCI || PCMCIA)
 	---help---
 	  A driver for 802.11b wireless cards based based on the "Hermes" or
 	  Intersil HFA384x (Prism 2) MAC controller.  This includes the vast
