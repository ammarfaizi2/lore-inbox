Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTKGWd1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTKGW1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:27:43 -0500
Received: from zeus.kernel.org ([204.152.189.113]:15062 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264540AbTKGV7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 16:59:39 -0500
Subject: Re: [Bug 1412] Copy from USB1 CF/SM reader stalls, no actual
	content is read (only directory structure)
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1068197144.21576.32.camel@ulysse.olympe.o2t>
References: <20031105084002.GX1477@suse.de>
	 <Pine.LNX.4.44L0.0311051013190.828-100000@ida.rowland.org>
	 <20031107082439.GB504@suse.de> <1068195038.21576.1.camel@ulysse.olympe.o2t>
	 <20031107090924.GB616@suse.de>
	 <1068197144.21576.32.camel@ulysse.olympe.o2t>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-S0Ak7LjWNGE5bkAVFq87"
Organization: Adresse personelle
Message-Id: <1068238928.4088.2.camel@m70.net81-64-235.noos.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 07 Nov 2003 22:02:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S0Ak7LjWNGE5bkAVFq87
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven 07/11/2003 =E0 10:25, Nicolas Mailhot a =E9crit :
> Le ven 07/11/2003 =E0 10:09, Jens Axboe a =E9crit :

> > Try with this debug patch then, does it work now?
> >=20
> > =3D=3D=3D=3D=3D drivers/scsi/scsi_lib.c 1.77 vs edited =3D=3D=3D=3D=3D
> > --- 1.77/drivers/scsi/scsi_lib.c	Tue Oct 14 09:28:06 2003
> > +++ edited/drivers/scsi/scsi_lib.c	Fri Nov  7 10:08:52 2003
> > @@ -1215,6 +1215,7 @@
> > =20
> >  u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)
> >  {
> > +#if 0
> >  	struct device *host_dev;
> > =20
> >  	if (shost->unchecked_isa_dma)
> > @@ -1229,6 +1230,9 @@
> >  	 * hardware have no practical limit.
> >  	 */
> >  	return BLK_BOUNCE_ANY;
> > +#else
> > +	return BLK_BOUNCE_HIGH;
> > +#endif
> >  }
> > =20
> >  struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)
>=20
> Will try this evening when I have physical access to the system. (It's
> difficult to plug a USB device via ssh;)

Well, it does work now (couldn't believe my eyes, tried three times in a
row just to be sure). Is this supposed to be a definitive fix that will
be in the next bk snapshots or should I wait for something else ?

Regards,

--=20
Nicolas Mailhot

--=-S0Ak7LjWNGE5bkAVFq87
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/rAhQI2bVKDsp8g0RArTkAKCnOc8VacZVHdHkdBCRMahWq3qdWwCfRKfu
Rbrj1xy6D29QUGhqG6Q3gno=
=ZPZ6
-----END PGP SIGNATURE-----

--=-S0Ak7LjWNGE5bkAVFq87--

