Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbTAARgi>; Wed, 1 Jan 2003 12:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbTAARgi>; Wed, 1 Jan 2003 12:36:38 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:44479 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265002AbTAARgf>; Wed, 1 Jan 2003 12:36:35 -0500
Date: Wed, 1 Jan 2003 18:44:58 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] do justice to netfilter configuration
Message-ID: <20030101174458.GK15200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$subj.  I wanted to do this for a long time, so here comes:

o  Move all IPv4 netfilter config entries to net/ipv4/netfilter/Kconfig.
o  Move the netfilter submenu right under the netfilter on/off switch.
o  Move the netfilter debug option into the netfilter submenu.
o  Move all netfilter settings as close to their IPv6 sibling as possible.
o  Rename "IP: Netfilter Configuration" to "IPv4 Netfilter Configuration"
o  Rename "IPv6: Netfilter Configuration" to "IPv6 Netfilter Configuration"

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	2003-01-01 18:07:56.000000000 +0100
+++ b/net/Kconfig	2003-01-01 18:28:12.000000000 +0100
@@ -40,66 +40,6 @@
 	  the real netlink socket.
 	  This is a backward compatibility option, choose Y for now.
 
-config NETFILTER
-	bool "Network packet filtering (replaces ipchains)"
-	---help---
-	  Netfilter is a framework for filtering and mangling network packets
-	  that pass through your Linux box.
-
-	  The most common use of packet filtering is to run your Linux box as
-	  a firewall protecting a local network from the Internet. The type of
-	  firewall provided by this kernel support is called a "packet
-	  filter", which means that it can reject individual network packets
-	  based on type, source, destination etc. The other kind of firewall,
-	  a "proxy-based" one, is more secure but more intrusive and more
-	  bothersome to set up; it inspects the network traffic much more
-	  closely, modifies it and has knowledge about the higher level
-	  protocols, which a packet filter lacks. Moreover, proxy-based
-	  firewalls often require changes to the programs running on the local
-	  clients. Proxy-based firewalls don't need support by the kernel, but
-	  they are often combined with a packet filter, which only works if
-	  you say Y here.
-
-	  You should also say Y here if you intend to use your Linux box as
-	  the gateway to the Internet for a local network of machines without
-	  globally valid IP addresses. This is called "masquerading": if one
-	  of the computers on your local network wants to send something to
-	  the outside, your box can "masquerade" as that computer, i.e. it
-	  forwards the traffic to the intended outside destination, but
-	  modifies the packets to make it look like they came from the
-	  firewall box itself. It works both ways: if the outside host
-	  replies, the Linux box will silently forward the traffic to the
-	  correct local computer. This way, the computers on your local net
-	  are completely invisible to the outside world, even though they can
-	  reach the outside and can receive replies. It is even possible to
-	  run globally visible servers from within a masqueraded local network
-	  using a mechanism called portforwarding. Masquerading is also often
-	  called NAT (Network Address Translation).
-
-	  Another use of Netfilter is in transparent proxying: if a machine on
-	  the local network tries to connect to an outside host, your Linux
-	  box can transparently forward the traffic to a local server,
-	  typically a caching proxy server.
-
-	  Various modules exist for netfilter which replace the previous
-	  masquerading (ipmasqadm), packet filtering (ipchains), transparent
-	  proxying, and portforwarding mechanisms. Please see
-	  <file:Documentation/Changes> under "iptables" for the location of
-	  these packages.
-
-	  Make sure to say N to "Fast switching" below if you intend to say Y
-	  here, as Fast switching currently bypasses netfilter.
-
-	  Chances are that you should say Y here if you compile a kernel which
-	  will run as a router and N for regular hosts. If unsure, say N.
-
-config NETFILTER_DEBUG
-	bool "Network packet filtering debugging"
-	depends on NETFILTER
-	help
-	  You can say Y here if you want to get additional messages useful in
-	  debugging the netfilter code.
-
 config FILTER
 	bool "Socket Filtering"
 	---help---
diff -urN a/net/ipv4/Kconfig b/net/ipv4/Kconfig
--- a/net/ipv4/Kconfig	2002-12-08 20:06:25.000000000 +0100
+++ b/net/ipv4/Kconfig	2003-01-01 18:28:23.000000000 +0100
@@ -371,4 +371,3 @@
 	  If unsure, say Y.
 
 source "net/ipv4/netfilter/Kconfig"
-
diff -urN a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
--- a/net/ipv4/netfilter/Kconfig	2002-10-31 02:34:01.000000000 +0100
+++ b/net/ipv4/netfilter/Kconfig	2003-01-01 18:29:27.000000000 +0100
@@ -2,8 +2,68 @@
 # IP netfilter configuration
 #
 
-menu "IP: Netfilter Configuration"
-	depends on INET && NETFILTER
+config NETFILTER
+	depends on INET
+	bool "Network packet filtering (replaces ipchains)"
+	---help---
+	  Netfilter is a framework for filtering and mangling network packets
+	  that pass through your Linux box.
+
+	  The most common use of packet filtering is to run your Linux box as
+	  a firewall protecting a local network from the Internet. The type of
+	  firewall provided by this kernel support is called a "packet
+	  filter", which means that it can reject individual network packets
+	  based on type, source, destination etc. The other kind of firewall,
+	  a "proxy-based" one, is more secure but more intrusive and more
+	  bothersome to set up; it inspects the network traffic much more
+	  closely, modifies it and has knowledge about the higher level
+	  protocols, which a packet filter lacks. Moreover, proxy-based
+	  firewalls often require changes to the programs running on the local
+	  clients. Proxy-based firewalls don't need support by the kernel, but
+	  they are often combined with a packet filter, which only works if
+	  you say Y here.
+
+	  You should also say Y here if you intend to use your Linux box as
+	  the gateway to the Internet for a local network of machines without
+	  globally valid IP addresses. This is called "masquerading": if one
+	  of the computers on your local network wants to send something to
+	  the outside, your box can "masquerade" as that computer, i.e. it
+	  forwards the traffic to the intended outside destination, but
+	  modifies the packets to make it look like they came from the
+	  firewall box itself. It works both ways: if the outside host
+	  replies, the Linux box will silently forward the traffic to the
+	  correct local computer. This way, the computers on your local net
+	  are completely invisible to the outside world, even though they can
+	  reach the outside and can receive replies. It is even possible to
+	  run globally visible servers from within a masqueraded local network
+	  using a mechanism called portforwarding. Masquerading is also often
+	  called NAT (Network Address Translation).
+
+	  Another use of Netfilter is in transparent proxying: if a machine on
+	  the local network tries to connect to an outside host, your Linux
+	  box can transparently forward the traffic to a local server,
+	  typically a caching proxy server.
+
+	  Various modules exist for netfilter which replace the previous
+	  masquerading (ipmasqadm), packet filtering (ipchains), transparent
+	  proxying, and portforwarding mechanisms. Please see
+	  <file:Documentation/Changes> under "iptables" for the location of
+	  these packages.
+
+	  Make sure to say N to "Fast switching" below if you intend to say Y
+	  here, as Fast switching currently bypasses netfilter.
+
+	  Chances are that you should say Y here if you compile a kernel which
+	  will run as a router and N for regular hosts. If unsure, say N.
+
+menu "IPv4 Netfilter Configuration"
+	depends on NETFILTER
+
+config NETFILTER_DEBUG
+	bool "Network packet filtering debugging"
+	help
+	  You can say Y here if you want to get additional messages useful in
+	  debugging the netfilter code.
 
 config IP_NF_CONNTRACK
 	tristate "Connection tracking (required for masq/NAT)"
diff -urN a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
--- a/net/ipv6/netfilter/Kconfig	2002-10-31 02:34:02.000000000 +0100
+++ b/net/ipv6/netfilter/Kconfig	2003-01-01 18:29:35.000000000 +0100
@@ -2,7 +2,7 @@
 # IP netfilter configuration
 #
 
-menu "IPv6: Netfilter Configuration"
+menu "IPv6 Netfilter Configuration"
 	depends on INET && EXPERIMENTAL && IPV6!=n && NETFILTER
 
 #tristate 'Connection tracking (required for masq/NAT)' CONFIG_IP6_NF_CONNTRACK
