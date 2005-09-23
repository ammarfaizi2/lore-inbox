Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVIWPGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVIWPGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 11:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVIWPGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 11:06:38 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:3563 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751057AbVIWPGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 11:06:37 -0400
Date: Fri, 23 Sep 2005 17:06:31 +0200
From: Harald Welte <laforge@netfilter.org>
To: Patrick McHardy <kaber@trash.net>
Cc: Andrew Morton <akpm@osdl.org>, David Miller <davem@davemloft.net>,
       Linux Netdev List <netdev@vger.kernel.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix NFQUEUE Kconfig dependency (was Re: Fw: Kernel 2.6.14-rc2 compile error)
Message-ID: <20050923150631.GH731@sunbeam.de.gnumonks.org>
References: <20050923014412.26695cc4.akpm@osdl.org> <433412A6.2090904@trash.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gAUgrzRZ7tRi/Yr6"
Content-Disposition: inline
In-Reply-To: <433412A6.2090904@trash.net>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.2 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Fri, Sep 23, 2005 at 04:35:18PM +0200, Patrick
	McHardy wrote: > Andrew Morton wrote: > > I think we fixed this? > >
	Harald made some dependency fixes, but this one looks new to me. >
	Harald? Please apply the following patch, it fixes the problem. [...] 
	Content analysis details:   (0.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gAUgrzRZ7tRi/Yr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2005 at 04:35:18PM +0200, Patrick McHardy wrote:
> Andrew Morton wrote:
> > I think we fixed this?
>=20
> Harald made some dependency fixes, but this one looks new to me.
> Harald?

Please apply the following patch, it fixes the problem.

[NETFILTER]: Fix ip[6]t_NFQUEUE Kconfig dependency

We have to introduce a separate Kconfig menu entry for the NFQUEUE targets.
They cannot "just" depend on nfnetlink_queue, since nfnetlink_queue could
be linked into the kernel, whereas iptables can be a module.

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit d7252e42c8832cd5695decb1d834e4dcac4bb8d9
tree bb07ec7f79963d6aa1a9c74a99983cd3c27873b3
parent 1cd841ea786e2a74fc0d66299a024ae6b3b7424a
author Harald Welte <laforge@hanuman.de.gnumonks.org> Fri, 23 Sep 2005 17:0=
4:26 +0200
committer Harald Welte <laforge@hanuman.de.gnumonks.org> Fri, 23 Sep 2005 1=
7:04:26 +0200

 net/ipv4/netfilter/Kconfig  |   11 +++++++++++
 net/ipv4/netfilter/Makefile |    2 +-
 net/ipv6/netfilter/Kconfig  |   11 +++++++++++
 net/ipv6/netfilter/Makefile |    2 +-
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -521,6 +521,17 @@ config IP_NF_TARGET_TCPMSS
=20
 	  To compile it as a module, choose M here.  If unsure, say N.
=20
+config IP_NF_TARGET_NFQUEUE
+	tristate "NFQUEUE Target Support"
+	depends on IP_NF_IPTABLES
+	help
+	  This Target replaced the old obsolete QUEUE target.
+
+	  As opposed to QUEUE, it supports 65535 different queues,
+	  not just one.
+
+	  To compile it as a module, choose M here.  If unsure, say N.
+
 # NAT + specific targets
 config IP_NF_NAT
 	tristate "Full NAT"
diff --git a/net/ipv4/netfilter/Makefile b/net/ipv4/netfilter/Makefile
--- a/net/ipv4/netfilter/Makefile
+++ b/net/ipv4/netfilter/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_IP_NF_TARGET_TCPMSS) +=3D ipt
 obj-$(CONFIG_IP_NF_TARGET_NOTRACK) +=3D ipt_NOTRACK.o
 obj-$(CONFIG_IP_NF_TARGET_CLUSTERIP) +=3D ipt_CLUSTERIP.o
 obj-$(CONFIG_IP_NF_TARGET_TTL) +=3D ipt_TTL.o
+obj-$(CONFIG_IP_NF_TARGET_NFQUEUE) +=3D ipt_NFQUEUE.o
=20
 # generic ARP tables
 obj-$(CONFIG_IP_NF_ARPTABLES) +=3D arp_tables.o
@@ -96,4 +97,3 @@ obj-$(CONFIG_IP_NF_ARP_MANGLE) +=3D arpt_m
 obj-$(CONFIG_IP_NF_ARPFILTER) +=3D arptable_filter.o
=20
 obj-$(CONFIG_IP_NF_QUEUE) +=3D ip_queue.o
-obj-$(CONFIG_NETFILTER_NETLINK_QUEUE) +=3D ipt_NFQUEUE.o
diff --git a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -209,6 +209,17 @@ config IP6_NF_TARGET_REJECT
=20
 	  To compile it as a module, choose M here.  If unsure, say N.
=20
+config IP6_NF_TARGET_NFQUEUE
+	tristate "NFQUEUE Target Support"
+	depends on IP_NF_IPTABLES
+	help
+	  This Target replaced the old obsolete QUEUE target.
+
+	  As opposed to QUEUE, it supports 65535 different queues,
+	  not just one.
+
+	  To compile it as a module, choose M here.  If unsure, say N.
+
 #  if [ "$CONFIG_IP6_NF_FILTER" !=3D "n" ]; then
 #    dep_tristate '    REJECT target support' CONFIG_IP6_NF_TARGET_REJECT =
$CONFIG_IP6_NF_FILTER
 #    if [ "$CONFIG_EXPERIMENTAL" =3D "y" ]; then
diff --git a/net/ipv6/netfilter/Makefile b/net/ipv6/netfilter/Makefile
--- a/net/ipv6/netfilter/Makefile
+++ b/net/ipv6/netfilter/Makefile
@@ -21,9 +21,9 @@ obj-$(CONFIG_IP6_NF_FILTER) +=3D ip6table_
 obj-$(CONFIG_IP6_NF_MANGLE) +=3D ip6table_mangle.o
 obj-$(CONFIG_IP6_NF_TARGET_MARK) +=3D ip6t_MARK.o
 obj-$(CONFIG_IP6_NF_TARGET_HL) +=3D ip6t_HL.o
+obj-$(CONFIG_IP6_NF_TARGET_NFQUEUE) +=3D ip6t_NFQUEUE.o
 obj-$(CONFIG_IP6_NF_QUEUE) +=3D ip6_queue.o
 obj-$(CONFIG_IP6_NF_TARGET_LOG) +=3D ip6t_LOG.o
 obj-$(CONFIG_IP6_NF_RAW) +=3D ip6table_raw.o
 obj-$(CONFIG_IP6_NF_MATCH_HL) +=3D ip6t_hl.o
 obj-$(CONFIG_IP6_NF_TARGET_REJECT) +=3D ip6t_REJECT.o
-obj-$(CONFIG_NETFILTER_NETLINK_QUEUE) +=3D ip6t_NFQUEUE.o
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--gAUgrzRZ7tRi/Yr6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDNBn3XaXGVTD0i/8RAva2AJ9UQQf8+aUWHkhw0iLuG7zEo//jlQCffyO0
n0UJa8D1yVLZhGsLxMWzmec=
=htRK
-----END PGP SIGNATURE-----

--gAUgrzRZ7tRi/Yr6--
