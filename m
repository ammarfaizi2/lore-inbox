Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752071AbWCIXpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbWCIXpc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbWCIXpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:45:31 -0500
Received: from mout0.freenet.de ([194.97.50.131]:54971 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1750869AbWCIXp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:45:29 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
Date: Fri, 10 Mar 2006 00:45:09 +0100
User-Agent: KMail/1.8.3
References: <16835.1141936162@warthog.cambridge.redhat.com> <17424.48029.481013.502855@cargo.ozlabs.ibm.com>
In-Reply-To: <17424.48029.481013.502855@cargo.ozlabs.ibm.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, alan@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4573827.eG2HhSmO3S";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603100045.10375.mbuesch@freenet.de>
X-Warning: 213.54.177.245 is listed at list.dsbl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4573827.eG2HhSmO3S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 10 March 2006 00:34, you wrote:
> David Howells writes:
>=20
> > +On some systems, I/O writes are not strongly ordered across all CPUs, =
and so
> > +locking should be used, and mmiowb() should be issued prior to unlocki=
ng the
> > +critical section.
>=20
> I think we should say more strongly that mmiowb() is required where
> MMIO accesses are done under a spinlock, and that if your driver is
> missing them then that is a bug.  I don't think it makes sense to say
> that mmiowb is required "on some systems".

So what about:

#define spin_lock_mmio(lock)	spin_lock(lock)
#define spin_unlock_mmio(lock)	do { spin_unlock(lock); mmiowb(); } while (0)
#define spin_lock_mmio_irqsave(lock, flags)	spin_lock_irqsave(lock, flags)
#define spin_unlock_mmio_irqrestore(lock, flags)	do { spin_unlock_irqrestor=
e(lock, flags); mmiowb(); } while (0)

=2D-=20
Greetings Michael.

--nextPart4573827.eG2HhSmO3S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEEL4Glb09HEdWDKgRAtBZAJ44VLY+0W3wfWIXEQDF1kmvHe2yigCgvUw2
sietkplTWmt4zuk7puFGWhU=
=/KRq
-----END PGP SIGNATURE-----

--nextPart4573827.eG2HhSmO3S--
