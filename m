Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbTAJIIE>; Fri, 10 Jan 2003 03:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbTAJIIE>; Fri, 10 Jan 2003 03:08:04 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:13486 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S264625AbTAJIIC> convert rfc822-to-8bit; Fri, 10 Jan 2003 03:08:02 -0500
content-class: urn:content-classes:message
Subject: RE: detecting hyperthreading in linux 2.4.19
Date: Fri, 10 Jan 2003 00:16:39 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E20B@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: detecting hyperthreading in linux 2.4.19
Thread-Index: AcK4d2l7Ug2YIiRpEdewVwBQi2jYqAAB2L6Q
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>, <jamesclv@us.ibm.com>
Cc: "Jason Lunz" <lunz@falooley.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Jan 2003 08:16:39.0959 (UTC) FILETIME=[9A0BE270:01C2B880]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Mikael Pettersson [mailto:mikpe@csd.uu.se]
> 
> My performance monitoring counters driver uses this approach 
> in kernel-space
> using smp_call_function(). I don't use the siblings tables 
> because they suck :-)
> [I don't think they distinguish between logical CPUs #0 and 
> #1, and they aren't
> exported to modules. The CPUID check is simple and portable 
> across kernel versions.]

I believe it is better to use a OS interface to find out HT, rather than 
using CPUID. The reason being, it is possible to have HT disabled, in OS,
even after processor and the BIOS supports it. 
1) Consider the case when processor and BIOS supports HT, but linux
was booted with "noht" boot option (now I am not sure whether that option is 
there in 2.4.19. But is is certainly there in some other kernels).
2) What about some other kernel which is totally ignorant about HT, and 
doesn't initialize logical processor (kernel which looks at MPS in place
of ACPI)
I think, in both these cases cpuid can still say HT is present.

I know that sibling table is not exported. But I couldn't get your other
comment about sibling table "they distinguish between logical CPUs #0 and #1:"
Can you elaborate..

Thanks,
-Venkatesh
