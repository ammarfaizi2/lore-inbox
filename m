Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310552AbSCGVRM>; Thu, 7 Mar 2002 16:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310550AbSCGVRD>; Thu, 7 Mar 2002 16:17:03 -0500
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:31187 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S310548AbSCGVQw>; Thu, 7 Mar 2002 16:16:52 -0500
Subject: Question regarding VFS programming
From: James D Strandboge <jstrand1@rochester.rr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-7iFnMa1fXaLTD7fXiJf2"
X-Mailer: Evolution/1.0.2 
Date: 07 Mar 2002 16:16:48 -0500
Message-Id: <1015535808.22604.14.camel@hedwig.strandboge.cxm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7iFnMa1fXaLTD7fXiJf2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I am playing around in the VFS code (fs/namei.c), and was wondering what
is the most efficient way of finding a child subdir if I already have
the mountpoint?  Currently I am doing somethine like:

        <... from_nd initialization ...>

	to =3D kmalloc(PATH_MAX,GFP_KERNEL);
        if (to =3D=3D NULL)
                goto rel_fnd;
        to[0] =3D '\0';=20

        /* build the to pathname */
        strcat (to, from_nd.dentry->d_sb->s_root->d_name.name);
        strcat (to, "/dir_to_find/");

        /* check if the directory exists */
        if (path_init(to, LOOKUP_POSITIVE, &to_nd))
                error =3D path_walk(to, &to_nd);
	if(!error)
		...

This seems totally inefficient to me, but I can't seem to find a better
method.  I do not want to go into the fs code (eg ext2, etc) for a
faster way-- I need to stay up high in VFS.

Thanks!

Jamie Strandboge

--=20
Email:        jstrand1@rochester.rr.com
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

--=-7iFnMa1fXaLTD7fXiJf2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAjyH2L8ACgkQqnXcviY4SjplsgCfVFgIrXjXwIxGASvc9h1kdABu
1n4An0LAziFgEv0VjA12IPBqTvzGYtB4
=4Rei
-----END PGP SIGNATURE-----

--=-7iFnMa1fXaLTD7fXiJf2--

