Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264370AbUD0WOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbUD0WOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUD0WOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:14:51 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:8601 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S264370AbUD0WOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:14:48 -0400
Date: Tue, 27 Apr 2004 15:14:46 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] Implementation inconsistencies in 2.6.3
Message-ID: <20040427221446.GA2662@one-eyed-alien.net>
Mail-Followup-To: Ken Ashcraft <ken@coverity.com>,
	linux-kernel@vger.kernel.org
References: <4448.171.64.70.113.1083102442.spork@webmail.coverity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <4448.171.64.70.113.1083102442.spork@webmail.coverity.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2004 at 02:47:22PM -0700, Ken Ashcraft wrote:
> I'm trying to cross check implementations of the same interface for
> errors.  I assume that if functions are assigned to the same function
> pointer, they are implementations of a common interface and should be
> consistent with each other.  For example, if one implementation checks one
> of its arguments for NULL, the other implementation should also check that
> argument for NULL.
>=20
> In this case, I'm looking at which arguments are referenced at all in the
> implementation.  If we have 10 implementations and 9 of them read argument
> 1 and the 10th fails to read argument 1, the 10th implementation may be
> missing some code.  In each of the reports below, I give an example
> implementation that does read the argument.  That is followed by an
> implementation that fails to read the argument.
>=20

> ---------------------------------------------------------
> [BUG] (mdharm-usb@one-eyed-alien.net) looks like it should return count
> instead of strlen(buf), but this is in scsiglue.c, so is it special code?
>=20
> example:
> /home/kash/linux/2.6.3/linux-2.6.3/drivers/scsi/scsi_sysfs.c:274:store_re=
scan_field:
> NOTE:READ: Checking arg count [EXAMPLE=3Ddevice_attribute.store-2]
>=20
> /home/kash/linux/2.6.3/linux-2.6.3/drivers/usb/storage/scsiglue.c:321:sto=
re_max_sectors:
> ERROR:READ: Not checking arg [COUNTER=3Ddevice_attribute.store-2]  [fit=
=3D1]
> [fit_fn=3D1] [fn_ex=3D0] [fn_counter=3D1] [ex=3D233] [counter=3D1] [z =3D
> 3.20943839741638] [fn-z =3D -4.35889894354067]
>=20
> 	return sprintf(buf, "%u\n", sdev->request_queue->max_sectors);
> }
>=20
> /* Input routine for the sysfs max_sectors file */
>=20
> Error --->
> static ssize_t store_max_sectors(struct device *dev, const char *buf,
> 		size_t count)
> {
> 	struct scsi_device *sdev =3D to_scsi_device(dev);

My understanding was that I was supposed to return the number of bytes in
the buffer that I actually used.  I thought 'count' was the maximum size I
could use.

Is that not the case?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Oh great modem, why hast thou forsaken me?
					-- Dust Puppy
User Friendly, 3/2/1998

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAjttWIjReC7bSPZARAl/WAKC5HQMB6udjJzukNpZAOJJT6t/z/QCghUAO
b1ZiZeimWGeqUYS/7tzDn/w=
=DCeb
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
