Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTEMPAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbTEMPAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:00:23 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:48263 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id S261364AbTEMPAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:00:20 -0400
Date: Tue, 13 May 2003 10:13:01 -0500
From: Bob McElrath <bob+debian-alpha@mcelrath.org>
To: debian-alpha@lists.debian.org
Cc: linux-kernel@vger.kernel.org
Subject: alpha kernel memory leak
Message-ID: <20030513151300.GB26879@mcelrath.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have noticed that my alphas seems to have a gigantic memory leak.  I
have two machines, one with 2GB memory and one with 512MB memory.  When
I first boot up the machines run fine, but over time the amount of
memory available decreases steadily to zero.

At first I thought it was just poor VM code in linux that caused it, but
I ran for a couple of days with the swap turned off, and the results are
the same. =20

'ps' does not correctly report memory information anymore (latest debian
unstable -- why?), but using top and summing the VIRT, I get 202MB on
the 512MB machine, and top reports 505MB used, 5MB free, and 25MB
cached. Clearly something is horribly wrong.  The 2GB machine is
reporting that almost all memory is full (free + buffers + cached is
only different from the sum of VIRT by 150 MB).  But it is not used as
heavily so presumably it is leaking slower.  uptime is 4 days on the
512MB machine, 9 days on the 2GB machine.

The kernels on these two machines are 2.4.21-pre7 (2GB) and
2.4.21-rc1-ac1 (512MB), but this is something that I have noticed for
more than a year accross many kernels.

I have plotted the memory usage every 60 seconds over the last 3 days on
the 512MB machine (swap was turned off).  On first bootup I can run many
xterms, galeon, and xmms with no problem.  After 4 days both were killed
with OOM, but notice in the plots that the amount of memory available
hasn't changed, despite the fact that these (and X) are the largest
memory consuming processes running.  It is here:
    http://mcelrath.org/mem.log.ps.gz

Cheers,
Bob McElrath [Univ. of Wisconsin at Madison, Department of Physics]

    "You measure democracy by the freedom it gives its dissidents, not the
    freedom it gives its assimilated conformists." -- Abbie Hoffman


--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+wQt8jwioWRGe9K0RAj3rAKC3lgaQXUqlgI5H7U3ZqvPr3LKf5gCfaCSV
wVkJrVutkPnk8jXZHHX/HIY=
=fzF9
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
