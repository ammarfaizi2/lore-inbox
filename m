Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbSJUHU0>; Mon, 21 Oct 2002 03:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261186AbSJUHU0>; Mon, 21 Oct 2002 03:20:26 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:36658 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S261177AbSJUHUZ>; Mon, 21 Oct 2002 03:20:25 -0400
Date: Mon, 21 Oct 2002 09:26:29 +0200
From: Kurt Garloff <garloff@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Priorities for I/O
Message-ID: <20021021072629.GD6630@nbkurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Jens Axboe <axboe@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-UL1 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens,

one of the shortcomings of Linux process priority system is that it only
affects CPU resources (and even those are not affected strongly enough for
some applications).=20
As soon as processes waits for I/O, they are all equal.

I wonder how difficult it was to just add priorities to your I/O scheduler.
Basically, I think everything is there: You sort requests already and we
have deadlines. For sorting scores are used.
So the idea is: Why not just give I/O submitted on behalf of -19 processes
(and RT) some higher score and a shorter deadline than +19 ones?
Probably, it would only affect reads, as there we have the processes wait
on them; writes are often triggered asynchronously anyway.

This should have the effects that we want: When there's no fight for I/O
bandwidth, everybody just gets maximum performance as the I/O scheduler's
queue will be short. As soon as processes fight for reads, unniced processes
have a higher chance of getting served first.

Just think of nightly updatedb on a webserver for a real-world example why
this may matter.

Looks like something not too difficult to do, but my current knowledge on
2.5 code is somewhat sparse :-(

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers                        SuSE Labs
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9s6wkxmLh6hyYd04RAl8OAKCAaWpz82ZBeqtiAFewJM3IrSHEMQCgkokS
cyzk5FRuXZ7MaifCiSd9nwg=
=HuCi
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
