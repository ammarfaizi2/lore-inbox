Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUAVTeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266346AbUAVTeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:34:20 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:39092 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S266339AbUAVTdw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:33:52 -0500
Date: Fri, 23 Jan 2004 08:36:40 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: PATCH: Shutdown IDE before powering off.
In-reply-to: <m3y8rzlrj5.fsf@lugabout.jhcloos.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074800199.12771.110.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-gLk2vwqPfFk3S3V+4vGA";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1074735774.31963.82.camel@laptop-linux>
 <20040121234956.557d8a40.akpm@osdl.org>
 <200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk>
 <m3y8rzlrj5.fsf@lugabout.jhcloos.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gLk2vwqPfFk3S3V+4vGA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Well, as far as Suspend can see, all the data has been written. By the
time we reach this point, the end_buffer_io_async routine has been
called for every write submitted, and the last write submitted by
anything else was at least a few seconds ago (all other processes are
frozen and drivers suspended), so all data _should_ be on disk already
and sync should do nothing. Actually, we wouldn't want to call sync
anyway for reasons I won't go into here (unnecessary complication). I'm
sure you'd agree that we would want to delay for an arbitrary length of
time either (no guarantees that that would cut the mustard). We need to
flush caches properly.

Regards,

Nigel

On Fri, 2004-01-23 at 08:19, James H. Cloos Jr. wrote:
> John> I think it is an attempt to force some broken drives to flush
> John> their cache, but I wonder whether it will simply move the
> John> problem from one set of broken drives to another :-).
>=20
> It will.  I've had to work with a few drives or drive combos over
> the years that would not spin up reliably.  It was vital to keep
> them spinning once they were (all) up.  Adding this would make
> reboot unnecessarily unuseable in such cases.  Perhaps just
> flush, pause, flush would work as well?
>=20
> Or even the logical equivilent to sync;sync;sync;reboot?
>=20
> -JimC
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-gLk2vwqPfFk3S3V+4vGA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAECZHVfpQGcyBBWkRAtGTAJ9vP47JpdlryLRHmurPo1O03G97HgCeOjjr
XfmQfOFfJ9rvpRjbPs1wXE0=
=qTxh
-----END PGP SIGNATURE-----

--=-gLk2vwqPfFk3S3V+4vGA--

