Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270539AbTGQUBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbTGQUBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:01:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24529 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269291AbTGQT6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:58:17 -0400
Date: Thu, 17 Jul 2003 22:13:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] netfilter Configure.help cleanup
Message-ID: <20030717201304.GL1407@fs.tum.de>
References: <20030630051516.AAEC12C220@lists.samba.org> <Pine.LNX.4.55L.0307021624510.17865@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307021624510.17865@freak.distro.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 04:25:05PM -0300, Marcelo Tosatti wrote:
> 
> Make that go through davem, please.

Hi Dave,

the patch below does the following changes to the netfilter entries in
Configure.help in 2.4.22-pre2:
- order similar to net/ipv4/netfilter/Config.in
- remove useless short descriptions above CONFIG_*
- added CONFIG_IP_NF_MATCH_RECENT entry (stolen from 2.5)

It still applies against 2.4.22-pre6.
 
Please apply
Adrian



--- linux-2.4.22-pre2-full/Documentation/Configure.help.old	2003-06-28 00:55:54.000000000 +0200
+++ linux-2.4.22-pre2-full/Documentation/Configure.help	2003-06-28 01:20:11.000000000 +0200
@@ -2511,7 +2511,6 @@
   You can say Y here if you want to get additional messages useful in
   debugging the netfilter code.
 
-Connection tracking (required for masq/NAT)
 CONFIG_IP_NF_CONNTRACK
   Connection tracking keeps a record of what packets have passed
   through your machine, in order to figure out how they are related
@@ -2525,7 +2524,14 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-Amanda protocol support
+CONFIG_IP_NF_FTP
+  Tracking FTP connections is problematic: special helpers are
+  required for tracking them, and doing masquerading and other forms
+  of Network Address Translation on them.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  If unsure, say `Y'.
+
 CONFIG_IP_NF_AMANDA
   If you are running the Amanda backup package (http://www.amanda.org/)
   on this machine or machines that will be MASQUERADED through this
@@ -2537,8 +2543,15 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
+CONFIG_IP_NF_TFTP
+  TFTP connection tracking helper, this is required depending
+  on how restrictive your ruleset is.
+  If you are using a tftp client behind -j SNAT or -j MASQUERADING
+  you will need this.
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `Y'.
 
-IRC Send/Chat protocol support
 CONFIG_IP_NF_IRC
   There is a commonly-used extension to IRC called
   Direct Client-to-Client Protocol (DCC).  This enables users to send
@@ -2552,26 +2565,6 @@
   If you want to compile it as a module, say 'M' here and read
   Documentation/modules.txt.  If unsure, say 'N'.
 
-TFTP protocol support
-CONFIG_IP_NF_TFTP
-  TFTP connection tracking helper, this is required depending
-  on how restrictive your ruleset is.
-  If you are using a tftp client behind -j SNAT or -j MASQUERADING
-  you will need this.
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `Y'.
-
-FTP protocol support
-CONFIG_IP_NF_FTP
-  Tracking FTP connections is problematic: special helpers are
-  required for tracking them, and doing masquerading and other forms
-  of Network Address Translation on them.
-
-  If you want to compile it as a module, say M here and read
-  <file:Documentation/modules.txt>.  If unsure, say `Y'.
-
-User space queueing via NETLINK
 CONFIG_IP_NF_QUEUE
   Netfilter has the ability to queue packets to user space: the
   netlink device can be used to access them using this driver.
@@ -2579,7 +2572,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-IP tables support (required for filtering/masq/NAT)
 CONFIG_IP_NF_IPTABLES
   iptables is a general, extensible packet identification framework.
   The packet filtering and full NAT (masquerading, port forwarding,
@@ -2589,7 +2581,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-limit match support
 CONFIG_IP_NF_MATCH_LIMIT
   limit matching allows you to control the rate at which a rule can be
   matched: mainly useful in combination with the LOG target ("LOG
@@ -2598,7 +2589,13 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-skb->pkt_type packet match support
+CONFIG_IP_NF_MATCH_MAC
+  MAC matching allows you to match packets based on the source
+  Ethernet address of the packet.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
+
 CONFIG_IP_NF_MATCH_PKTTYPE
   This patch allows you to match packet in accrodance
   to its "class", eg. BROADCAST, MULTICAST, ...
@@ -2609,15 +2606,6 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
-MAC address match support
-CONFIG_IP_NF_MATCH_MAC
-  MAC matching allows you to match packets based on the source
-  Ethernet address of the packet.
-
-  If you want to compile it as a module, say M here and read
-  <file:Documentation/modules.txt>.  If unsure, say `N'.
-
-Netfilter MARK match support
 CONFIG_IP_NF_MATCH_MARK
   Netfilter mark matching allows you to match packets based on the
   `nfmark' value in the packet.  This can be set by the MARK target
@@ -2626,7 +2614,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-Multiple port match support
 CONFIG_IP_NF_MATCH_MULTIPORT
   Multiport matching allows you to match TCP or UDP packets based on
   a series of source or destination ports: normally a rule can only
@@ -2635,31 +2622,30 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-TTL match support
-CONFIG_IP_NF_MATCH_TTL
-  This adds CONFIG_IP_NF_MATCH_TTL option, which enabled the user
-  to match packets by their TTL value.
+CONFIG_IP_NF_MATCH_TOS
+  TOS matching allows you to match packets based on the Type Of
+  Service fields of the IP packet.
 
   If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-LENGTH match support
-CONFIG_IP_NF_MATCH_LENGTH
-  This option allows you to match the length of a packet against a
-  specific value or range of values.
+CONFIG_IP_NF_MATCH_RECENT
+  This match is used for creating one or many lists of recently
+  used addresses and then matching against that/those list(s).
+
+  Short options are available by using 'iptables -m recent -h'
+  Official Website: <http://snowman.net/projects/ipt_recent/>
 
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-AH/ESP match support
-CONFIG_IP_NF_MATCH_AH_ESP
-  These two match extensions (`ah' and `esp') allow you to match a
-  range of SPIs inside AH or ESP headers of IPSec packets.
+CONFIG_IP_NF_MATCH_ECN
+  This option adds a `ECN' match, which allows you to match against
+  the IPv4 and TCP header ECN fields.
 
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
-DSCP match support
 CONFIG_IP_NF_MATCH_DSCP
   This option adds a `DSCP' match, which allows you to match against
   the IPv4 header DSCP field (DSCP codepoint).
@@ -2669,39 +2655,42 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
- 
-
-ECN match support
-CONFIG_IP_NF_MATCH_ECN
-  This option adds a `ECN' match, which allows you to match against
-  the IPv4 and TCP header ECN fields.
+CONFIG_IP_NF_MATCH_AH_ESP
+  These two match extensions (`ah' and `esp') allow you to match a
+  range of SPIs inside AH or ESP headers of IPSec packets.
 
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
- 
-
-TOS match support
-CONFIG_IP_NF_MATCH_TOS
-  TOS matching allows you to match packets based on the Type Of
-  Service fields of the IP packet.
+CONFIG_IP_NF_MATCH_LENGTH
+  This option allows you to match the length of a packet against a
+  specific value or range of values.
 
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-conntrack match support
-CONFIG_IP_NF_MATCH_CONNTRACK
-  This is a general conntrack match module, a superset of the state match.
-
-  It allows matching on additional conntrack information, which is
-  useful in complex configurations, such as NAT gateways with multiple
-  internet links or tunnels.
+CONFIG_IP_NF_MATCH_TTL
+  This adds CONFIG_IP_NF_MATCH_TTL option, which enabled the user
+  to match packets by their TTL value.
 
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
+CONFIG_IP_NF_MATCH_TCPMSS
+  This option adds a `tcpmss' match, which allows you to examine the
+  MSS value of TCP SYN packets, which control the maximum packet size
+  for that connection.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
+
+CONFIG_IP_NF_MATCH_HELPER
+  Helper matching allows you to match packets in dynamic connections
+  tracked by a conntrack-helper, ie. ip_conntrack_ftp
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `Y'.
 
-Connection state match support
 CONFIG_IP_NF_MATCH_STATE
   Connection state matching allows you to match packets based on their
   relationship to a tracked connection (ie. previous packets).  This
@@ -2710,7 +2699,16 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-Unclean match support
+CONFIG_IP_NF_MATCH_CONNTRACK
+  This is a general conntrack match module, a superset of the state match.
+
+  It allows matching on additional conntrack information, which is
+  useful in complex configurations, such as NAT gateways with multiple
+  internet links or tunnels.
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `N'.
+
 CONFIG_IP_NF_MATCH_UNCLEAN
   Unclean packet matching matches any strange or invalid packets, by
   looking at a series of fields in the IP, TCP, UDP and ICMP headers.
@@ -2718,7 +2716,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-Owner match support
 CONFIG_IP_NF_MATCH_OWNER
   Packet owner matching allows you to match locally-generated packets
   based on who created them: the user, group, process or session.
@@ -2726,7 +2723,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-Packet filtering
 CONFIG_IP_NF_FILTER
   Packet filtering defines a table `filter', which has a series of
   rules for simple packet filtering at local input, forwarding and
@@ -2735,7 +2731,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-REJECT target support
 CONFIG_IP_NF_TARGET_REJECT
   The REJECT target allows a filtering rule to specify that an ICMP
   error should be issued in response to an incoming packet, rather
@@ -2744,7 +2739,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-MIRROR target support
 CONFIG_IP_NF_TARGET_MIRROR
   The MIRROR target allows a filtering rule to specify that an
   incoming packet should be bounced back to the sender.
@@ -2752,20 +2746,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-Local NAT support
-CONFIG_IP_NF_NAT_LOCAL
-  This option enables support for NAT of locally originated connections. 
-  Enable this if you need to use destination NAT on connections
-  originating from local processes on the nat box itself.
-
-  Please note that you will need a recent version (>= 1.2.6a)
-  of the iptables userspace program in order to use this feature.
-  See <http://www.iptables.org/> for download instructions.
-
-  If unsure, say 'N'.
-
-
-Full NAT (Network Address Translation)
 CONFIG_IP_NF_NAT
   The Full NAT option allows masquerading, port forwarding and other
   forms of full Network Address Port Translation.  It is controlled by
@@ -2774,7 +2754,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-MASQUERADE target support
 CONFIG_IP_NF_TARGET_MASQUERADE
   Masquerading is a special case of NAT: all outgoing connections are
   changed to seem to come from a particular interface's address, and
@@ -2785,9 +2764,27 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-Basic SNMP-ALG support
-CONFIG_IP_NF_NAT_SNMP_BASIC
+CONFIG_IP_NF_TARGET_REDIRECT
+  REDIRECT is a special case of NAT: all incoming connections are
+  mapped onto the incoming interface's address, causing the packets to
+  come to the local machine instead of passing through.  This is
+  useful for transparent proxies.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
 
+CONFIG_IP_NF_NAT_LOCAL
+  This option enables support for NAT of locally originated connections. 
+  Enable this if you need to use destination NAT on connections
+  originating from local processes on the nat box itself.
+
+  Please note that you will need a recent version (>= 1.2.6a)
+  of the iptables userspace program in order to use this feature.
+  See <http://www.iptables.org/> for download instructions.
+
+  If unsure, say 'N'.
+
+CONFIG_IP_NF_NAT_SNMP_BASIC
   This module implements an Application Layer Gateway (ALG) for
   SNMP payloads.  In conjunction with NAT, it allows a network
   management system to access multiple private networks with
@@ -2799,17 +2796,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-REDIRECT target support
-CONFIG_IP_NF_TARGET_REDIRECT
-  REDIRECT is a special case of NAT: all incoming connections are
-  mapped onto the incoming interface's address, causing the packets to
-  come to the local machine instead of passing through.  This is
-  useful for transparent proxies.
-
-  If you want to compile it as a module, say M here and read
-  <file:Documentation/modules.txt>.  If unsure, say `N'.
-
-Packet mangling
 CONFIG_IP_NF_MANGLE
   This option adds a `mangle' table to iptables: see the man page for
   iptables(8).  This table is used for various packet alterations
@@ -2818,25 +2804,17 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-DSCP target support
-CONFIG_IP_NF_TARGET_DSCP
-  This option adds a `DSCP' target, which allows you to create rules in
-  the iptables mangle table. The selected packet has the DSCP field set
-  to the hex value provided on the command line; unlike the TOS target
-  which will only set the legal values within ip.h.
-
-  The DSCP field can be set to any value between 0x0 and 0x4f. It does
-  take into account that bits 6 and 7 are used by ECN.
+CONFIG_IP_NF_TARGET_TOS
+  This option adds a `TOS' target, which allows you to create rules in
+  the `mangle' table which alter the Type Of Service field of an IP
+  packet prior to routing.
 
   If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
-
- 
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-ECN target support
 CONFIG_IP_NF_TARGET_ECN
   This option adds a `ECN' target, which can be used in the iptables mangle
-  table.  
+  table.
 
   You can use this target to remove the ECN bits from the IPv4 header of
   an IP packet.  This is particularly useful, if you need to work around
@@ -2846,18 +2824,18 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
- 
+CONFIG_IP_NF_TARGET_DSCP
+  This option adds a `DSCP' target, which allows you to create rules in
+  the iptables mangle table. The selected packet has the DSCP field set
+  to the hex value provided on the command line; unlike the TOS target
+  which will only set the legal values within ip.h.
 
-TOS target support
-CONFIG_IP_NF_TARGET_TOS
-  This option adds a `TOS' target, which allows you to create rules in
-  the `mangle' table which alter the Type Of Service field of an IP
-  packet prior to routing.
+  The DSCP field can be set to any value between 0x0 and 0x4f. It does
+  take into account that bits 6 and 7 are used by ECN.
 
   If you want to compile it as a module, say M here and read
-  <file:Documentation/modules.txt>.  If unsure, say `N'.
+  Documentation/modules.txt.  If unsure, say `N'.
 
-MARK target support
 CONFIG_IP_NF_TARGET_MARK
   This option adds a `MARK' target, which allows you to create rules
   in the `mangle' table which alter the netfilter mark (nfmark) field
@@ -2869,7 +2847,25 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-TCPMSS target support
+CONFIG_IP_NF_TARGET_LOG
+  This option adds a `LOG' target, which allows you to create rules in
+  any iptables table which records the packet header to the syslog.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  If unsure, say `N'.
+
+CONFIG_IP_NF_TARGET_ULOG
+  This option adds a `ULOG' target, which allows you to create rules in
+  any iptables table. The packet is passed to a userspace logging
+  daemon using netlink multicast sockets; unlike the LOG target
+  which can only be viewed through syslog.
+
+  The appropriate userspace logging daemon (ulogd) may be obtained from
+  <http://www.gnumonks.org/projects/ulogd>
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `N'.
+
 CONFIG_IP_NF_TARGET_TCPMSS
   This option adds a `TCPMSS' target, which allows you to alter the
   MSS value of TCP SYN packets, to control the maximum size for that
@@ -2894,45 +2890,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-Helper match support
-CONFIG_IP_NF_MATCH_HELPER
-  Helper matching allows you to match packets in dynamic connections
-  tracked by a conntrack-helper, ie. ip_conntrack_ftp
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `Y'.
-
-TCPMSS match support
-CONFIG_IP_NF_MATCH_TCPMSS
-  This option adds a `tcpmss' match, which allows you to examine the
-  MSS value of TCP SYN packets, which control the maximum packet size
-  for that connection.
-
-  If you want to compile it as a module, say M here and read
-  <file:Documentation/modules.txt>.  If unsure, say `N'.
-
-ULOG target support
-CONFIG_IP_NF_TARGET_ULOG
-  This option adds a `ULOG' target, which allows you to create rules in
-  any iptables table. The packet is passed to a userspace logging
-  daemon using netlink multicast sockets; unlike the LOG target
-  which can only be viewed through syslog.
-
-  The appropriate userspace logging daemon (ulogd) may be obtained from
-  <http://www.gnumonks.org/projects/ulogd>
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
-
-LOG target support
-CONFIG_IP_NF_TARGET_LOG
-  This option adds a `LOG' target, which allows you to create rules in
-  any iptables table which records the packet header to the syslog.
-
-  If you want to compile it as a module, say M here and read
-  <file:Documentation/modules.txt>.  If unsure, say `N'.
-
-ipchains (2.2-style) support
 CONFIG_IP_NF_COMPAT_IPCHAINS
   This option places ipchains (with masquerading and redirection
   support) back into the kernel, using the new netfilter
@@ -2943,7 +2900,6 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-ipfwadm (2.0-style) support
 CONFIG_IP_NF_COMPAT_IPFWADM
   This option places ipfwadm (with masquerading and redirection
   support) back into the kernel, using the new netfilter
