Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbTLMXVa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 18:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265313AbTLMXVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 18:21:30 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:22433
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S265315AbTLMXV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 18:21:26 -0500
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200312140916.26005.ross@datscreative.com.au>
References: <200312140407.28580.ross@datscreative.com.au>
	 <1071354516.2634.3.camel@big.pomac.com>
	 <200312140916.26005.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JZb182QYk2nQ/djW7adG"
Message-Id: <1071357683.2024.5.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Dec 2003 00:21:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JZb182QYk2nQ/djW7adG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-14 at 00:16, Ross Dickson wrote:
> On Sunday 14 December 2003 08:28, you wrote:
> > On Sat, 2003-12-13 at 19:07, Ross Dickson wrote:
> > > ..APIC TIMER ack delay, reload:16701, safe:16691
> >=20
> > calibrating APIC timer ...
> > ..... CPU clock speed is 2079.0146 MHz.
> > ..... host bus clock speed is 332.0663 MHz.
> > NET: Registered protocol family 16
> > ..APIC TIMER ack delay, reload:20791, safe:20779
> > ..APIC TIMER ack delay, predelay count: 20769
> > ..APIC TIMER ack delay, predelay count: 20786
> > ..APIC TIMER ack delay, predelay count: 20716
> > ..APIC TIMER ack delay, predelay count: 20731
> > ..APIC TIMER ack delay, predelay count: 20747
> > ..APIC TIMER ack delay, predelay count: 20762
> > ..APIC TIMER ack delay, predelay count: 20780
> > ..APIC TIMER ack delay, predelay count: 20729
> > ..APIC TIMER ack delay, predelay count: 20740
> > ..APIC TIMER ack delay, predelay count: 20757
>=20
> Thanks Ian.
> From this we see your local apic is indeed counting 1.2 times faster than=
 mine
> ratio of 333/266 fsb. So the reload:20791 - safe:20779 gives 12 counts ti=
me.
> Given 20791 is 1ms on your system then your 12 counts is 577ns
> But more importantly from the ack delay theory as your machine like mine =
is
> prone to lockups then a lockup could likely have occured at count:20786 h=
aving
> only 240ns time expired. Next worst case was less likely to lockup at cou=
nt:20780.

I just had a lockup running with preempt, now trying with preempt
disabled. This is a clean 2.6.0-test11 with just io-apic and apic v2
patches.

> The only ones any delay would have been added to by the patch would be th=
e
> count:20786 and count:20780 and it would have been just enough to wait un=
til=20
> the counter got below the safe:20779 so the patch contributes little over=
head.
=20
> > Survived my greptest which no non patched kernel has ever done on this
> > machine.
> >=20
> > Has anyone got that extended ringbuffer to work? I haven't been able to
> > get a complete "boot" dmesg in ages because of all the output all the
> > drivers make... Does it need a updated dmesg?
>=20
> This may be what you have already tried:
> I am not sure where it is in the 2.6 config or indeed if it is different =
but it is
> CONFIG_LOG_BUF_SHIFT under kernel hacking on 2.4.23 maybe try 16 for 64K.
> To match dmesg output try=20
>=20
> dmesg -s65536
>=20
> (unless dmesg can automatically pick up the expanded ring buffer size on =
2.6?)

Ahhh great!, no, it doesn't auto detect it... Maybe there is a newer
version, i hate mdk for being so nice to new versions and ignoring the
old.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-JZb182QYk2nQ/djW7adG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/257z7F3Euyc51N8RAmZpAJ9KGpTy1bmYy+1dqndRUrzVD+5OZQCfT138
bhE+mCq+L9wuD7z7rn5SQDk=
=qSfS
-----END PGP SIGNATURE-----

--=-JZb182QYk2nQ/djW7adG--

