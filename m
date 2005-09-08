Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVIHUnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVIHUnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbVIHUnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:43:53 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:45031 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S1751388AbVIHUnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:43:52 -0400
Date: Thu, 8 Sep 2005 13:43:45 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jim Ramsay <jim.ramsay@gmail.com>
Cc: linux-usb-users@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [Linux-usb-users] Possible bug in usb storage (2.6.11 kernel)
Message-ID: <20050908204345.GB3196@one-eyed-alien.net>
Mail-Followup-To: Jim Ramsay <jim.ramsay@gmail.com>,
	linux-usb-users@lists.sourceforge.net,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
References: <4789af9e05090810142bd3531d@mail.gmail.com> <20050908175852.GA3196@one-eyed-alien.net> <4789af9e05090812521d9d687b@mail.gmail.com> <4789af9e05090813287f05e12a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <4789af9e05090813287f05e12a@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2005 at 02:28:09PM -0600, Jim Ramsay wrote:
> On 9/8/05, Jim Ramsay <jim.ramsay@gmail.com> wrote:
> > On 9/8/05, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> > > On Thu, Sep 08, 2005 at 11:14:36AM -0600, Jim Ramsay wrote:
> > > > I think I have found a possible bug:
> > > > [...]
> > > > I suppose the scsi code could be changed to guarantee that
> > > > srb->request_buffer is page-aligned or cache-aligned, but that seems
> > > > like the wrong solution for this bug.
> > >
> > > Fixing the SCSI layer is -exactly- the correct solution.  The SCSI la=
yer is
> > > supposed to guarantee us that those buffers are suitable for DMA'ing,=
 and
> > > apparently it's violating that promise.
> >=20
> > Thanks, I'll check on what buffer I'm actually getting, where it's
> > allocated, and post back what I find, or how I fixed it.
>=20
> More information:
>=20
> The error only occurrs during device sensing when the
> srb->request_buffer is assigned as follows, by usb/storage/transport.c
> in the routine usb_stor_invoke_transport:
>=20
> old_request_buffer =3D srb->request_buffer;
> srb->request_buffer =3D srb->sense_buffer;
>=20
> Now, this is a problem because srb->sense_buffer is defined as follows
> in the struct scsi_cmnd:
>=20
> #define SCSI_SENSE_BUFFERSIZE   96
>         unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE];
>=20
> Since it is not allocated at runtime there is NO WAY the SCSI layer
> can possibly guarantee it is page- or cache-aligned and ready for DMA.
>=20
> Any suggestions on best fix for this?  Is it still a SCSI-layer issue?
>  Or should USB step up in this case and ensure this buffer is dma-safe
> itself?

Ah, that buffer doesn't come from SCSI (tho I've long thought they should
provide us with a sense data buffer).  So this is a real usb-storage bug.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

What, are you one of those Microsoft-bashing Linux freaks?
					-- Customer to Greg
User Friendly, 2/10/1999

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDIKKBHL9iwnUZqnkRAvTjAJ9OHrIYeHE7to8yWHF7NImA8o7NgACdF9LS
o2NPzfcGF4CinxqR7PEKEUY=
=LM5m
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
