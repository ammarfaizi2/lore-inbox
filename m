Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267442AbTBXSRM>; Mon, 24 Feb 2003 13:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbTBXSQs>; Mon, 24 Feb 2003 13:16:48 -0500
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:11262 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S267292AbTBXSKN> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:13 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (9/13): configuration.
Date: Mon, 24 Feb 2003 19:11:39 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302241911.39062.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updates for unified netdev config

- remove duplicate questions from drivers/s390/Kconfig
- some trivial fixes to make the s390 specific options work
- new default configurations

diff -urN linux-2.5.62/arch/s390/Kconfig linux-2.5.62-s390/arch/s390/Kconfig
--- linux-2.5.62/arch/s390/Kconfig	Mon Feb 17 23:56:13 2003
+++ linux-2.5.62-s390/arch/s390/Kconfig	Mon Feb 24 18:24:34 2003
@@ -268,6 +268,9 @@
 
 endmenu
 
+config PCMCIA
+	bool
+	default n
 
 menu "SCSI support"
 
diff -urN linux-2.5.62/arch/s390/defconfig linux-2.5.62-s390/arch/s390/defconfig
--- linux-2.5.62/arch/s390/defconfig	Mon Feb 17 23:56:53 2003
+++ linux-2.5.62-s390/arch/s390/defconfig	Mon Feb 24 18:24:34 2003
@@ -15,17 +15,18 @@
 #
 # General setup
 #
-CONFIG_NET=y
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+CONFIG_LOG_BUF_SHIFT=17
 
 #
 # Loadable module support
 #
 CONFIG_MODULES=y
 # CONFIG_MODULE_UNLOAD is not set
-# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y
 
 #
@@ -59,11 +60,13 @@
 # CONFIG_PROCESS_DEBUG is not set
 CONFIG_PFAULT=y
 # CONFIG_SHARED_KERNEL is not set
+# CONFIG_PCMCIA is not set
 
 #
 # SCSI support
 #
 # CONFIG_SCSI is not set
+CONFIG_CCW=y
 
 #
 # Block device drivers
@@ -124,27 +127,12 @@
 # S/390 tape hardware support
 #
 CONFIG_S390_TAPE_34XX=m
+CONFIG_HOTPLUG=y
 
 #
-# Network device drivers
-#
-CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
-CONFIG_BONDING=m
-CONFIG_EQUALIZER=m
-CONFIG_TUN=m
-CONFIG_NET_ETHERNET=y
-# CONFIG_TR is not set
-# CONFIG_FDDI is not set
-
-#
-# S/390 network device drivers
+# Networking support
 #
-CONFIG_HOTPLUG=y
-CONFIG_LCS=m
-CONFIG_CTC=m
-CONFIG_IUCV=m
-CONFIG_CCWGROUP=m
+CONFIG_NET=y
 
 #
 # Networking options
@@ -174,7 +162,7 @@
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
+CONFIG_IPV6_SCTP__=m
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
@@ -186,7 +174,7 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-CONFIG_NET_FASTROUTE=y
+# CONFIG_NET_FASTROUTE is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
@@ -219,6 +207,47 @@
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=m
+CONFIG_BONDING=m
+CONFIG_EQUALIZER=m
+CONFIG_TUN=m
+# CONFIG_ETHERTAP is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Token Ring devices (depends on LLC=y)
+#
+# CONFIG_SHAPER is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+
+#
+# S/390 network device drivers
+#
+CONFIG_LCS=m
+CONFIG_CTC=m
+CONFIG_IUCV=m
+CONFIG_CCWGROUP=m
 
 #
 # File systems
@@ -232,8 +261,11 @@
 # CONFIG_HFS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
-# CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
 # CONFIG_FAT_FS is not set
 # CONFIG_EFS_FS is not set
 # CONFIG_CRAMFS is not set
@@ -270,6 +302,7 @@
 # CONFIG_NFSD_V4 is not set
 # CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_GSS is not set
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
@@ -277,6 +310,7 @@
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_AFS_FS is not set
+CONFIG_FS_MBCACHE=y
 
 #
 # Partition Types
@@ -319,10 +353,12 @@
 # CONFIG_CRYPTO_MD5 is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
diff -urN linux-2.5.62/arch/s390x/Kconfig linux-2.5.62-s390/arch/s390x/Kconfig
--- linux-2.5.62/arch/s390x/Kconfig	Mon Feb 17 23:56:15 2003
+++ linux-2.5.62-s390/arch/s390x/Kconfig	Mon Feb 24 18:24:34 2003
@@ -282,6 +282,9 @@
 
 endmenu
 
+config PCMCIA
+	bool
+	default n
 
 menu "SCSI support"
 
diff -urN linux-2.5.62/arch/s390x/defconfig linux-2.5.62-s390/arch/s390x/defconfig
--- linux-2.5.62/arch/s390x/defconfig	Mon Feb 17 23:55:49 2003
+++ linux-2.5.62-s390/arch/s390x/defconfig	Mon Feb 24 18:24:34 2003
@@ -15,17 +15,18 @@
 #
 # General setup
 #
-CONFIG_NET=y
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+CONFIG_LOG_BUF_SHIFT=17
 
 #
 # Loadable module support
 #
 CONFIG_MODULES=y
 # CONFIG_MODULE_UNLOAD is not set
-# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y
 
 #
@@ -37,8 +38,7 @@
 #
 CONFIG_SMP=y
 CONFIG_NR_CPUS=64
-CONFIG_S390_SUPPORT=y
-CONFIG_BINFMT_ELF32=y
+# CONFIG_S390_SUPPORT is not set
 
 #
 # I/O subsystem configuration
@@ -60,68 +60,13 @@
 # CONFIG_PROCESS_DEBUG is not set
 CONFIG_PFAULT=y
 # CONFIG_SHARED_KERNEL is not set
+# CONFIG_PCMCIA is not set
 
 #
 # SCSI support
 #
-CONFIG_SCSI=m
-
-#
-# SCSI support type (disk, tape, CD-ROM)
-#
-CONFIG_BLK_DEV_SD=m
-CONFIG_CHR_DEV_ST=m
-CONFIG_CHR_DEV_OSST=m
-CONFIG_BLK_DEV_SR=m
-CONFIG_BLK_DEV_SR_VENDOR=y
-CONFIG_CHR_DEV_SG=m
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
-# CONFIG_SCSI_MULTI_LUN is not set
-# CONFIG_SCSI_REPORT_LUNS is not set
-CONFIG_SCSI_CONSTANTS=y
-CONFIG_SCSI_LOGGING=y
-
-#
-# SCSI low-level drivers
-#
-CONFIG_SCSI_ACARD=m
-CONFIG_SCSI_AIC7XXX=m
-CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
-CONFIG_AIC7XXX_RESET_DELAY_MS=15000
-# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
-CONFIG_SCSI_AIC7XXX_OLD=m
-CONFIG_SCSI_DPT_I2O=m
-CONFIG_SCSI_ADVANSYS=m
-CONFIG_SCSI_IN2000=m
-CONFIG_SCSI_MEGARAID=m
-CONFIG_SCSI_BUSLOGIC=m
-# CONFIG_SCSI_OMIT_FLASHPOINT is not set
-CONFIG_SCSI_EATA=m
-CONFIG_SCSI_EATA_TAGGED_QUEUE=y
-# CONFIG_SCSI_EATA_LINKED_COMMANDS is not set
-CONFIG_SCSI_EATA_MAX_TAGS=16
-CONFIG_SCSI_EATA_DMA=m
-CONFIG_SCSI_EATA_PIO=m
-CONFIG_SCSI_FUTURE_DOMAIN=m
-CONFIG_SCSI_GDTH=m
-CONFIG_SCSI_GENERIC_NCR5380=m
-# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
-# CONFIG_SCSI_GENERIC_NCR53C400 is not set
-CONFIG_SCSI_PCI2000=m
-CONFIG_SCSI_PCI2220I=m
-CONFIG_SCSI_U14_34F=m
-# CONFIG_SCSI_U14_34F_LINKED_COMMANDS is not set
-CONFIG_SCSI_U14_34F_MAX_TAGS=8
-# CONFIG_SCSI_NSP32 is not set
-CONFIG_SCSI_DEBUG=m
-
-#
-# PCMCIA SCSI adapter support
-#
-# CONFIG_SCSI_PCMCIA is not set
+# CONFIG_SCSI is not set
+CONFIG_CCW=y
 
 #
 # Block device drivers
@@ -182,27 +127,12 @@
 # S/390 tape hardware support
 #
 CONFIG_S390_TAPE_34XX=m
+CONFIG_HOTPLUG=y
 
 #
-# Network device drivers
-#
-CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
-CONFIG_BONDING=m
-CONFIG_EQUALIZER=m
-CONFIG_TUN=m
-CONFIG_NET_ETHERNET=y
-# CONFIG_TR is not set
-# CONFIG_FDDI is not set
-
-#
-# S/390 network device drivers
+# Networking support
 #
-CONFIG_HOTPLUG=y
-CONFIG_LCS=m
-CONFIG_CTC=m
-CONFIG_IUCV=m
-CONFIG_CCWGROUP=m
+CONFIG_NET=y
 
 #
 # Networking options
@@ -232,7 +162,7 @@
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
+CONFIG_IPV6_SCTP__=m
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
@@ -244,7 +174,7 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-CONFIG_NET_FASTROUTE=y
+# CONFIG_NET_FASTROUTE is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
@@ -277,6 +207,47 @@
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=m
+CONFIG_BONDING=m
+CONFIG_EQUALIZER=m
+CONFIG_TUN=m
+# CONFIG_ETHERTAP is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Token Ring devices (depends on LLC=y)
+#
+# CONFIG_SHAPER is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+
+#
+# S/390 network device drivers
+#
+CONFIG_LCS=m
+CONFIG_CTC=m
+CONFIG_IUCV=m
+CONFIG_CCWGROUP=m
 
 #
 # File systems
@@ -293,8 +264,11 @@
 # CONFIG_HFS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
-# CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
 # CONFIG_FAT_FS is not set
 # CONFIG_EFS_FS is not set
 # CONFIG_CRAMFS is not set
@@ -331,6 +305,7 @@
 # CONFIG_NFSD_V4 is not set
 # CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_GSS is not set
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
@@ -338,6 +313,7 @@
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_AFS_FS is not set
+CONFIG_FS_MBCACHE=y
 
 #
 # Partition Types
@@ -380,10 +356,12 @@
 # CONFIG_CRYPTO_MD5 is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
diff -urN linux-2.5.62/drivers/net/Kconfig linux-2.5.62-s390/drivers/net/Kconfig
--- linux-2.5.62/drivers/net/Kconfig	Mon Feb 24 18:17:43 2003
+++ linux-2.5.62-s390/drivers/net/Kconfig	Mon Feb 24 18:24:37 2003
@@ -2445,3 +2445,5 @@
 source "drivers/net/pcmcia/Kconfig"
 
 source "drivers/atm/Kconfig"
+
+source "drivers/s390/net/Kconfig"
diff -urN linux-2.5.62/drivers/net/tokenring/Kconfig linux-2.5.62-s390/drivers/net/tokenring/Kconfig
--- linux-2.5.62/drivers/net/tokenring/Kconfig	Mon Feb 17 23:56:09 2003
+++ linux-2.5.62-s390/drivers/net/tokenring/Kconfig	Mon Feb 24 18:24:37 2003
@@ -8,7 +8,7 @@
 # So far, we only have PCI, ISA, and MCA token ring devices
 config TR
 	bool "Token Ring driver support"
-	depends on (PCI || ISA || MCA) && LLC=y
+	depends on (PCI || ISA || MCA || CCW) && LLC=y
 	help
 	  Token Ring is IBM's way of communication on a local network; the
 	  rest of the world uses Ethernet. To participate on a Token Ring
diff -urN linux-2.5.62/drivers/s390/Kconfig linux-2.5.62-s390/drivers/s390/Kconfig
--- linux-2.5.62/drivers/s390/Kconfig	Mon Feb 17 23:56:54 2003
+++ linux-2.5.62-s390/drivers/s390/Kconfig	Mon Feb 24 18:24:37 2003
@@ -1,3 +1,7 @@
+config CCW
+	bool
+	default y
+
 
 menu "Block device drivers"
 
@@ -317,186 +321,6 @@
 endmenu
 
 
-menu "Network device drivers"
-	depends on NET
-
-config NETDEVICES
-	bool "Network device support"
-	---help---
-	  You can say N here if you don't intend to connect your Linux box to
-	  any other computer at all or if all your connections will be over a
-	  telephone line with a modem either via UUCP (UUCP is a protocol to
-	  forward mail and news between unix hosts over telephone lines; read
-	  the UUCP-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>) or dialing up a shell
-	  account or a BBS, even using term (term is a program which gives you
-	  almost full Internet connectivity if you have a regular dial up
-	  shell account on some Internet connected Unix computer. Read
-	  <http://www.bart.nl/~patrickr/term-howto/Term-HOWTO.html>).
-
-	  You'll have to say Y if your computer contains a network card that
-	  you want to use under Linux (make sure you know its name because you
-	  will be asked for it and read the Ethernet-HOWTO (especially if you
-	  plan to use more than one network card under Linux)) or if you want
-	  to use SLIP (Serial Line Internet Protocol is the protocol used to
-	  send Internet traffic over telephone lines or null modem cables) or
-	  CSLIP (compressed SLIP) or PPP (Point to Point Protocol, a better
-	  and newer replacement for SLIP) or PLIP (Parallel Line Internet
-	  Protocol is mainly used to create a mini network by connecting the
-	  parallel ports of two local machines) or AX.25/KISS (protocol for
-	  sending Internet traffic over amateur radio links).
-
-	  Make sure to read the NET-3-HOWTO. Eventually, you will have to read
-	  Olaf Kirch's excellent and free book "Network Administrator's
-	  Guide", to be found in <http://www.linuxdoc.org/docs.html#guide>. If
-	  unsure, say Y.
-
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
-	  will be called dummy.  If you want to use more than one dummy
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
-	  will be called bonding.
-
-config EQUALIZER
-	tristate "EQL (serial line load balancing) support"
-	depends on NETDEVICES
-	---help---
-	  If you have two serial connections to some other computer (this
-	  usually requires two modems and two telephone lines) and you use
-	  SLIP (the protocol for sending Internet traffic over telephone
-	  lines) or PPP (a better SLIP) on them, you can make them behave like
-	  one double speed connection using this driver.  Naturally, this has
-	  to be supported at the other end as well, either with a similar EQL
-	  Linux driver or with a Livingston Portmaster 2e.
-
-	  Say Y if you want this and read
-	  <file:Documentation/networking/eql.txt>.  You may also want to read
-	  section 6.2 of the NET-3-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called eql.  If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.  If
-	  unsure, say N.
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
-	  The module will be called tun.  If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
-
-	  If you don't know what to use this for, you don't need it.
-
-config NET_ETHERNET
-	bool "Ethernet (10 or 100Mbit)"
-	depends on NETDEVICES
-	---help---
-	  Ethernet (also called IEEE 802.3 or ISO 8802-2) is the most common
-	  type of Local Area Network (LAN) in universities and companies.
-
-	  Common varieties of Ethernet are: 10BASE-2 or Thinnet (10 Mbps over
-	  coaxial cable, linking computers in a chain), 10BASE-T or twisted
-	  pair (10 Mbps over twisted pair cable, linking computers to central
-	  hubs), 10BASE-F (10 Mbps over optical fiber links, using hubs),
-	  100BASE-TX (100 Mbps over two twisted pair cables, using hubs),
-	  100BASE-T4 (100 Mbps over 4 standard voice-grade twisted pair
-	  cables, using hubs), 100BASE-FX (100 Mbps over optical fiber links)
-	  [the 100BASE varieties are also known as Fast Ethernet], and Gigabit
-	  Ethernet (1 Gbps over optical fiber or short copper links).
-
-	  If your Linux machine will be connected to an Ethernet and you have
-	  an Ethernet network interface card (NIC) installed in your computer,
-	  say Y here and read the Ethernet-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>. You will then also have
-	  to say Y to the driver for your particular NIC.
-
-	  Note that the answer to this question won't directly affect the
-	  kernel: saying N will just cause the configurator to skip all
-	  the questions about Ethernet network cards. If unsure, say N.
-
-config TR
-	bool "Token Ring driver support"
-	depends on NETDEVICES
-	help
-	  Token Ring is IBM's way of communication on a local network; the
-	  rest of the world uses Ethernet. To participate on a Token Ring
-	  network, you need a special Token ring network card. If you are
-	  connected to such a Token Ring network and want to use your Token
-	  Ring card under Linux, say Y here and to the driver for your
-	  particular card below and read the Token-Ring mini-HOWTO, available
-	  from <http://www.linuxdoc.org/docs.html#howto>. Most people can
-	  say N here.
-
-config FDDI
-	bool "FDDI driver support"
-	depends on NETDEVICES
-	help
-	  Fiber Distributed Data Interface is a high speed local area network
-	  design; essentially a replacement for high speed Ethernet. FDDI can
-	  run over copper or fiber. If you are connected to such a network and
-	  want a driver for the FDDI card in your computer, say Y here (and
-	  then also Y to the driver for your FDDI card, below). Most people
-	  will say N.
-
-comment "S/390 network device drivers"
-	depends on NETDEVICES
-
 config HOTPLUG
 	bool
 	default y
@@ -516,39 +340,4 @@
 	  agent" (/sbin/hotplug) to load modules and set up software needed
 	  to use devices as you hotplug them.
 
-config LCS
-	tristate "Lan Channel Station Interface"
-	depends on NETDEVICES && (NET_ETHERNET || TR || FDDI)
-	help
-	   Select this option if you want to use LCS networking  on IBM S/390
-  	   or zSeries. This device driver supports Token Ring (IEEE 802.5),
-  	   FDDI (IEEE 802.7) and Ethernet. 
-	   This option is also available as a module which will be
-	   called lcs . If you do not know what it is, it's safe to say "Y".
-
-config CTC
-	tristate "CTC device support"
-	depends on NETDEVICES
-	help
-	  Select this option if you want to use channel-to-channel networking
-	  on IBM S/390 or zSeries. This device driver supports real CTC
-	  coupling using ESCON. It also supports virtual CTCs when running
-	  under VM. It will use the channel device configuration if this is
-	  available.  This option is also available as a module which will be
-	  called ctc.  If you do not know what it is, it's safe to say "Y".
-
-config IUCV
-	tristate "IUCV device support (VM only)"
-	depends on NETDEVICES
-	help
-	  Select this option if you want to use inter-user communication
-	  vehicle networking under VM or VIF.  This option is also available
-	  as a module which will be called iucv. If unsure, say "Y".
-
-config CCWGROUP
- 	tristate
- 	depends on LCS || CTC
-	default m if LCS!=y && CTC!=y
-	default y if LCS=y || CTC=y
-endmenu
 
diff -urN linux-2.5.62/drivers/s390/net/Kconfig linux-2.5.62-s390/drivers/s390/net/Kconfig
--- linux-2.5.62/drivers/s390/net/Kconfig	Thu Jan  1 01:00:00 1970
+++ linux-2.5.62-s390/drivers/s390/net/Kconfig	Mon Feb 24 18:24:37 2003
@@ -0,0 +1,38 @@
+menu "S/390 network device drivers"
+	depends on NETDEVICES && ARCH_S390
+
+config LCS
+	tristate "Lan Channel Station Interface"
+	depends on NETDEVICES && (NET_ETHERNET || TR || FDDI)
+	help
+	   Select this option if you want to use LCS networking  on IBM S/390
+  	   or zSeries. This device driver supports Token Ring (IEEE 802.5),
+  	   FDDI (IEEE 802.7) and Ethernet. 
+	   This option is also available as a module which will be
+	   called lcs.o . If you do not know what it is, it's safe to say "Y".
+
+config CTC
+	tristate "CTC device support"
+	depends on NETDEVICES
+	help
+	  Select this option if you want to use channel-to-channel networking
+	  on IBM S/390 or zSeries. This device driver supports real CTC
+	  coupling using ESCON. It also supports virtual CTCs when running
+	  under VM. It will use the channel device configuration if this is
+	  available.  This option is also available as a module which will be
+	  called ctc.o.  If you do not know what it is, it's safe to say "Y".
+
+config IUCV
+	tristate "IUCV device support (VM only)"
+	depends on NETDEVICES
+	help
+	  Select this option if you want to use inter-user communication
+	  vehicle networking under VM or VIF.  This option is also available
+	  as a module which will be called iucv.o. If unsure, say "Y".
+
+config CCWGROUP
+ 	tristate
+ 	depends on LCS || CTC
+	default m if LCS!=y && CTC!=y
+	default y if LCS=y || CTC=y
+endmenu

