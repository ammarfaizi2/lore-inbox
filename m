Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTKIRux (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 12:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTKIRux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 12:50:53 -0500
Received: from draal.physics.wisc.edu ([128.104.222.75]:41150 "EHLO
	moya.mcelrath.org") by vger.kernel.org with ESMTP id S262747AbTKIRuv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 12:50:51 -0500
Date: Sun, 9 Nov 2003 09:44:36 -0800
From: Bob McElrath <bob+linux-kernel@mcelrath.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/rtc on alpha
Message-ID: <20031109174436.GA24812@mcelrath.org>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
References: <20031108213356.GD16295@mcelrath.org> <20031109142435.A4596@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20031109142435.A4596@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ivan Kokshaysky [ink@jurassic.park.msu.ru] wrote:
> On Sat, Nov 08, 2003 at 01:33:57PM -0800, Bob McElrath wrote:
> > Why is the alpha kernel code grabbing the rtc interrupt?  Is it possible
> > it share its use with a user program?  Would reprogramming the interrupt
> > rate by a user program do violence to some internel kernel timing?
>=20
> On most Alphas RTC is the system timer (running at 1024 Hz).
> So changing the interrupt rate from user space wouldn't be a good idea.

Then I propose CONFIG_RTC be set to "n" in the arch/alpha files, and the
/dev/rtc driver be disabled on alpha.  There seems to be confusion on
this point in the config files.  CONFIG_RTC is for the /dev/rtc driver.

Since the timer can only be set to powers of 2, it should be possible to
simulate getting the interrupt by calling the rtc.c interrupt handler
every 2^n interrupts...that way the user could program the timer for any
interval less than 1024 Hz.

Cheers,
Bob McElrath [Univ. of California at Davis, Department of Physics]

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/rn0EjwioWRGe9K0RAllwAJ9YYERjMwauQOf5QTVWP8ATK3PefQCfWB06
1WduJOqOUT2vSp0nuvk7XTU=
=Ov+I
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
