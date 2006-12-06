Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758818AbWLFA2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758818AbWLFA2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758829AbWLFA2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:28:42 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:19871 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758818AbWLFA2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:28:41 -0500
Date: Tue, 05 Dec 2006 19:26:37 -0500
From: Thomas Tuttle <linux-kernel@ttuttle.net>
Subject: Re: SAK and screen readers
In-reply-to: <20061205235006.GA8273@bouh.residence.ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, mrkiko.rs@gmail.com,
       dave@mielke.cc, sebastien.hinderer@loria.fr
Mail-followup-to: linux-kernel@vger.kernel.org,
	Samuel Thibault <samuel.thibault@ens-lyon.org>, mrkiko.rs@gmail.com,
	dave@mielke.cc, sebastien.hinderer@loria.fr
Message-id: <20061206002637.GA6237@lion>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=VS++wcV0S1rZb1Fb
Content-disposition: inline
References: <20061205235006.GA8273@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On December 05 at 18:50 EST, Samuel Thibault hastily scribbled:
> The problem comes when using SAK: brltty gets killed because it owns an
> fd on /dev/tty0.  This is a problem since the blind user then just can't
> use her computer any more...
> <snip>
> Could there be a solution for brltty yet not being killed by SAK? (like
> letting brltty just nicely close his fd for the current VT, and then
> re-open it later)

How about this?

brltty launches a child process that opens the VT and pipes data back
and forth to the parent process via pipes or fifos.

When the SAK is pressed, the child process will die, and the parent
process will simply relaunch it.

It seems like any solution that involves the kernel not killing brltty
will compromise the (admittedly rudimentary) security that the SAK
offers.

Hope this helps,

Thomas Tuttle

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFdg49gPpxLpYWreERAk6DAJ9q4HgYTAf5hMn4hXWn0B22qaJJ9ACfSVoh
WoVvGrtOwiBjlo67dd/7RAU=
=Uqjn
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
