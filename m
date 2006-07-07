Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWGGE5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWGGE5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 00:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWGGE5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 00:57:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47066 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750821AbWGGE5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 00:57:13 -0400
Message-ID: <44ADE9B6.1020900@redhat.com>
Date: Thu, 06 Jul 2006 21:57:26 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Michael Kerrisk <michael.kerrisk@gmx.net>
CC: manfred@colorfullife.com, linux-kernel@vger.kernel.org, tytso@mit.edu,
       torvalds@osdl.org, eggert@cs.ucla.edu, roland@redhat.com,
       rlove@rlove.org, mtk-lkml@gmx.net, mtk-manpages@gmx.net
Subject: Re: Strange Linux behaviour with blocking syscalls and stop signals+SIGCONT
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com> <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com> <44AD5CB6.7000607@redhat.com> <20060707043220.186800@gmx.net>
In-Reply-To: <20060707043220.186800@gmx.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig264209A0FB530EEB5DE3CC33"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig264209A0FB530EEB5DE3CC33
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Michael Kerrisk wrote:
>> Whoa, not so fast.  At least the futex syscall but be interruptible by=

>> signals.  It is crucial to return EINTR.
>=20
> When you say "return" do you mean "in kernel", or "return=20
> to userspace"?  My (possibly naive) understanding is that
> one could simply s/EINTR/ERESTARTNOHAND/ for FUTEX_WAIT, in
> order to achieve the change I want: for userland that=20
> ERESTARTNOHAND would be returned as EINTR if a signal=20
> handler interrupted the FUTEX_WAIT.

The futex syscall must _at least_ behave like every other syscall which
can block and can be interrupted by a signal.  It essential for internal
operation (cancellation) but also for programs.  For the former any
change which still allows EINTR to be reported could be acceptable.  We
install the signal handler internally and so make sure it's correct.

sem_wait() is another case.  Here the EINTR handling is exposed to the
programmer.  Currently, as I understand it, even SA_RESTART handlers
cause EINTR to be returned.  Yes, this usually correct but it  might
disrupt existing code.

This is why I'd caution anybody who thinks about changing something in
this area.  *I* could live with it, I can fix and recompile all the code
I use.  But others aren't that lucky.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig264209A0FB530EEB5DE3CC33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFErem22ijCOnn/RHQRAtwaAJ4kbbzCzC8uFbiqJ9rIx5MWxz4CmwCffJrV
g9rt5stcTTfhGZwEmZtp0Gk=
=oi6B
-----END PGP SIGNATURE-----

--------------enig264209A0FB530EEB5DE3CC33--
