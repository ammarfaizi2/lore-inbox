Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVKKHCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVKKHCI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 02:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVKKHCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 02:02:07 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:1772 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751233AbVKKHCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 02:02:06 -0500
Subject: Re: latest mtd changes broke collie
From: Ian Campbell <ijc@hellion.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Todd Poynor <tpoynor@mvista.com>, linux-mtd@lists.infradead.org,
       David Woodhouse <dwmw2@infradead.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051111001617.GD9905@elf.ucw.cz>
References: <20051109221712.GA28385@elf.ucw.cz>
	 <4372B7A8.5060904@mvista.com> <20051110095050.GC2021@elf.ucw.cz>
	 <1131616948.27347.174.camel@baythorne.infradead.org>
	 <20051110103823.GB2401@elf.ucw.cz>
	 <1131619903.27347.177.camel@baythorne.infradead.org>
	 <20051110105954.GE2401@elf.ucw.cz>
	 <1131621090.27347.184.camel@baythorne.infradead.org>
	 <20051110224158.GC9905@elf.ucw.cz> <4373DEB4.5070406@mvista.com>
	 <20051111001617.GD9905@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AuRR8L0s3Oar1H47HN26"
Date: Fri, 11 Nov 2005 07:01:54 +0000
Message-Id: <1131692514.3525.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AuRR8L0s3Oar1H47HN26
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-11-11 at 01:16 +0100, Pavel Machek wrote:
> Hi!
>=20
> > >With these hacks, I'm able to mount flash at least read-only. On
> > >attempt to remount read-write, I get=20
> > >
> > >"Write error in obliterating obsoleted node at 0x00bc0000: -30
> > >...
> > >Erase at 0x00c00000 failed immediately: -EROFS. Is the sector locked?"
> > >
> > >Is it good news?
> >=20
> > I see the old sharp driver has a normally-not-defined AUTOUNLOCK symbol=
=20
> > that would enable some code to unlock blocks before writing/erasing=20
> > (which isn't recommended since the code doesn't know the policy on=20
> > whether the block is supposed to be locked).  The tree previously in us=
e=20
> > may have had something similar setup.  It seems these flashes have all=20
> > blocks locked by default at power up.
>=20
> Is there some quick hack I can do in kernel to unlock it?

I use the following on my device:

        mtd =3D do_map_probe(...);
       =20
        if (!mtd) { ...err... }
       =20
        mtd->owner =3D THIS_MODULE;
       =20
        mtd->unlock(mtd,0,mtd->size);
       =20
> Is it possible to accidentally unlock "BIOS" area and brick the device?

Yep, but you could modify the parameters to unlock to no do so.
Depending on you partitioning scheme you might be able to use that to
figure out what to unlock...

Ian.

--=20
Ian Campbell

The most exciting phrase to hear in science, the one that heralds new
discoveries, is not "Eureka!" (I found it!) but "That's funny ..."
		-- Isaac Asimov

--=-AuRR8L0s3Oar1H47HN26
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDdEHiM0+0qS9rzVkRAj6sAJ9EL16qd0r1PMIJSuyhiVjHqLw3gQCg4jHP
yE93xTi9mMYs7+O5fLnL56I=
=UVyC
-----END PGP SIGNATURE-----

--=-AuRR8L0s3Oar1H47HN26--

