Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbVKWG7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbVKWG7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 01:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVKWG7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 01:59:40 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:32128 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1030340AbVKWG7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 01:59:39 -0500
Date: Wed, 23 Nov 2005 07:59:21 +0100
From: Harald Welte <laforge@netfilter.org>
To: Krzysztof Oledzki <ole@ans.pl>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [patch 13/23] [PATCH] [NETFILTER] ctnetlink: Fix oops when no ICMP ID info in message
Message-ID: <20051123065921.GK31478@sunbeam.de.gnumonks.org>
References: <20051122205223.099537000@localhost.localdomain> <20051122210804.GN28140@shell0.pdx.osdl.net> <Pine.LNX.4.64.0511230023310.15479@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1HiqrRAOzahhT936"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511230023310.15479@bizon.gios.gov.pl>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1HiqrRAOzahhT936
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2005 at 12:31:55AM +0100, Krzysztof Oledzki wrote:
> On Tue, 22 Nov 2005, Chris Wright wrote:
>=20
> >-stable review patch.  If anyone has any objections, please let us know.
>=20
> It seems we have two different patches here.

yes, it seems like two independent patches slipped into the one patch
that was submitted.  I detected that error for mainline, but forgot that
the same patch was submitted for stable.

So the first part (as pointed out by Krzyzstof) is not a bugfix, but a
cosmetic fix. =20

I therefore request reverting this patch '13', and instead applying the ver=
sion
below, the one that contains only the real fix (as indicated in the
changelog)

Sorry once again.

[NETFILTER] ctnetlink: Fix oops when no ICMP ID info in message

This patch fixes an userspace triggered oops. If there is no ICMP_ID
info the reference to attr will be NULL.

Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit 922474105255d7791128688c8e60bb27a8eadf1d
tree b072448bfe0b79058b03ed798a1145ad1a7c6397
parent 723cb15b48e5510094296a9fc240d69a3acae95c
author Krzysztof Piotr Oledzki <ole@ans.pl> Tue, 15 Nov 2005 12:16:43 +0100
committer Harald Welte <laforge@netfilter.org> Tue, 15 Nov 2005 12:16:43 +0=
100

 net/ipv4/netfilter/ip_conntrack_proto_icmp.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/netfilter/ip_conntrack_proto_icmp.c b/net/ipv4/netfil=
ter/ip_conntrack_proto_icmp.c
--- a/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
@@ -296,7 +296,8 @@ static int icmp_nfattr_to_tuple(struct n
 				struct ip_conntrack_tuple *tuple)
 {
 	if (!tb[CTA_PROTO_ICMP_TYPE-1]
-	    || !tb[CTA_PROTO_ICMP_CODE-1])
+	    || !tb[CTA_PROTO_ICMP_CODE-1]
+	    || !tb[CTA_PROTO_ICMP_ID-1])
 		return -1;
=20
 	tuple->dst.u.icmp.type =3D=20
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--1HiqrRAOzahhT936
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDhBNJXaXGVTD0i/8RAvwTAJ93GLbS0G8QoufVPqjicbU2sSkeVgCfaz3D
d4qmI2EpYvGTS14j2eUxIBc=
=V5RR
-----END PGP SIGNATURE-----

--1HiqrRAOzahhT936--
