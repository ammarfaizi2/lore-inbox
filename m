Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVI2It7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVI2It7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 04:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVI2It6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 04:49:58 -0400
Received: from mail.parbin.co.uk ([213.162.111.43]:57736 "EHLO
	mail.parbin.co.uk") by vger.kernel.org with ESMTP id S1751125AbVI2It6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 04:49:58 -0400
Date: Thu, 29 Sep 2005 09:44:35 +0100
From: Alexander Clouter <alex@digriz.org.uk>
To: LKML <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Blaisorblade <blaisorblade@yahoo.it>, alex-kernel@digriz.org.uk
Subject: [patch 1/1] cpufreq_conservative: invert meaning of 'ignore_nice'
Message-ID: <20050929084435.GC3169@inskipp.digriz.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JwB53PgKC5A7+0Ej
Content-Type: multipart/mixed; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The use of the 'ignore_nice' sysfs file is confusing to anyone using.  This=
=20
patch makes it so when you now set it to the default value of 1, process ni=
ce=20
time is also ignored in the cpu 'busyness' calculation.

Prior to this patch to set it to '1' to make process nice time count...even=
=20
confused me :)

WARNING: this obvious breaks any userland tools that expect things to be th=
e=20
other way round.  This patch clears up the confusion but should go in ASAP =
as=20
at the moment it seems very few tools even make use of this functionality;=
=20
all I could find was a Gentoo Wiki entry.

Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>

--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_inverse_ignore_nice_flag.diff"
Content-Transfer-Encoding: quoted-printable

diff -u linux-2.6.13.orig/drivers/cpufreq/cpufreq_conservative.c linux-2.6.=
13/drivers/cpufreq/cpufreq_conservative.c
--- linux-2.6.13.orig/drivers/cpufreq/cpufreq_conservative.c	2005-09-23 15:=
24:46.605223250 +0100
+++ linux-2.6.13/drivers/cpufreq/cpufreq_conservative.c	2005-09-23 15:24:30=
=2E740231750 +0100
@@ -93,7 +93,7 @@
 {
 	return	kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait +
-		( !dbs_tuners_ins.ignore_nice ?=20
+		( dbs_tuners_ins.ignore_nice ?=20
 		  kstat_cpu(cpu).cpustat.nice :
 		  0);
 }
@@ -515,7 +515,7 @@
 			def_sampling_rate =3D (latency / 1000) *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
-			dbs_tuners_ins.ignore_nice =3D 0;
+			dbs_tuners_ins.ignore_nice =3D 1;
 			dbs_tuners_ins.freq_step =3D 5;
=20
 			dbs_timer_init();
diff -u linux-2.6.13.orig/drivers/cpufreq/cpufreq_ondemand.c linux-2.6.13/d=
rivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.13.orig/drivers/cpufreq/cpufreq_ondemand.c	2005-09-23 15:24:4=
6.609223500 +0100
+++ linux-2.6.13/drivers/cpufreq/cpufreq_ondemand.c	2005-09-23 15:24:08.846=
863500 +0100
@@ -86,7 +86,7 @@
 {
 	return	kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait +
-		( !dbs_tuners_ins.ignore_nice ?=20
+		( dbs_tuners_ins.ignore_nice ?=20
 		  kstat_cpu(cpu).cpustat.nice :
 		  0);
 }
@@ -424,7 +424,7 @@
 			def_sampling_rate =3D (latency / 1000) *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate =3D def_sampling_rate;
-			dbs_tuners_ins.ignore_nice =3D 0;
+			dbs_tuners_ins.ignore_nice =3D 1;
=20
 			dbs_timer_init();
 		}

--KN5l+BnMqAQyZLvT--

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDO6lzNv5Ugh/sRBYRAvrVAJ0Sqytl1vMcA/lSsG0sycKgunv6nwCeIMe8
EPCT+XzR+jDoAalnp5flRUw=
=GI2g
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
