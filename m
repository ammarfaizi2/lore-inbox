Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275459AbTHJCf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 22:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275460AbTHJCf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 22:35:57 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:58241
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id S275459AbTHJCfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 22:35:55 -0400
Date: Sun, 10 Aug 2003 04:36:06 +0200
To: linux-kernel@vger.kernel.org
Cc: pascal.brisset-ml@wanadoo.fr, mbligh@aracnet.com, kernel@gozer.org,
       axboe@suse.de
Subject: [PATCH] loop: fixing cryptoloop troubles.
Message-ID: <20030810023606.GA15356@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1061346967.29a4@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In loop_transfer_bio the initial vector has been computed only once. For any
situation where more than one bio_vec is present the initial vector will be
wrong. Here is the trivial but important fix.=20

This will fix the disk corruption problems of cryptoloop for block-backed
loop devices mentioned earlier this month on this list.=20

This should close http://bugme.osdl.org/show_bug.cgi?id=3D1000=20

Please confirm.

Regards, Clemens

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop-2.6t2.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.0-test2/drivers/block/loop.c~	Sun Jul 27 19:03:16 2003
+++ linux-2.6.0-test2/drivers/block/loop.c	Sun Aug 10 04:22:44 2003
@@ -513,6 +513,7 @@
 					from_bvec->bv_len, IV);
 		kunmap(from_bvec->bv_page);
 		kunmap(to_bvec->bv_page);
+		IV +=3D from_bvec->bv_len >> 9;
 	}
=20
 	return ret;

--h31gzZEtNLTqOjlF--

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/Na+WW7sr9DEJLk4RAiVOAJ9vbeAjCVocJs74e2fkLGrrF7YlzgCfcM3u
1SkgasnrkqGEqbceC8+f854=
=oLoF
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
