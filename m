Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbTJNIbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 04:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTJNIbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 04:31:13 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:11247 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262002AbTJNIbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 04:31:10 -0400
Subject: Re: gcc -msoft-float [Was: Linux 2.6.0-test7 - stability freeze]
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Olaf Hering <olh@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031014081228.GA23257@suse.de>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
	 <20031013173446.GA13186@suse.de> <20031013205039.GA1638@mars.ravnborg.org>
	 <20031014081228.GA23257@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-B91Y4SXULeyYPRscCiSN"
Organization: Red Hat, Inc.
Message-Id: <1066120260.5241.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Tue, 14 Oct 2003 10:31:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-B91Y4SXULeyYPRscCiSN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-14 at 10:12, Olaf Hering wrote:
>  On Mon, Oct 13, Sam Ravnborg wrote:
>=20
> > On Mon, Oct 13, 2003 at 07:34:46PM +0200, Olaf Hering wrote:
> > > a longstanding bug, should probably go to the main Makefile. But I do=
nt
> > > know if all supported archs know about -msoft-float.
> >=20
> > Could you please elaborate about what this fixes.
> > I'm very resistant to add new flags unconditionally to gcc at this stag=
e.
>=20
> Is floating point in the kernel really allowed on i386? If so, please
> please add a commet to this Makefile about this fact.=20
>=20
> test7bk3 results, allyesconfig:
>=20
>=20
> drivers/built-in.o(.text+0x2ba129): In function `amd8111e_resume':
> drivers/net/amd8111e.c:1700: undefined reference to `__floatsidf'

real bug:
        if(lp->options & OPTION_DYN_IPG_ENABLE)
                mod_timer(&lp->ipg_data.ipg_timer,
                                jiffies + (IPG_CONVERGE_TIME * HZ));
=20
where=20
#define      IPG_CONVERGE_TIME 0.5

> drivers/media/dvb/ttpci/av7110.c:2709: undefined reference to `__floatsid=
f'

worse:
       if (freq < 16*168.25 )
                config =3D 0xa0;
        else if (freq < 16*447.25)
                config =3D 0x90;
        else
                config =3D 0x30;

> drivers/built-in.o(.text+0x5c24d0): In function `sisfb_do_set_var':
> drivers/video/sis/sis_main.c:654: undefined reference to `__floatsidf'


static int sisfb_do_set_var(struct fb_var_screeninfo *var, int isactive,
                      struct fb_info *info)
{
        unsigned int htotal =3D
                var->left_margin + var->xres + var->right_margin +
                var->hsync_len;
        unsigned int vtotal =3D 0;
        double drate =3D 0, hrate =3D 0;
=20
ugh


--=-B91Y4SXULeyYPRscCiSN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/i7RDxULwo51rQBIRAroVAJ0UtfgpTlqpwxIIjGewP5H0KfQnhgCfTLxo
jOvaj/CzasV6r2rM8E+SJ7Q=
=ke0s
-----END PGP SIGNATURE-----

--=-B91Y4SXULeyYPRscCiSN--
