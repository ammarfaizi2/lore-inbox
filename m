Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264740AbTI2Ud4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 16:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264741AbTI2Ud4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 16:33:56 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:47089 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264740AbTI2Udx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 16:33:53 -0400
Subject: Re: [PATCH] ULL fixes for qlogicfc
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bla4fg$pbp$1@cesium.transmeta.com>
References: <E1A41Rq-0000NJ-00@hardwired> <20030929172329.GD6526@gtf.org>
	 <bla4fg$pbp$1@cesium.transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v4ZBVjP/82UaNrYNqJGN"
Organization: Red Hat, Inc.
Message-Id: <1064867628.5033.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 29 Sep 2003 22:33:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v4ZBVjP/82UaNrYNqJGN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-09-29 at 22:25, H. Peter Anvin wrote:
> Followup to:  <20030929172329.GD6526@gtf.org>
> By author:    Jeff Garzik <jgarzik@pobox.com>
> In newsgroup: linux.dev.kernel
> >
> > On Mon, Sep 29, 2003 at 06:04:34PM +0100, davej@redhat.com wrote:
> > > diff -urpN --exclude-from=3D/home/davej/.exclude bk-linus/drivers/scs=
i/qlogicfc.c linux-2.5/drivers/scsi/qlogicfc.c
> > > --- bk-linus/drivers/scsi/qlogicfc.c	2003-09-08 00:47:00.000000000 +0=
100
> > > +++ linux-2.5/drivers/scsi/qlogicfc.c	2003-09-08 01:30:56.000000000 +=
0100
> > > @@ -718,8 +718,8 @@ int isp2x00_detect(Scsi_Host_Template *=20
> > >  				continue;
> > > =20
> > >  			/* Try to configure DMA attributes. */
> > > -			if (pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff) &&
> > > -			    pci_set_dma_mask(pdev, (u64) 0xffffffff))
> > > +			if (pci_set_dma_mask(pdev, 0xffffffffffffffffULL) &&
> > > +			    pci_set_dma_mask(pdev, 0xffffffffULL))
> > >  					continue;
> >=20
> > Looks great.
> >=20
> > I wonder if you are motivated to create similar pci_set_dma_mask()
> > cleanups for other drivers?  ;-)  Several other drivers need this same
> > cleanup, too.
> >=20
>=20
> Dumb question: why marking these explicitly as ULL instead of letting
> the compiler do its usual promotion?

even dumbe question, why don't we provide ONE #define
PCI_DMA_MASK_64BIT that does it right....=20
and use that in all needed places
(of course we need a _32BIT one too)

--=-v4ZBVjP/82UaNrYNqJGN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/eJcsxULwo51rQBIRAuu0AJ42JKQN/90kcaaNUh+Cvv1wcjGwbACdEpG9
+/cMNWaxg1PEh5xh0QQLAK0=
=wXUy
-----END PGP SIGNATURE-----

--=-v4ZBVjP/82UaNrYNqJGN--
