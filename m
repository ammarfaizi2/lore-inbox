Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbUK1MKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUK1MKS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 07:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUK1MKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 07:10:18 -0500
Received: from natmwynyy.rzone.de ([81.169.145.169]:9380 "EHLO
	natmwynyy.rzone.de") by vger.kernel.org with ESMTP id S261442AbUK1MKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 07:10:03 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Sun, 28 Nov 2004 13:03:41 +0100
User-Agent: KMail/1.6.2
Cc: David Woodhouse <dwmw2@infradead.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Tonnerre <tonnerre@thundrix.ch>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <200411272353.54056.arnd@arndb.de> <1101626019.2638.2.camel@laptop.fenrus.org>
In-Reply-To: <1101626019.2638.2.camel@laptop.fenrus.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_i6bqB4JVETHhlkJ";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200411281303.46609.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_i6bqB4JVETHhlkJ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok, I've looked for places where someone actually tried using
the kernel headers by googling for /usr/include/asm/foo.h.
The good news is that marking these files broken in=20
glibc-kernheaders has already pointed most authors to the
source of the problem.

On S=FCnndag 28 November 2004 08:13, Arjan van de Ven wrote:
>=20
> > The problem with these (atomic.h
>=20
> that is a very non portable header and there are several good
> alternatives (see the apr library for example). In fact. atomic.h is
> *dangerous* in userspace, it is only atomic if CONFIG_SMP is set, so if
> you compile your app on a machine without that set and then run it on an
> smp machine, you are not atomic.

Yes, it appears that most people who attempted to use this
have already been bitten so hard that they stopped trying.

> >
> > , bitops.h
>=20
> again not portable=20

netbase-ping6 tried to use it, along with some other applications that
I had not heard of.

> >
> > , byteorder.h,=20
>=20
> there are perfectly good alternatives in glibc

Google found abuses of byteorder.h in kdeedu, dbootstrap and netatalk,
I would expect to find many more if I kept looking.

> >
> > div64.h,
>=20
> huh? what is wrong with "/" in C

Ok, probably nobody has tried to do funny things with this one.

> > list.h
>=20
> this one I can see

Surprisingly few abuses. It is already been protected with
#ifdef __KERNEL__ for some time.

> >
> > , spinlock.h
>=20
> EHHHH????? Spinlocks in userland? You got to be kidding.

I don't think it's that uncommon to use spinlocks in user
space, IIRC samba (tdb) and some databases implement their
own version of user spinlocks. The kernel implementation
is used at least in "Open Runtime Platform" and in "Chrony".
Chrony even has an FAQ entry on how to circumvent the=20
"#ifndef __KERNEL__" that was added in Red Hat Linux...

> > , unaligned.h=20
>=20
> weird

At least one application that I use every day (vdr) tried including
asm/unaligned.h, but it's rather uncommon otherwise.

> > and xor.h)=20
>=20
> xor.h is very raid specific (and GPL with lots of code, so a license
> trap)

Right, this one has never been used from user space AFAICS.

	Arnd <><

--Boundary-02=_i6bqB4JVETHhlkJ
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBqb6i5t5GS2LDRf4RAt8BAJ4sWVqeo6OhMe9rXJANgTD7FpwaYQCfac6U
RRIuFOliWXBw6uiuuVK8FzA=
=jvpb
-----END PGP SIGNATURE-----

--Boundary-02=_i6bqB4JVETHhlkJ--
