Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264892AbTL2Siy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbTL2Siy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:38:54 -0500
Received: from smtp2.actcom.co.il ([192.114.47.15]:42985 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S264892AbTL2Siw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:38:52 -0500
Date: Mon, 29 Dec 2003 20:38:47 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@zip.com.au>, Muli Ben-Yehuda <mulix@mulix.org>
Subject: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
Message-ID: <20031229183846.GI13481@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6CXocAQn8Xbegyxo"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6CXocAQn8Xbegyxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've had a bit of time on my hands in the last few days, and gave
sound/oss/trident.c a much needed cleanup. The changes are mostly
cleanups, a few bug fixes where we wouldn't do cleanup properly on
error paths, and the removal of lock_kernel()/unlock_kernel().

If anyone who has this sound card wishes to take the driver for a
spin, I'd love bug/success reports. Especially on SMP and/or machines
with multiple trident cards. Andrew, if you feel it's appropriate for
-mm, please include it.=20

The patch against 2.6.0 is rather large. 140kb unzipped, 30kb
gzipped. It's available at
http://www.mulix.org/patches/trident-cleanup-B1-2.6.0.diff (gzipped:
http://www.mulix.org/patches/trident-cleanup-B1-2.6.0.diff.gz)

Summary of changes:=20

- run the code through Lindent, and then fix it manually (this is the
bulk of the patch)=20
- switch lock_set_fmt() and unlock_set_fmt() from macros to inline
functions. Macros that call return() are EVIL.=20
- simplify lock_set_fmt() and implement it via test_and_set_bit().=20
- fix a bug wherein we would do an up() on a semaphore that hasn't
been down()ed if a signal happened after timeout in trident_write()
- fix a bug where we would not release the open_sem on OOM
- make the arguments for prog_dmabuf clearer (int -> enum)=20
- fix a bug where we would call VALIDATE_STATE after
lock_kernel(). Since VALIDATE_STATE does 'return' if validation fails,
bad things can happen. Thanks to Dawson Engler <engler@stanford.edu>
and the Stanford checker for spotting.
- remove the calls to lock_kernel() from trident_release() and
trident_mmap(). trident_release() appears to be covered by the
open_sem, and trident_mmap() is covered by state->sem.=20
- s/TRUE/1/, s/FALSE/0/

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--6CXocAQn8Xbegyxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8HS2KRs727/VN8sRAmfXAJ0Q8lmw7lkaVpNrgQf61DGG6rCC8wCgqlvd
xW8RPBsQLLROBk/F+OLK02k=
=ayLU
-----END PGP SIGNATURE-----

--6CXocAQn8Xbegyxo--
