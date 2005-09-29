Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVI2It7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVI2It7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 04:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVI2It7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 04:49:59 -0400
Received: from mail.parbin.co.uk ([213.162.111.43]:57480 "EHLO
	mail.parbin.co.uk") by vger.kernel.org with ESMTP id S1751250AbVI2It6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 04:49:58 -0400
Date: Thu, 29 Sep 2005 09:47:24 +0100
From: Alexander Clouter <alex@digriz.org.uk>
To: LKML <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Blaisorblade <blaisorblade@yahoo.it>, alex-kernel@digriz.org.uk
Subject: [patch 1/1] cpufreq: documentation for 'ondemand' and 'conservative'
Message-ID: <20050929084724.GD3169@inskipp.digriz.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Content-Disposition: inline
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8TaQrIeukR7mmbKf
Content-Type: multipart/mixed; boundary="Yb+qhiCg54lqZFXW"
Content-Disposition: inline


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Added a more verbose entry for the 'ondemend' governor and an entry for the=
=20
'conservative' governor to the documentation.

Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>

--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="02_ondemand-and-conservative-documentation.diff"
Content-Transfer-Encoding: quoted-printable

diff -r -u linux-2.6.13.orig/Documentation/cpu-freq/governors.txt linux-2.6=
=2E13/Documentation/cpu-freq/governors.txt
--- linux-2.6.13.orig/Documentation/cpu-freq/governors.txt	2005-09-23 15:25=
:14.302954250 +0100
+++ linux-2.6.13/Documentation/cpu-freq/governors.txt	2005-09-23 15:36:09.8=
75925000 +0100
@@ -27,6 +27,7 @@
 2.2  Powersave
 2.3  Userspace
 2.4  Ondemand
+2.5  Conservative
=20
 3.   The Governor Interface in the CPUfreq Core
=20
@@ -110,9 +111,64 @@
=20
 The CPUfreq govenor "ondemand" sets the CPU depending on the
 current usage. To do this the CPU must have the capability to
-switch the frequency very fast.
-
+switch the frequency very quickly.  There are a number of sysfs file
+accessible parameters:
=20
+sampling_rate: measured in uS (10^-6 seconds), this is how often you
+want the kernel to look at the CPU usage and to make decisions on
+what to do about the frequency.  Typically this is set to values of
+around '10000' or more.
+
+show_sampling_rate_(min|max): the minimum and maximum sampling rates
+available that you may set 'sampling_rate' to.
+
+up_threshold: defines what the average CPU usaged between the samplings
+of 'sampling_rate' needs to be for the kernel to make a decision on
+whether it should increase the frequency.  For example when it is set
+to its default value of '80' it means that between the checking
+intervals the CPU needs to be on average more than 80% in use to then
+decide that the CPU frequency needs to be increased. =20
+
+sampling_down_factor: this parameter controls the rate that the CPU
+makes a decision on when to decrease the frequency.  When set to its
+default value of '5' it means that at 1/5 the sampling_rate the kernel
+makes a decision to lower the frequency.  Five "lower rate" decisions
+have to be made in a row before the CPU frequency is actually lower.
+If set to '1' then the frequency decreases as quickly as it increases,
+if set to '2' it decreases at half the rate of the increase.
+
+ignore_nice: this parameter takes a value of '0' or '1', when set to
+'0' then all processes are counted towards towards the 'cpu
+utilisation' value.   When set to '1' (its default) then processes that
+are run with a 'nice' value will not count (and thus be ignored) in
+the overal usage calculation.  This is useful if you are running a CPU
+intensive calculation on your laptop that you do not care how long it
+takes to complete as you can 'nice' it and prevent it from taking part
+in the deciding process of whether to increase your CPU frequency.
+
+
+2.5 Conservative
+----------------
+
+The CPUfreq governor "conservative", much like the "ondemand"
+governor, sets the CPU depending on the current usage.  It differs in
+behaviour in that it gracefully increases and decreases the CPU speed
+rather than jumping to max speed the moment there is any load on the
+CPU.  This behaviour more suitable in a battery powered environment.
+The governor is tweaked in the same manner as the "ondemand" governor
+through sysfs with the addition of:
+
+freq_step: this describes what percentage steps the cpu freq should be
+increased and decreased smoothly by.  By default the cpu frequency will
+increase in 5% chunks of your maximum cpu frequency.  You can change this
+value to anywhere between 0 and 100 where '0' will effectively lock your
+CPU at a speed regardless of its load whilst '100' will, in theory, make
+it behave identically to the "ondemand" governor.
+
+down_threshold: same as the 'up_threshold' found for the "ondemand"
+governor but for the opposite direction.  For example when set to its
+default value of '20' it means that if the CPU usage needs to be below
+20% between samples to have the frequency decreased.
=20
 3. The Governor Interface in the CPUfreq Core
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--Yb+qhiCg54lqZFXW--

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDO6ocNv5Ugh/sRBYRAla6AJ9nhfweyXmARco+vYd09y93fxOGxwCffGpY
xZwoKeGLPDfqywt/7TubscE=
=R8/S
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--
