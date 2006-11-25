Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757932AbWKYQAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757932AbWKYQAu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 11:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757933AbWKYQAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 11:00:50 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:25555 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1757932AbWKYQAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 11:00:49 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/2] Introduce mutex_lock_timeout
Date: Sat, 25 Nov 2006 17:00:27 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20061109182721.GN16952@parisc-linux.org> <20061125035526.GF14076@parisc-linux.org>
In-Reply-To: <20061125035526.GF14076@parisc-linux.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4148155.fAcnVGd7We";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611251700.39806.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4148155.fAcnVGd7We
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Matthew,

On Saturday, 25. November 2006 04:55, Matthew Wilcox wrote:
> No comment on this?

Ok, I will comment it. But I'll NOT comment on the implementation.
I'll prove you instead, that timout based locking is non-sense.

What should the timout mutex_timeout() prevent? Usually the answer is=20
"if sombody hangs on a mutex forever ...?" and people tell you "ok, that is
a deadlock -> fix your code not to deadlock instead."
Then they tell you "Ok, but if somebody takes a mutex too long?"
and people will answer "ok, then this is a livelock -> fix your code not to=
=20
livelock."

Another answer is "I like to block until sth. happens wihin a specific time=
 frame"=20
=2D> fine, this is accomplished by wait_event_timout (which blocks only you=
 and=20
not every other user of the mutex).

So you see there is no real need for this and having it yould introduce an=
=20
instrument for hiding such bugs.

When you talk with untrusted binary only code such locks with timeouts
are sometimes needed, since you don't know the locking rules within
such code.

As this is not the case for kernel code, it is simply not needed.

I know why ACPI needs it (API requirement) and I think the qla???-driver
just needs to be fixed to work without it and nobody did it yet.


Regards

Ingo Oeser, who actually IS the implementation of mutex_lock_timeout()[1]

[1] Everytime (since 2001) someone suggest it, I discuss it away :-)

--nextPart4148155.fAcnVGd7We
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFaGinU56oYWuOrkARAu3PAJ43u7eQ8z3u7IL5jupSk3rqmQJJAwCeK3ys
HbDdsgIUV94QuieZDDVHcBM=
=vcki
-----END PGP SIGNATURE-----

--nextPart4148155.fAcnVGd7We--
