Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268325AbTCFUBV>; Thu, 6 Mar 2003 15:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268335AbTCFUBV>; Thu, 6 Mar 2003 15:01:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37125 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268325AbTCFUBT>; Thu, 6 Mar 2003 15:01:19 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: TransMeta longrun control utility maintainer?
Date: 6 Mar 2003 12:11:31 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b48a1j$4tu$1@cesium.transmeta.com>
References: <9cfy93s4mbd.fsf@rogue.ncsl.nist.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <9cfy93s4mbd.fsf@rogue.ncsl.nist.gov>
By author:    Ian Soboroff <ian.soboroff@nist.gov>
In newsgroup: linux.dev.kernel
> 
> I know this isn't the best place to ask, but maybe someone here knows.
> 
> Who is maintaining the longrun(1) (should probably be longrun(8))
> utility?  The author is listed as Daniel Quinlan
> <quinlan@transmeta.com>, but mail to that address bounces.
> 
> The longrun utility frobs the MSR on TransMeta processors to switch
> between performance and economy modes.
> 
> On my laptop, currently running 2.4.21-pre5-ac1, I get the following
> error:
> 
> # longrun -p
> longrun: error reading /dev/cpu/0/cpuid: Invalid argument
> 
> # ls -l /dev/cpu/0
> total 0
> cr--r--r--    1 root     root     203,   0 Aug 30  2002 cpuid
> crw-------    1 root     root      10, 184 Aug 30  2002 microcode
> crw-------    1 root     root     202,   0 Aug 30  2002 msr
> 

Compile with -D_FILE_OFFSET_BITS=64 and it should work.  The problem
is that some of the MSRs and CPUID levels it touches have addresses
above 0x80000000, and newer glibc's running on newer kernels interpret
those as 64-bit negative, i.e. 0xffffffff80000000.

The longrun utility is currently unmaintained (and Longrun control is
being integrated into the cpufreq framework), but I can at least take
minor bug reports.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
