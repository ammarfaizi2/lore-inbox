Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVCYSf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVCYSf6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVCYSf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:35:58 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.34]:56468 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261735AbVCYSfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:35:46 -0500
Date: Fri, 25 Mar 2005 20:35:35 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH] driver core: Separate platform device name from platform device number
Message-ID: <20050325183534.GB4192@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	rmk+lkml@arm.linux.org.uk
References: <1110414879646@kroah.com> <11104148792069@kroah.com> <20050325180136.GA4192@linux-sh.org> <20050325181014.GA13436@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20050325181014.GA13436@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2005 at 10:10:14AM -0800, Greg KH wrote:
> > This might make sense for devices that end in numbers, but does it real=
ly
> > make sense for devices that don't?
>=20
> Then fix those drivers to not put the number in there if they don't have
> one :)
>=20
But they do have non -1 ids, the device name itself just doesn't end in a
number. In this event, the delimiter makes no sense.

These drivers are expecting that you will have <devicename><id>, and
application code is expecting the same. /dev follows this convention too,
I don't see this as being an unreasonable expectation.

If anything, serial8250 is broken and should rename itself to something
not ending in a number. It's not nice when one driver exhibits a corner
case and decides to change the semantics for everyone else.

> I don't see the serial8250 driver adding that .0 to it on my machines,
> does this happen on yours?
>=20
Yes, we end up having /sys/devices/platform/serial8250 and serial8250.0.
Where serial8250.0 ends up as:

drwxr-xr-x    3 0        0               0 Jan  1 00:00 .
drwxr-xr-x   18 0        0               0 Jan  1 00:00 ..
lrwxrwxrwx    1 0        0               0 Jan  1 00:00 bus -> ../../../bus=
/platform
-rw-r--r--    1 0        0            4096 Jan  1 00:00 detach_state
lrwxrwxrwx    1 0        0               0 Jan  1 00:00 driver -> ../../../=
bus/platform/drivers/serial8250
drwxr-xr-x    2 0        0               0 Jan  1 00:00 power

That doesn't really bother me, having serial8250.0 is more sensible then
serial82500. For this type of corner case the delimiter makes sense, but
not in a blanket sense.

> What userspace code are you referring to?
>=20
Anything that expects that it can open a /sys/devices/platform/<device><id>
path. I have a few applications like this, I have no reason to doubt that
others do too. I don't see any reason to go out of the way to break this
convention if the end of the device name is not a number.

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCRFn21K+teJFxZ9wRAiFsAJ9QbR2XDGiWdCFuUzPrtGZgJxB5bgCfZ81A
Z0Ty1vWeSxsZIqCjN2ttimQ=
=qX3G
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
