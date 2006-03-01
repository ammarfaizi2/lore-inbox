Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWCALVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWCALVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 06:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWCALVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 06:21:19 -0500
Received: from mout1.freenet.de ([194.97.50.132]:60084 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S964916AbWCALVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 06:21:19 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Generic hardware RNG support
Date: Wed, 1 Mar 2006 12:21:04 +0100
User-Agent: KMail/1.8.3
References: <200602281229.12887.mbuesch@freenet.de> <20060301004039.GA14229@plexity.net> <81D78F6B-7492-4DE0-A82D-F647869B3A40@kernel.crashing.org>
In-Reply-To: <81D78F6B-7492-4DE0-A82D-F647869B3A40@kernel.crashing.org>
Cc: Michael Buesch <mbuesch@freenet.de>, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, dsaxena@plexity.net
MIME-Version: 1.0
Message-Id: <200603011221.05192.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart2069984.XQRfkH4eLB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2069984.XQRfkH4eLB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 01 March 2006 03:57, you wrote:
> > Hi, I'll email you the patchset off-list so you can look at the API
> > and write the bcm43xx driver against it.  They are a few months old =20
> > and
> > need updating to 2.6.latest and it is on my 2.6.18 TODO. If you =20
> > search the
> > archives there were a few small issues left such as separating out =20
> > all the
> > x86 stuff into separate amd, via, and intel code instead of having =20
> > a single
> > file.
>=20
> Are the patches in any state to include in -mm?

I don't think so. In fact, I think they are lacking important
functionality, which is present in my patches.
What about this: I change my patches to split the whole RNG
code into a "core" and the various drivers. That is basically
what Deepak Saxena's patches do and mine not, yet.
Support for multiple RNGs in the system at the same time is missing
in Deepak Saxena's patches. This support is important for the
bcm43xx driver, for example.
The rng_operations structure (which I renamed to struct hwrng)
lacks a few (more or less) important members. The n_bytes field
for example. Not every driver is able to generate sizeof(u32) bytes
for every read_data. (That is the case for bcm43xx and others).
The init and cleanup callbacks are less important, athough they
are often convenient. So I would like to have them, too.

To summerize, I'd like to change my patches:
=2D Split it into core + drivers.
=2D Get rid of the ugly struct pci_dev *dev; in struct hwrng.
=2D Remove the dependency for PCI from the core.
=2D Maybe remove some of the redundant asserts the some hardware routines.
=2D Fix a few minor bugs I spotted after submitting. Oops :D

and re-submit them to andrew.
I think this is also less work than resyncing Deepak Saxena's patches.

=2D-=20
Greetings Michael.

--nextPart2069984.XQRfkH4eLB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEBYOhlb09HEdWDKgRAhfoAJsHTCclv1eQygYgVgG+6d8veIYeuQCfbCEV
syZoFMH3KD6HhrKfEehgrqY=
=iYGY
-----END PGP SIGNATURE-----

--nextPart2069984.XQRfkH4eLB--
