Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752489AbWAFWYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbWAFWYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbWAFWYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:24:54 -0500
Received: from smtp06.auna.com ([62.81.186.16]:6841 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1752489AbWAFWYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:24:53 -0500
Date: Fri, 6 Jan 2006 23:28:37 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Warnings on void* arithmetic
Message-ID: <20060106232837.03bcacc3@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 1.9.100cvs125 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_9CykI.Y8D4ML+Iv=9l.t.As";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.223.226] Login:jamagallon@able.es Fecha:Fri, 6 Jan 2006 23:24:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_9CykI.Y8D4ML+Iv=9l.t.As
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi...

Building the nVidia driver gives this couple warnings. I send them just
to see if they are real bugs or not.

include/linux/prefetch.h: In function =E2=80=98prefetch_range=E2=80=99:
include/linux/prefetch.h:62: warning: pointer of type =E2=80=98void *=E2=80=
=99 used in arithmetic

static inline void prefetch_range(void *addr, size_t len)
                                  ^^^^^^
{
#ifdef ARCH_HAS_PREFETCH
    char *cp;
    char *end =3D addr + len; <<<<<<<<<<<<<

    for (cp =3D addr; cp < end; cp +=3D PREFETCH_STRIDE)
        prefetch(cp);
#endif
}


include/asm/io.h: In function =E2=80=98check_signature=E2=80=99:
include/asm/io.h:258: warning: wrong type argument to increment

static inline int check_signature(volatile void __iomem * io_addr,
                                           ^^^^^^^^^^^^^^
    const unsigned char *signature, int length)
{
    int retval =3D 0;
    do {
        if (readb(io_addr) !=3D *signature)
            goto out;
        io_addr++;    <<<<<<<<<<<<<<<<<<<
        signature++;
        length--;
    } while (length);
    retval =3D 1;
out:
    return retval;
}


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam1 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_9CykI.Y8D4ML+Iv=9l.t.As
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDvu8bRlIHNEGnKMMRArwcAJ0bGBxprDB48CHraa2WNTfavK+0OgCeLS15
ajhPd03Sx3kQf1I6EhoVphU=
=C9nm
-----END PGP SIGNATURE-----

--Sig_9CykI.Y8D4ML+Iv=9l.t.As--
