Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbSLVMZg>; Sun, 22 Dec 2002 07:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbSLVMZg>; Sun, 22 Dec 2002 07:25:36 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:8874 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S266425AbSLVMZg>;
	Sun, 22 Dec 2002 07:25:36 -0500
Date: Sun, 22 Dec 2002 13:33:37 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212221233.NAA14598@harpo.it.uu.se>
To: mingo@elte.hu, torvalds@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Cc: drepper@redhat.com, jun.nakajima@intel.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Dec 2002 11:23:08 +0100 (CET), Ingo Molnar wrote:
>while reviewing the sysenter trampoline code i started wondering about the
>HT case. Dont HT boxes share the MSRs between logical CPUs? This pretty
>much breaks the concept of per-logical-CPU sysenter trampolines. It also
>makes context-switch time sysenter MSR writing impossible, so i really
>hope this is not the case.

Some MSRs are shared, some aren't. One must always check this in
the IA32 Volume 3 manual. The three SYSENTER MSRs are not shared.

However, no-one has yet proven that writing to these in the context
switch path has acceptable performance -- remember, there is _no_
a priori reason to assume _anything_ about performance on P4s,
you really do need to measure things before taking design decisions.

Manfred had a version with fixed MSR values and the varying data
in memory. Maybe that's actually faster.
