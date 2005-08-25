Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVHYAf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVHYAf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVHYAf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:35:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19898 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932429AbVHYAfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:35:25 -0400
Message-ID: <430D1210.8080006@redhat.com>
Date: Wed, 24 Aug 2005 17:34:24 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Michael Kerrisk <mtk-lkml@gmx.net>, jakub@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, michael.kerrisk@gmx.net
Subject: Re: Add pselect, ppoll system calls.
References: <11156.1123243084@www3.gmx.net>  <25911.1123246168@www3.gmx.net> <1124928289.7316.92.camel@baythorne.infradead.org>
In-Reply-To: <1124928289.7316.92.camel@baythorne.infradead.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8EB70A8BB4006064A633C171"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8EB70A8BB4006064A633C171
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

David Woodhouse wrote:
> If it's mandatory that we actually call the signal handler, then we nee=
d
> to play tricks like sigsuspend() does to leave the old signal mask on
> the stack frame. That's a bit painful atm because do_signal is differen=
t
> between architectures.=20

It is necessary that the handler is called.  This is the purpose of
these interfaces.  If this means more complexity is needed then this is
how the cookie crumbles.  One use case for pselect would be something
like this:


int got_signal;
void sigint_handler(int sig) {
  got_signal =3D 1;
}

{
  ...
  while (1) {
    if (!got_signal)
      pselect()

    if (got_signal) {
      handle signal
      got_signal =3D 0;
    }
  }
  ...
}

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig8EB70A8BB4006064A633C171
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDDRIQ2ijCOnn/RHQRAnypAJ9bYKkYJq929Iuf9iW00x9zaUXSWgCfWYne
Pr66FZ4yoAhjx6HSgxbvHgY=
=piDI
-----END PGP SIGNATURE-----

--------------enig8EB70A8BB4006064A633C171--
