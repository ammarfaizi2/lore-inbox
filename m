Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263039AbVEIEAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbVEIEAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 00:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbVEIEAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 00:00:37 -0400
Received: from zak.futurequest.net ([69.5.6.152]:7877 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S263039AbVEID6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 23:58:30 -0400
Date: Sun, 8 May 2005 21:58:23 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: How to diagnose a kernel memory leak
Message-ID: <20050509035823.GA13715@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings.

I am trying to diagnose a slow kernel memory leak, and am having no luck
in pining it down.

I am currently running unpatched 2.6.12-rc3 (x86 on Gentoo, I saw the
same symptoms with gentoo-sources 2.6.11-r6 and 2.6.11-r4.  Over the
course of several days, the server in question has the amount of
available memory (free minus buffers+cache) gradually decrease.  If I
leave it go, it does eventually thrash itself to death after about a
week (give or take).  The rate is about 150MB per day (the system has
2GB of RAM total so it takes several days).  The working set of
processes remains the same through the whole period at between 50-150MB
(depending on if you count VSZ or RSS).  Nothing shows up in dmesg
except for a couple of one-time lockd and nfs messages  (the system uses
two remote filesystems).  The local filesystems are ReiserFS on a 3Ware
7500-4 controller, and the NIC is an Intel E100.

# free
             total       used       free     shared    buffers     cached
Mem:       2076180    2024068      52112          0     166760      93200
-/+ buffers/cache:    1764108     312072
Swap:      1028152         56    1028096

# cat /proc/meminfo
MemTotal:      2076180 kB
MemFree:         63080 kB
Buffers:        158776 kB
Cached:          91664 kB
SwapCached:          4 kB
Active:        1055244 kB
Inactive:       874660 kB
HighTotal:     1179072 kB
HighFree:          640 kB
LowTotal:       897108 kB
LowFree:         62440 kB
SwapTotal:     1028152 kB
SwapFree:      1028096 kB
Dirty:             768 kB
Writeback:           0 kB
Mapped:          12648 kB
Slab:            69872 kB
CommitLimit:   2066240 kB
Committed_AS:    26316 kB
PageTables:       1492 kB
VmallocTotal:   114680 kB
VmallocUsed:      4700 kB
VmallocChunk:   109784 kB

I would be happy to provide any additional information.  As it stands, I
have to reboot about once a week to clear the RAM or else it thrashes
itself to death.
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCft/f6W+y3GmZgOgRAuTVAKChERJiGSuVftJWehMwZsGfF8CxvQCgqlcR
ku+lzzGDFaDRCjmG0K7sL/M=
=YGxn
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
