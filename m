Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUFAPHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUFAPHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUFAPHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:07:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6041 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265081AbUFAPGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:06:46 -0400
Subject: Re: Resume enhancement: restore pci config space
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Takashi Iwai <tiwai@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <s5hllj7qt7g.wl@alsa2.suse.de>
References: <20040526203524.GF2057@devserv.devel.redhat.com>
	 <20040530184031.GF997@openzaurus.ucw.cz>
	 <20040531133834.GA5834@devserv.devel.redhat.com>
	 <s5hllj7qt7g.wl@alsa2.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GxiWo+WemLM8kPvN49ta"
Organization: Red Hat UK
Message-Id: <1086102397.7500.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Jun 2004 17:06:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GxiWo+WemLM8kPvN49ta
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> int xxx_resume(struct pci_dev *dev)
> {
> 	int err;
> 	if ((err =3D pci_default_resume(dev)) < 0)
> 		return err;
> 	// ... do h/w specific
> }

well define "h/w specific", just give me an example of a real (alsa?)
driver that would use it (or point me to one) so that I can see if this
is the best API, what the return value should be etc etc=20
>=20
>=20
> but IMO, the jobs of pci_default_suspend/resume() should be applied
> always after/before calling driver's suspend/resume callbacks.

I would be very wary of unconditionally doing the resume thing without
the driver having had a chance to do it's thing. Imo the driver HAS to
be able to override stuff or at least talk to the hw before the generic
resume happens.


--=-GxiWo+WemLM8kPvN49ta
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAvJt9xULwo51rQBIRArpdAJ9F0yqKSQkbEA463bsZZzKbC29x9wCgq/B3
HEWjGg0k6kBq6VOSb8xUDSQ=
=gdLy
-----END PGP SIGNATURE-----

--=-GxiWo+WemLM8kPvN49ta--

