Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269240AbUHaWcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269240AbUHaWcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269121AbUHaWYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:24:53 -0400
Received: from mout1.freenet.de ([194.97.50.132]:9359 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S269099AbUHaWQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:16:56 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: What policy for BUG_ON()?
Date: Wed, 1 Sep 2004 00:16:30 +0200
User-Agent: KMail/1.7
References: <1093964782.434.7054.camel@cube> <1093973977.434.7097.camel@cube> <F8184F90-FB94-11D8-9B58-000393ACC76E@mac.com>
In-Reply-To: <F8184F90-FB94-11D8-9B58-000393ACC76E@mac.com>
Cc: Albert Cahalan <albert@users.sf.net>,
       Albert Cahalan <albert@users.sourceforge.net>, axboe@suse.de,
       bunk@fs.tum.de, Linus Torvalds <torvalds@osdl.org>, arjanv@redhat.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1795912.L1NiqqKKrm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409010016.36570.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1795912.L1NiqqKKrm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Kyle Moffett <mrmacman_g4@mac.com>:
> Then in most cases new statements would use BUG_CHECK, especially if
> they contain expensive unnecessary function calls or critical sections.
>=20
> This would break the least amount of existing code, and provide both
> methods to kernel developers.

So, back to the real world. ;)
=2D Where do we insert BUG_ON()s?
Only in places, where we are going to crash or corrupt data soon.

=2D Do we insert "expensive unnecessary function calls" in a BUG_ON()?
No we don't. Could you give a good example, which
needs an expensive call inside a BUG_ON()?

In a shiny good world we expect BUG()s to never trigger. So I think
it's a bit crazy to check for things that theoretically can't happen
and waste tons of CPU cycles for this, with expensive calls.
If we really want to check this while debugging, I think we
should explicitely honor the DEBUG define in the code and have
our own debug printk() that shows the mess.

I think here's a general confusion about what BUG_ON() is intended
for. I think (I'm not the author of it, so I can't say 100%. :) )
it is _not_ for debugging while development. It is for checking unpossible
things, that blow up the whole machine if they trigger nevertheless.
So I think it's wrong to let BUG_ON() depend on a DEBUG define, because
DEBUG is, by definition, not enabled in the kernels people use.
But I think we _want_ that people evaluate the BUG_ON()s.

I'm not talking of embedded systems, etc... .

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


--nextPart1795912.L1NiqqKKrm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBNPjEFGK1OIvVOP4RAn1rAKCXWVmCdwzDLtcgbofA3xdGITsiLwCdHzTe
jnpuvh0Z55SvU1JkWACHqmY=
=UD8e
-----END PGP SIGNATURE-----

--nextPart1795912.L1NiqqKKrm--
