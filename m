Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270762AbTHGU1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270766AbTHGU1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:27:07 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:32470 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S270762AbTHGU1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:27:01 -0400
Date: Thu, 7 Aug 2003 13:26:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: devinit
Message-ID: <20030807202658.GD579@ip68-0-152-218.tc.ph.cox.net>
References: <3F315CDD.12EB17FE@hp.com> <20030806230919.GB8187@kroah.com> <3F318D73.3000809@pobox.com> <20030806233103.GA8497@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <20030806233103.GA8497@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2003 at 04:31:03PM -0700, Greg KH wrote:

> On Wed, Aug 06, 2003 at 07:21:23PM -0400, Jeff Garzik wrote:
> > Greg KH wrote:
> > >I've applied the 2.6 patch to my trees and will send it on to Linus in=
 a
> > >few days, thanks.
> >=20
> >=20
> > Speaking of PCI... are we gonna have to zap __devinit too?  Another=20
> > option is to think of add-new-pci-ids-on-the-fly as a CONFIG_HOTPLUG=20
> > feature, which should(?) maintain the current __devinit semantics: no=
=20
> > re-probes.
>=20
> Yeah, that option does break almost all current usages of __devinit* in
> pci drivers today with CONFIG_HOTPLUG disabled :(
>=20
> So either making it a different config option, or just dropping
> __devinit* all together is fine with me, one of them needs to happen.
>=20
> Any preferences from anyone else?

Make it an option.

> > OTOH, __devinit already is a no-op for CONFIG_HOTPLUG cases (read: most=
=20
> > everybody), so I wonder if we care enough about __devinit anymore?  I=
=20
> > used the same logic to support __devinitdata removal, after all.
>=20
> If we drop __devinit* then having CONFIG_HOTPLUG as a config option is
> almost pointless as it doesn't really affect much code at all.  Any
> objections to just always enabling it?
>=20
> Anyone want to make up any before and after memory usages with
> CONFIG_HOTPLUG enabled and disabled to see if it's really as small as
> I'm thinking it is? =20

Well, here's some numbers I came up with on 2.6.0-test2 on PPC.  I
picked 3 boards, EmbeddedPlanet 8260, IBM Spruce and IBM Walnut, made
the vmlinux (with an occasional fix here and there for other issues),
and came up with the following size changes (see arch/ppc/configs/ for
the base config).  From HOTPLUG=3Dn to HOTPLUG=3Dy, and with __devinit stuff
put in it's own section I got:
EmbeddedPlanet 8260 (PPC8260, CONFIG_PCI=3D=3Dn):
=2Etext: +2580
=2Eexit.text: same
=2Erodata: +104
__ksymtab: same
=2Edata: +352
=2Einit.text (excluding __devinit): same.
=2Einit.dev.text: 1692.
=2Einit.data vs .init.data: 84

IBM Spruce (PPC750):
=2Etext: +18528
=2Eexit.text: -300
=2Erodata: +956
__ksymstab: +96
=2Edata: +6816
=2Einit.text (excluding __devinit): +132
=2Einit.dev.text: 13032

IBM Walnut (PPC405):
=2Etext: +17648
=2Eexit.text: -300
=2Erodata: +1288
__ksymstab: +96
=2Edata: +5312
=2Einit.text (excluding __devinit): +128
=2Einit.dev.text: 10508

The 8260 board is almost all 'custom' drivers inside of arch/ppc (long
story) and don't make much use of __init-style markups.  The other
boards make use of more standard drivers, and have PCI.  Since this is
-test2, and not current BK I'm not sure how correct the .data figures
are now, but it looks like CONFIG_HOTPLUG adds ~13kB to a kernel.  So
how about stubbing things out if that makes it easier to code up hotplug
stuff (which can be important on some embedded devices too) so there's
choice?

--=20
Tom Rini
http://gate.crashing.org/~trini/

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/MrYSdZngf2G4WwMRAslAAJwK2qsmAhlB3u0ny6hS3TVn1fJ/2ACeP5xq
6+siQ/fTRecjcURXqelf7KQ=
=xsnz
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
