Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbTLZIqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 03:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbTLZIqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 03:46:44 -0500
Received: from coruscant.franken.de ([193.174.159.226]:45497 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S265094AbTLZIql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 03:46:41 -0500
Date: Fri, 26 Dec 2003 09:46:29 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2.6] fix pci_update_resource() / IORESOURCE_UNSET on PPC
Message-ID: <20031226084629.GD9391@obroa-skai.de.gnumonks.org>
References: <20031224111054.GB941@obroa-skai.de.gnumonks.org> <20031224200433.GC6577@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <20031224200433.GC6577@kroah.com>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.6.0-test11
X-Date: Today is Setting Orange, the 68th day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2003 at 12:04:33PM -0800, Greg KH wrote:
> On Wed, Dec 24, 2003 at 12:10:55PM +0100, Harald Welte wrote:
> > After investigating differences in the PCI code of 2.4.x and 2.6.x, i
> > noticed that 2.4.x/arc/ppc/kernel/pci.c:pcibios_update_resource()
> > contained a couple of lines that unset the IORESOURCE_UNSET bitflag.
> >=20
> > In 2.6.x, this is handled by the generic PCI core in
> > drivers/pci/setup-res.c:pci_update_resource() code.  However, the code
> > is missing the 'res->flags &=3D ~IORESOURCE_UNSET' part.
> >=20
> > The below fix re-adds that section from 2.4.x.=20
> >=20
> > I'm not sure wether this belongs into the arch-independent PCI api.
> > Anyway, on PPC it seems to be needed for certain cardbus devices.
>=20
> Is there any way you can add this to the ppc arch specific code, as
> that's the only platform that seems to want this, right?

AFAICT: Not a straight-forward one.  The reason seems to be that in
2.4.x every PCI arch implementation could specify it's own
update_resource() function, whereas in 2.6.x this is all handled by the
core.

A quick grep of the kernel source revealed that only
arch/ppc/kernel/pci.c ever sets an IORESOURCE_UNSET flag.  So there is
no possibility for non-ppc arch's of ever having set that flag.  Maybe
the overall PPC pci implementation could be changed... instead of
setting that flag in fixup_resources() and later on re-assigning the
resoure in update_resource(), we could directly re-assign the resource
in fixup_resources().

But remember, I'm a packet filter guy, not a PCI geek, nor a PPC
hardware geek.

Consider my original email as:=20

"I've found a problem, fixed it somehow (albeit not really knowing the
code I've touched). PPC and PCI guys, please review." =20

So if there is an arch-specific way of solving this in a different way,
BenH or the other LinuxPPC guys would know how.

I'm happy to test any proposed alternative fix and give feedback.

> thanks,
> greg k-h

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/6/VkXaXGVTD0i/8RAoQOAJ946xJpALG+q9HxKlUCYUCB/ijlMACfTixu
rZYPK1YMyqXaIoTzJ63iioc=
=3Fhv
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
