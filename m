Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTLGT6v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 14:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTLGT6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 14:58:51 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:37792
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264511AbTLGT6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 14:58:48 -0500
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: ross@datscreative.com.au
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rOnUUhxv3iCu8G54aevo"
Message-Id: <1070827127.1991.16.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 07 Dec 2003 20:58:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rOnUUhxv3iCu8G54aevo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> I have monitored list and know my nforce2 experiences have been
> common.

Hell yeah =3D)

> When I enabled either apic or io-apic in kern config, lockups came=20
> hard and fast. Particularly bad under hard disk load. Heaps of lost=20
> ints on irq7 in apic and ioapic mode. Lockups disappeared when I=20
> lowered the ide hda udma speed to mode 3 with hdparm so I went looking
> for answers which now follow.

Good job =3D)

> There are three parts to this email.
> a) apic mods.
> Lockups are due to too fast an apic acknowledge of apic timer int.
> Apic hard locked up the system - no nmi debug available.
> Fixed it by introducing a delay of at least 500ns into=20
> smp_apic_timer_interrupt() just prior to ack_APIC_irq().

I find this really odd... It works just fine...=20
As did disabling whats now active ie:
'Halt Disconnect and Stop Grant Disconnect' bit is enabled.

So it seems like these are the two most important factors, at least from
where i stand. Both enabled me to actually use my machine with IO-APIC.
(1, disabling Halt Disconnect and Stop Grand Disconnect bit or 2, Add a
delay on the irq ack.)
Anyone that has any clues?

> b) io-apic mods
> So I have fixed it too (tested on both my epox and albatron MOBOs).
> Firstly I found 8254 connected directly to pin 0 not pin 2 of io-apic.
> I have modified check_timer() in io_apic.c to trial connect pin and=20
> test for it after the existing test for connection to io-apic.

Good job, i wonder if it could be more generalized and integrated with
the rest of the code (i haven't even checked the rest of the code, but
this seemed separated).

One thing though, I get a lot more NMI's now than with nmi_watchdog=3D2...
NMI:      85520
LOC:      85477

I usually had a 3 figure number by now... but.. =3D)

> c) ide driver mods

Cool..=20

I applied all patches and it survived my grep test so i think it works.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-rOnUUhxv3iCu8G54aevo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/04Z27F3Euyc51N8RAuI+AKCE+YFdNAirUb8YCstrQaWZekF1SgCfUn0u
hYYFWrFiNyaYrsPhIQSUSjQ=
=EDWU
-----END PGP SIGNATURE-----

--=-rOnUUhxv3iCu8G54aevo--

