Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWBXMnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWBXMnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 07:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWBXMnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 07:43:25 -0500
Received: from spirit.analogic.com ([204.178.40.4]:8972 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750796AbWBXMnY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 07:43:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.64.0602231127260.3771@g5.osdl.org>
x-originalarrivaltime: 24 Feb 2006 12:43:06.0644 (UTC) FILETIME=[DC2F2D40:01C6393F]
Content-class: urn:content-classes:message
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Date: Fri, 24 Feb 2006 07:43:05 -0500
Message-ID: <Pine.LNX.4.61.0602240741480.17432@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Patch to reorder functions in the vmlinux to a defined order
Thread-Index: AcY5P9w7esJ4763NTUWYV/GYwkqrAg==
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>  <1140707358.4672.67.camel@laptopd505.fenrus.org>  <200602231700.36333.ak@suse.de> <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org> <Pine.LNX.4.61.0602231400430.4226@chaos.analogic.com> <Pine.LNX.4.64.0602231127260.3771@g5.osdl.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Arjan van de Ven" <arjan@linux.intel.com>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <mingo@elte.hu>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Feb 2006, Linus Torvalds wrote:

>
> On Thu, 23 Feb 2006, linux-os (Dick Johnson) wrote:
>>>
>>> Does anybody want to run benchmarks? (Totally untested, may not boot,
>>> might physically accost your pets for all I know).
>>>
>>> 		Linus
>>
>> I just reconfigured and rebuilt linux-2.6.15.4 to put PHYSICAL_START
>> at 0x00400000, unconditionally and it booted fine and is working so
>> a 'boot' shouldn't be a problem.
>
> I ended up doing even more.
>
> For me, running lmbench with this, it seems to improve some things by up
> to 20% (pipe bandwidth and latency, small file delete), some other things
> by 10% (larger file delete), and others not at all.
>
> Still, that 20% is _huge_.
>
> HOWEVER. I didn't compare very strictly. I should have done many more runs
> (I only did three), and more importantly, I should have compared the exact
> same kernel (I compared the new results against a kernel that was a couple
> of weeks old, so there were other differences). So it's a bit suspect.
> Finally, it might depend on the core a lot, and other cores might not get
> the same results.
>
> So somebody should do a much better test. I'm too lazy.
>
> 		Linus
>


I compiled the kernel with the kernel start address at both
0x00400000 and 0x00100000.

Conditions:
No network attached, machine newly rebooted, no other activity.

Meminfo AFTER the last compile.

MemTotal:       773856 kB
MemFree:         16388 kB
Buffers:        328532 kB
Cached:          39888 kB
SwapCached:          0 kB
Active:         129072 kB
Inactive:       258928 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       773856 kB
LowFree:         16388 kB
SwapTotal:      907664 kB
SwapFree:       907664 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:          33924 kB
Slab:           361224 kB
CommitLimit:   1294592 kB
Committed_AS:    29292 kB
PageTables:        736 kB
VmallocTotal:   253652 kB
VmallocUsed:      2708 kB
VmallocChunk:   250684 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

CPU Info:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping	: 7
cpu MHz		: 2793.305
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 5589.53

This CPU is supposed to be SMP, and the kernel is compiled SMP, but
I was never able to have the two cores show up. It shouldn't affect
the comparison bench-marks.

Tail end of the log with the start at 0x00400000.

   CC      sound/usb/snd-usb-audio.mod.o
   LD [M]  sound/usb/snd-usb-audio.ko
   CC      sound/usb/snd-usb-lib.mod.o
   LD [M]  sound/usb/snd-usb-lib.ko
   CC      sound/usb/usx2y/snd-usb-usx2y.mod.o
   LD [M]  sound/usb/usx2y/snd-usb-usx2y.ko

real	33m4.832s
user	29m47.359s
sys	3m13.611s


Tail end of the log with the start at 0x00100000.

   CC      sound/usb/snd-usb-audio.mod.o
   LD [M]  sound/usb/snd-usb-audio.ko
   CC      sound/usb/snd-usb-lib.mod.o
   LD [M]  sound/usb/snd-usb-lib.ko
   CC      sound/usb/usx2y/snd-usb-usx2y.mod.o
   LD [M]  sound/usb/usx2y/snd-usb-usx2y.ko

real	33m21.078s
user	29m41.274s
sys	3m13.910s

Conclusion: It doesn't make a damn bit of difference one way or
the other on this machine!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
