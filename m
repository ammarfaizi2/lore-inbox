Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269248AbRGaKp6>; Tue, 31 Jul 2001 06:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269247AbRGaKps>; Tue, 31 Jul 2001 06:45:48 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:38813 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S269246AbRGaKpl>;
	Tue, 31 Jul 2001 06:45:41 -0400
Date: Tue, 31 Jul 2001 12:45:44 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200107311045.MAA20562@harpo.it.uu.se>
To: tigran@veritas.com
Subject: Re: booting SMP P6 kernel on P4 hangs.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001 07:10:34 +0100 (BST), Tigran Aivazian wrote:

>Isn't SMP P6 kernel supposed to boot fine on a P4? Btw, booting with
>"nosmp" works but booting with "noapic" hangs just the same.
>
>Here is where it hangs:
>
>> CPU0: Intel(R) Pentium(R) 4 CPU 1300 Mhz stepping 0a
>> per-CPU timeslice cutoff: 731.49 usecs
>> weird, boot CPU (#0) not listed by the BIOS
>> Getting VERSION: f000acde
>> Getting VERSION: f0ffac21
>> leaving PIC mode, enabling symmetric IO mode.
>> enabled ExtINT on CPU#0
>> ESR value before enabling vector: 00000000
>> ESR value after enabling vector: 00000000
>> CPU present map: 1
>> Before bogomips.
>> Error: only one processor found.
>> Boot done.
>> ENABLING IO-APIC IRQs
>> Synchronizing Arb IDs.
>> ..TIMER: vector=31 pin1=2 pin2=0
>> activating NMI Watchdog...done
>> CPU#0 NMI appears to be stuck
>> testing the IO APIC.............
>> ..........................done
>> calibrating APIC timer...
>> .....CPU clock speed is 1285.2614 Mhz
>> ....host bus clock speed is 0.0000 Mhz
>> cpu:0, clocks:0, slice:0

Which kernel version?
I actually wouldn't expect the current local APIC or SMP code to
work perfectly on a P4, since there are many differences to P6/K7.
I scribbled some of them down a while ago (based on reading
the first rev of Intel's IA32 Vol3 for P4 manual):
- FEE000090 Arbitration Priority not supported in P4
- broadcast is 0xFF in P4
- flat cluster model is not supported in P4
- focus processor concept doesn't exist in P4
- "all excluding self" destination shorthand == "all including self"
  in P4 if lowest-priority delivery mode is used (not recommended)
- SPIV bit 9 (focus) should be 0 on P4
- version is 0x14 and maxlvt is 5 on P4

2.4.7 apic.c enables the SPIV focus bit, maybe that's the problem.

/Mikael
