Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268230AbUHYSy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268230AbUHYSy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUHYSy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:54:59 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:23469 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S268230AbUHYSy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:54:56 -0400
Date: Wed, 25 Aug 2004 11:54:54 -0700
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Subject: x86-64 compile error in 2.6.9-rc1-bk1
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Message-id: <1093460094.23633.18.camel@duffman>
MIME-version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-1bIMBeHQRbNl87E3HMh8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1bIMBeHQRbNl87E3HMh8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

If you have CONFIG_SWIOTLB=3Dy (GART_IOMMU=3Dy), you get:

ld: BFD 2.15.90.0.3 20040415 assertion fail ../../bfd/linker.c:619
arch/x86_64/mm/built-in.o(.init.text+0x52a): In function `mem_init':
: undefined reference to `swiotlb_force'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [_all] Error 2

This was added in Linus's tree.  But I cannot find where swiotlb_force is d=
efined...

diff -Nru a/arch/x86_64/mm/init.c b/arch/x86_64/mm/init.c
--- a/arch/x86_64/mm/init.c     2004-06-24 01:55:57 -07:00
+++ b/arch/x86_64/mm/init.c     2004-08-24 02:08:31 -07:00

@@ -396,6 +400,8 @@
        return 0;
 }
                                                                           =
    =20
+extern int swiotlb_force;
+
 static struct kcore_list kcore_mem, kcore_vmalloc, kcore_kernel, kcore_mod=
ules,                         kcore_vsyscall;
                                                                           =
    =20
@@ -405,7 +411,10 @@
        int tmp;
                                                                           =
    =20
 #ifdef CONFIG_SWIOTLB
-       if (!iommu_aperture && end_pfn >=3D 0xffffffff>>PAGE_SHIFT)
+       if (swiotlb_force)
+               swiotlb =3D 1;
+       if (!iommu_aperture &&
+           (end_pfn >=3D 0xffffffff>>PAGE_SHIFT || force_iommu))
               swiotlb =3D 1;
        if (swiotlb)
                swiotlb_init();


--=-1bIMBeHQRbNl87E3HMh8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBLOB+dY502zjzwbwRAqk5AKCdCxcDV9obLhWoEvDZwsGWRpb2BgCbBduu
8TPNdtOVf5C08ikP2oEWA6w=
=6X9L
-----END PGP SIGNATURE-----

--=-1bIMBeHQRbNl87E3HMh8--

