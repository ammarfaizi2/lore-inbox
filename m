Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbWCIEfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbWCIEfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWCIEfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:35:53 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:50108 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932671AbWCIEfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:35:53 -0500
Date: Thu, 9 Mar 2006 15:34:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: filldir[64] oddness
Message-Id: <20060309153453.0027649a.sfr@canb.auug.org.au>
In-Reply-To: <20060309042744.GA23148@redhat.com>
References: <20060309042744.GA23148@redhat.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__9_Mar_2006_15_34_53_+1100_3J+a5QWJo4mN35em"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__9_Mar_2006_15_34_53_+1100_3J+a5QWJo4mN35em
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Mar 2006 23:27:44 -0500 Dave Jones <davej@redhat.com> wrote:
>
> I'm puzzled by an aparent use of uninitialised memory
> that coverity's checker picked up.
>=20
> fs/readdir.c
>=20
> #define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
> #define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
>=20
> 140  	static int filldir(void * __buf, const char * name, int namlen, lof=
f_t offset,
> 141  			   ino_t ino, unsigned int d_type)
> 142  	{
> 143  		struct linux_dirent __user * dirent;
> 144  		struct getdents_callback * buf =3D (struct getdents_callback *) __=
buf
> 145  		int reclen =3D ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);
>=20
> How come that NAME_OFFSET isn't causing an oops when
> it dereferences stackjunk->d_name ?

because d_name is an array, so the reference is really &(dirent->d_name[0])=
 and no
dereference occurs ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__9_Mar_2006_15_34_53_+1100_3J+a5QWJo4mN35em
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFED7BtFdBgD/zoJvwRAlVkAJ9+m0ooBFOJg1BvdoIlK4VmGIskMwCgnYET
iUDJAbqiMGPO2ZTxm27JzDA=
=bjDD
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Mar_2006_15_34_53_+1100_3J+a5QWJo4mN35em--
