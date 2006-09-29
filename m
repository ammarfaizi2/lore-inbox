Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWI3Rb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWI3Rb0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWI3Rb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:31:26 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:60649 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1751317AbWI3RbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:31:22 -0400
Date: Fri, 29 Sep 2006 18:25:58 +0100
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Zach Brown <zab@zabbo.net>, Roger Gammans <roger@computer-surgery.co.uk>,
       lkml <linux-kernel@vger.kernel.org>, axboe@kernel.dk
Subject: Re: fs/bio.c - Hardcoded sector size ?
Message-ID: <20060929172558.GB4478@julia.computer-surgery.co.uk>
References: <20060928182238.GA4759@julia.computer-surgery.co.uk> <20060929113814.db87b8d5.rdunlap@xenotime.net> <20060928185820.GB4759@julia.computer-surgery.co.uk> <20060929121157.0258883f.rdunlap@xenotime.net> <20060928191946.GC4759@julia.computer-surgery.co.uk> <20060929123737.ec613178.rdunlap@xenotime.net> <20060928195627.GD4759@julia.computer-surgery.co.uk> <20060929131730.0b733137.rdunlap@xenotime.net> <451D808A.9050005@zabbo.net> <20060929133205.19c318cb.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20060929133205.19c318cb.rdunlap@xenotime.net>
X-GPG-Fingerprint: ADAD DF3A AE05 CA28 3BDB  D352 7E81 8852 817A FB7B
X-GPG-Key: 1024D/817AFB7B (wwwkeys.uk.pgp.net)
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2006 at 01:32:05PM -0700, Randy Dunlap wrote:
> > How about adding kerneldoc for sector_t itself?
>=20
> Good idea, but afaik it would have to be added for the entire
> struct, not just one field.

sector_t 's a simple typedef from unsigned long or u64 depending on
config rather than a struct - will kerneldoc still pick up the comments
on theese?

Assuming it will I suggest the following. I've kept my shorter text in
the bi_sector field as it is now more fully explained with sector_t.


Signed-Off-By: Roger Gammans <rgammans@computer-surgery.co.uk>

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
diff --git a/include/linux/types.h b/include/linux/types.h
index 3f23566..0ddfa1a 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -127,8 +127,12 @@ #endif
 /* this is a special 64bit data type that is 8-byte aligned */
 #define aligned_u64 unsigned long long __attribute__((aligned(8)))

-/*
+/**
  * The type used for indexing onto a disc or disc partition.
+ *
+ * Linux always considers sectors to be 512 bytes long independently
+ * of the devices real block size.
+ *
  * If required, asm/types.h can override it and define
  * HAVE_SECTOR_T
  */


--=20
Roger.                          Home| http://www.sandman.uklinux.net/
Master of Peng Shui.      (Ancient oriental art of Penguin Arranging)
Work|Independent Sys Consultant | http://www.computer-surgery.co.uk/
So what are the eigenvalues and eigenvectors of 'The Matrix'? --anon

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFHVcmTryqm47jHdMRAiyKAJ9YSJToFrylK0XwKaJpzdSiko6ukACgtq6f
5TD7OSZzoNmka36Qz5Tsy2Q=
=dC90
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
