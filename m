Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbTBSUOX>; Wed, 19 Feb 2003 15:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbTBSUOX>; Wed, 19 Feb 2003 15:14:23 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:16614 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S266958AbTBSUOV>; Wed, 19 Feb 2003 15:14:21 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: [PATCH][2.5] flush_tlb_all is not preempt safe.
Date: Wed, 19 Feb 2003 21:23:50 +0100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0302140600050.3518-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0302140600050.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_df+U+wysbH1VBZ5";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302192123.57431.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_df+U+wysbH1VBZ5
Content-Type: multipart/mixed;
  boundary="Boundary-01=_Wf+U+tTfnWH3ZAL"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_Wf+U+tTfnWH3ZAL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi,

I've created a patch based on yours to solve the flush_tlb_all preempt-issu=
e=20
for x86_64 and the i386/mach-voyager subarchitecture. I'm not sure if the=20
ia64 architecture would need to be patched, too...?

Wouldn't it even have been possible to solve this problem just by swapping =
the=20
two original lines?

Best regards
  Thomas Schlichter
--Boundary-01=_Wf+U+tTfnWH3ZAL
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

--Boundary-01=_Wf+U+tTfnWH3ZAL--

--Boundary-03=_df+U+wysbH1VBZ5
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+U+fdYAiN+WRIZzQRAkPCAJ9+NKwFZ+Iprbx4DvkcN3LteGea4QCgwUyl
SMNQmhWOYjvoMXrynTr59PE=
=N9cT
-----END PGP SIGNATURE-----

--Boundary-03=_df+U+wysbH1VBZ5--

