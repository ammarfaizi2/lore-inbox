Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264567AbTLMMBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 07:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTLMMBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 07:01:34 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:24077 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S264567AbTLMMBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 07:01:23 -0500
Message-ID: <3FDAFF79.5080509@nishanet.com>
Date: Sat, 13 Dec 2003 07:00:57 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup,
 apic, io-apic, udma133 covered
References: <200312132040.00875.ross@datscreative.com.au>
In-Reply-To: <200312132040.00875.ross@datscreative.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

udma133 with Award bios update and nforce2

APIC error on CPU0: 02(02)
what?? no crash though.

Ross Dickson wrote:

>Hi Bob
>
>Jesse has award bios, see attached
>Ross.
>
Months ago I thought using a 3ware card might
help with nforce2 crashes so I gave up on promise
and sii hd cards after a lot of experiments(hdparm,
no lapic, no acpi, apic off in bios) and put in a 3ware
card but I flashed the bios at the same time so didn't
know if the 3ware card helped with the nforce2
crashing or not, since the bios flash did the job.

With 3ware I couldn't use hdparm to see what udma
settings the drives were set to. Now I can report.

Just now I took the 3ware card out and went back
to promise cards(using 4 hd's either method, 2 cd's
on mboard amd74xx, onboard sata disabled).

bob@where cat /proc/interrupts
           CPU0      
  0:    3350153    IO-APIC-edge  timer
  1:       5775    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:       5385    IO-APIC-edge  i8042
 14:         10    IO-APIC-edge  ide0
 15:         10    IO-APIC-edge  ide1
 16:    1717957   IO-APIC-level  ide2, ide3, eth0
 19:     472929   IO-APIC-level  ide4, ide5
 21:          0   IO-APIC-level  NVidia nForce2
NMI:        822
LOC:    3350073
ERR:         35
MIS:      15818

cd's on amd74xx onboard, amd74xx onboard is always solid,
4 ide hd's on two promise cards. not many nmi ticks without
the better patch there.

bonnie++ smooth, then hdparm up the settings, udma6,
bonnie++ again, saw a few "APIC error on CPU0: 02(02)"
but no lockup. not sure if data lost since it was a test. APIC
error might be fixed by changing hdparm settings. This
second test was with unmasked irq and udma6.

I have to patch to get ioapic edge timer on.

This 11/7/2003 updated award bios does not have a cpu
disconnect option but it does eliminate the crashes with
no patch and it is no longer impossible to use promise
ide udma133 controller cards.

MSI K7N2 Delta MCP2-T mboard

I don't have the promise patch in yet, either, so the APIC
error might be from that, or hdparm unmasked irq.

-Bob
