Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbUKQAI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUKQAI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbUKQAHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:07:53 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:39886 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S262143AbUKPX4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:56:06 -0500
Date: Wed, 17 Nov 2004 00:56:03 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: checking if a job still uses the CPU
Message-ID: <20041116235603.GA8120@cirrus.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
X-OS: Debian GNU/Linux 3.1 kernel 2.6.8-cirrus i686
X-Mailer: Mutt 1.5.6+20040907i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I want to check a job periodically whether it still uses the CPU. If
not, I want to kill it. The latest solution I found is at

  http://madduck.net/~madduck/scratch/worker.sh
  http://madduck.net/~madduck/scratch/job.sh

worker.sh starts job.sh and polls /proc/$PID/stat:16 (the 16th
field: cutime) regularly. As soon as it stopped changing, the job is
killed.

This works fine as long as job.sh does not start jobs itself which
run longer than the period used to check in the worker (7 seconds in
my example). If job.sh's children take longer than 7 seconds to
complete, job.sh might get killed because the cutime value of
a process in /proc is only updated whenever a child returns.

Is there another way to achieve what I am trying to do? How can
I kill jobs that are idling and have not used the CPU in $DELAY
time?

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"we are like shop windows in which we are continually arranging,
 concealing or illuminating the supposed qualities other ascribe to us
 -- in order to deceive ourselves."
                                                 - friedrich nietzsche

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBmpOTIgvIgzMMSnURAmxgAKCBatgIRrMhuM4EgY+tj6IAttgDNgCcDACl
0OGYv2sbCqWJcuuMBplLVJ4=
=K/G7
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
