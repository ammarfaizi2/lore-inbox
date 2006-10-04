Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWJDRXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWJDRXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWJDRXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:23:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34692 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964789AbWJDRXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:23:23 -0400
Message-ID: <4523ED6C.9080902@redhat.com>
Date: Wed, 04 Oct 2006 10:20:44 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru> <20060927150957.GA18116@2ka.mipt.ru> <a36005b50610032150x8233feqe556fd93bcb5dc73@mail.gmail.com> <20061004045527.GB32267@2ka.mipt.ru> <452363C5.1020505@redhat.com> <20061004074821.GA22688@2ka.mipt.ru>
In-Reply-To: <20061004074821.GA22688@2ka.mipt.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0658E7C63740A516B1128C14"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0658E7C63740A516B1128C14
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Evgeniy Polyakov wrote:
> It is completely possible to do what you describe without special
> syscall parameters.

First of all, I don't see how this is efficiently possible.  The mask
might change from call to call.

Second, hasn't it sunk in that inventing new ways to pass parameters is
bad?  Programmers don't want to learn new ways for every new interface.
 Reuse is good!

This applies to the signal mask here.

But there is another parameter falling into that category and I meant to
mention it before: the timeout value.  All other calls except poll and
especially all modern interfaces use a timespec pointer.  This is the
way times are kept in userland code.  Don't try to force people to do
something else.

Using a timespec also has the advantage that we can add an absolute
timeout value mode (optional) instead of the relative timeout value.

In this context, we should/must be able to specify which clock the
timeout is for (not as part of the wait call, but another control
operation perhaps).  It's important to distinguish between
CLOCK_REALTIME and CLOCK_MONOTONE.  Both have their use.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig0658E7C63740A516B1128C14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFI+1s2ijCOnn/RHQRAimhAJ0T64z1qhbiCRnYzZGAKcasQ5JrlACeIyLJ
aUzqTBXH0RVCdAd2DKhFJho=
=chcY
-----END PGP SIGNATURE-----

--------------enig0658E7C63740A516B1128C14--
