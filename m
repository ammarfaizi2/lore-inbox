Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVC2U12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVC2U12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVC2U11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:27:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29148 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261400AbVC2UZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:25:10 -0500
Date: Tue, 29 Mar 2005 15:25:06 -0500
From: Neil Horman <nhorman@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, netdev@oss.sgi.com, nhorman@redhat.com
Subject: [Patch] net: fix build break when CONFIG_NET_CLS_ACT is not set
Message-ID: <20050329202506.GI22447@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch to fix build break that occurs when CONFIG_NET_CLS_ACT is not set.

Signed-off-by: Neil Horman <nhorman@redhat.com>

 cls_fw.c      |    3 ++-
 cls_route.c   |    3 ++-
 cls_tcindex.c |    3 ++-
 cls_u32.c     |    2 ++
 4 files changed, 8 insertions(+), 3 deletions(-)



--- linux-2.6-sctp/net/sched/cls_u32.c.fix	2005-03-29 15:21:04.000000000 -0=
500
+++ linux-2.6-sctp/net/sched/cls_u32.c	2005-03-29 14:31:34.000000000 -0500
@@ -775,9 +775,11 @@ static int u32_dump(struct tcf_proto *tp
 	}
=20
 	rta->rta_len =3D skb->tail - b;
+#ifdef CONFIG_NET_CLS_ACT
 	if (TC_U32_KEY(n->handle) && n->exts.action && n->exts.action->type =3D=
=3D TCA_OLD_COMPAT)
 		if (tcf_exts_dump_stats(skb, &n->exts, &u32_ext_map) < 0)
 			goto rtattr_failure;
+#endif
 	return skb->len;
=20
 rtattr_failure:
--- linux-2.6-sctp/net/sched/cls_fw.c.fix	2005-03-29 14:28:29.000000000 -05=
00
+++ linux-2.6-sctp/net/sched/cls_fw.c	2005-03-29 14:28:43.000000000 -0500
@@ -337,10 +337,11 @@ static int fw_dump(struct tcf_proto *tp,
 		goto rtattr_failure;
=20
 	rta->rta_len =3D skb->tail - b;
-
+#ifdef CONFIG_NET_CLS_ACT
 	if (f->exts.action && f->exts.action->type =3D=3D TCA_OLD_COMPAT)
 		if (tcf_exts_dump_stats(skb, &f->exts, &fw_ext_map) < 0)
 			goto rtattr_failure;
+#endif
=20
 	return skb->len;
=20
--- linux-2.6-sctp/net/sched/cls_tcindex.c.fix	2005-03-29 14:30:18.00000000=
0 -0500
+++ linux-2.6-sctp/net/sched/cls_tcindex.c	2005-03-29 14:30:44.000000000 -0=
500
@@ -495,10 +495,11 @@ static int tcindex_dump(struct tcf_proto
 		if (tcf_exts_dump(skb, &r->exts, &tcindex_ext_map) < 0)
 			goto rtattr_failure;
 		rta->rta_len =3D skb->tail-b;
-
+#ifdef CONFIG_NET_CLS_ACT
 		if (r->exts.action && r->exts.action->type =3D=3D TCA_OLD_COMPAT)
 			if (tcf_exts_dump_stats(skb, &r->exts, &tcindex_ext_map) < 0)
 				goto rtattr_failure;
+#endif
 	}
 =09
 	return skb->len;
--- linux-2.6-sctp/net/sched/cls_route.c.fix	2005-03-29 14:29:30.000000000 =
-0500
+++ linux-2.6-sctp/net/sched/cls_route.c	2005-03-29 14:29:55.000000000 -0500
@@ -598,10 +598,11 @@ static int route4_dump(struct tcf_proto=20
 		goto rtattr_failure;
=20
 	rta->rta_len =3D skb->tail - b;
-
+#ifdef CONFIG_NET_CLS_ACT
 	if (f->exts.action && f->exts.action->type =3D=3D TCA_OLD_COMPAT)
 		if (tcf_exts_dump_stats(skb, &f->exts, &route_ext_map) < 0)
 			goto rtattr_failure;
+#endif
=20
 	return skb->len;
=20
--=20
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCSbmiM+bEoZKnT6ERAnqPAJ9+fPnFuuIjpjA4WXHWP81EwswAlwCdE6C/
VhIn6zeUUc+p4RPGjJk2LU8=
=t8dN
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
