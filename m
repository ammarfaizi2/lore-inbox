Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWARETw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWARETw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 23:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWARETw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 23:19:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26769 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964922AbWARETw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 23:19:52 -0500
Message-ID: <43CDC21C.7050608@redhat.com>
Date: Tue, 17 Jan 2006 20:20:44 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] pepoll_wait ...
References: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCD0C289E2CA51AF7136D280B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCD0C289E2CA51AF7136D280B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Davide Libenzi wrote:
> The attached patch implements the pepoll_wait system call, that extend
> the event wait mechanism with the same logic ppoll and pselect do. The
> definition of pepoll_wait is: [...]

I definitely ACK this patch, it's needed for the same reasons we need
pselect and ppoll.


> +	if (error =3D=3D -EINTR) {
> +		if (sigmask) {
> +			memcpy(&current->saved_sigmask, &sigsaved, sizeof(sigsaved));
> +			set_thread_flag(TIF_RESTORE_SIGMASK);
> +		}
> +	} else if (sigmask)
> +		sigprocmask(SIG_SETMASK, &sigsaved, NULL);

This part I'd clean up a bit, though.  Move the if (sigmask) test to the
top and have the EINTR test decide what to do.  As is the code would be
a bit irritating if it wouldn't be so trivial.  The important thing is
that you only do something special if sigmask !=3D NULL.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigCD0C289E2CA51AF7136D280B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDzcIc2ijCOnn/RHQRAq5JAJ9yK8JpdlVmTGb9KuvtQjMxjE+EYACeJsdp
9okEH0h8rDfJzpSJqHhDkMo=
=fq8o
-----END PGP SIGNATURE-----

--------------enigCD0C289E2CA51AF7136D280B--
