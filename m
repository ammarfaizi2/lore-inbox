Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWGGNgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWGGNgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWGGNgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:36:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61635 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932157AbWGGNgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:36:19 -0400
Message-ID: <44AE6354.9000405@redhat.com>
Date: Fri, 07 Jul 2006 06:36:20 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Michael Kerrisk <michael.kerrisk@gmx.net>,
       Arjan van de Ven <arjan@infradead.org>, mtk-manpages@gmx.net,
       mtk-lkml@gmx.net, rlove@rlove.org, roland@redhat.com,
       eggert@cs.ucla.edu, torvalds@osdl.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: Strange Linux behaviour with blocking syscalls and stop signals+SIGCONT
References: <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com> <44AD5CB6.7000607@redhat.com> <20060707043220.186800@gmx.net> <44ADE9B6.1020900@redhat.com> <20060707050731.186770@gmx.net> <44ADFD43.4040204@redhat.com> <20060707070334.186790@gmx.net> <1152256856.3111.20.camel@laptopd505.fenrus.org> <20060707080212.186780@gmx.net> <20060707092636.GU3115@devserv.devel.redhat.com>
In-Reply-To: <20060707092636.GU3115@devserv.devel.redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF34D3D9082AA54F921B76BEB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF34D3D9082AA54F921B76BEB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jakub Jelinek wrote:
> In futex(2) case (except FUTEX_LOCK_PI where we want it to be restartab=
le),
> getting EINTR rather than the getting the syscall restarted is very
> desirable though and several NPTL routines rely on it.

Jakub, you're slightly missing the point.  Restartable means the only if
SA_RESTART is set the syscall restarts.  Otherwise it returns.  That
should always be the behavior if EINTR is an acceptable error.

The difference for the _PI operations is that be never need to see EINTR
errors.  I.e., the syscall should _always_ restart, regardless of
SA_RESTART.  That's not done using the error code but through explicit
programming.  I told Ingo that we don't need EINTR for those operations
and I hope that part is still in.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigF34D3D9082AA54F921B76BEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFErmNU2ijCOnn/RHQRAqdRAKCNqmgVKH0Oyfl9S4Xymh+9dBkzowCdGvbJ
fKvqn/rdgDpMdQ5rjmkTFY0=
=G/xc
-----END PGP SIGNATURE-----

--------------enigF34D3D9082AA54F921B76BEB--
