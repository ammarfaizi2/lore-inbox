Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbTAATYd>; Wed, 1 Jan 2003 14:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbTAATYd>; Wed, 1 Jan 2003 14:24:33 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:59327 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261545AbTAATYV>; Wed, 1 Jan 2003 14:24:21 -0500
Date: Wed, 1 Jan 2003 20:32:29 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH,RFC] move CONFIG_NET to net/Kconfig
Message-ID: <20030101193229.GN15200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After playing a bit of the old iq test game "find an entry that doesn't
fit" in "General Setup," I decided to send in for review the following
patch that seems almost as drastic as it is logical:

o  Create a "Networking Support" menu.
o  Move "Networking options" into the new "Networking Support" menu.
o  Move "Network device support" into the new "Networking Support" menu.

The best part of this patch is that it eliminates a lot of duplicit
stuff in 15 arch-specific files (only sparc32 and m68k define their
net devices in an arch specific Kconfig) and places a single 'source
"drivers/net/Kconfig"' line in the one file where it belongs, net/Kconfig.

There's one problem with the CRIS and M68KNOMMU architectures, that is
they don't provide CONFIG_{CRIS,M68KNOMMU} or a similar setting, which
is a boo hoo for drivers/atm/Kconfig (see the comment in the patch).

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/arch/alpha/Kconfig b/arch/alpha/Kconfig
--- a/arch/alpha/Kconfig	2002-12-16 07:01:45.000000000 +0100
+++ b/arch/alpha/Kconfig	2003-01-01 19:49:40.000000000 +0100
@@ -810,47 +810,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "drivers/isdn/Kconfig"
diff -urN a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig	2002-12-16 07:01:45.000000000 +0100
+++ b/arch/arm/Kconfig	2003-01-01 19:45:41.000000000 +0100
@@ -898,45 +898,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-endmenu
-
 #   source net/ax25/Config.in
 source "net/irda/Kconfig"
 
diff -urN a/arch/cris/Kconfig b/arch/cris/Kconfig
--- a/arch/cris/Kconfig	2002-12-08 20:06:11.000000000 +0100
+++ b/arch/cris/Kconfig	2003-01-01 19:46:33.000000000 +0100
@@ -603,47 +603,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
diff -urN a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2003-01-01 13:54:08.000000000 +0100
+++ b/arch/i386/Kconfig	2003-01-01 19:46:24.000000000 +0100
@@ -1436,47 +1436,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
diff -urN a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	2002-12-24 10:45:35.000000000 +0100
+++ b/arch/ia64/Kconfig	2003-01-01 19:47:04.000000000 +0100
@@ -655,44 +655,6 @@
 
 if !IA64_HP_SIM
 
-menu "Network device support"
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
-	  parallel ports of two local systems) or AX.25/KISS (protocol for
-	  sending Internet traffic over amateur radio links).
-
-	  Make sure to read the NET-3-HOWTO. Eventually, you will have to read
-	  Olaf Kirch's excellent and free book "Network Administrator's
-	  Guide", to be found in <http://www.linuxdoc.org/docs.html#guide>. If
-	  unsure, say Y.
-
-source "drivers/net/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "drivers/isdn/Kconfig"
diff -urN a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
--- a/arch/m68knommu/Kconfig	2002-12-16 07:01:45.000000000 +0100
+++ b/arch/m68knommu/Kconfig	2003-01-01 19:51:39.000000000 +0100
@@ -611,47 +611,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
diff -urN a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig	2002-12-16 07:01:45.000000000 +0100
+++ b/arch/mips/Kconfig	2003-01-01 19:49:24.000000000 +0100
@@ -919,47 +919,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
diff -urN a/arch/mips64/Kconfig b/arch/mips64/Kconfig
--- a/arch/mips64/Kconfig	2002-12-16 07:02:00.000000000 +0100
+++ b/arch/mips64/Kconfig	2003-01-01 19:50:47.000000000 +0100
@@ -504,47 +504,6 @@
 #source drivers/message/i2o/Config.in
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
diff -urN a/arch/parisc/Kconfig b/arch/parisc/Kconfig
--- a/arch/parisc/Kconfig	2002-12-16 07:01:45.000000000 +0100
+++ b/arch/parisc/Kconfig	2003-01-01 19:51:02.000000000 +0100
@@ -276,46 +276,6 @@
 
 source "net/Kconfig"
 
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
 #source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
diff -urN a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2002-12-16 07:01:45.000000000 +0100
+++ b/arch/ppc/Kconfig	2003-01-01 19:46:12.000000000 +0100
@@ -1415,47 +1415,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
diff -urN a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig	2002-12-16 07:01:45.000000000 +0100
+++ b/arch/ppc64/Kconfig	2003-01-01 19:49:52.000000000 +0100
@@ -354,47 +354,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
diff -urN a/arch/sh/Kconfig b/arch/sh/Kconfig
--- a/arch/sh/Kconfig	2002-12-16 07:01:46.000000000 +0100
+++ b/arch/sh/Kconfig	2003-01-01 19:45:26.000000000 +0100
@@ -745,48 +745,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
-
 menu "Old CD-ROM drivers (not SCSI, not IDE)"
 
 config CD_NO_IDESCSI
diff -urN a/arch/sparc/Kconfig b/arch/sparc/Kconfig
--- a/arch/sparc/Kconfig	2002-12-16 07:01:46.000000000 +0100
+++ b/arch/sparc/Kconfig	2003-01-01 19:56:21.000000000 +0100
@@ -1269,7 +1269,6 @@
 #      bool '  FDDI driver support' CONFIG_FDDI
 #      if [ "$CONFIG_FDDI" = "y" ]; then
 #      fi
-source "drivers/atm/Kconfig"
 
 endmenu
 
diff -urN a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	2002-12-16 07:01:46.000000000 +0100
+++ b/arch/sparc64/Kconfig	2003-01-01 19:50:38.000000000 +0100
@@ -1404,47 +1404,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 # This one must be before the filesystem configs. -DaveM
diff -urN a/arch/v850/Kconfig b/arch/v850/Kconfig
--- a/arch/v850/Kconfig	2002-12-16 07:01:46.000000000 +0100
+++ b/arch/v850/Kconfig	2003-01-01 19:49:33.000000000 +0100
@@ -304,47 +304,6 @@
 
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
diff -urN a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	2003-01-01 13:54:08.000000000 +0100
+++ b/arch/x86_64/Kconfig	2003-01-01 19:51:30.000000000 +0100
@@ -567,49 +567,6 @@
 #source drivers/message/i2o/Config.in
 source "net/Kconfig"
 
-
-menu "Network device support"
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
-source "drivers/net/Kconfig"
-
-# ATM seems to be largely 64bit unsafe and also unmaintained - disable it for now.
-#      if [ "$CONFIG_ATM" = "y" ]; then
-#         source drivers/atm/Config.in
-#      fi
-endmenu
-
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
diff -urN a/drivers/atm/Kconfig b/drivers/atm/Kconfig
--- a/drivers/atm/Kconfig	2003-01-01 16:28:07.000000000 +0100
+++ b/drivers/atm/Kconfig	2003-01-01 19:53:20.000000000 +0100
@@ -3,7 +3,8 @@
 #
 
 config ATM_DRIVERS
-	depends on NETDEVICES && ATM
+# FIXME: should also include M68KNOMMU and CRIS!
+	depends on NETDEVICES && ATM && (SUPERH || PPC || X86 || MIPS || V850 || ALPHA || PPC64 || SPARC32 || SPARC64 || SGI_IP22 || SGI_IP27 || PARISC)
 	bool "ATM drivers (depends on ATM=y)"
 
 menu "ATM drivers"
diff -urN a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2003-01-01 14:56:41.000000000 +0100
+++ b/drivers/net/Kconfig	2003-01-01 20:12:56.000000000 +0100
@@ -1,7 +1,45 @@
 #
 # Network device configuration
 #
-source "drivers/net/arcnet/Kconfig"
+
+# SPARC32 and M68K have their network devices configured in arch/.../Kconfig
+if !SPARC32 && !M68K
+
+config NETDEVICES
+	depends on NET
+	bool "Network device support"
+	---help---
+	  You can say N here if you don't intend to connect your Linux box to
+	  any other computer at all or if all your connections will be over a
+	  telephone line with a modem either via UUCP (UUCP is a protocol to
+	  forward mail and news between unix hosts over telephone lines; read
+	  the UUCP-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>) or dialing up a shell
+	  account or a BBS, even using term (term is a program which gives you
+	  almost full Internet connectivity if you have a regular dial up
+	  shell account on some Internet connected Unix computer. Read
+	  <http://www.bart.nl/~patrickr/term-howto/Term-HOWTO.html>).
+
+	  You'll have to say Y if your computer contains a network card that
+	  you want to use under Linux (make sure you know its name because you
+	  will be asked for it and read the Ethernet-HOWTO (especially if you
+	  plan to use more than one network card under Linux)) or if you want
+	  to use SLIP (Serial Line Internet Protocol is the protocol used to
+	  send Internet traffic over telephone lines or null modem cables) or
+	  CSLIP (compressed SLIP) or PPP (Point to Point Protocol, a better
+	  and newer replacement for SLIP) or PLIP (Parallel Line Internet
+	  Protocol is mainly used to create a mini network by connecting the
+	  parallel ports of two local machines) or AX.25/KISS (protocol for
+	  sending Internet traffic over amateur radio links).
+
+	  Make sure to read the NET-3-HOWTO. Eventually, you will have to read
+	  Olaf Kirch's excellent and free book "Network Administrator's
+	  Guide", to be found in <http://www.linuxdoc.org/docs.html#guide>. If
+	  unsure, say Y.
+
+if NETDEVICES
+	source "drivers/net/arcnet/Kconfig"
+endif
 
 config DUMMY
 	tristate "Dummy net driver support"
@@ -2377,3 +2415,6 @@
 
 source "drivers/net/pcmcia/Kconfig"
 
+source "drivers/atm/Kconfig"
+
+endif
diff -urN a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2002-12-16 07:02:05.000000000 +0100
+++ b/init/Kconfig	2003-01-01 19:21:22.000000000 +0100
@@ -37,22 +37,6 @@
 
 menu "General setup"
 
-config NET
-	bool "Networking support"
-	---help---
-	  Unless you really know what you are doing, you should say Y here.
-	  The reason is that some programs need kernel networking support even
-	  when running on a stand-alone machine that isn't connected to any
-	  other computer. If you are upgrading from an older kernel, you
-	  should consider updating your networking tools too because changes
-	  in the kernel and the tools often go hand in hand. The tools are
-	  contained in the package net-tools, the location and version number
-	  of which are given in <file:Documentation/Changes>.
-
-	  For a general introduction to Linux networking, it is highly
-	  recommended to read the NET-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>.
-
 config SYSVIPC
 	bool "System V IPC"
 	---help---
diff -urN a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	2003-01-01 18:28:12.000000000 +0100
+++ b/net/Kconfig	2003-01-01 19:21:22.000000000 +0100
@@ -2,6 +2,24 @@
 # Network configuration
 #
 
+menu "Networking support"
+
+config NET
+	bool "Networking support"
+	---help---
+	  Unless you really know what you are doing, you should say Y here.
+	  The reason is that some programs need kernel networking support even
+	  when running on a stand-alone machine that isn't connected to any
+	  other computer. If you are upgrading from an older kernel, you
+	  should consider updating your networking tools too because changes
+	  in the kernel and the tools often go hand in hand. The tools are
+	  contained in the package net-tools, the location and version number
+	  of which are given in <file:Documentation/Changes>.
+
+	  For a general introduction to Linux networking, it is highly
+	  recommended to read the NET-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>.
+
 menu "Networking options"
 	depends on NET
 
@@ -552,3 +570,6 @@
 
 endmenu
 
+source "drivers/net/Kconfig"
+
+endmenu
