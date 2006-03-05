Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751855AbWCECEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWCECEq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 21:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWCECEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 21:04:46 -0500
Received: from mout1.freenet.de ([194.97.50.132]:13762 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1751787AbWCECEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 21:04:45 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Memory barriers and spin_unlock safety
Date: Sun, 5 Mar 2006 03:04:40 +0100
User-Agent: KMail/1.8.3
References: <32518.1141401780@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org> <17417.29375.87604.537434@cargo.ozlabs.ibm.com>
In-Reply-To: <17417.29375.87604.537434@cargo.ozlabs.ibm.com>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arch@vger.kernel.org, bcrl@linux.intel.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, mingo@redhat.com,
       linuxppc64-dev@ozlabs.org, jblunck@suse.de,
       Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Message-Id: <200603050304.41436.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart1188511.K669AMxjeT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1188511.K669AMxjeT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 04 March 2006 11:58, you wrote:
> Linus Torvalds writes:
>=20
> > PPC has an absolutely _horrible_ memory ordering implementation, as far=
 as=20
> > I can tell. The thing is broken. I think it's just implementation=20
> > breakage, not anything really fundamental, but the fact that their writ=
e=20
> > barriers are expensive is a big sign that they are doing something bad.=
=20
>=20
> An smp_wmb() is just an eieio on PPC, which is pretty cheap.  I made
> wmb() be a sync though, because it seemed that there were drivers that
> expected wmb() to provide an ordering between a write to memory and a
> write to an MMIO register.  If that is a bogus assumption then we
> could make wmb() lighter-weight (after auditing all the drivers we're
> interested in, of course, ...).

In the bcm43xx driver there is code which looks like the following:

/* Write some coherent DMA memory */
wmb();
/* Write MMIO, which depends on the DMA memory
 * write to be finished.
 */

Are the assumptions in this code correct? Is wmb() the correct thing
to do here?
I heavily tested this code on PPC UP and did not see any anormaly, yet.

=2D-=20
Greetings Michael.

--nextPart1188511.K669AMxjeT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBECkc5lb09HEdWDKgRApuIAJwMAakFvgtIbq37IZLzPaBIdxtugQCfbR28
PW5W8HI7rbyYI0WT7iHd/nE=
=xFGE
-----END PGP SIGNATURE-----

--nextPart1188511.K669AMxjeT--
