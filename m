Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWERK6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWERK6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 06:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWERK6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 06:58:46 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:48023 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751295AbWERK6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 06:58:45 -0400
Date: Thu, 18 May 2006 12:58:41 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: openezx-devel@lists.gnumonks.org, linux-kernel@vger.kernel.org,
       "Michael 'Mickey' Lauer" <mickey@tm.informatik.uni-frankfurt.de>
Subject: Re: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
Message-ID: <20060518105841.GW17897@sunbeam.de.gnumonks.org>
References: <20060518070700.GT17897@sunbeam.de.gnumonks.org> <1147945947.20943.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xnH/NIbSm9ew9GxF"
Content-Disposition: inline
In-Reply-To: <1147945947.20943.22.camel@localhost.localdomain>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xnH/NIbSm9ew9GxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

thanks for your prompt reply.

On Thu, May 18, 2006 at 10:52:27AM +0100, Richard Purdie wrote:
> Hi,
>=20
> On Thu, 2006-05-18 at 09:07 +0200, Harald Welte wrote:
> > 0) What kind of X/Y/Pressure values should I return?  Are they supposed
> >    to be scaled to the X/Y resolution of the LCD?  As of now, I return
> >    X_ABS, Y_ABS and PRESSURE values between 0 and 1000 (each).
> >=20
> >    However, the coordinates are actually inverted, so '0,0' corresponds
> >    to the lower right corner of the screen, whereas '1000,1000' is the
> >    upper left corner.  Shall I invert them (i.e. return 1000-coord')?
>=20
> Just send the raw data to userspace. Any translations needed can be
> handled in userspace by the calibration program. You probably want to
> have a look at tslib: http://cvs.arm.linux.org.uk/cgi/viewcvs.cgi/tslib/

ok, I'll investigate. Thanks for the hint.

> The range of the values also doesn't really matter and scaling would
> again get handled in userspace.

ok.

> Calibration happens in userspace and tslib stores the result
> in /etc/pointercal. If you device has this data stored in hardware, you
> could have a userspace app translate that data into such a file,
> otherwise, you can run a calibration program such as ts_calibrate (from
> tslib) or something like xtscal.

well, I guess re-calibrating using ts_calibrate will be easier than
trying to understand the proprietary calibration data format.

> If the user is pressing the screen at all, its a button event and
> release is when they stop touching the screen. I'd try not to make it
> depend upon pressure but it will depend on the hardware to a degree.

ok.  I have observed that this specific  hardware sometimes indicates a
pressure of '1' (out of a rage ~ 0...1000) even if the screen is not
pressed.  So I think there should be some level (maybe 10/20), only
after this level of pressure has been reached it should report a button
press.
=20
> Admittedly, tslib doesn't do much with pressure information at the
> moment but tslib would the the correct place to handle pressure rather
> than have every kernel touchscreen driver doing it.

ok, i see.  perfectly makes sense.

> For debugging, I'd highly recommend the test tools in tslib (ts_print,
> ts_calibrate and ts_test). Use them in that order, checking for sane
> output with ts_print first, get a working calibration second and finally
> prove its working with ts_test. I found them to be very useful when
> developing corgi_ts.

thanks again, will do so later today.

> I'm told you're thinking about using OpenEmbedded and would highly
> recommend it. It should easily be able to provide a known working
> userspace with tslib and these tools in.

yes, I've actually managed to do a full task-bootstrap and task-gpe for
the device now (cross-compiled from my linuxppc64 quad-g5), and was
quite amazed that it almost worked out of the box.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
We all know Linux is great...it does infinite loops in 5 seconds. -- Linus

--xnH/NIbSm9ew9GxF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEbFNhXaXGVTD0i/8RAiBiAJ9YbBzjfwPVtt1a0TW1VYTrtcUCJACcCjZP
5rfBvvQnSHQwH9vIKhjSi30=
=+36j
-----END PGP SIGNATURE-----

--xnH/NIbSm9ew9GxF--
