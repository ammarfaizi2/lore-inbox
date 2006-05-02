Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWEBU2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWEBU2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWEBU2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:28:18 -0400
Received: from smtp04.auna.com ([62.81.186.14]:16029 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S1751246AbWEBU2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:28:17 -0400
Date: Tue, 2 May 2006 22:28:12 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Al Boldi <a1426z@gawab.com>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
Message-ID: <20060502222812.4fb7e34f@werewolf.auna.net>
In-Reply-To: <200605022121.44831.a1426z@gawab.com>
References: <200605022121.44831.a1426z@gawab.com>
X-Mailer: Sylpheed-Claws 2.1.1cvs41 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_AmovTWW16J.zjvHOSC=dHu9";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Tue, 2 May 2006 22:28:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_AmovTWW16J.zjvHOSC=dHu9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 2 May 2006 21:21:44 +0300, Al Boldi <a1426z@gawab.com> wrote:

> Christer Weinigel <christer@weinigel.se> wrote:
> >> eCos is nice enough -- because it's mostly C :)
> >
> > And those parts that are C++ (from a 2 year old eCos dist) won't
> > compile with a modern g++.
>=20
> C++ is OO, and OO is great!  OO is the natural way of doing things, and=20
> allows one to concentrate on the issues at hand, while leaving the=20
> nitty-gritty to the compiler to decide.
>=20
> And this is the problem, as kernel development is highly sensitive to=20
> compiler output, and which is why there are parts written in asm and othe=
rs=20
> in C.
>=20
> So rewriting C with C++ would be as dumb as rewriting asm with C.
>=20
> But there may be certain higher level parts in the kernel that could bene=
fit=20
> from rewriting C with C++, much the same as lower level parts have benefi=
ted=20
> from rewriting them in asm.
>=20
> So we have a situation like this:
>=20
> 	low-level written in asm when needed
>=20
> 	main-level written in C mostly
>=20
> 	high-level written in C++ when needed
>=20

You can control low level features in C++ even much better than in asm.
Just an example. You can be pretty sure that a function like this:

inline void f(const int& x)
{
}

would use the parameter you pass to it without doing a copy on the stack.
And that is not dependent on anything.
For example, I wrote a vector library to do math with SSE, and there it
is fundamental that you don't _ever_ write a xmm register to the stack or
to memory in temporary variables. Look like this:

class Vector {
    float   f[4];

    typedef float __vr __attribute__((__mode__(__V4SF__),__aligned__(16)));
   =20
    Vector operator+(const __vr that) const
    {
	return __builtin_ia32_addps(...);
    };
    Vector operator-(const __vr that) const
    {
	return __builtin_ia32_subps(...);
    };
    ...
};

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.16-jam11 (gcc 4.1.1 20060330 (prerelease)) #1 SMP PREEMPT Mon

--Sig_AmovTWW16J.zjvHOSC=dHu9
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEV8DcRlIHNEGnKMMRAv9NAJ4qCZCX+AcvzMbI7NARV0h4OgVeowCeJihr
mqbfopH5OUUHZ1MXSzOtMho=
=OUO6
-----END PGP SIGNATURE-----

--Sig_AmovTWW16J.zjvHOSC=dHu9--
