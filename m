Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbSLVPhO>; Sun, 22 Dec 2002 10:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbSLVPhO>; Sun, 22 Dec 2002 10:37:14 -0500
Received: from fmr01.intel.com ([192.55.52.18]:21222 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264733AbSLVPhN> convert rfc822-to-8bit;
	Sun, 22 Dec 2002 10:37:13 -0500
content-class: urn:content-classes:message
Subject: RE: Intel P6 vs P7 system call performance
Date: Sun, 22 Dec 2002 07:45:18 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB564419F01@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
X-MS-Has-Attach: 
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: Intel P6 vs P7 system call performance
Thread-Index: AcKptl2gVKvd/hWnEdeo8gBQi2jWzAAGPPSQ
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>, <mingo@elte.hu>,
       <torvalds@transmeta.com>
Cc: <drepper@redhat.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Dec 2002 15:45:18.0970 (UTC) FILETIME=[212DBDA0:01C2A9D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct. Please look at Table B-1. Most of MSRs are shared, but some MSRs are unique in each logical processor, to provide the x86 architectural state. Those SYSENTER MSRs, and Machine Check register save state (IA32_MCG_XXX), for example, are unique.

Jun

> -----Original Message-----
> From: Mikael Pettersson [mailto:mikpe@csd.uu.se]
> Sent: Sunday, December 22, 2002 4:34 AM
> To: mingo@elte.hu; torvalds@transmeta.com
> Cc: drepper@redhat.com; Nakajima, Jun; linux-kernel@vger.kernel.org
> Subject: Re: Intel P6 vs P7 system call performance
> 
> On Sun, 22 Dec 2002 11:23:08 +0100 (CET), Ingo Molnar wrote:
> >while reviewing the sysenter trampoline code i started wondering about
> the
> >HT case. Dont HT boxes share the MSRs between logical CPUs? This pretty
> >much breaks the concept of per-logical-CPU sysenter trampolines. It also
> >makes context-switch time sysenter MSR writing impossible, so i really
> >hope this is not the case.
> 
> Some MSRs are shared, some aren't. One must always check this in
> the IA32 Volume 3 manual. The three SYSENTER MSRs are not shared.
> 
> However, no-one has yet proven that writing to these in the context
> switch path has acceptable performance -- remember, there is _no_
> a priori reason to assume _anything_ about performance on P4s,
> you really do need to measure things before taking design decisions.
> 
> Manfred had a version with fixed MSR values and the varying data
> in memory. Maybe that's actually faster.
