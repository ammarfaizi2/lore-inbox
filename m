Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265299AbTLMViq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 16:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTLMViq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 16:38:46 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:2465
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S265299AbTLMVim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 16:38:42 -0500
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: forming@charter.net, the3dfxdude@hotmail.com, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com
In-Reply-To: <200312140407.28580.ross@datscreative.com.au>
References: <200312140407.28580.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SLh+6quVXSgO4DvHXfXa"
Message-Id: <1071351521.2267.37.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Dec 2003 22:38:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SLh+6quVXSgO4DvHXfXa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-13 at 19:07, Ross Dickson wrote:
> Greetings,
> I have updated the apic timer ack delay patch and the io-apic edge patch
> although I do not think anyone had any problems with the first release.

I have 3days of uptime here... It's low due to me wanting to test dual
channel memory...

> These patches may not be required if your bios is sorted out - mine are
> not yet.

Neither is mine =3DP

> The apic ack delay no longer adds a small delay to every timer int so I=20
> believe its performance hit is barely detectable.=20

Niiice

> In fact the busier the system gets with irqs- the more likelyhood=20
> of the delay time expiring naturally and the less the impact of the patch=
.
>=20
> It now only delays the ones that would be too quick and most likely
> cause a hard lockup. It also reports its existence on boot if used. e.g.
>=20
> ..APIC TIMER ack delay, reload:16701, safe:16691
>=20
> And if =20
>=20
> #define APIC_DEBUG 0
>=20
> is set to 1 in=20
>=20
> /usr/src/linux-2.4.23-rd2/include/asm-i386/apic.h

Right now i'm compiling and hope that the patch doesn't need more
workups. (Josh McKinney patches missed some things, more on that further
down)

> Then you can report at boot ten pre delay apic timer times as well to get=
 a=20
> feel as to whether the delay had to kick in or not. Note that ten is a ve=
ry
> small sample size but it gives an idea of the timing numbers.
>=20
> The apic timer counts down from the reload value and interrupts at zero.
> The reload value corresponds to the time between HZ at the rate the=20
> counter counts. Nothing new so far.
> e.g. My system is running 1000Hz so the time is 1ms.
> The reload value is 16701 so that represents 1ms.
>=20
> The safe count it calculates for my system is 16691 so any number smaller
> than that is expected to be when it is safe to ack the local apic after a=
n apic
> timer interrupt. If you want to experiment with the delay time in nano se=
conds
> just change the 600UL. If I set mine to 400UL then my hard lockups return=
.
> Interestingly I can read the local apic timer safely right after the inte=
rrupt -=20
> I just can't safely ack it then. It is as if the C1 disconnect logic with=
in the
> processor only screws with the ACK irq cancellation logic and then only f=
or
> a short time after an irq.

Did you see the 240usecond delay that happens after a disconnect? But
according to the amd northbridge spec, the pci bus will be disabled or
something at that time...

> The io-apic edge patch has been cleaned up a little. If the above debug i=
s on
> then it will display the 8259a xtpic interrupt mask. I get hex fb and hex=
 ff=20
> indicating that the only int enabled on the 8259A xtpic which handles irq=
 0-7
> is the cascade irq 2 which is OK because on the other 8259A irq 8-15 are =
masked.
> This masked xtpic should always be the case. We want the 8259A off during
> our test to see if the 8254 timer is connected directly to pin 0 of the i=
oapic.
> The other messages are as per previous version.
>=20
>=20
> Lastly I need sleep (4 am) so they are not yet done as patch files. I hav=
e
> put them into two text files and bzipped them as an attachment. Anyhow th=
ey
> are small and insert in the same places as their previous versions.
>=20
> Thanks Jesse for rediffing the original patches for 2.6 would you like to=
 repeat
> the favour with these please?
>=20
> Again they are still experimental.... so I am hoping Ian, Jesse and other=
s will
> put them to the test.

Compiling 2.6.0 atm, since i want to test that somemore on this
machine...=20

Josh McKinney wrote:
> I am not Jesse but I thought I would diff them for 2.6 myself.  Thanks
> Ross and others for putting so much time and effort into this.  I
> haven't had time to test them, but I soon will.  Uptime is: =20
>  15:19:45 up 2 days,  3:53,  7 users,  load average: 0.05, 0.28, 0.37
> with the original v1 patches.

apic part is missing a closing ) and the last part of the #ifdef =3D)
So, either rediff or let the users fix that up =3D)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-SLh+6quVXSgO4DvHXfXa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/24bg7F3Euyc51N8RAkVCAJ95v4k98Mij9DyTFxOtOnqR9G9tDQCeK9A3
dOY+oLo3kjpMTvESqsUrWMc=
=5Jrl
-----END PGP SIGNATURE-----

--=-SLh+6quVXSgO4DvHXfXa--

