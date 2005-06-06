Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVFFQGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVFFQGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 12:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVFFQGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 12:06:17 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:48048 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261225AbVFFQFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 12:05:36 -0400
Date: Mon, 6 Jun 2005 18:05:31 +0200
From: Harald Welte <laforge@gnumonks.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BUG] oops while completing async USB via usbdevio
Message-ID: <20050606160531.GG6596@sunbeam.de.gnumonks.org>
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org> <200505301555.39985.david-b@pacbell.net> <20050531084852.GJ25536@sunbeam.de.gnumonks.org> <200505311153.24747.david-b@pacbell.net> <20050531221258.GI29780@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"
Content-Disposition: inline
In-Reply-To: <20050531221258.GI29780@sunbeam.de.gnumonks.org>
User-Agent: mutt-ng 1.5.8-r168i (Debian)
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Wed, Jun 01, 2005 at 12:12:58AM +0200, Harald Welte
	wrote: > > > Wouldn't it help to associate the URB with the file
	(instaed of the > > > task), and then send the signal to any task that
	still has opened the > > > file? I'm willing to hack up a patch, if
	this is considered a sane fix. > > > > Sounds reasonable, except that
	not all such tasks will want the signal. > > Though I guess the
	infrastructure to filter the signal out already exists, > > so the main
	missing piece is that urb-to-file binding. > > Ok, I'll get something
	coded shortly. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 01, 2005 at 12:12:58AM +0200, Harald Welte wrote:

> > > Wouldn't it help to associate the URB with the file (instaed of the
> > > task), and then send the signal to any task that still has opened the
> > > file?  I'm willing to hack up a patch, if this is considered a sane f=
ix.
> >=20
> > Sounds reasonable, except that not all such tasks will want the signal.
> > Though I guess the infrastructure to filter the signal out already exis=
ts,
> > so the main missing piece is that urb-to-file binding.
>=20
> Ok, I'll get something coded shortly.

Unfortunately this approach is not feasible, since there is no 'reverse
mapping' from a file to a process.  So for every URB delivery, we would
have to walk that task_list and check which tasks have opened this file.

So what do we do now?

A reimplementation of async URB handling (probably use the AIO code)
=66rom userspace is a significant amount of work.

Meanwhile, this bug allows any regular non-root userspace program with
access to a single USB device to oops the kernel, so a short-term fix is
definitely required for security reasons.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCpHRLXaXGVTD0i/8RArx1AJ49FB23gkmgVZ+xjntw8CiWL8HsYACgoQOl
lVMY8Q3lEL9o9d70XvbpQGw=
=Rmdw
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--
