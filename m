Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTIUIJk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 04:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTIUIJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 04:09:40 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:46243 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262357AbTIUIJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 04:09:38 -0400
Date: Sun, 21 Sep 2003 11:09:23 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
Subject: [PATCH] fix compile warning in fs/nfsd/nfs4xdr.c, 2.6.0-t5-cvs
Message-ID: <20030921080923.GC4938@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When compiling fs/nfsd/nfs4xdr.c, I get a warning:

fs/nfsd/nfs4xdr.c: In function `nfsd4_encode_open':
fs/nfsd/nfs4xdr.c:1773: warning: `return' with a value, in function
returning void

This patch fixes it. I'm not 100% sure about it, but it seems
correct, and the return value is ignored anyway...=20

diff --exclude-from /home/muli/p/dontdiff -Naur ../linux-2.5/fs/nfsd/nfs4xd=
r.c 2.6.0-t5-Werror/fs/nfsd/nfs4xdr.c
--- ../linux-2.5/fs/nfsd/nfs4xdr.c	Tue Sep  2 12:51:06 2003
+++ 2.6.0-t5-Werror/fs/nfsd/nfs4xdr.c	Sun Sep 21 10:18:19 2003
@@ -1709,13 +1709,13 @@
 }
=20
=20
-static void
+static int
 nfsd4_encode_open(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4=
_open *open)
 {
 	ENCODE_HEAD;
=20
 	if (nfserr)
-		return;
+		return nfserr;
=20
 	RESERVE_SPACE(36 + sizeof(stateid_t));
 	WRITE32(open->op_stateid.si_generation);

--=20
Muli Ben-Yehuda
http://www.mulix.org


--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/bVyzKRs727/VN8sRAto2AKCO53m8PNgLFlu+SSWriqFuBO/QjwCguBqU
KzpMAFa5zYYeYnojylOaMAs=
=aOTg
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
