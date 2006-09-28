Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422721AbWI2UE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422721AbWI2UE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422727AbWI2UE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:04:56 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:38568 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1422721AbWI2UEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:04:55 -0400
Date: Thu, 28 Sep 2006 20:56:27 +0100
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Roger Gammans <roger@computer-surgery.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: fs/bio.c - Hardcoded sector size ?
Message-ID: <20060928195627.GD4759@julia.computer-surgery.co.uk>
References: <20060928182238.GA4759@julia.computer-surgery.co.uk> <20060929113814.db87b8d5.rdunlap@xenotime.net> <20060928185820.GB4759@julia.computer-surgery.co.uk> <20060929121157.0258883f.rdunlap@xenotime.net> <20060928191946.GC4759@julia.computer-surgery.co.uk> <20060929123737.ec613178.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20060929123737.ec613178.rdunlap@xenotime.net>
X-GPG-Fingerprint: ADAD DF3A AE05 CA28 3BDB  D352 7E81 8852 817A FB7B
X-GPG-Key: 1024D/817AFB7B (wwwkeys.uk.pgp.net)
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2006 at 12:37:37PM -0700, Randy Dunlap wrote:
> Hm, I looked thru fs/bio.c and block/*.c and Documentation/Docbook/*.tmpl.
> The best place that I see to put it right now is in
> include/linux/bio.h, struct bio, field: bi_sector.
>=20
> What do you think of that?

Well, ... Um. I can't think of anywhere better either, so how about
this:-

Signed-Off-By: Roger Gammans <rgammans@computer-sugery.co.uk>

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 76bdaea..77a8e6b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -70,7 +70,8 @@ typedef void (bio_destructor_t) (struct
  * stacking drivers)
  */
 struct bio {
-       sector_t                bi_sector;
+       sector_t                bi_sector;      /* device address in 512 by=
te
+                                                  sectors */
        struct bio              *bi_next;       /* request queue link */
        struct block_device     *bi_bdev;
        unsigned long           bi_flags;       /* status, command, etc
*/


--=20
Roger.                          Home| http://www.sandman.uklinux.net/
Master of Peng Shui.      (Ancient oriental art of Penguin Arranging)
Work|Independent Sys Consultant | http://www.computer-surgery.co.uk/
So what are the eigenvalues and eigenvectors of 'The Matrix'? --anon

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFHCjqTryqm47jHdMRAppAAKChfRmMB6a6MwmRJLKIIDF2HWbP1ACbBphj
aITeTNo8tJ99UX6HFkkVyWQ=
=LwQH
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
