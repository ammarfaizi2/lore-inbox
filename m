Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTJOQuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbTJOQut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:50:49 -0400
Received: from tog-wakko4.prognet.com ([207.188.29.244]:46977 "EHLO virago")
	by vger.kernel.org with ESMTP id S263612AbTJOQur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:50:47 -0400
Date: Wed, 15 Oct 2003 09:50:16 -0700
From: Tom Marshall <tmarshall@real.com>
To: George Anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fw: missed itimer signals in 2.6
Message-ID: <20031015165016.GA2167@real.com>
References: <20031013163411.37423e4e.akpm@osdl.org> <3F8C8692.5010108@mvista.com> <20031014235213.GC860@real.com> <3F8D63AA.9000509@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <3F8D63AA.9000509@mvista.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >I understand what happens and why.  I admit that I'm not familiar with t=
he
> >POSIX standard on this issue.  Questions:
> >
> > * I've heard that the kernel's timer resolution has increased from 10ms=
 to
> >   1ms in 2.6.  Why does the itimer have such a large granularity?  I
> >   expected it to be highly accurate in this range.
>=20
> I think it is.  The missing understanding is, I think, that you expect th=
e=20
> resolution to be exactly 1/HZ or 1ms.  It is actually not exactly that=20
> because the PIC can not generate 1ms interrupts (close but not close enou=
gh=20
> for NTP). So the kernel figures out what the true PIC rate is and sets up=
=20
> the resolution for that.  This results in a resolution of ~999,849=20
> nanoseconds (i.e. instead of 1,000,000 nano seconds per tick).  Now there=
=20
> is some errors in converting this to micro seconds..., but the actual mat=
h=20
> is done with more precision with the conversion after (which is why the=
=20
> various times the program tries don't come out being exact multiples of=
=20
> each other, or of anything expressed as only microseconds).

I expect there are at least a few applications that will misbehave because
the developers did not expect a timer to behave this way (regardless of
whether it's proper according to the spec).

Is it possible to choose a timer resolution that errs on the high side of
1ms instead of the low side? [*]  It seems to me that would result in the
application getting very close to the expected number of alarm signals.  I
am not at all familiar with the kernel design so I don't know if this would
be feasible or not.

[*] If this is the 8254 timer, using 1192 as a divisor should result in a
resolution of ~1,000,686 nanoseconds.

--=20
I mean, if 10 years from now, when you are doing something quick and dirty,
you suddenly visualize that I am looking over your shoulders and say to
yourself, "Dijkstra would not have liked this", well that would be enough
immortality for me.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jXrIqznSmcYu2m8RAhLOAJ4iEMUvVilYlQzVuBAatHwKmBPYxwCfXaKr
h+YbpXU+tS8UgmIAyaFD1Tc=
=woIj
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
