Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWGZQmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWGZQmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWGZQmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:42:19 -0400
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:10689 "EHLO
	outbound2-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751083AbWGZQmS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:42:18 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Date: Wed, 26 Jul 2006 11:42:02 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84303218F04@SAUSEXMB1.amd.com>
In-Reply-To: <p73fyhdpqe1.fsf@verdi.suse.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Thread-Index: Acahvmrm3RpL0cJ7Qb+6QjSqeqjUbgPE5eeQ
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: ak@suse.de, "Gulam, Nagib" <nagib.gulam@amd.com>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
X-OriginalArrivalTime: 26 Jul 2006 16:42:03.0681 (UTC)
 FILETIME=[6C836910:01C6B0D2]
X-WSS-ID: 68D944D10Y8462929-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Set this option
> - Let the system run for let's say a day or two with some 
> freq transitions and varying loads [Better would be to let 
> two systems run in this way to compare]
> - Then hotunplug all the CPUs >0 with
> for i in /sys/devices/system/cpu/cpu*/online ; do echo 0 > $i ; done
> - Wait a bit
> - Restart them again with
> for i in /sys/devices/system/cpu/cpu*/online ; do echo 1 > $i ; done
> 
> The kernel should now print the results of the TSC resync for 
> the replugged CPUs with output like this
> 
> CPU N: Syncing TSC to CPU 0.
> CPU N: synchronized TSC with CPU 0 (last diff XXX cycles, 
> maxerr YYY cycles)
> 
> How do these numbers look like, also compared to the original 
> boot output?
> 
> If the cycles diverge more between the different CPUs it 
> would be a bad sign. 
> It would mean that the error would add up over longer runtime 
> and timing would get more and more unstable.

Andi -

Are you sure this test is testing what you think it is testing?
I just ran my system with the stock 2.6.18 kernel and TSC enabled.
I ran PN! on a varying load long enough for the clocks to become
completely unglued.  The time delta on the command `date;sleep 5;
date` was going from -10 to 30 seconds.  However, the results
of your test show no problems:

during bootup
SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4394.60 BogoMIPS
(lpj=8789206)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 1
AMD Opteron(tm) Processor 854 stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -135 cycles, maxerr 968
cycles)
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 4394.60 BogoMIPS
(lpj=8789208)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2/2 -> Node 2
AMD Opteron(tm) Processor 838 stepping 01
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -132 cycles, maxerr 949
cycles)
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 4394.60 BogoMIPS
(lpj=8789214)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3/3 -> Node 3
AMD Opteron(tm) Processor 838 stepping 01
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -184 cycles, maxerr 1648
cycles)
Brought up 4 CPUs

hot add of offlined CPUs
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 1997.56 BogoMIPS
(lpj=3995129)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 1
AMD Opteron(tm) Processor 854 stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -102 cycles, maxerr 685
cycles)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0xc
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xe
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x10
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 1997.54 BogoMIPS
(lpj=3995084)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2/2 -> Node 2
AMD Opteron(tm) Processor 838 stepping 01
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -97 cycles, maxerr 663
cycles)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x6
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x8
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 1997.54 BogoMIPS
(lpj=3995099)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3/3 -> Node 3
AMD Opteron(tm) Processor 838 stepping 01
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -109 cycles, maxerr 1024
cycles)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x6
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x8
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12

Is there a better test we can be using?

-Mark Langsdorf
AMD, Inc.


