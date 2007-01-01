Return-Path: <linux-kernel-owner+w=401wt.eu-S932235AbXAAVlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbXAAVlP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 16:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbXAAVlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 16:41:15 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:60488 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbXAAVlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 16:41:14 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
Date: Mon, 1 Jan 2007 22:40:58 +0100
User-Agent: KMail/1.9.5
Cc: Amit Choudhary <amit2030@yahoo.com>, Bernd Petrovitsch <bernd@firmix.at>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <88880.94256.qm@web55601.mail.re4.yahoo.com> <200701011709.48349.ioe-lkml@rameria.de> <je3b6uhfz4.fsf@sykes.suse.de>
In-Reply-To: <je3b6uhfz4.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2672794.2fjJhaRq9u";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701012241.08240.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2672794.2fjJhaRq9u
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday, 1. January 2007 17:25, Andreas Schwab wrote:
> Ingo Oeser <ioe-lkml@rameria.de> writes:
> > Then this works, because the side effect (+20) is evaluated only once.=
=20
>=20
> It's not a side effect, it's a non-lvalue, and you can't take the address
> of a non-lvalue.

Just verified this. So If we cannot make it work in all cases, it will
cause more problems then it will solve.

So we are left with a function, which will=20
a) only be used by janitors to provide "kfree(x); x =3D NULL;"=20
    with an macro KFREE(x) in all the simple cases.

b) be used by developers, who are aware of the fact that reusable
    pointer values should set to NULL after kfree().

Doing a) and b) is "running into open doors", so doesn't prevent any
error, obfuscates code more and works only sometimes.

I give up here and would vote for dropping that idea then.


Regards

Ingo Oeser

--nextPart2672794.2fjJhaRq9u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFmX/0U56oYWuOrkARAvjeAJ9har8a5I+JkKCCVtM02Pfk6EfGWACZAfGN
vmzkSC2ExUY6QsxZjl4xTmY=
=So/a
-----END PGP SIGNATURE-----

--nextPart2672794.2fjJhaRq9u--
