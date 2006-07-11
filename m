Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWGKM4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWGKM4e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWGKM4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:56:34 -0400
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:31127 "EHLO
	outbound2-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750733AbWGKM4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:56:32 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
From: "Joachim Deguara" <joachim.deguara@amd.com>
To: "Andi Kleen" <ak@suse.de>
cc: "Mark Langsdorf" <mark.langsdorf@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
In-Reply-To: <p73fyhdpqe1.fsf@verdi.suse.de>
References: <Pine.LNX.4.64.0607061519040.9066@solonow.amd.com>
 <p73fyhdpqe1.fsf@verdi.suse.de>
Date: Tue, 11 Jul 2006 14:55:54 +0200
Message-ID: <1152622554.4489.32.camel@lapdog.site>
MIME-Version: 1.0
X-Mailer: Evolution 2.6.0
X-OriginalArrivalTime: 11 Jul 2006 12:56:19.0298 (UTC)
 FILETIME=[673C5420:01C6A4E9]
X-WSS-ID: 68AD407C27K16308108-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 14:10 +0200, Andi Kleen wrote:
> How do these numbers look like, also compared to the original boot
> output?
> 
> If the cycles diverge more between the different CPUs it would be a
> bad sign. 
> It would mean that the error would add up over longer runtime
> and timing would get more and more unstable. 

Here are some initial findings.  When I say I change the frequencies,
then I mean that a script toggles from max to min or from min to max
every two seconds.  I will let the machine run overnight to compare, but
the interesting fact is that the cycle difference where the same for a
short test (2 minutes) and a medium test (2 hours).  The maching is a
two-way dual-core Tyan Thunder K8WE 2895.

letting the computer run while toggling the freqs for 2 hours, set freqs
to max, then put all but cpu0 offline.  
Jul 11 21:21:52 gradient kernel: Breaking affinity for irq 0
Jul 11 21:21:52 gradient kernel: Breaking affinity for irq 1
Jul 11 21:21:52 gradient kernel: CPU 1 is now offline
Jul 11 21:21:52 gradient kernel: Breaking affinity for irq 201
Jul 11 21:21:52 gradient kernel: CPU 2 is now offline
Jul 11 21:21:52 gradient [powersave]: WARNING (adjustSpeed:159)
calcCPULoad failed. Cannot adjust speeds: -1
Jul 11 21:21:52 gradient kernel: CPU 3 is now offline
Jul 11 21:21:52 gradient kernel: SMP alternatives: switching to UP code


waited a bit then put all cores online

Jul 11 21:23:35 gradient kernel: SMP alternatives: switching to SMP code
Jul 11 21:23:35 gradient kernel: Booting processor 1/4 APIC 0x1
Jul 11 21:23:35 gradient kernel: Initializing CPU#1
Jul 11 21:23:35 gradient kernel: Calibrating delay using timer specific
routine.. 2009.40 BogoMIPS (lpj=4018809)
Jul 11 21:23:35 gradient kernel: CPU: L1 I Cache: 64K (64 bytes/line), D
cache 64K (64 bytes/line)
Jul 11 21:23:35 gradient kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Jul 11 21:23:35 gradient kernel: CPU 1/1 -> Node 0
Jul 11 21:23:35 gradient kernel: CPU: Physical Processor ID: 0
Jul 11 21:23:35 gradient kernel: CPU: Processor Core ID: 1
Jul 11 21:23:35 gradient kernel: Dual Core AMD Opteron(tm) Processor 275
stepping 02
Jul 11 21:23:35 gradient kernel: CPU 1: Syncing TSC to CPU 0.
Jul 11 21:23:35 gradient kernel: CPU 1: synchronized TSC with CPU 0
(last diff 3 cycles, maxerr 502 cycles)
Jul 11 21:23:35 gradient kernel: powernow-k8:    0 : fid 0xe (2200 MHz),
vid 0x8
Jul 11 21:23:35 gradient kernel: powernow-k8:    1 : fid 0xc (2000 MHz),
vid 0xa
Jul 11 21:23:35 gradient kernel: powernow-k8:    2 : fid 0xa (1800 MHz),
vid 0xc
Jul 11 21:23:35 gradient kernel: powernow-k8:    3 : fid 0x2 (1000 MHz),
vid 0x12
Jul 11 21:23:35 gradient kernel: SMP alternatives: switching to SMP code
Jul 11 21:23:35 gradient kernel: Booting processor 2/4 APIC 0x2
Jul 11 21:23:35 gradient kernel: Initializing CPU#2
Jul 11 21:23:35 gradient kernel: Calibrating delay using timer specific
routine.. 2009.41 BogoMIPS (lpj=4018838)
Jul 11 21:23:35 gradient kernel: CPU: L1 I Cache: 64K (64 bytes/line), D
cache 64K (64 bytes/line)
Jul 11 21:23:35 gradient kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Jul 11 21:23:35 gradient kernel: CPU 2/2 -> Node 1
Jul 11 21:23:35 gradient kernel: CPU: Physical Processor ID: 1
Jul 11 21:23:35 gradient kernel: CPU: Processor Core ID: 0
Jul 11 21:23:35 gradient kernel: Dual Core AMD Opteron(tm) Processor 275
stepping 02
Jul 11 21:23:35 gradient kernel: CPU 2: Syncing TSC to CPU 0.
Jul 11 21:23:35 gradient kernel: CPU 2: synchronized TSC with CPU 0
(last diff -91 cycles, maxerr 621 cycles)
Jul 11 21:23:35 gradient kernel: powernow-k8:    0 : fid 0xe (2200 MHz),
vid 0x8
Jul 11 21:23:35 gradient kernel: powernow-k8:    1 : fid 0xc (2000 MHz),
vid 0xa
Jul 11 21:23:35 gradient kernel: powernow-k8:    2 : fid 0xa (1800 MHz),
vid 0xc
Jul 11 21:23:35 gradient kernel: powernow-k8:    3 : fid 0x2 (1000 MHz),
vid 0x12
Jul 11 21:23:35 gradient kernel: SMP alternatives: switching to SMP code
Jul 11 21:23:35 gradient kernel: Booting processor 3/4 APIC 0x3
Jul 11 21:23:35 gradient kernel: Initializing CPU#3
Jul 11 21:23:35 gradient kernel: Calibrating delay using timer specific
routine.. 4420.77 BogoMIPS (lpj=8841555)
Jul 11 21:23:35 gradient kernel: CPU: L1 I Cache: 64K (64 bytes/line), D
cache 64K (64 bytes/line)
Jul 11 21:23:35 gradient kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Jul 11 21:23:35 gradient kernel: CPU 3/3 -> Node 1
Jul 11 21:23:35 gradient kernel: CPU: Physical Processor ID: 1
Jul 11 21:23:35 gradient kernel: CPU: Processor Core ID: 1
Jul 11 21:23:35 gradient kernel: Dual Core AMD Opteron(tm) Processor 275
stepping 02
Jul 11 21:23:35 gradient kernel: CPU 3: Syncing TSC to CPU 0.
Jul 11 21:23:35 gradient kernel: CPU 3: synchronized TSC with CPU 0
(last diff -122 cycles, maxerr 1129 cycles)
Jul 11 21:23:35 gradient kernel: powernow-k8:    0 : fid 0xe (2200 MHz),
vid 0x8
Jul 11 21:23:35 gradient kernel: powernow-k8:    1 : fid 0xc (2000 MHz),
vid 0xa
Jul 11 21:23:35 gradient kernel: powernow-k8:    2 : fid 0xa (1800 MHz),
vid 0xc
Jul 11 21:23:35 gradient kernel: powernow-k8:    3 : fid 0x2 (1000 MHz),
vid 0x12


going offline again results in:

Jul 11 21:24:39 gradient kernel: CPU 1 is now offline
Jul 11 21:24:39 gradient kernel: Breaking affinity for irq 201
Jul 11 21:24:39 gradient kernel: powernow-k8: limiting to CPU 2 failed
in powernowk8_get
Jul 11 21:24:39 gradient kernel: powernow-k8: limiting to CPU 2 failed
in powernowk8_get
Jul 11 21:24:39 gradient kernel: CPU 2 is now offline
Jul 11 21:24:39 gradient kernel: CPU 3 is now offline
Jul 11 21:24:39 gradient kernel: SMP alternatives: switching to UP code


I waited just a little bit and did not do any freq changes, but when I
put the cores online, the differences where about the same???

Jul 11 21:25:24 gradient kernel: SMP alternatives: switching to SMP code
Jul 11 21:25:24 gradient kernel: Booting processor 1/4 APIC 0x1
Jul 11 21:25:24 gradient kernel: Initializing CPU#1
Jul 11 21:25:24 gradient kernel: Calibrating delay using timer specific
routine.. 2009.44 BogoMIPS (lpj=4018898)
Jul 11 21:25:24 gradient kernel: CPU: L1 I Cache: 64K (64 bytes/line), D
cache 64K (64 bytes/line)
Jul 11 21:25:24 gradient kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Jul 11 21:25:24 gradient kernel: CPU 1/1 -> Node 0
Jul 11 21:25:24 gradient kernel: CPU: Physical Processor ID: 0
Jul 11 21:25:24 gradient kernel: CPU: Processor Core ID: 1
Jul 11 21:25:24 gradient kernel: Dual Core AMD Opteron(tm) Processor 275
stepping 02
Jul 11 21:25:24 gradient kernel: CPU 1: Syncing TSC to CPU 0.
Jul 11 21:25:24 gradient kernel: CPU 1: synchronized TSC with CPU 0
(last diff 4 cycles, maxerr 499 cycles)
Jul 11 21:25:24 gradient kernel: powernow-k8:    0 : fid 0xe (2200 MHz),
vid 0x8
Jul 11 21:25:24 gradient kernel: powernow-k8:    1 : fid 0xc (2000 MHz),
vid 0xa
Jul 11 21:25:24 gradient kernel: powernow-k8:    2 : fid 0xa (1800 MHz),
vid 0xc
Jul 11 21:25:24 gradient kernel: powernow-k8:    3 : fid 0x2 (1000 MHz),
vid 0x12
Jul 11 21:25:24 gradient kernel: SMP alternatives: switching to SMP code
Jul 11 21:25:24 gradient kernel: Booting processor 2/4 APIC 0x2
Jul 11 21:25:24 gradient kernel: Initializing CPU#2
Jul 11 21:25:24 gradient kernel: Calibrating delay using timer specific
routine.. 2009.43 BogoMIPS (lpj=4018861)
Jul 11 21:25:24 gradient kernel: CPU: L1 I Cache: 64K (64 bytes/line), D
cache 64K (64 bytes/line)
Jul 11 21:25:24 gradient kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Jul 11 21:25:24 gradient kernel: CPU 2/2 -> Node 1
Jul 11 21:25:24 gradient kernel: CPU: Physical Processor ID: 1
Jul 11 21:25:24 gradient kernel: CPU: Processor Core ID: 0
Jul 11 21:25:24 gradient kernel: Dual Core AMD Opteron(tm) Processor 275
stepping 02
Jul 11 21:25:24 gradient kernel: CPU 2: Syncing TSC to CPU 0.
Jul 11 21:25:24 gradient kernel: CPU 2: synchronized TSC with CPU 0
(last diff -93 cycles, maxerr 625 cycles)
Jul 11 21:25:24 gradient kernel: powernow-k8:    0 : fid 0xe (2200 MHz),
vid 0x8
Jul 11 21:25:24 gradient kernel: powernow-k8:    1 : fid 0xc (2000 MHz),
vid 0xa
Jul 11 21:25:24 gradient kernel: powernow-k8:    2 : fid 0xa (1800 MHz),
vid 0xc
Jul 11 21:25:24 gradient kernel: powernow-k8:    3 : fid 0x2 (1000 MHz),
vid 0x12
Jul 11 21:25:24 gradient kernel: SMP alternatives: switching to SMP code
Jul 11 21:25:24 gradient kernel: Booting processor 3/4 APIC 0x3
Jul 11 21:25:24 gradient kernel: Initializing CPU#3
Jul 11 21:25:24 gradient kernel: Calibrating delay using timer specific
routine.. 4420.67 BogoMIPS (lpj=8841353)
Jul 11 21:25:24 gradient kernel: CPU: L1 I Cache: 64K (64 bytes/line), D
cache 64K (64 bytes/line)
Jul 11 21:25:24 gradient kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Jul 11 21:25:24 gradient kernel: CPU 3/3 -> Node 1
Jul 11 21:25:24 gradient kernel: CPU: Physical Processor ID: 1
Jul 11 21:25:24 gradient kernel: CPU: Processor Core ID: 1
Jul 11 21:25:24 gradient kernel: Dual Core AMD Opteron(tm) Processor 275
stepping 02
Jul 11 21:25:24 gradient kernel: CPU 3: Syncing TSC to CPU 0.
Jul 11 21:25:24 gradient kernel: CPU 3: synchronized TSC with CPU 0
(last diff -122 cycles, maxerr 1126 cycles)
Jul 11 21:25:24 gradient kernel: powernow-k8:    0 : fid 0xe (2200 MHz),
vid 0x8
Jul 11 21:25:24 gradient kernel: powernow-k8:    1 : fid 0xc (2000 MHz),
vid 0xa
Jul 11 21:25:24 gradient kernel: powernow-k8:    2 : fid 0xa (1800 MHz),
vid 0xc
Jul 11 21:25:24 gradient kernel: powernow-k8:    3 : fid 0x2 (1000 MHz),
vid 0x12

sorry if this word-wrappings looks as bad by you as it does with
evolution.

-joachim



