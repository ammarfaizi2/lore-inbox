Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUHTJd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUHTJd6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 05:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUHTJd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 05:33:58 -0400
Received: from smtprelay02.uni-oldenburg.de ([134.106.40.86]:24783 "EHLO
	smtprelay02.uni-oldenburg.de") by vger.kernel.org with ESMTP
	id S265812AbUHTJdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 05:33:50 -0400
Date: Fri, 20 Aug 2004 11:33:44 +0200
From: matthias brill <matthias.brill@akamail.com>
To: jeremy@goop.org, linux-kernel@vger.kernel.org
Subject: banias with different (unusual?) model_name
Message-ID: <20040820093344.GA2923@akamail.com>
Reply-To: matthias.brill@akamail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
X-Conspiracy: there is no conspiracy
User-Agent: Mutt/1.5.6+20040803i
X-PMX-Version: 4.6.1.107272, Antispam-Core: 4.6.1.106808, Antispam-Data: 2004.8.19.110815
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__TO_MALFORMED_2 0, TO_HAS_SPACES 0.000, __HAS_MSGID 0, __SANE_MSGID 0, __MIME_VERSION 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __CD 0, __USER_AGENT 0, SIGNATURE_SHORT_DENSE 0, USER_AGENT 0.000'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi jeremy

i've found a pentium-m banias which reports "Mobile Genuine Intel(R)
processor       1400MHz" in /proc/cpuinfo.  this (strange?) signature
prevents speedstep-centrino.c from working properly.

the machine is a asus L4000R-series (L4510RBP) pentium-m/ati9100igp
notebook.

"Enhanced SpeedStep" works as advertised for this particular pentium-m
with the following trivial patch applied:

# diff -up arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c.default arch/i=
386/kernel/cpu/cpufreq/speedstep-centrino.c
--- arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c.default	2004-08-19 19=
:53:59.000000000 +0200
+++ arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2004-08-19 20:49:06.0=
00000000 +0200
@@ -195,7 +195,7 @@ static struct cpufreq_frequency_table ba
=20
 #define _BANIAS(cpuid, max, name)	\
 {	.cpu_id		=3D cpuid,	\
-	.model_name	=3D "Intel(R) Pentium(R) M processor " name "MHz", \
+	.model_name	=3D "Mobile Genuine Intel(R) processor       " name "MHz", \
 	.max_freq	=3D (max)*1000,	\
 	.op_points	=3D banias_##max,	\
 }

it seems that only the model_name is different for this CPU?

thias


# cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 9
model name	: Mobile Genuine Intel(R) processor       1400MHz
stepping	: 5
cpu MHz		: 600.087
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca cmov pat clfl=
ush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
bogomips	: 1190.18

--=20
Matthias Brill <matthias.brill@akamail.com>

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBJcV415PQg+xdZ4cRAsdjAKCaXC+Qs1uh27GANvpkqc0xMCIviwCfe1cL
wgUSD0XogY5NuKzzVKZx6hE=
=MSNs
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
