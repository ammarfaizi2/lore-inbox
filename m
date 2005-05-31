Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVEaIGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVEaIGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 04:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVEaIGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 04:06:31 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:63136 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261358AbVEaIGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 04:06:11 -0400
Date: Tue, 31 May 2005 10:06:10 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG] oops while completing async USB via usbdevio
Message-ID: <20050531080609.GI25536@sunbeam.de.gnumonks.org>
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org> <20050530212641.GE25536@sunbeam.de.gnumonks.org> <200505310107.03747.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Content-Disposition: inline
In-Reply-To: <200505310107.03747.oliver@neukum.org>
User-Agent: mutt-ng 1.5.8-r168i (Debian)
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tue, May 31, 2005 at 01:07:03AM +0200, Oliver Neukum
	wrote: > > > and it prints "p->sighand == NULL" every time I exit a
	program while > > using the usbdevio based driver. > > > >
	consequently, the following patch 'fixed' the problem. Please do not >
	> consider this as a real fix, since there's certainly still a race > >
	condition left. Please use it as a hint to correctly fix the problem. >
	> It would be cleaner to terminate all URBs a task has submitted when
	the > task terminates. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2005 at 01:07:03AM +0200, Oliver Neukum wrote:
>=20
> > and it prints "p->sighand =3D=3D NULL" every time I exit a program while
> > using the usbdevio based driver.
> >=20
> > consequently, the following patch 'fixed' the problem.  Please do not
> > consider this as a real fix, since there's certainly still a race
> > condition left.   Please use it as a hint to correctly fix the problem.
>=20
> It would be cleaner to terminate all URBs a task has submitted when the
> task terminates.

so for every task termination, we do a linear search over the global
list of pending URB's and terminate those where urb->task =3D=3D
taks_to_kill?  Sounds a bit expensive, especially since you don't know
(before iteration) whether that task has actually ever dealt with
usbdevio or not.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCnBrxXaXGVTD0i/8RAuAnAJ9uwM00uSL0x6av1iI1O6deh9jxlgCfaMKz
AZ1EwcU1IYKzxbfhVZcfm8U=
=CCvg
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--
