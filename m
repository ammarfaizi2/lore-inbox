Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbUJYRfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUJYRfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUJYRfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:35:05 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:32950 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261216AbUJYReD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:34:03 -0400
Subject: Re: Can't build current 2.6 with separate output directory [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <16764.57958.975620.565173@wombat.chubb.wattle.id.au>
References: <16764.57958.975620.565173@wombat.chubb.wattle.id.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yE36DtNrms1h2d8vqnnd"
Date: Mon, 25 Oct 2004 19:33:42 +0200
Message-Id: <1098725622.12420.34.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yE36DtNrms1h2d8vqnnd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-10-25 at 21:24 +1000, Peter Chubb wrote:
>=20
> I see this:
>=20
>    $ make O=3D../build/i386/linux-2.6.10-rc1 V=3D1
>    ...
>      CHK     include/linux/compile.h
>    make -f /usr/src/linux-2.5-import/scripts/Makefile.build obj=3Dusr
>      echo Using shipped usr/initramfs_list
>    Using shipped usr/initramfs_list
>      ./usr/gen_init_cpio usr/initramfs_list > usr/initramfs_data.cpio
>    ERROR: unable to open 'usr/initramfs_list': No such file or directory
>=20
> because usr/Makefile is trying to access $(obj)/usr/initramfs_list
> instead of  $(src)/usr/initramfs_list.
>=20
> Here's a (probably incorrect) patch:
>=20
> Signed-off-by: Peter Chubb.
>=20
> =3D=3D=3D=3D=3D usr/Makefile 1.12 vs edited =3D=3D=3D=3D=3D
> --- 1.12/usr/Makefile   2004-10-20 18:37:03 +10:00
> +++ edited/usr/Makefile 2004-10-25 21:22:23 +10:00
> @@ -8,7 +8,7 @@
>  # If you want a different list of files in the initramfs_data.cpio
>  # then you can either overwrite the cpio_list in this directory
>  # or set INITRAMFS_LIST to another filename.
> -INITRAMFS_LIST :=3D $(obj)/initramfs_list
> +INITRAMFS_LIST :=3D $(KBUILD_SRC)/usr/initramfs_list
> =20
>  # initramfs_data.o contains the initramfs_data.cpio.gz image.
>  # The image is included using .incbin, a dependency which is not
> -

initramfs_list is modified, so it should be in the output dir.  There
are a few other patches floating around that fixes this properly.


Cheers,

--=20
Martin Schlemmer


--=-yE36DtNrms1h2d8vqnnd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBfTj2qburzKaJYLYRAv8tAJ49Xdihr+mg/lWux9rBqTY8CUmNZgCfajN3
yM8972OyXyhA+VXVQ1gmKxQ=
=UBkW
-----END PGP SIGNATURE-----

--=-yE36DtNrms1h2d8vqnnd--

