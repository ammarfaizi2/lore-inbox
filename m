Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932777AbVITRhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbVITRhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbVITRhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:37:36 -0400
Received: from [204.13.84.100] ([204.13.84.100]:31500 "EHLO
	stargazer.tbdnetworks.com") by vger.kernel.org with ESMTP
	id S932777AbVITRhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:37:35 -0400
Subject: [PATCH] trivial: delete 2 unreachable statements in
	drivers/block/paride/pf.c
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HXy0FZEED83kMCudcM6Y"
Organization: TBD Networks
Date: Tue, 20 Sep 2005 10:37:21 -0700
Message-Id: <1127237842.4416.28.camel@defiant>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HXy0FZEED83kMCudcM6Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

the last patch from Jens Axboe for drivers/block/paride/pf.c
introduced pf_end_request() which sets pf_req to NULL.  The trivial
patch below deletes 2 unreachable statements.  I asked Jens about it
and he said: "Yeah that is a leftover, harmless though."

Best,
  Norbert


diff -u a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
--- a/drivers/block/paride/pf.c	2005-09-20 10:24:54.000000000 -0700
+++ b/drivers/block/paride/pf.c	2005-09-20 10:25:55.000000000 -0700
@@ -807,10 +807,6 @@
 		return 1;
 	spin_lock_irqsave(&pf_spin_lock, saved_flags);
 	pf_end_request(1);
-	if (pf_req) {
-		pf_count =3D pf_req->current_nr_sectors;
-		pf_buf =3D pf_req->buffer;
-	}
 	spin_unlock_irqrestore(&pf_spin_lock, saved_flags);
 	return 1;
 }


--=-HXy0FZEED83kMCudcM6Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDMEjROIJDAvi0wRwRAmQWAJ0b2K0/AIlLi9ZW4KCmsCaFyHI5lgCghogv
9WZ6BRggVCQk8f7HTZ/ubtQ=
=Ug/L
-----END PGP SIGNATURE-----

--=-HXy0FZEED83kMCudcM6Y--

