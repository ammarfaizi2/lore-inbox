Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271232AbTG2E1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 00:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271233AbTG2E1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 00:27:08 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:2437 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S271232AbTG2E0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 00:26:50 -0400
Date: Tue, 29 Jul 2003 06:26:18 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] place IPv4 netfilter submenu where it belongs
Message-ID: <20030729042618.GL32673@louise.pinerecords.com>
References: <20030726200646.GF16160@louise.pinerecords.com> <20030727160942.647707d8.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030727160942.647707d8.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [davem@redhat.com]
> 
> On Sat, 26 Jul 2003 22:06:46 +0200
> Tomas Szepe <szepe@pinerecords.com> wrote:
> 
> > $subj
> > 
> > Patch against -bk3.
> 
> This doesn't look right at all.
> 
> Netfilter is for many protocols other than ipv4 (ipv6, bridging,
> decnet, etc.) so putting it under ipv4 makes not much sense
> to me.

Ok, what does this look like?

The only aim of the patch is to put most netfilter options
in a dedicated submenu so that one can go tweaking the
them right where they've enabled netfilter in the first
place.  I understand the ordering is a matter of personal
opinion (and not much else really), so anybody just tell
me if you totally hate this and I'll scrap the idea. :)
It just so happens that I've had this cleanup on my TODO
since the time I had spawned the "united networking menu."

-- 
Tomas Szepe <szepe@pinerecords.com>


(Patch against 2.6.0-test2 vanilla.)

diff -urN a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	2003-05-27 08:06:58.000000000 +0200
+++ b/net/Kconfig	2003-07-29 06:11:00.000000000 +0200
@@ -58,66 +58,6 @@
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
 config UNIX
 	tristate "Unix domain sockets"
 	---help---
@@ -208,6 +148,129 @@
 
 source "net/ipv6/Kconfig"
 
+config DECNET
+	tristate "DECnet Support"
+	---help---
+	  The DECnet networking protocol was used in many products made by
+	  Digital (now Compaq).  It provides reliable stream and sequenced
+	  packet communications over which run a variety of services similar
+	  to those which run over TCP/IP.
+
+	  To find some tools to use with the kernel layer support, please
+	  look at Patrick Caulfield's web site:
+	  <http://linux.dreamtime.org/decnet/>.
+
+	  More detailed documentation is available in
+	  <file:Documentation/networking/decnet.txt>.
+
+	  Be sure to say Y to "/proc file system support" and "Sysctl support"
+	  below when using DECnet, since you will need sysctl support to aid
+	  in configuration at run time.
+
+	  The DECnet code is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called decnet.
+
+source "net/decnet/Kconfig"
+
+config BRIDGE
+	tristate "802.1d Ethernet Bridging"
+	depends on INET
+	---help---
+	  If you say Y here, then your Linux box will be able to act as an
+	  Ethernet bridge, which means that the different Ethernet segments it
+	  is connected to will appear as one Ethernet to the participants.
+	  Several such bridges can work together to create even larger
+	  networks of Ethernets using the IEEE 802.1 spanning tree algorithm.
+	  As this is a standard, Linux bridges will cooperate properly with
+	  other third party bridge products.
+
+	  In order to use the Ethernet bridge, you'll need the bridge
+	  configuration tools; see <file:Documentation/networking/bridge.txt>
+	  for location. Please read the Bridge mini-HOWTO for more
+	  information.
+
+	  If you enable iptables support along with the bridge support then you
+	  turn your bridge into a bridging firewall.
+	  iptables will then see the IP packets being bridged, so you need to
+	  take this into account when setting up your firewall rules.
+
+	  If you want to compile this code as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module
+	  will be called bridge.
+
+	  If unsure, say N.
+
+menuconfig NETFILTER
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
+if NETFILTER
+
+config NETFILTER_DEBUG
+	bool "Network packet filtering debugging"
+	depends on NETFILTER
+	help
+	  You can say Y here if you want to get additional messages useful in
+	  debugging the netfilter code.
+
+source "net/ipv4/netfilter/Kconfig"
+source "net/ipv6/netfilter/Kconfig"
+source "net/decnet/netfilter/Kconfig"
+source "net/bridge/netfilter/Kconfig"
+
+endif
+
 source "net/xfrm/Kconfig"
 
 source "net/sctp/Kconfig"
@@ -370,62 +433,6 @@
 
 source "drivers/net/appletalk/Kconfig"
 
-config DECNET
-	tristate "DECnet Support"
-	---help---
-	  The DECnet networking protocol was used in many products made by
-	  Digital (now Compaq).  It provides reliable stream and sequenced
-	  packet communications over which run a variety of services similar
-	  to those which run over TCP/IP.
-
-	  To find some tools to use with the kernel layer support, please
-	  look at Patrick Caulfield's web site:
-	  <http://linux.dreamtime.org/decnet/>.
-
-	  More detailed documentation is available in
-	  <file:Documentation/networking/decnet.txt>.
-
-	  Be sure to say Y to "/proc file system support" and "Sysctl support"
-	  below when using DECnet, since you will need sysctl support to aid
-	  in configuration at run time.
-
-	  The DECnet code is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module is called decnet.
-
-source "net/decnet/Kconfig"
-
-config BRIDGE
-	tristate "802.1d Ethernet Bridging"
-	depends on INET
-	---help---
-	  If you say Y here, then your Linux box will be able to act as an
-	  Ethernet bridge, which means that the different Ethernet segments it
-	  is connected to will appear as one Ethernet to the participants.
-	  Several such bridges can work together to create even larger
-	  networks of Ethernets using the IEEE 802.1 spanning tree algorithm.
-	  As this is a standard, Linux bridges will cooperate properly with
-	  other third party bridge products.
-
-	  In order to use the Ethernet bridge, you'll need the bridge
-	  configuration tools; see <file:Documentation/networking/bridge.txt>
-	  for location. Please read the Bridge mini-HOWTO for more
-	  information.
-
-	  If you enable iptables support along with the bridge support then you
-	  turn your bridge into a bridging firewall.
-	  iptables will then see the IP packets being bridged, so you need to
-	  take this into account when setting up your firewall rules.
-
-	  If you want to compile this code as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called bridge.
-
-	  If unsure, say N.
-
-source "net/bridge/netfilter/Kconfig"
-
 config X25
 	tristate "CCITT X.25 Packet Layer (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
diff -urN a/net/decnet/Kconfig b/net/decnet/Kconfig
--- a/net/decnet/Kconfig	2003-05-27 08:06:58.000000000 +0200
+++ b/net/decnet/Kconfig	2003-07-29 06:03:34.000000000 +0200
@@ -35,5 +35,3 @@
 	  packets with different FWMARK ("firewalling mark") values
 	  (see ipchains(8), "-m" argument).
 
-source "net/decnet/netfilter/Kconfig"
-
diff -urN a/net/ipv4/Kconfig b/net/ipv4/Kconfig
--- a/net/ipv4/Kconfig	2003-07-14 09:38:21.000000000 +0200
+++ b/net/ipv4/Kconfig	2003-07-29 06:01:10.000000000 +0200
@@ -374,6 +374,5 @@
 	  
 	  If unsure, say Y.
 
-source "net/ipv4/netfilter/Kconfig"
 source "net/ipv4/ipvs/Kconfig"
 
diff -urN a/net/ipv6/Kconfig b/net/ipv6/Kconfig
--- a/net/ipv6/Kconfig	2003-06-14 23:07:13.000000000 +0200
+++ b/net/ipv6/Kconfig	2003-07-29 06:01:39.000000000 +0200
@@ -63,4 +63,3 @@
 
 	  If unsure, say N.
 
-source "net/ipv6/netfilter/Kconfig"
