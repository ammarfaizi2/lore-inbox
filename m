Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbTKGWCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbTKGWA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:00:28 -0500
Received: from smtp2.clb.oleane.net ([213.56.31.18]:53161 "EHLO
	smtp2.clb.oleane.net") by vger.kernel.org with ESMTP
	id S263973AbTKGJZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:25:58 -0500
Subject: Re: [Bug 1412] Copy from USB1 CF/SM reader stalls, no actual
	content is read (only directory structure)
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031107090924.GB616@suse.de>
References: <20031105084002.GX1477@suse.de>
	 <Pine.LNX.4.44L0.0311051013190.828-100000@ida.rowland.org>
	 <20031107082439.GB504@suse.de> <1068195038.21576.1.camel@ulysse.olympe.o2t>
	 <20031107090924.GB616@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I9GActTLtSLpPd9uelT5"
Organization: Adresse personnelle
Message-Id: <1068197144.21576.32.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 07 Nov 2003 10:25:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I9GActTLtSLpPd9uelT5
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven 07/11/2003 =E0 10:09, Jens Axboe a =E9crit :
> On Fri, Nov 07 2003, Nicolas Mailhot wrote:
> > Le ven 07/11/2003 =E0 09:24, Jens Axboe a =E9crit :
> > > On Wed, Nov 05 2003, Alan Stern wrote:
> >=20
> > > > In any case, it quite likely _does_ point to a driver bug.  But sin=
ce
> > > > sddr09_read_data() was handed this sg entry and didn't change it, i=
f there
> > > > is such a bug it must lie in a higher-level driver.  Maybe the scsi=
 layer,=20
> > > > maybe the block layer, maybe the memory-management system, maybe th=
e file=20
> > > > system.  That was my original point.
> > >=20
> > > Well, the sg entry looks perfectly valid. And that was my original
> > > point :-). And that is why I said it looks like a driver bug, not in
> > > upper layers. How much memory did the system that crashed have? If th=
e
> > > system has highmem, try testing with scsi_calculate_bounce_limit()
> > > unconditionally returning BLK_BOUNCE_HIGH.
> >=20
> > The system has 1 GiB of memory, ie just enough to make stuff like
> > radeonfb fail
>=20
> Try with this debug patch then, does it work now?
>=20
> =3D=3D=3D=3D=3D drivers/scsi/scsi_lib.c 1.77 vs edited =3D=3D=3D=3D=3D
> --- 1.77/drivers/scsi/scsi_lib.c	Tue Oct 14 09:28:06 2003
> +++ edited/drivers/scsi/scsi_lib.c	Fri Nov  7 10:08:52 2003
> @@ -1215,6 +1215,7 @@
> =20
>  u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)
>  {
> +#if 0
>  	struct device *host_dev;
> =20
>  	if (shost->unchecked_isa_dma)
> @@ -1229,6 +1230,9 @@
>  	 * hardware have no practical limit.
>  	 */
>  	return BLK_BOUNCE_ANY;
> +#else
> +	return BLK_BOUNCE_HIGH;
> +#endif
>  }
> =20
>  struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)

Will try this evening when I have physical access to the system. (It's
difficult to plug a USB device via ssh;)

Cheers,

--=20
Nicolas Mailhot

--=-I9GActTLtSLpPd9uelT5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/q2UXI2bVKDsp8g0RAjQZAJ0TOLz4TB1xCwBTNFu52pUT6eY2bwCgqKYT
xAc7yy6trAv8D4bNGC504GE=
=z14l
-----END PGP SIGNATURE-----

--=-I9GActTLtSLpPd9uelT5--

