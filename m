Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUHaSkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUHaSkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUHaSkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:40:42 -0400
Received: from coruscant.franken.de ([193.174.159.226]:5088 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S266574AbUHaSkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:40:08 -0400
Date: Tue, 31 Aug 2004 20:40:00 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Linus Torvalds <torvalds@osdl.org>,
       netfilter-devel@lists.netfilter.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [netfilter-core] 2.6.9-rc1: missing netfilter help texts
Message-ID: <20040831184000.GO5824@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
	Linus Torvalds <torvalds@osdl.org>,
	netfilter-devel@lists.netfilter.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org> <20040831173425.GE3466@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BtjZvq0+OkLkL8An"
Content-Disposition: inline
In-Reply-To: <20040831173425.GE3466@fs.tum.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BtjZvq0+OkLkL8An
Content-Type: multipart/mixed; boundary="H8fFO+isr9ADh2Iv"
Content-Disposition: inline


--H8fFO+isr9ADh2Iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 31, 2004 at 07:34:25PM +0200, Adrian Bunk wrote:
> The following new netfilter options lack help texts:
> - IP_NF_CT_ACCT
> - IP_NF_MATCH_SCTP
> - IP_NF_CT_PROTO_SCTP
>=20
> Could someone add the help texts?

Patch to add help texts attached, as well as a second, incremental patch
to sort entries into reasonable order

Signed-off-by: Harald Welte <laforge@netfilter.org>

> Adrian

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--H8fFO+isr9ADh2Iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.9-rc1-nfhelp1.diff"
Content-Transfer-Encoding: quoted-printable

diff -Nru --exclude .depend --exclude '*.o' --exclude '*.ko' --exclude '*.v=
er' --exclude '.*.flags' --exclude '*.orig' --exclude '*.rej' --exclude '*.=
cmd' --exclude '*.mod.c' --exclude '*~' linux-2.6.9-rc1-plain/net/ipv4/netf=
ilter/Kconfig linux-2.6.9-rc1-nfhelp/net/ipv4/netfilter/Kconfig
--- linux-2.6.9-rc1-plain/net/ipv4/netfilter/Kconfig	2004-08-31 20:24:43.00=
0000000 +0200
+++ linux-2.6.9-rc1-nfhelp/net/ipv4/netfilter/Kconfig	2004-08-31 20:29:12.0=
00000000 +0200
@@ -631,14 +631,35 @@
 config IP_NF_CT_ACCT
 	bool "Connection tracking flow accounting"
 	depends on IP_NF_CONNTRACK
+	help
+	  If this option is enabled, the connection tracking code will
+	  keep per-flow packet and byte counters.
+
+	  Those counters can be used for flow-based accounting or the
+	  `connbytes' match.
+
+	  If unsure, say `N'.
=20
 config IP_NF_MATCH_SCTP
 	tristate  'SCTP protocol match support'
 	depends on IP_NF_IPTABLES
+	help
+	  With this option enabled, you will be able to use the iptables
+	  `sctp' match in order to match on SCTP source/destination ports
+	  and SCTP chunk types.
+
+	  If you want to compile it as a module, say M here and read
+	  Documentation/modules.txt.  If unsure, say `N'.
=20
 config IP_NF_CT_PROTO_SCTP
 	tristate  'SCTP protocol connection tracking support (EXPERIMENTAL)'
 	depends on IP_NF_CONNTRACK && EXPERIMENTAL
+	help
+	  With this option enabled, the connection tracking code will
+	  be able to do state tracking on SCTP connections.
+
+	  If you want to compile it as a module, say M here and read
+	  Documentation/modules.txt.  If unsure, say `N'.
=20
 endmenu
=20

--H8fFO+isr9ADh2Iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.9-rc1-nfhelp2.diff"
Content-Transfer-Encoding: quoted-printable

diff -Nru --exclude .depend --exclude '*.o' --exclude '*.ko' --exclude '*.v=
er' --exclude '.*.flags' --exclude '*.orig' --exclude '*.rej' --exclude '*.=
cmd' --exclude '*.mod.c' --exclude '*~' linux-2.6.9-rc1-nfhelp/net/ipv4/net=
filter/Kconfig linux-2.6.9-rc1-nfhelp2/net/ipv4/netfilter/Kconfig
--- linux-2.6.9-rc1-nfhelp/net/ipv4/netfilter/Kconfig	2004-08-31 20:30:50.0=
00000000 +0200
+++ linux-2.6.9-rc1-nfhelp2/net/ipv4/netfilter/Kconfig	2004-08-31 20:36:46.=
000000000 +0200
@@ -5,6 +5,7 @@
 menu "IP: Netfilter Configuration"
 	depends on INET && NETFILTER
=20
+# connection tracking, helpers and protocols
 config IP_NF_CONNTRACK
 	tristate "Connection tracking (required for masq/NAT)"
 	---help---
@@ -19,6 +20,28 @@
=20
 	  To compile it as a module, choose M here.  If unsure, say N.
=20
+config IP_NF_CT_ACCT
+	bool "Connection tracking flow accounting"
+	depends on IP_NF_CONNTRACK
+	help
+	  If this option is enabled, the connection tracking code will
+	  keep per-flow packet and byte counters.
+
+	  Those counters can be used for flow-based accounting or the
+	  `connbytes' match.
+
+	  If unsure, say `N'.
+
+config IP_NF_CT_PROTO_SCTP
+	tristate  'SCTP protocol connection tracking support (EXPERIMENTAL)'
+	depends on IP_NF_CONNTRACK && EXPERIMENTAL
+	help
+	  With this option enabled, the connection tracking code will
+	  be able to do state tracking on SCTP connections.
+
+	  If you want to compile it as a module, say M here and read
+	  Documentation/modules.txt.  If unsure, say `N'.
+
 config IP_NF_FTP
 	tristate "FTP protocol support"
 	depends on IP_NF_CONNTRACK
@@ -86,7 +109,7 @@
=20
 	  To compile it as a module, choose M here.  If unsure, say N.
=20
-# The simple matches.
+# The matches.
 config IP_NF_MATCH_LIMIT
 	tristate "limit match support"
 	depends on IP_NF_IPTABLES
@@ -274,7 +297,42 @@
=20
 	  To compile it as a module, choose M here.  If unsure, say N.
=20
-# The targets
+config IP_NF_MATCH_ADDRTYPE
+	tristate  'address type match support'
+	depends on IP_NF_IPTABLES
+	help
+	  This option allows you to match what routing thinks of an address,
+	  eg. UNICAST, LOCAL, BROADCAST, ...
+=09
+	  If you want to compile it as a module, say M here and read
+	  Documentation/modules.txt.  If unsure, say `N'.
+
+config IP_NF_MATCH_REALM
+	tristate  'realm match support'
+	depends on IP_NF_IPTABLES
+	select NET_CLS_ROUTE
+	help
+	  This option adds a `realm' match, which allows you to use the realm
+	  key from the routing subsytem inside iptables.
+=09
+	  This match pretty much resembles the CONFIG_NET_CLS_ROUTE4 option=20
+	  in tc world.
+=09
+	  If you want to compile it as a module, say M here and read
+	  Documentation/modules.txt.  If unsure, say `N'.
+
+config IP_NF_MATCH_SCTP
+	tristate  'SCTP protocol match support'
+	depends on IP_NF_IPTABLES
+	help
+	  With this option enabled, you will be able to use the iptables
+	  `sctp' match in order to match on SCTP source/destination ports
+	  and SCTP chunk types.
+
+	  If you want to compile it as a module, say M here and read
+	  Documentation/modules.txt.  If unsure, say `N'.
+
+# `filter', generic and specific targets
 config IP_NF_FILTER
 	tristate "Packet filtering"
 	depends on IP_NF_IPTABLES
@@ -295,6 +353,56 @@
=20
 	  To compile it as a module, choose M here.  If unsure, say N.
=20
+config IP_NF_TARGET_LOG
+	tristate "LOG target support"
+	depends on IP_NF_IPTABLES
+	help
+	  This option adds a `LOG' target, which allows you to create rules in
+	  any iptables table which records the packet header to the syslog.
+
+	  To compile it as a module, choose M here.  If unsure, say N.
+
+config IP_NF_TARGET_ULOG
+	tristate "ULOG target support"
+	depends on IP_NF_IPTABLES
+	---help---
+	  This option adds a `ULOG' target, which allows you to create rules in
+	  any iptables table. The packet is passed to a userspace logging
+	  daemon using netlink multicast sockets; unlike the LOG target
+	  which can only be viewed through syslog.
+
+	  The apropriate userspace logging daemon (ulogd) may be obtained from
+	  <http://www.gnumonks.org/projects/ulogd/>
+
+	  To compile it as a module, choose M here.  If unsure, say N.
+
+config IP_NF_TARGET_TCPMSS
+	tristate "TCPMSS target support"
+	depends on IP_NF_IPTABLES
+	---help---
+	  This option adds a `TCPMSS' target, which allows you to alter the
+	  MSS value of TCP SYN packets, to control the maximum size for that
+	  connection (usually limiting it to your outgoing interface's MTU
+	  minus 40).
+
+	  This is used to overcome criminally braindead ISPs or servers which
+	  block ICMP Fragmentation Needed packets.  The symptoms of this
+	  problem are that everything works fine from your Linux
+	  firewall/router, but machines behind it can never exchange large
+	  packets:
+	  	1) Web browsers connect, then hang with no data received.
+	  	2) Small mail works fine, but large emails hang.
+	  	3) ssh works fine, but scp hangs after initial handshaking.
+
+	  Workaround: activate this option and add a rule to your firewall
+	  configuration like:
+
+	  iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN \
+	  		 -j TCPMSS --clamp-mss-to-pmtu
+
+	  To compile it as a module, choose M here.  If unsure, say N.
+
+# NAT + specific targets
 config IP_NF_NAT
 	tristate "Full NAT"
 	depends on IP_NF_IPTABLES && IP_NF_CONNTRACK
@@ -408,6 +516,7 @@
 	default IP_NF_NAT if IP_NF_AMANDA=3Dy
 	default m if IP_NF_AMANDA=3Dm
=20
+# mangle + specific targets
 config IP_NF_MANGLE
 	tristate "Packet mangling"
 	depends on IP_NF_IPTABLES
@@ -478,55 +587,34 @@
=20
 	  To compile it as a module, choose M here.  If unsure, say N.
=20
-config IP_NF_TARGET_LOG
-	tristate "LOG target support"
+# raw + specific targets
+config IP_NF_RAW
+	tristate  'raw table support (required for NOTRACK/TRACE)'
 	depends on IP_NF_IPTABLES
 	help
-	  This option adds a `LOG' target, which allows you to create rules in
-	  any iptables table which records the packet header to the syslog.
-
-	  To compile it as a module, choose M here.  If unsure, say N.
-
-config IP_NF_TARGET_ULOG
-	tristate "ULOG target support"
-	depends on IP_NF_IPTABLES
-	---help---
-	  This option adds a `ULOG' target, which allows you to create rules in
-	  any iptables table. The packet is passed to a userspace logging
-	  daemon using netlink multicast sockets; unlike the LOG target
-	  which can only be viewed through syslog.
-
-	  The apropriate userspace logging daemon (ulogd) may be obtained from
-	  <http://www.gnumonks.org/projects/ulogd/>
-
-	  To compile it as a module, choose M here.  If unsure, say N.
-
-config IP_NF_TARGET_TCPMSS
-	tristate "TCPMSS target support"
-	depends on IP_NF_IPTABLES
-	---help---
-	  This option adds a `TCPMSS' target, which allows you to alter the
-	  MSS value of TCP SYN packets, to control the maximum size for that
-	  connection (usually limiting it to your outgoing interface's MTU
-	  minus 40).
-
-	  This is used to overcome criminally braindead ISPs or servers which
-	  block ICMP Fragmentation Needed packets.  The symptoms of this
-	  problem are that everything works fine from your Linux
-	  firewall/router, but machines behind it can never exchange large
-	  packets:
-	  	1) Web browsers connect, then hang with no data received.
-	  	2) Small mail works fine, but large emails hang.
-	  	3) ssh works fine, but scp hangs after initial handshaking.
-
-	  Workaround: activate this option and add a rule to your firewall
-	  configuration like:
+	  This option adds a `raw' table to iptables. This table is the very
+	  first in the netfilter framework and hooks in at the PREROUTING
+	  and OUTPUT chains.
+=09
+	  If you want to compile it as a module, say M here and read
+	  <file:Documentation/modules.txt>.  If unsure, say `N'.
+	  help
=20
-	  iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN \
-	  		 -j TCPMSS --clamp-mss-to-pmtu
+config IP_NF_TARGET_NOTRACK
+	tristate  'NOTRACK target support'
+	depends on IP_NF_RAW
+	depends on IP_NF_CONNTRACK
+	help
+	  The NOTRACK target allows a select rule to specify
+	  which packets *not* to enter the conntrack/NAT
+	  subsystem with all the consequences (no ICMP error tracking,
+	  no protocol helpers for the selected packets).
+=09
+	  If you want to compile it as a module, say M here and read
+	  <file:Documentation/modules.txt>.  If unsure, say `N'.
=20
-	  To compile it as a module, choose M here.  If unsure, say N.
=20
+# ARP tables
 config IP_NF_ARPTABLES
 	tristate "ARP tables support"
 	help
@@ -579,87 +667,5 @@
=20
 	  To compile it as a module, choose M here.  If unsure, say N.
=20
-config IP_NF_TARGET_NOTRACK
-	tristate  'NOTRACK target support'
-	depends on IP_NF_RAW
-	depends on IP_NF_CONNTRACK
-	help
-	  The NOTRACK target allows a select rule to specify
-	  which packets *not* to enter the conntrack/NAT
-	  subsystem with all the consequences (no ICMP error tracking,
-	  no protocol helpers for the selected packets).
-=09
-	  If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.  If unsure, say `N'.
-
-config IP_NF_RAW
-	tristate  'raw table support (required for NOTRACK/TRACE)'
-	depends on IP_NF_IPTABLES
-	help
-	  This option adds a `raw' table to iptables. This table is the very
-	  first in the netfilter framework and hooks in at the PREROUTING
-	  and OUTPUT chains.
-=09
-	  If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.  If unsure, say `N'.
-	  help
-
-config IP_NF_MATCH_ADDRTYPE
-	tristate  'address type match support'
-	depends on IP_NF_IPTABLES
-	help
-	  This option allows you to match what routing thinks of an address,
-	  eg. UNICAST, LOCAL, BROADCAST, ...
-=09
-	  If you want to compile it as a module, say M here and read
-	  Documentation/modules.txt.  If unsure, say `N'.
-
-config IP_NF_MATCH_REALM
-	tristate  'realm match support'
-	depends on IP_NF_IPTABLES
-	select NET_CLS_ROUTE
-	help
-	  This option adds a `realm' match, which allows you to use the realm
-	  key from the routing subsytem inside iptables.
-=09
-	  This match pretty much resembles the CONFIG_NET_CLS_ROUTE4 option=20
-	  in tc world.
-=09
-	  If you want to compile it as a module, say M here and read
-	  Documentation/modules.txt.  If unsure, say `N'.
-
-config IP_NF_CT_ACCT
-	bool "Connection tracking flow accounting"
-	depends on IP_NF_CONNTRACK
-	help
-	  If this option is enabled, the connection tracking code will
-	  keep per-flow packet and byte counters.
-
-	  Those counters can be used for flow-based accounting or the
-	  `connbytes' match.
-
-	  If unsure, say `N'.
-
-config IP_NF_MATCH_SCTP
-	tristate  'SCTP protocol match support'
-	depends on IP_NF_IPTABLES
-	help
-	  With this option enabled, you will be able to use the iptables
-	  `sctp' match in order to match on SCTP source/destination ports
-	  and SCTP chunk types.
-
-	  If you want to compile it as a module, say M here and read
-	  Documentation/modules.txt.  If unsure, say `N'.
-
-config IP_NF_CT_PROTO_SCTP
-	tristate  'SCTP protocol connection tracking support (EXPERIMENTAL)'
-	depends on IP_NF_CONNTRACK && EXPERIMENTAL
-	help
-	  With this option enabled, the connection tracking code will
-	  be able to do state tracking on SCTP connections.
-
-	  If you want to compile it as a module, say M here and read
-	  Documentation/modules.txt.  If unsure, say `N'.
-
 endmenu
=20

--H8fFO+isr9ADh2Iv--

--BtjZvq0+OkLkL8An
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBNMYAXaXGVTD0i/8RAiMQAKCMnYWKwWbkh8i3jCEeoxODU0YP0ACgkw4+
vS2G+hYOCxWjeTsl3ynB9Dg=
=Q7Ap
-----END PGP SIGNATURE-----

--BtjZvq0+OkLkL8An--
