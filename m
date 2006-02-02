Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423081AbWBBGGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423081AbWBBGGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423083AbWBBGGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:06:18 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:8348 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1423081AbWBBGGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:06:17 -0500
Date: Thu, 2 Feb 2006 17:05:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH] compat: fix compat_sys_openat and friends
Message-Id: <20060202170523.3ee85519.sfr@canb.auug.org.au>
In-Reply-To: <20060201.215644.116024082.davem@davemloft.net>
References: <20060202161151.58839ffd.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0602012134150.21884@g5.osdl.org>
	<20060201.215644.116024082.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__2_Feb_2006_17_05_23_+1100_yhV_Xjw2xj48Zmbr"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__2_Feb_2006_17_05_23_+1100_yhV_Xjw2xj48Zmbr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 01 Feb 2006 21:56:44 -0800 (PST) "David S. Miller" <davem@davemloft=
.net> wrote:
>
> From: Linus Torvalds <torvalds@osdl.org>
> Date: Wed, 1 Feb 2006 21:36:40 -0800 (PST)
>=20
> > Wouldn't it be _much_ better to declare the argument as a "long", since=
=20
> > some architectures (alpha, for example) may assume that 32-bit argument=
s=20
> > have been _sign_extended, not zero-extended.
> >=20
> > Then, when the "compat_sys_xxxx()" function passes the "long" down to t=
he=20
> > _real_ function (which takes an "int"), those architectures (and only=20
> > those architectures) that actually have assumptions about high bits wil=
l=20
> > have the compiler automatically do the right zero- or sign-extensions a=
t=20
> > that call-site.
>=20
> There is the convention that for the compat system calls all the args
> will be 32-bit zero extended by the platform syscall entry code before
> the C code is invoked.  This topic used to come up a lot and finally
> we all decided that was the thing to do.
>=20
> It's important (at least I think so :-) for all of this generic compat
> code to be able to have a well defined argument environment.
>=20
> Anyways, I think that's how Stephen arrived at his patch.

Yes, that is it.  I have tried using "long" and "unsigned int" for those
first parameters and it produces exactly the same assembler output on
ppc64 and x86_64.  Everywhere else that we have a file descriptor argument
to a compat syscall function it is declared "unsigned int".

And for these compat functions, alpha is irrelevent of course. :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__2_Feb_2006_17_05_23_+1100_yhV_Xjw2xj48Zmbr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD4aEjFdBgD/zoJvwRAniWAKCBoe+AK8Slr/R7KOoIsI5TU6I0rgCcCS+0
h/RJ5vlOyAVMKL5KaKvLtj8=
=kmLS
-----END PGP SIGNATURE-----

--Signature=_Thu__2_Feb_2006_17_05_23_+1100_yhV_Xjw2xj48Zmbr--
