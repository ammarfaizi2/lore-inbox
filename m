Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266215AbUHMRDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUHMRDH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUHMRDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:03:07 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:61703 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S266215AbUHMRCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:02:53 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] [ix86,x86_64] cpu features.
Date: Fri, 13 Aug 2004 19:02:45 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <2sMat-61I-43@gated-at.bofh.it> <m3smarrpau.fsf@averell.firstfloor.org>
In-Reply-To: <m3smarrpau.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2QPHBVlwW1S7ZcL"
Message-Id: <200408131902.46553.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_2QPHBVlwW1S7ZcL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 13 of August 2004 18:11, Andi Kleen wrote:
> Pawe=E2 Sikora <pluto@pld-linux.org> writes:
> > +++ linux-2.6.8-rc4/arch/i386/kernel/cpu/proc.c	2004-08-13
> > 16:48:53.971370504 +0200 @@ -44,8 +44,8 @@
> >  		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> >
> >  		/* Intel-defined (#2) */
> > -		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
> > -		"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
> > +		"sse3", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
> > +		"tm2", NULL, "cid", NULL, NULL, NULL, "xtpr", NULL,
>
> You cannot just do the pni -> sse3 rename. That could break existing
> applications that read /proc/cpuinfo and parse it. The only way would
> be to add a new sse3 flag in addition to pni, but I guess that would
> be not worth the ugly special case.

Ok, it's now correct?

=2D-=20
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_2QPHBVlwW1S7ZcL
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0.diff"

Index: 2.6.8-cpu_feature.patch
===================================================================
RCS file: /cvsroot/SOURCES/Attic/2.6.8-cpu_feature.patch,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 2.6.8-cpu_feature.patch
--- 2.6.8-cpu_feature.patch	13 Aug 2004 15:29:38 -0000	1.1.2.1
+++ 2.6.8-cpu_feature.patch	13 Aug 2004 16:55:10 -0000
@@ -6,7 +6,7 @@
  		/* Intel-defined (#2) */
 -		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
 -		"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
-+		"sse3", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
++		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
 +		"tm2", NULL, "cid", NULL, NULL, NULL, "xtpr", NULL,
  		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
  		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
@@ -19,7 +19,7 @@
  		/* Intel-defined (#2) */
 -		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
 -		"est", NULL, "cid", NULL, NULL, "cmpxchg16b", NULL, NULL,
-+		"sse3", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
++		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
 +		"tm2", NULL, "cid", NULL, NULL, "cx16", "xtpr", NULL,
  		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
  		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
@@ -42,6 +42,22 @@
  
  /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
  #define X86_FEATURE_XSTORE	(5*32+ 2) /* on-CPU RNG present (xstore insn) */
+@@ -93,13 +97,14 @@
+ #define cpu_has_tsc		boot_cpu_has(X86_FEATURE_TSC)
+ #define cpu_has_pae		boot_cpu_has(X86_FEATURE_PAE)
+ #define cpu_has_pge		boot_cpu_has(X86_FEATURE_PGE)
+-#define cpu_has_sse2		boot_cpu_has(X86_FEATURE_XMM2)
+ #define cpu_has_apic		boot_cpu_has(X86_FEATURE_APIC)
+ #define cpu_has_sep		boot_cpu_has(X86_FEATURE_SEP)
+ #define cpu_has_mtrr		boot_cpu_has(X86_FEATURE_MTRR)
+ #define cpu_has_mmx		boot_cpu_has(X86_FEATURE_MMX)
+ #define cpu_has_fxsr		boot_cpu_has(X86_FEATURE_FXSR)
+ #define cpu_has_xmm		boot_cpu_has(X86_FEATURE_XMM)
++#define cpu_has_xmm2		boot_cpu_has(X86_FEATURE_XMM2)
++#define cpu_has_xmm3		boot_cpu_has(X86_FEATURE_XMM3)
+ #define cpu_has_ht		boot_cpu_has(X86_FEATURE_HT)
+ #define cpu_has_mp		boot_cpu_has(X86_FEATURE_MP)
+ #define cpu_has_nx		boot_cpu_has(X86_FEATURE_NX)
 --- linux-2.6.8-rc4/include/asm-x86_64/cpufeature.h.orig	2004-08-10 04:23:13.000000000 +0200
 +++ linux-2.6.8-rc4/include/asm-x86_64/cpufeature.h	2004-08-13 16:53:48.776553304 +0200
 @@ -63,8 +63,14 @@
@@ -60,3 +76,12 @@
  
  #define cpu_has(c, bit)                test_bit(bit, (c)->x86_capability)
  #define boot_cpu_has(bit)      test_bit(bit, boot_cpu_data.x86_capability)
+@@ -81,6 +87,8 @@
+ #define cpu_has_mmx            1
+ #define cpu_has_fxsr           1
+ #define cpu_has_xmm            1
++#define cpu_has_xmm2           1
++#define cpu_has_xmm3           boot_cpu_has(X86_FEATURE_XMM3)
+ #define cpu_has_ht             boot_cpu_has(X86_FEATURE_HT)
+ #define cpu_has_mp             1 /* XXX */
+ #define cpu_has_k6_mtrr        0

--Boundary-00=_2QPHBVlwW1S7ZcL--
