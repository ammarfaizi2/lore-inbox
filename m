Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbVKPSQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbVKPSQX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVKPSQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:16:23 -0500
Received: from mail.gondor.com ([212.117.64.182]:7691 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1030350AbVKPSQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:16:22 -0500
Date: Wed, 16 Nov 2005 19:16:17 +0100
From: Jan Niehusmann <jan@gondor.com>
To: bart@samwel.tk
Cc: linux-kernel@vger.kernel.org
Subject: Laptop mode causing writes to wrong sectors?
Message-ID: <20051116181612.GA9231@knautsch.gondor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Cc: to linux-kernel, in case somebody else is interested in this as well)

Hi Bart,

let me start by stating that the following is mainly guessed. I may be
completely wrong. Still I think you may be interested in my
observations, and perhaps you already got similar reports?

On my laptop, running 2.6.14, I'm observing some strange file- and
filesystem corruptions. First, I thought it may have been caused by an
ext3 bug because the first corruption I did observe happened shortly
after an ext3 journal replay.

I did report this to linux-kernel, but without any helpful response:
http://www.ussg.iu.edu/hypermail/linux/kernel/0511.0/0129.html
(Subject: ext3 corruption: "JBD: no valid journal superblock found")

But now, I got another hint pointing to a possible cause of this
problem: I found a file - /usr/lib/libatlas.so.3.0 - which was corrupted
by 4k of it being overwritten by a different file, which I recognized.=20
And that file happened to be an uncompressed manual page.

As usually the manual pages are only stored compressed, this must have
happened when I actually did look at that manual page, which causes the
uncompressed version to be written to a file in /tmp/. And the best is:
I actually remember when I did read that man page, and it was while the
notebook ran on battery power, which is quite seldom. On battery power,
I have laptop mode activated and the hard disk spun down after a short
idle time.

Why do I think this is related to the corruption? Well, on the one hand,
I'm compiling kernels quite often, tracking linus' git repository, and
I'm regularly upgrading my system to debian unstable, both involving
hundreds of megabytes of disk writes - and I never observed a single
problem while doing so. On the other hand, a simple look at a short
manual page did cause file system corruption. This would be rather
strange if the corruption happened at random disk writes. But kernel
compiles as well as system upgrades involve regular writes to the hard
disk, which therefore doesn't spin down. (And additionally, I usually
don't do such things while running on battery.) Reading the man page
happend while the system was quite idle, and it may have been the read
of the compressed image or the write to the temporary file which spun up
the hard drive. (To be exact, I looked at the man page more than once -
so the second time, the compressed image probably was cached and reading
it didn't require filesystem access, so it really could have been the
write triggering the spin up)

Well, quite a long mail for a little observation, and sorry if you think
that I wasted your time. Did I? Or may my suspicion be true and there is
some connection between laptop mode and the corruptions I observe?

Thanks for reading all this stuff ;-)=20

Jan


--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ3t3ZoFL8fYptN/eAQIR7wP/d8Ea3yGBDqh2Pggkn3cOzABuclMm+V3s
1VAHaRdoNhefMTohBzu3UnEcXUtWv0Io9NSJgeFLqPxiDECZkAHgPuKW5LoZM2GD
euRW5JCNYw5rNX3VDfMvW1CxNyIIndZccEBIwwyFvuRRzIrdcjWgyZJPJPTDZmDR
Vgs3bu9L9yI=
=B1K3
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
