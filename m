Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWB0S1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWB0S1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWB0S1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:27:10 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:27779 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750727AbWB0S1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:27:09 -0500
Subject: Re: [PATCH] Revert sky2 to 0.13a
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: Stephen Hemminger <shemminger@osdl.org>
Cc: woho@woho.de, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060227091837.3c214435@localhost.localdomain>
References: <4400FC28.1060705@gmx.net> <200602270003.46353.woho@woho.de>
	 <20060227080042.0cf3f05d@localhost.localdomain>
	 <200602271738.38675.woho@woho.de>
	 <20060227091837.3c214435@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-abOhmutKglUVrWgsVTtL"
Date: Mon, 27 Feb 2006 19:27:21 +0100
Message-Id: <1141064841.23375.36.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-abOhmutKglUVrWgsVTtL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-02-27 at 09:18 -0800, Stephen Hemminger wrote:
> On Mon, 27 Feb 2006 17:38:38 +0100
> Wolfgang Hoffmann <woho@woho.de> wrote:
> > On Monday 27 February 2006 17:00, Stephen Hemminger wrote:
> > 2.6.16-rc5 with disable_msi=3D1 works for me, no hangs seen so far. I r=
synced 80=20
> > GB of data, thats about 5-10 times more than I typically need to reprod=
uce a=20
> > hang, so it seems to be solid. For the record: 2.6.16-rc5 with disable_=
msi=3D0=20
> > does hang.
> >=20
> > I have not seen the memory trashing others reported, with no version I =
tested=20
> > so far. Maybe my scenario is not likely to trigger this, so I can't tel=
l.
> >=20
> > Unless a fix for msi is at hand, may I suggest for 2.6.16 to revert the=
 msi=20
> > commit or switch the default to disable_msi=3D1?
> >=20
> > I've updated bugzilla #6084 accordingly.
>=20
> Okay, then what I need is lspci -v of all systems that have the problem, =
I'll make
> a blacklist (or update PCI quirks). I suspect that MSI doesn't work for a=
ny devices
> on these systems, or MSI changes the timing enough to expose existing rac=
es.

Am i just tired from trying to make XSLT to do something unnatural or is
there something odd going on in msi.c?

static void msi_set_mask_bit(unsigned int vector, int flag)
{
        struct msi_desc *entry;

        entry =3D (struct msi_desc *)msi_desc[vector];
        if (!entry || !entry->dev || !entry->mask_base)
                return;
        switch (entry->msi_attrib.type) {
        case PCI_CAP_ID_MSI:
        {
                int             pos;		<=3D=3D
                u32             mask_bits;

                pos =3D (long)entry->mask_base;	<=3D=3D
...

Doesn't that mean that we, a: read 64 bit from memory. b: save it in a
32 bit area?

(esp since it seems to be a address pointer, which could also be using
higher memory areas... but then i dunno what a void __iomem * is, but i
assume that it will be 64 bits here =3D))

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-abOhmutKglUVrWgsVTtL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1-ecc0.1.6 (GNU/Linux)

iD8DBQBEA0SJ7F3Euyc51N8RArYzAKCWSgcdnJ+sAP/+0+itzllaOFI3SQCgrW/1
C7DwGr6NIZnK/AoX1x7e4x0=
=2ZhW
-----END PGP SIGNATURE-----

--=-abOhmutKglUVrWgsVTtL--

