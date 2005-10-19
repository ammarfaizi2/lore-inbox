Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVJSPy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVJSPy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVJSPy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:54:28 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:60355 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751121AbVJSPy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:54:28 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: large files unnecessary trashing filesystem cache?
Date: Wed, 19 Oct 2005 17:54:11 +0200
User-Agent: KMail/1.7.2
Cc: gfiala@s.netic.de
References: <200510182201.11241.gfiala@s.netic.de> <20051018213721.236b2107.akpm@osdl.org> <1129720232.435629a8753d3@webmail.LF.net>
In-Reply-To: <1129720232.435629a8753d3@webmail.LF.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1962184.kT50JWrA61";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510191754.17963.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1962184.kT50JWrA61
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wednesday 19 October 2005 13:10, gfiala@s.netic.de wrote:
> Zitat von Andrew Morton <akpm@osdl.org>:
> > So I'd also suggest a new resource limit which, if set, is copied into =
the
> > applications's file_structs on open().  So you then write a little wrap=
per
> > app which does setrlimit()+exec():
> >=20
> > 	limit-cache-usage -s 1000 my-fave-backup-program <args>
> >=20
> > Which will cause every file which my-fave-backup-program reads or write=
s to
> > be limited to a maximum pagecache residency of 1000 kbytes.
>=20
> Or make it another 'ulimit' parameter...

Which is already there: There is an ulimit for "maximum RSS",=20
which is at least a superset of "maximum pagecache residency".

This is already settable and known by many admins. But AFAIR it is not
honoured by the kernel completely, right?

But per file is a much better choice, since this would allow
concurrent streaming. This is needed to implement timeshifting at least[1].

So either I miss something or this is no proper solution yet.


Regards

Ingo Oeser

[1] Which is obviously done by some kind of on-disk FIFO.


--nextPart1962184.kT50JWrA61
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDVmwpU56oYWuOrkARAp+JAJ9w6JjZdpfjnBGCMN7fUDHm+Vhm8QCfW3ss
jtPiBgpdv6KSU3btvarf/c0=
=72WG
-----END PGP SIGNATURE-----

--nextPart1962184.kT50JWrA61--
