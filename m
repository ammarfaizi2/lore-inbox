Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbTBTTwm>; Thu, 20 Feb 2003 14:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTBTTwl>; Thu, 20 Feb 2003 14:52:41 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:60907 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S266944AbTBTTwa>; Thu, 20 Feb 2003 14:52:30 -0500
Message-Id: <200302202002.h1KK2XZ00009@rumms.uni-mannheim.de>
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2.5] flush_tlb_all is not preempt safe in x86_64 and i386/mach-voyager
Date: Thu, 20 Feb 2003 11:55:26 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0302140600050.3518-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0302140600050.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_pQLV+P5xaA0IXCB";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_pQLV+P5xaA0IXCB
Content-Type: multipart/mixed;
  boundary="Boundary-01=_eQLV+rW/yfUInu0"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_eQLV+rW/yfUInu0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: body text
Content-Disposition: inline

This patch is based on Changeset 1.914.160.6.
It solves the flush_tlb_all preempt-issue for x86_64 and the i386/mach-voyager subarchitecture.

Best regards
  Thomas Schlichter

P.S.: Wouldn't it even have been possible to solve this problem just by swapping the original two lines?

--Boundary-01=_eQLV+rW/yfUInu0
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="flush_tlb_all_preempt.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="flush_tlb_all_preempt.patch"

=2D-- linux-2.5.62/arch/i386/mach-voyager/voyager_smp.c.orig	Wed Feb 19 16:=
43:22 2003
+++ linux-2.5.62/arch/i386/mach-voyager/voyager_smp.c	Wed Feb 19 16:43:57 2=
003
@@ -1230,9 +1230,11 @@
 void
 flush_tlb_all(void)
 {
+	preempt_disable();
 	smp_call_function (flush_tlb_all_function, 0, 1, 1);
=20
 	do_flush_tlb_all_local();
+	preempt_enable();
 }
=20
 /* used to set up the trampoline for other CPUs when the memory manager
=2D-- linux-2.5.62/arch/x86_64/kernel/smp.c.orig	Wed Feb 19 21:08:20 2003
+++ linux-2.5.62/arch/x86_64/kernel/smp.c	Wed Feb 19 21:09:40 2003
@@ -344,9 +344,11 @@
=20
 void flush_tlb_all(void)
 {
+	preempt_disable();
 	smp_call_function (flush_tlb_all_ipi,0,1,1);
=20
 	do_flush_tlb_all_local();
+	preempt_enable();
 }
=20
 void smp_kdb_stop(void)

--Boundary-01=_eQLV+rW/yfUInu0--

--Boundary-03=_pQLV+P5xaA0IXCB
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+VLQpYAiN+WRIZzQRArcDAKCPjb8hcEaD/sW8tthMKFm0kgQdvACeLmKU
+D9oRiDaYeAAd235H4UrFAY=
=OXlB
-----END PGP SIGNATURE-----

--Boundary-03=_pQLV+P5xaA0IXCB--


