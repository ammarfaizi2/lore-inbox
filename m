Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269282AbUJQT60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269282AbUJQT60 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269272AbUJQT60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:58:26 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:63210 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S269292AbUJQT6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:58:08 -0400
Subject: Re: rc4-mm1 and pwc-unofficial: kernel BUG and scheduling while
	atomic [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org,
       luc@saillard.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041017190054.GB5607@holomorphy.com>
References: <20041017073614.GC7395@gamma.logic.tuwien.ac.at>
	 <20041017093018.GY5607@holomorphy.com>
	 <1098038131.15115.8.camel@nosferatu.lan>
	 <20041017190054.GB5607@holomorphy.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+8UAXKM81Y4aNdv/NPYj"
Date: Sun, 17 Oct 2004 21:57:45 +0200
Message-Id: <1098043065.15115.13.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+8UAXKM81Y4aNdv/NPYj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-17 at 12:00 -0700, William Lee Irwin III wrote:
> On Sun, 2004-10-17 at 02:30 -0700, William Lee Irwin III wrote:
> >> You need to right shift the argument by PAGE_SHIFT.
>=20
> On Sun, Oct 17, 2004 at 08:35:31PM +0200, Martin Schlemmer [c] wrote:
> > I am trying to get vesafb-tng to work with rc4-mm1, but are not sure
> > when to shift the argument by PAGE_SHIFT, and when not to.  The patches
> > from you in rc4-mm1 sometimes shifts the second arg, other times the
> > third, and other times not at all.  Is there a easy way for a mostly
> > clueless person to figure out when to shift what argument and when not?
>=20
> Please point out where these inconsistencies occur and I will repair
> them.
>=20
> Only the third argument changed, from a physical address to a pfn.
>=20

Its the vesafb-tng patch
(http://dev.gentoo.org/~spock/projects/vesafb-tng/)
Relevant part:

----
        vma.vm_mm =3D current->active_mm;
        vma.vm_page_prot.pgprot =3D PROT_READ | PROT_EXEC | PROT_WRITE;

        ret =3D remap_page_range(&vma, 0x000000, __pa(mem), REAL_MEM_SIZE, =
vma.vm_page_prot);
        ret +=3D remap_page_range(&vma, 0x0a0000, 0x0a0000, 0x100000 - 0x0a=
0000, vma.vm_page_prot);
----

I did it as:

----
        vma.vm_mm =3D current->active_mm;
        vma.vm_page_prot.pgprot =3D PROT_READ | PROT_EXEC | PROT_WRITE;

        ret =3D remap_pfn_range(&vma, 0x000000, __pa(mem) >> PAGE_SHIFT, RE=
AL_MEM_SIZE, vma.vm_page_prot);
        ret +=3D remap_pfn_range(&vma, 0x0a0000, 0x0a0000, 0x100000 - 0x0a0=
000, vma.vm_page_prot);
----


Thanks,
--=20
Martin Schlemmer


--=-+8UAXKM81Y4aNdv/NPYj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBcs65qburzKaJYLYRAqxNAKCIEmljIjx6TepdOwcSnNO9mmrXdwCeIQbB
9+pAZdCS3L/QftIBonQ3UJo=
=K99T
-----END PGP SIGNATURE-----

--=-+8UAXKM81Y4aNdv/NPYj--

