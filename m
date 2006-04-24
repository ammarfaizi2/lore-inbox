Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWDXWQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWDXWQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWDXWQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:16:19 -0400
Received: from smtp04.auna.com ([62.81.186.14]:22933 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S1750701AbWDXWQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:16:19 -0400
Date: Tue, 25 Apr 2006 00:16:17 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
Message-ID: <20060425001617.0a536488@werewolf.auna.net>
In-Reply-To: <1145915533.1635.60.camel@localhost.localdomain>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
	<mj+md-20060424.201044.18351.atrey@ucw.cz>
	<444D44F2.8090300@wolfmountaingroup.com>
	<1145915533.1635.60.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.1.1cvs22 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_kBUjkrZJsttjK2f5DWPa0yz;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Tue, 25 Apr 2006 00:16:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_kBUjkrZJsttjK2f5DWPa0yz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Apr 2006 22:52:12 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wro=
te:

> On Llu, 2006-04-24 at 15:36 -0600, Jeff V. Merkey wrote:
> > C++ in the kernel is a BAD IDEA. C++ code can be written in such a=20
> > convoluted manner as to be unmaintainable and unreadable.
>=20
> So can C.=20
>=20
> > All of the hidden memory allocations from constructor/destructor=20
> > operatings can and do KILL OS PERFORMANCE.=20
>=20
> This is one area of concern. Just as big a problem for the OS case is
> that the hidden constructors/destructors may fail.

Tell me what is the difference between:


    sbi =3D kmalloc(sizeof(*sbi), GFP_KERNEL);
    if (!sbi)
        return -ENOMEM;
    sb->s_fs_info =3D sbi;
    memset(sbi, 0, sizeof(*sbi));
    sbi->s_mount_opt =3D 0;
    sbi->s_resuid =3D EXT3_DEF_RESUID;
    sbi->s_resgid =3D EXT3_DEF_RESGID;

and

    SuperBlock() : s_mount_opt(0), s_resuid(EXT3_DEF_RESUID), s_resgid(EXT3=
_DEF_RESGID)
    {}

    ...
    sbi =3D new SuperBlock;
    if (!sbi)
        return -ENOMEM;

apart that you don't get members initalized twice and get a shorter code :).

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.16-jam9 (gcc 4.1.1 20060330 (prerelease)) #1 SMP PREEMPT Tue

--Sig_kBUjkrZJsttjK2f5DWPa0yz
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFETU4xRlIHNEGnKMMRAuoMAKCVSsESkrxxAiyYXS2+/GljU/laCwCgnCtD
6Ni1KLZ2WkSCPVghz/K7x/8=
=PgXW
-----END PGP SIGNATURE-----

--Sig_kBUjkrZJsttjK2f5DWPa0yz--
