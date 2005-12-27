Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVL0M4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVL0M4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 07:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVL0M4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 07:56:42 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:12466 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1750706AbVL0M4l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 07:56:41 -0500
Date: Tue, 27 Dec 2005 13:55:04 +0100
From: Jules Villard <jvillard@ens-lyon.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
Message-ID: <20051227125504.GA11838@blatterie>
References: <20051226194527.GA3036@blatterie> <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org> <1135641618.4780.3.camel@localhost.localdomain> <20051227012053.GB9771@blatterie> <1135646828.4780.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <1135646828.4780.10.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le mar, 27 d=E9c 2005 12:27:08 +1100, Benjamin Herrenschmidt a =E9crit :
>=20
> > > Also, does it work if you don't use radeonfb ? radeonfb shouldn't tou=
ch
> > > MC_AGP_LOCATION and the DRM change only affects that, so I'm a bit
> > > surprised.
> > >=20
> > > Ben.
> > >=20
> >=20
> > Do you still want me to try that now that reverting the two patches
> > made the job?
>=20
> Definitely, and we need to figure out why the patch cause a regression.
> Those patches fixes a serious issues with a number of machines.

Removing radeonfb from the kernel only makes things worse: the box
gets completly frozen when reproducing the bug (no more ssh access nor
sysrq).

>=20
> The problem is very nasty as all the various parties involved (radeonfb,
> X radeon driver, radeon DRM, etc...) all try to reconfigure the card
> memory map in differently bogus ways...
>=20
> Can you add printk's to the kernel to check the values in
> CONFIG_MEMSIZE, CONFIG_APER_SIZE, priv->fb_location and the values
> calculated for gart_vm_start ? Then tell me what that printk gets on X
> start and when switching consoles.

I get these figures when I first start X:
[  104.399101] ### fb_location is now e0000000
[  104.399104] ### mem_size is 2000000
[  104.399107] ### aper_size is 4000000
[  104.399109] ### gart_vm_start is e2000000

The sad thing is that it looks like the crash occurs *before* entering
the radeon_do_init_cp function, assuming it should enter it again when
I switch back from a tty to X (I've put some printk's at the
beginning of the function but didn't see them in dmesg although other
things showed up), so I don't know where to put the printk's in order
to get other figures...

Thanks,

Jules

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFDsTmopBRla5yeL58RAhBGAJ9asB6AFel8ctCnmaL+tSa/fGEWBACeMgkd
LkM8mpscA3w6G0WwJFY7Fag=
=YksF
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
