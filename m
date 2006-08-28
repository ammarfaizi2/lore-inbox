Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWH1CMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWH1CMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 22:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWH1CMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 22:12:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31922 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932349AbWH1CMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 22:12:17 -0400
Message-ID: <44F250D9.90904@redhat.com>
Date: Sun, 27 Aug 2006 19:11:37 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org, akpm@osdl.org,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org,
       chase.venters@clientec.com
Subject: Re: [take14 0/3] kevent: Generic event handling mechanism.
References: <11564996832717@2ka.mipt.ru>	<44F208A5.4050308@redhat.com> <20060827.185744.82374086.davem@davemloft.net>
In-Reply-To: <20060827.185744.82374086.davem@davemloft.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD070FAD1FCD3FAED83C8D367"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD070FAD1FCD3FAED83C8D367
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

David Miller wrote:
> SigEvent, and signals in general, are crap.  They are complex
> and userland gets it wrong more often than not.  Interfaces
> for userland should be simple, signals are not simple.

You miss the point.

sigevent has nothing necessarily to do with signals.  I don't want
signals.  I just want the same interface to specify the action to be used=
=2E

If I'm using

  struct sigevent sigev;
  int kfd;

  kfd =3D kevent_create (...);

  sigev.sigev_notify =3D SIGEV_KEVENT;
  sigev.sigev_kfd =3D kfd;
  sigev.sigev_valie.sival_ptr =3D &some_data;


then I can use this sigev variable in an unmodified timer_create call.
The kernel would see SIGEV_KEVENT (as opposed to SIGEV_SIGNAL etc) and
**not** generate a signal but instead create the event in the kevent queu=
e.


The proposal to use sigevent has nothing to do with signals.  It's just
about the interface and to have smooth integration with existing
functionality.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigD070FAD1FCD3FAED83C8D367
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFE8lDZ2ijCOnn/RHQRAsTYAJ0bUeSaOflzWljtW+bC6hLDSLAEdgCgpKIn
bFaoVNSv9J2QdddkB3D7LBI=
=/h+i
-----END PGP SIGNATURE-----

--------------enigD070FAD1FCD3FAED83C8D367--
