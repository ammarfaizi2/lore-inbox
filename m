Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUANTOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbUANTNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:13:35 -0500
Received: from smtp03.web.de ([217.72.192.158]:34063 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262888AbUANTNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:13:08 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.1-mm3
Date: Wed, 14 Jan 2004 20:11:44 +0100
User-Agent: KMail/1.5.4
References: <20040114014846.78e1a31b.akpm@osdl.org>
In-Reply-To: <20040114014846.78e1a31b.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_4RZBAa05S+oHQW+";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401142011.52301.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_4RZBAa05S+oHQW+
Content-Type: multipart/mixed;
  boundary="Boundary-01=_wRZBAxDXQpKicFf"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_wRZBAxDXQpKicFf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi,

the patch "sched-sibling-map-to-cpumask.patch" inroduced following compile=
=20
error on UP machines:

  CC [M]  arch/i386/kernel/cpu/cpufreq/p4-clockmod.o
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c: In function `cpufreq_p4_setdc':
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:71: error: `cpu_sibling_map'=20
undeclared (first use in this function)
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:71: error: (Each undeclared=20
identifier is reported only once
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:71: error: for each function it=
=20
appears in.)

The attached patch fixes it...

  Thomas Schlichter

--Boundary-01=_wRZBAxDXQpKicFf
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix_p4-clockmod.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fix_p4-clockmod.diff"

=2D-- linux-2.6.1-mm3/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c.orig	2004-=
01-14 18:15:05.891246656 +0100
+++ linux-2.6.1-mm3/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2004-01-14 1=
8:27:35.876231608 +0100
@@ -68,7 +68,11 @@
 	cpus_allowed =3D current->cpus_allowed;
=20
 	/* only run on CPU to be set, or on its sibling */
+#ifdef CONFIG_SMP
 	affected_cpu_map =3D cpu_sibling_map[cpu];
+#else
+	affected_cpu_map =3D cpumask_of_cpu(cpu);
+#endif
 	set_cpus_allowed(current, affected_cpu_map);
         BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
=20

--Boundary-01=_wRZBAxDXQpKicFf--

--Boundary-03=_4RZBAa05S+oHQW+
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBABZR4YAiN+WRIZzQRAnXgAJ94E83PAyfgBF68vaQwjFxTtok2zQCg9wnF
TciYPrTWt1mx8nrJV6Tc1GM=
=c/Gy
-----END PGP SIGNATURE-----

--Boundary-03=_4RZBAa05S+oHQW+--

