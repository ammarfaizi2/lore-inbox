Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWCFI14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWCFI14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbWCFI14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:27:56 -0500
Received: from mail.anathoth.gen.nz ([202.78.241.50]:16827 "EHLO
	mail.anathoth.gen.nz") by vger.kernel.org with ESMTP
	id S1750853AbWCFI1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:27:55 -0500
Subject: Re: PROBLEM:  rt_sigsuspend() does not return EINTR on 2.6.16-rc2+
From: Matthew Grant <grantma@anathoth.gen.nz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1141557862.3764.47.camel@pmac.infradead.org>
References: <1141521960.7628.9.camel@localhost.localdomain>
	 <1141557862.3764.47.camel@pmac.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JDrr8zfxt5NWjcgA3uqg"
Organization: Matthew's UNIX Box
Date: Mon, 06 Mar 2006 21:28:05 +1300
Message-Id: <1141633685.7634.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JDrr8zfxt5NWjcgA3uqg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

David,

OK, a major piece of software is broken for mounting removable media. A
kernel upgrade from 2.6.15 SHOULDn't do that. =20

Could you please tell me where go I go next?

Thanks and Cheers,

Matthew Grant

On Sun, 2006-03-05 at 11:24 +0000, David Woodhouse wrote:
> On Sun, 2006-03-05 at 14:26 +1300, Matthew Grant wrote:
> > Problem is that new sys_rt_sigsuspend in kernel/signal.c in 2.6.16-rc2+
> > does not return EINTR.
>=20
> It does for me -- try the trivial test case at
> http://david.woodhou.se/sigsusptest.c
>=20
> If you strace that under old and new kernels you'll see a difference in
> the strace output, but it should be entirely cosmetic. The old code
> would incestuously call do_signal() inside sys_rt_sigsuspend(), and
> would never need to use the mechanism we have for restarting system
> calls. Either it would know it delivered a signal and it would return
> -EINTR, or it would know that it _didn't_, and it would loop for itself.
> Now it behaves like all the other restartable syscalls, and ptrace will
> actually see the -ERESTARTNOHAND return code which later gets converted
> by the signal code either to -EINTR or to an actual restart, as
> appropriate.
>=20
> In short, I think what you've picked up on in the strace output is
> entirely cosmetic, and shouldn't affect the behaviour of the program in
> any way. In each case, it comes back from the signal and goes
> immediately into gettimeofday() and then poll() -- it _has_ come out of
> the sigsuspend(). You then find that poll() gives different results in
> each case, and I'd be inclined to suspect that the _real_ change in
> behaviour goes from that point.
>=20
> > I think David woodhouse may be responsible for this....
>=20
> I read lkml sporadically; usually better to Cc me when I'm to blame :)
>=20
--=20
Matthew Grant <grantma@anathoth.gen.nz>
Matthew's UNIX Box

--=-JDrr8zfxt5NWjcgA3uqg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEC/KVuk55Di7iAnARAspaAKCrhRjq1ABs0wdrcKvVgZm04+PLUgCfaFo2
vFrhqKsWUr/e6uwRrBD8Mco=
=vlAw
-----END PGP SIGNATURE-----

--=-JDrr8zfxt5NWjcgA3uqg--

