Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWBORv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWBORv7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWBORv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:51:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54449 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751173AbWBORv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:51:58 -0500
Message-ID: <43F36A00.602@redhat.com>
Date: Wed, 15 Feb 2006 09:50:56 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
References: <20060215151711.GA31569@elte.hu> <p73lkwc5xv2.fsf@verdi.suse.de>
In-Reply-To: <p73lkwc5xv2.fsf@verdi.suse.de>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2BD4B436ADE2E0D864E72AB7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2BD4B436ADE2E0D864E72AB7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Andi Kleen wrote:
> e.g. you could add a new VMA flag that says "when one user
> of this dies unexpectedly by a signal kill all"=20

"kill all"?  That is so completely different from the intended behavior.
 Robust mutexes are no concept which has been invented here.  It is
clearly specified.  The reaction to a terminating thread/process is
notification of other interested parties.

None of your proposals makes any sense in this context.


> And what happens if the patch is rejected? I don't really think you
> can force patches in this way ("do it or I break glibc")

Nothing which relies on the syscalls goes into cvs unless the kernel
side is first committed.  I never do this.  What is in cvs now is an
implementation of the intra-thread robust mutexes based on the same
mechanisms.  I.e., using the new syscall is a trivial thing since the
infrastructure is already in place.  And the method is proven to work.


> What happens when the list gets corrupted? Does the kernel go
> into an endless loop? Kernel going through arbitary user structures
> like this seems very risky to me. There are ways to do
> list walking with cycle detection, but they still have quite
> bad worst case detection times.

The list being corrupted means that the mutexes are corrupted.  In which
case the application would crash anyway.

As for the "endless loop".  You didn't read the code, it seems.  There
are two mechanisms to prevent this: the list is destroyed when the
individual elements are handled and there is an upper limit on the
number of robust mutexes which can be registered.  The limit is
ridiculously high so it'll no problem for correct programs and it also
will eliminate run-away list following code.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig2BD4B436ADE2E0D864E72AB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFD82oA2ijCOnn/RHQRAq7xAJ93+DtWubHU7nQk86LGOsbEkuW3KgCcDotm
bEw9f2Z2D/YYtlPMP6B5rSg=
=97it
-----END PGP SIGNATURE-----

--------------enig2BD4B436ADE2E0D864E72AB7--
