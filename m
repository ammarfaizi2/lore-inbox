Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbTDIBfn (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTDIBfn (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:35:43 -0400
Received: from tomts15-srv.bellnexxia.net ([209.226.175.3]:15252 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262682AbTDIBfi (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 21:35:38 -0400
Date: Tue, 8 Apr 2003 21:42:54 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.5.67 PATCH] menu cleanup: "Networking support" -> "Networking
 options"
Message-ID: <Pine.LNX.4.44.0304082138500.20953-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  considerable shuffling to keep related and interdependent options 
together.  there's more to be done on this menu alone, but i'd appreciate
feedback on just this part of it before i go any further.





diff -Nru bk1/net/ipv4/Kconfig rday-bk1/net/ipv4/Kconfig
--- bk1/net/ipv4/Kconfig	2003-04-07 13:32:18.000000000 -0400
+++ rday-bk1/net/ipv4/Kconfig	2003-04-08 21:26:17.000000000 -0400
@@ -15,6 +15,41 @@
 	  <file:Documentation/networking/multicast.txt>. For most people, it's
 	  safe to say N.
 
+config IP_MROUTE
+	bool "IP: multicast routing"
+	depends on IP_MULTICAST
+	help
+	  This is used if you want your machine to act as a router for IP
+	  packets that have several destination addresses. It is needed on the
+	  MBONE, a high bandwidth network on top of the Internet which carries
+	  audio and video broadcasts. In order to do that, you would most
+	  likely run the program mrouted. Information about the multicast
+	  capabilities of the various network cards is contained in
+	  <file:Documentation/networking/multicast.txt>. If you haven't heard
+	  about it, you don't need it.
+
+config IP_PIMSM_V1
+	bool "IP: PIM-SM version 1 support"
+	depends on IP_MROUTE
+	help
+	  Kernel side support for Sparse Mode PIM (Protocol Independent
+	  Multicast) version 1. This multicast routing protocol is used widely
+	  because Cisco supports it. You need special software to use it
+	  (pimd-v1). Please see <http://netweb.usc.edu/pim/> for more
+	  information about PIM.
+
+	  Say Y if you want to use PIM-SM v1. Note that you can say N here if
+	  you just want to use Dense Mode PIM.
+
+config IP_PIMSM_V2
+	bool "IP: PIM-SM version 2 support"
+	depends on IP_MROUTE
+	help
+	  Kernel side support for Sparse Mode PIM version 2. In order to use
+	  this, you need an experimental routing daemon supporting it (pimd or
+	  gated-5). This routing protocol is not used widely, so say N unless
+	  you want to play with it.
+
 config IP_ADVANCED_ROUTER
 	bool "IP: advanced router"
 	depends on INET
@@ -232,41 +267,6 @@
 	  Network), but can be distributed all over the Internet. If you want
 	  to do that, say Y here and to "IP multicast routing" below.
 
-config IP_MROUTE
-	bool "IP: multicast routing"
-	depends on IP_MULTICAST
-	help
-	  This is used if you want your machine to act as a router for IP
-	  packets that have several destination addresses. It is needed on the
-	  MBONE, a high bandwidth network on top of the Internet which carries
-	  audio and video broadcasts. In order to do that, you would most
-	  likely run the program mrouted. Information about the multicast
-	  capabilities of the various network cards is contained in
-	  <file:Documentation/networking/multicast.txt>. If you haven't heard
-	  about it, you don't need it.
-
-config IP_PIMSM_V1
-	bool "IP: PIM-SM version 1 support"
-	depends on IP_MROUTE
-	help
-	  Kernel side support for Sparse Mode PIM (Protocol Independent
-	  Multicast) version 1. This multicast routing protocol is used widely
-	  because Cisco supports it. You need special software to use it
-	  (pimd-v1). Please see <http://netweb.usc.edu/pim/> for more
-	  information about PIM.
-
-	  Say Y if you want to use PIM-SM v1. Note that you can say N here if
-	  you just want to use Dense Mode PIM.
-
-config IP_PIMSM_V2
-	bool "IP: PIM-SM version 2 support"
-	depends on IP_MROUTE
-	help
-	  Kernel side support for Sparse Mode PIM version 2. In order to use
-	  this, you need an experimental routing daemon supporting it (pimd or
-	  gated-5). This routing protocol is not used widely, so say N unless
-	  you want to play with it.
-
 config ARPD
 	bool "IP: ARP daemon support (EXPERIMENTAL)"
 	depends on INET && EXPERIMENTAL
@@ -348,6 +348,8 @@
 
 	  If unsure, say N.
 
+source "net/ipv4/netfilter/Kconfig"
+
 config INET_AH
 	tristate "IP: AH transformation"
 	---help---
@@ -362,5 +364,3 @@
 
 	  If unsure, say Y.
 
-source "net/ipv4/netfilter/Kconfig"
-
diff -Nru bk1/net/Kconfig rday-bk1/net/Kconfig
--- bk1/net/Kconfig	2003-04-07 13:30:39.000000000 -0400
+++ rday-bk1/net/Kconfig	2003-04-08 21:29:08.000000000 -0400
@@ -23,6 +23,15 @@
 menu "Networking options"
 	depends on NET
 
+config NETLINK_DEV
+	tristate "Netlink device emulation (deprecated)"
+	help
+	  This option will be removed soon. Any programs that want to use
+	  character special nodes like /dev/tap0 or /dev/route (all with major
+	  number 36) need this option, and need to be rewritten soon to use
+	  the real netlink socket.
+	  This is a backward compatibility option, choose Y for now.
+
 config PACKET
 	tristate "Packet socket"
 	---help---
@@ -49,14 +58,37 @@
 
 	  If unsure, say N.
 
-config NETLINK_DEV
-	tristate "Netlink device emulation"
-	help
-	  This option will be removed soon. Any programs that want to use
-	  character special nodes like /dev/tap0 or /dev/route (all with major
-	  number 36) need this option, and need to be rewritten soon to use
-	  the real netlink socket.
-	  This is a backward compatibility option, choose Y for now.
+config UNIX
+	tristate "Unix domain sockets"
+	---help---
+	  If you say Y here, you will include support for Unix domain sockets;
+	  sockets are the standard Unix mechanism for establishing and
+	  accessing network connections.  Many commonly used programs such as
+	  the X Window system and syslog use these sockets even if your
+	  machine is not connected to any network.  Unless you are working on
+	  an embedded system or something similar, you therefore definitely
+	  want to say Y here.
+
+	  However, the socket support is also available as a module ( = code
+	  which can be inserted in and removed from the running kernel
+	  whenever you want).  If you want to compile it as a module, say M
+	  here and read <file:Documentation/modules.txt>. The module will be
+	  called unix.  If you try building this as a module and you have
+	  said Y to "Kernel module loader support" above, be sure to add
+	  'alias net-pf-1 unix' to your /etc/modules.conf file. Note that
+	  several important services won't work correctly if you say M here
+	  and then neglect to load the module.
+
+	  Say Y unless you know what you are doing.
+
+config NET_KEY
+	tristate "PF_KEY sockets"
+	---help---
+	  PF_KEYv2 socket family, compatible to KAME ones.
+	  They are required if you are going to use IPsec tools ported
+	  from KAME.
+
+	  Say Y unless you know what you are doing.
 
 config NETFILTER
 	bool "Network packet filtering (replaces ipchains)"
@@ -118,38 +150,6 @@
 	  You can say Y here if you want to get additional messages useful in
 	  debugging the netfilter code.
 
-config UNIX
-	tristate "Unix domain sockets"
-	---help---
-	  If you say Y here, you will include support for Unix domain sockets;
-	  sockets are the standard Unix mechanism for establishing and
-	  accessing network connections.  Many commonly used programs such as
-	  the X Window system and syslog use these sockets even if your
-	  machine is not connected to any network.  Unless you are working on
-	  an embedded system or something similar, you therefore definitely
-	  want to say Y here.
-
-	  However, the socket support is also available as a module ( = code
-	  which can be inserted in and removed from the running kernel
-	  whenever you want).  If you want to compile it as a module, say M
-	  here and read <file:Documentation/modules.txt>. The module will be
-	  called unix.  If you try building this as a module and you have
-	  said Y to "Kernel module loader support" above, be sure to add
-	  'alias net-pf-1 unix' to your /etc/modules.conf file. Note that
-	  several important services won't work correctly if you say M here
-	  and then neglect to load the module.
-
-	  Say Y unless you know what you are doing.
-
-config NET_KEY
-	tristate "PF_KEY sockets"
-	---help---
-	  PF_KEYv2 socket family, compatible to KAME ones.
-	  They are required if you are going to use IPsec tools ported
-	  from KAME.
-
-	  Say Y unless you know what you are doing.
-
 config INET
 	bool "TCP/IP networking"
 	---help---
@@ -181,6 +181,7 @@
 source "net/ipv4/Kconfig"
 
 #   IPv6 as module will cause a CRASH if you try to unload it
+
 config IPV6
 	tristate "The IPv6 protocol (EXPERIMENTAL)"
 	depends on INET && EXPERIMENTAL

