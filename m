Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbTCYAOm>; Mon, 24 Mar 2003 19:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbTCYAOl>; Mon, 24 Mar 2003 19:14:41 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:62929 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S261294AbTCYAOj>; Mon, 24 Mar 2003 19:14:39 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andi Kleen <ak@suse.de>, davej@codemonkey.org.uk
Subject: [PATCH][x86-64] make the pci aperture cachable
Date: Tue, 25 Mar 2003 01:25:32 +0100
User-Agent: KMail/1.5
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <200303241641.h2OGfw35008208@deviant.impure.org.uk> <1048527139.12339.109.camel@averell>
In-Reply-To: <1048527139.12339.109.camel@averell>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_DI6f+Mxd3TUeVBQ";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200303250125.39564.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_DI6f+Mxd3TUeVBQ
Content-Type: multipart/mixed;
  boundary="Boundary-01=_8H6f+kI5hWcQqz0"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_8H6f+kI5hWcQqz0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Am Montag, 24. M=E4rz 2003 18:32 schrieb Andi Kleen:
> On Mon, 2003-03-24 at 17:41, davej@codemonkey.org.uk wrote:
> > diff -urpN --exclude-from=3D/home/davej/.exclude=20
bk-linus/arch/x86_64/kernel/pci-gart.c=20
linux-2.5/arch/x86_64/kernel/pci-gart.c
> > --- bk-linus/arch/x86_64/kernel/pci-gart.c	2003-03-08 09:56:51.00000000=
0=20
+0000
> > +++ linux-2.5/arch/x86_64/kernel/pci-gart.c	2003-03-18 21:19:53.0000000=
00=20
+0000
> > @@ -419,6 +419,7 @@ static __init int init_k8_gatt(agp_kern_
> >  		panic("Cannot allocate GATT table");=20
> >  	memset(gatt, 0, gatt_size);=20
> >  	change_page_attr(virt_to_page(gatt), gatt_size/PAGE_SIZE,=20
PAGE_KERNEL_NOCACHE);
> > +	global_flush_tlb();
> >  	agp_gatt_table =3D gatt;
> >  =09
> >  	for_all_nb(dev) {=20
>=20
> No it needs to be completely removed. the pci aperture is supposed to be
> cachable (unlike the AGP aperture) That's still a trace of an earlier
> design.
>=20
> -Andi

As this patch has been applied anyway here is a patch to make the pci apert=
ure=20
cachable for 2.5.66.

  Thomas Schlichter
--Boundary-01=_8H6f+kI5hWcQqz0
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="pci-gart.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="pci-gart.patch"

=2D-- linux-2.5.66/arch/x86_64/kernel/pci-gart.c.old	Tue Mar 25 01:09:51 20=
03
+++ linux-2.5.66/arch/x86_64/kernel/pci-gart.c	Tue Mar 25 01:16:28 2003
@@ -418,8 +418,6 @@
 	if (!gatt)=20
 		panic("Cannot allocate GATT table");=20
 	memset(gatt, 0, gatt_size);=20
=2D	change_page_attr(virt_to_page(gatt), gatt_size/PAGE_SIZE, PAGE_KERNEL_N=
OCACHE);
=2D	global_flush_tlb();
 	agp_gatt_table =3D gatt;
 =09
 	for_all_nb(dev) {=20
@@ -438,8 +436,6 @@
 	}
 	flush_gart();=20
 =09
=2D	global_flush_tlb();
=2D	=09
 	printk("PCI-DMA: aperture base @ %x size %u KB\n", aper_base, aper_size>>=
10);=20
 	return 0;
=20

--Boundary-01=_8H6f+kI5hWcQqz0--

--Boundary-03=_DI6f+Mxd3TUeVBQ
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+f6IDYAiN+WRIZzQRAqDqAKCIwxYx8K4jSqhFgbBoauFRb/whqgCg+yQt
L6ZAtoxEMMMCV3byGtLXk0E=
=Myc3
-----END PGP SIGNATURE-----

--Boundary-03=_DI6f+Mxd3TUeVBQ--

