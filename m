Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTJNXwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 19:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTJNXwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 19:52:47 -0400
Received: from tog-wakko4.prognet.com ([207.188.29.244]:19072 "EHLO virago")
	by vger.kernel.org with ESMTP id S261735AbTJNXwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 19:52:45 -0400
Date: Tue, 14 Oct 2003 16:52:13 -0700
From: Tom Marshall <tmarshall@real.com>
To: George Anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fw: missed itimer signals in 2.6
Message-ID: <20031014235213.GC860@real.com>
References: <20031013163411.37423e4e.akpm@osdl.org> <3F8C8692.5010108@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <3F8C8692.5010108@mvista.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Since the actual interval used by the system is a bit larger than what=20
> was asked for, there will be fewer ticks.

I understand what happens and why.  I admit that I'm not familiar with the
POSIX standard on this issue.  Questions:

 * I've heard that the kernel's timer resolution has increased from 10ms to
   1ms in 2.6.  Why does the itimer have such a large granularity?  I
   expected it to be highly accurate in this range.

 * Is this how the timer is supposed to work?  It seems to me that an
   algorithm which kept running track of the difference in requested and
   actual times (a la Bresenham) could make the itimer behave closer to what
   the user requested.

> Maybe you could save this code if it is part of a test suite....

This code is part of a "timer calibration" routine used by the RealNetworks
Helix Server.  I just noticed that the timer calibration failed on a machine
that had 2.6.0-test7 installed (we have not officially looked at supporting
2.6 yet).  The test runs on many different flavors of *nix (probably a dozen
or so).  I can check to see what the behavior is on the other platforms if
that would be useful.  If this is the Right Way to do timers, we'll probably
end up changing our "calibration" routine to read back the actual timer
interval as you suggest.

--=20
One good reason why computers can do more work than people is that they
never have to stop and answer the phone.

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jIwtqznSmcYu2m8RAvr9AKCQ2ip4lupQT4Lx5yt5+MTs4RVVSwCeLptv
7v0ylI1J768smJ2ZrqcN4sg=
=MCMU
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
