Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270407AbTGNOeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270609AbTGNOeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:34:23 -0400
Received: from [200.230.190.107] ([200.230.190.107]:42258 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S270407AbTGNOcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:32:51 -0400
Subject: [PATCH][2.6.0-test1] put netfilter setup in right place.
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-PRaxsK6K43QO54Ifneun"
Organization: Governo Eletronico - SP
Message-Id: <1058194264.1908.5.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 14 Jul 2003 11:51:05 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PRaxsK6K43QO54Ifneun
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


hi all,

 this patch put the netfilter configuration in the right
place under network options.

PS: Sorry for any mistakes, is my first patch.

-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

--=-PRaxsK6K43QO54Ifneun
Content-Disposition: attachment; filename=2.6.0-test1_kconfig.diff
Content-Type: text/x-patch; name=2.6.0-test1_kconfig.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Nru linux-2.6.0-test1/net/ipv4/Kconfig linux-2.6.0-test1~/net/ipv4/Kconfig
--- linux-2.6.0-test1/net/ipv4/Kconfig	2003-07-14 11:33:22.000000000 -0300
+++ linux-2.6.0-test1~/net/ipv4/Kconfig	2003-07-14 10:23:21.000000000 -0300
@@ -374,6 +374,5 @@
 	  
 	  If unsure, say Y.
 
-source "net/ipv4/netfilter/Kconfig"
 source "net/ipv4/ipvs/Kconfig"
 
diff -Nru linux-2.6.0-test1/net/Kconfig linux-2.6.0-test1~/net/Kconfig
--- linux-2.6.0-test1/net/Kconfig	2003-05-26 22:00:21.000000000 -0300
+++ linux-2.6.0-test1~/net/Kconfig	2003-07-14 10:29:32.000000000 -0300
@@ -58,65 +58,6 @@
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
 
 config UNIX
 	tristate "Unix domain sockets"
@@ -208,6 +149,69 @@
 
 source "net/ipv6/Kconfig"
 
+config NETFILTER
+	bool "Network packet filtering (replaces ipchains)"
+	depends on INET
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
+source "net/ipv4/netfilter/Kconfig"
+
+config NETFILTER_DEBUG
+	bool "Network packet filtering debugging"
+	depends on NETFILTER
+	help
+	  You can say Y here if you want to get additional messages useful in
+	  debugging the netfilter code.
+
 source "net/xfrm/Kconfig"
 
 source "net/sctp/Kconfig"

--=-PRaxsK6K43QO54Ifneun--

