Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbTCKWwI>; Tue, 11 Mar 2003 17:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261648AbTCKWwI>; Tue, 11 Mar 2003 17:52:08 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:49384 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261646AbTCKWwH>;
	Tue, 11 Mar 2003 17:52:07 -0500
Subject: Re: [RFC][PATCH] linux-2.5.64_monotonic-clock_A1
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Joel.Becker@oracle.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, wim.coekaerts@oracle.com
In-Reply-To: <3E6E65BC.2060200@mvista.com>
References: <1047411561.16614.684.camel@w-jstultz2.beaverton.ibm.com>
	 <1047411650.16613.687.camel@w-jstultz2.beaverton.ibm.com>
	 <3E6E5989.6060301@mvista.com>
	 <1047419933.16615.704.camel@w-jstultz2.beaverton.ibm.com>
	 <3E6E65BC.2060200@mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ad+MzJBj2nenbbBNnjWh"
Organization: 
Message-Id: <1047423553.16608.723.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 14:59:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ad+MzJBj2nenbbBNnjWh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-03-11 at 14:39, george anzinger wrote:

> I must have confused you.  I am woking on a get time of day sort of=20
> thing.  In time.c, the gettimeofday code calls get_offset() and then=20
> adds in lost ticks (ticks clocked by the PIT interrupt but not yet=20
> rolled into the wall clock (xtime).  I was thinking that get_offset=20
> might be defined to add this its result.

I'm still not quite following that. But as long as we're both pointing
at the same code and grunting in agreement I think I'll just let it
slide ;)


> But, back to the problem I am trying to solve.  The posixtimers code=20
> is in the common kernel and needs the result returned by get_offset=20
> OR, we could define a new function, get_monotonictimeofday(), which=20
> returns the jiffies since boot + get_offset() + pending ticks (i.e. it=20
> would be the same as gettimeofday except it would use jiffies_64=20
> instead of xtime to get its result.  The format would be a timespec,=20
> i.e. the same as xtime.


Actually, what is the difference between the call you're trying to
implement and monotonic_clock() (outside of the timespec return)?  Could
you point me to the specific code you are describing? It sounds like
we're working on basically the same solution from two different angles.=20


> This translates directly into a system call and is also used in the=20
> timers code to convert from wall clock time to jiffies time for timers.
>=20
> Either way, we have a bit of a mess due to the arch dependency.  I=20
> don't really care which way it goes, but I do think it should be=20
> resolved in 2.5.

Well, if the generic interfaces aren't providing what you need, then a
new interface needs to be considered. This is precisely what the
hangcheck-timer code ran into, and is why we're working on this
monotonic_clock() code (which is intended be arch independent in the
future).=20

thanks
-john

--=-ad+MzJBj2nenbbBNnjWh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+bmpBMDAZ/OmgHwwRAqbmAJwO1NjP02doJwp2e84m6jzSu3FkHwCeMlft
SrMaiv6E+1dBQdZVOmvfQ1k=
=hLeD
-----END PGP SIGNATURE-----

--=-ad+MzJBj2nenbbBNnjWh--

