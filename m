Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVCYT6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVCYT6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVCYT6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:58:33 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:40398 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261769AbVCYT61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:58:27 -0500
Date: Fri, 25 Mar 2005 21:58:26 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: rmk+lkml@arm.linux.org.uk, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Separate platform device name from platform device number
Message-ID: <20050325195826.GC4192@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Kyle Moffett <mrmacman_g4@mac.com>, rmk+lkml@arm.linux.org.uk,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <1110414879646@kroah.com> <11104148792069@kroah.com> <20050325180136.GA4192@linux-sh.org> <20050325181014.GA13436@kroah.com> <20050325183534.GB4192@linux-sh.org> <5c0804da3486a6e735a46220d73c9637@mac.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <5c0804da3486a6e735a46220d73c9637@mac.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2005 at 02:38:22PM -0500, Kyle Moffett wrote:
> So how would you tell the difference between the following?
> 	device =3D "foobar0"
> 	id =3D -1
> 	path =3D "/sys/devices/platform/foobar0"
> versus
> 	device =3D "foobar"
> 	id =3D 0
> 	path =3D "/sys/devices/platform/foobar0"
>=20
Easy, we use the delimiter on anything ending with a number at the end of
the device name.. so for device =3D "foobar0", this would end up as
/sys/devices/platform/foobar0.0, whereas in the latter case this would
end up as /sys/devices/platform/foobar0.

The first case is a corner case, and really shouldn't happen that much in
practice outside of broken drivers.

> It's not as nice to add the extra period, but otherwise you end up with
> a lot of _extra_ special cases in both the kernel _and_ applications,
> which helps nobody.
>=20
No you don't, it's pretty easy to figure out that if the end of the
device name is a number that there will be a delimiter between that and
the id. This should be the exception, not the rule.

We don't go around changing /dev semantics everytime someone decides to
call their device something silly, I don't see why platform devices
should be treated differently, better to just fix the broken drivers..

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCRG1i1K+teJFxZ9wRAqxcAJ0ZsqeZoNyTuWJNNEG3UTU7IBFnHACfZq+h
+47V3OzkRtC18zByfFkBJZQ=
=AA4Z
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
