Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTLPRuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTLPRuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:50:10 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:22148 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261936AbTLPRtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:49:16 -0500
Subject: Re: PCI Express support for 2.4 kernel
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Martin Mares <mj@ucw.cz>
In-Reply-To: <3FDF3C6C.9030609@pobox.com>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>
	 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>
	 <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com>
	 <3FDDBDFE.5020707@intel.com>
	 <Pine.LNX.4.58.0312151154480.1631@home.osdl.org>
	 <3FDEDC77.9010203@intel.com>  <3FDF3C6C.9030609@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d7AGdRLsbjGx/GCwFG79"
Organization: Red Hat, Inc.
Message-Id: <1071596889.5223.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 16 Dec 2003 18:48:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d7AGdRLsbjGx/GCwFG79
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-16 at 18:10, Jeff Garzik wrote:

> > +	spin_lock_irqsave(&pci_config_lock, flags);
> > +	pci_exp_set_dev_base(bus, dev, fn);
> > +	switch (len) {
> > +	case 1:
> > +		writeb(value, addr);
> > +		break;
> > +	case 2:
> > +		writew(value, addr);
> > +		break;
> > +	case 4:
> > +		writel(value, addr);
> > +		break;
> > +	}
> > +	/* dummy read to flush PCI write */
> > +	readb(addr);
>=20
> This is going to choke some hardware, I guarantee.
>=20
> You always want to make sure your flush is of the same size at the=20
> write.  Reading a byte from an address that the hardware defines as=20
> "32-bit writes only" can get ugly real quick ;-)

also reading back addr might not be the best choice in case some
registers have side effects on reading, it's probably better to read
back an address that is known to be ok to read (like the vendor ID
field)


--=-d7AGdRLsbjGx/GCwFG79
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/30VZxULwo51rQBIRAuw+AKCadM3VptRJX+0onfsYwLZZFoiIlwCfSQGv
YR8PPLKQhIjluQUXzufYw4Q=
=xYnJ
-----END PGP SIGNATURE-----

--=-d7AGdRLsbjGx/GCwFG79--
