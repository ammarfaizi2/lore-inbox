Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWGYVr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWGYVr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWGYVr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:47:58 -0400
Received: from outbound-red.frontbridge.com ([216.148.222.49]:40160 "EHLO
	outbound1-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S964876AbWGYVr5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:47:57 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Date: Tue, 25 Jul 2006 16:47:47 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84303218EF5@SAUSEXMB1.amd.com>
In-Reply-To: <p73fyhdpqe1.fsf@verdi.suse.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Thread-Index: Acahvmrm3RpL0cJ7Qb+6QjSqeqjUbgOdYiFA
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: ak@suse.de, "Gulam, Nagib" <nagib.gulam@amd.com>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
X-OriginalArrivalTime: 25 Jul 2006 21:47:48.0633 (UTC)
 FILETIME=[F88B3090:01C6B033]
X-WSS-ID: 68D84E0E0Y8302392-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch provides a workaround by changing all processors to the 
> > same frequency at the same time, so that the TSC on each processor 
> > never increments at a different rate than the TSC on 
> > another processor.
>
> I'm still dubious if the result is really correct if the 
> hardware wasn't designed to guarantee synchronous TSC operation.
> 
> Can you do the following test please? 
> 
> - Set this option
> - Let the system run for let's say a day or two with some 
> freq transitions and varying loads [Better would be to let 
> two systems run in this way to compare]
> - Then hotunplug all the CPUs >0 with
> for i in /sys/devices/system/cpu/cpu*/online ; do echo 0 > $i ; done
> - Wait a bit
> - Restart them again with
> for i in /sys/devices/system/cpu/cpu*/online ; do echo 1 > $i ; done

I started running a baseline test on Thursday, July 13th,
and continued until today.  The system was not running
cpufreq but it was using TSC as the sole gtod timesource.
Here's the numbers (again, after 12 days uptime):

SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4394.60 BogoMIPS
(lpj=8789204)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 1
AMD Opteron(tm) Processor 854 stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -132 cycles, maxerr 966
cycles)
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 4394.60 BogoMIPS
(lpj=8789200)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2/2 -> Node 2
AMD Opteron(tm) Processor 838 stepping 01
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -132 cycles, maxerr 953
cycles)
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 4394.58 BogoMIPS
(lpj=8789169)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3/3 -> Node 3
AMD Opteron(tm) Processor 838 stepping 01
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -257 cycles, maxerr 864
cycles)

Compared to the same machine, immediately after reboot:
SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4394.60 BogoMIPS
(lpj=8789216)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 1
AMD Opteron(tm) Processor 854 stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -132 cycles, maxerr 972
cycles)
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 4394.60 BogoMIPS
(lpj=8789212)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2/2 -> Node 2
AMD Opteron(tm) Processor 838 stepping 01
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -129 cycles, maxerr 949
cycles)
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 4394.57 BogoMIPS
(lpj=8789142)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3/3 -> Node 3
AMD Opteron(tm) Processor 838 stepping 01
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -173 cycles, maxerr 1648
cycles)

I don't see any significant drift.  It looks to me like 
current generation Opterons are TSC-safe.

Joachim was supposed to be collecting the data for the system
with PN! enabled, if he hasn't posted it already.

-Mark Langsdorf
AMD, Inc.


