Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263878AbTCUUvB>; Fri, 21 Mar 2003 15:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263819AbTCUUtt>; Fri, 21 Mar 2003 15:49:49 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:26274 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264146AbTCUUsR>;
	Fri, 21 Mar 2003 15:48:17 -0500
Subject: Re: Clock monotonic  a suggestion
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Joel Becker <Joel.Becker@oracle.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3E7AC6C9.5000401@mvista.com>
References: <3E7A59CD.8040700@mvista.com>
	 <20030321025045.GX2835@ca-server1.us.oracle.com>
	 <3E7AC6C9.5000401@mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6q3gAwKX+14UAKhx9Brl"
Organization: 
Message-Id: <1048280007.4821.301.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 21 Mar 2003 12:53:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6q3gAwKX+14UAKhx9Brl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-03-21 at 00:01, george anzinger wrote:
> Joel Becker wrote:
> > 	If the system is delayed (udelay() or such) by a driver or=20
> > something for 10 seconds, then you have this (assume gettimeofday is
> > in seconds for simplicity):
> >=20
> > 1    gettimeofday =3D 1000000000
> > 2    driver delays 10s
> > 3    gettimeofday =3D 1000000000
> > 4    timer notices lag and adjusts
>=20
> Uh, how is this done?  At this time there IS correction for delays up=20
> to about a second built into the gettimeofday() code.  You seem to be=20
> assuming that we can do better than this with clock monotonic.  Given=20
> the right hardware, this may even be possible, but why not correct=20
> gettimeofday in the same way?

Because to to it properly is slow. Right now gettimeofday is all done
with 32bit math. However this bounds us to ~2 seconds of counting time
before we overflow the low 32bits of the TSC on a 2GHz cpu.  Rather then
slowing down gettimeofday with 64bit math to be able to handle the crazy
cases where timer interrupts are not handled for more then 2 seconds, we
propose a new interface (monotonic_clock) that provides increased
corner-case accuracy at increased cost.=20

thanks
-john

--=-6q3gAwKX+14UAKhx9Brl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+e3vHMDAZ/OmgHwwRAtTMAKCYEYJ2ObO4kPXVE5WB7i64f5ZRegCffMnu
q5lR/TlByZcnDZMHbBB8k0Y=
=vuPI
-----END PGP SIGNATURE-----

--=-6q3gAwKX+14UAKhx9Brl--

