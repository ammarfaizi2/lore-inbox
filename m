Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272073AbTHDSOM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272075AbTHDSOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:14:12 -0400
Received: from mx2.undergrid.net ([64.174.245.170]:4257 "EHLO
	mail.undergrid.net") by vger.kernel.org with ESMTP id S272073AbTHDSOE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:14:04 -0400
Date: Mon, 4 Aug 2003 11:12:21 -0700
From: "Jeremy T. Bouse" <Jeremy.Bouse@UnderGrid.net>
To: linux-kernel@vger.kernel.org, breed@users.sourceforge.net
Subject: Re: PROBLEM: Problem with wireless PCMCIA card insertion on 2.6.0-test2
Message-ID: <20030804181221.GA3340@UnderGrid.net>
References: <20030804171858.GA3215@UnderGrid.net> <20030804190133.D25847@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20030804190133.D25847@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2003 at 07:01:33PM +0100, Russell King wrote:
> On Mon, Aug 04, 2003 at 10:18:59AM -0700, Jeremy T. Bouse wrote:
> > [1.]
> > Problem with Wireless PCMCIA card insertion.
>=20
> PCMCIA or CardBus?
>
	My bad it is a CardBus bridge using the yenta socket
CONFIG_CARDBUS=3Dy
=20
> > [5.]
> > Jul 28 18:02:10 vaio kernel: airo:  Probing for PCI adapters
> > Jul 28 18:02:10 vaio kernel: kobject_register failed for airo (-17)
>=20
> This looks like an error in airo.  For starters, it doesn't unregister
> its PCI driver structure when the module removed, so when it is
> inserted the next time, you get this complaint.
>=20
> (You can only have one driver called "airo" registered with the device
> model.)
>
	I am currently compiling -test2-bk4 to test it out and see if
there is any change... I did notice a patch to airo.c in it... I'll
advise if there is any change good or bad...=20
=20
>=20
> Oops, it seems to be scheduling from timer context.  That's pretty bad.
> I guess this is the culpret:
>=20
> static u16 issuecommand(struct airo_info *ai, Cmd *pCmd, Resp *pRsp) {
> ...
>                 if (!in_interrupt() && (max_tries & 255) =3D=3D 0)
>                         schedule();
> ...
> }
>=20
	This must be active only if CONFIG_PREEMPT is set as the atomic
errors did seem to cease after recompiling with CONFIG_PREEMPT not being
set...=20

	Regards,
	Jeremy T. Bouse

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE/LqIFVExIaGLb32IRArayAJ0dfKnUdH6uHBCVtYcgXtC0dw4j6ACgi6jJ
0DrSSKyE67UaQvseWaWPnKE=
=s6UQ
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
