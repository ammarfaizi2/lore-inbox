Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbTLHHzh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 02:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbTLHHzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 02:55:37 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:45580 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S265332AbTLHHzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 02:55:33 -0500
Message-ID: <3FD432C3.1020102@nishanet.com>
Date: Mon, 08 Dec 2003 03:13:55 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog - found
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com>	<3FD1199E.2030402@gmx.de> <20031206081848.GA4023@localnet> <frodoid.frodo.87zne6chry.fsf@usenet.frodoid.org> <3FD3F15F.4090309@nishanet.com>
In-Reply-To: <3FD3F15F.4090309@nishanet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The athcool patch seemed to work as far as patch reported,
but there were undef and unused problems on compile so
I don't have that in right now. The timer patch is in.

http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/nforce2-apic.patch

Patch succeeded in giving me the ioapic-edge timer,
then lilo append="nmi_watchdog=1" did not work but
=2 did get NMI ticks as shown below.

cat /proc/interrupts

           CPU0       
  0:     617651    IO-APIC-edge  timer
  1:        868    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:       8736    IO-APIC-edge  i8042
 14:         22    IO-APIC-edge  ide0
 15:         24    IO-APIC-edge  ide1
 16:      92853   IO-APIC-level  3ware Storage Controller, yenta, yenta
 17:       2793   IO-APIC-level  eth0
 21:          0   IO-APIC-level  NVidia nForce2
NMI:        122 
LOC:     617511 
ERR:          0
MIS:          0

Does the kernel opt "user HPET timer" relate to io-apic-edge timer?
Does the kernel opt "hangcheck timer relate" to nmi_watchdog?
Does the kernel opt "ACPI, Processor (c2) (c3 states)" relate to
  the cmos/bios "processor disconnect" option and athcool patch?

kernel 2.6.0-test11, pre-emptive, apic, lapic, acpi, anticipatory
scheduling not deadline scheduling, cpu and fsb clock 1:1 333mhz,
amd xp3000+ and high-performance settings(CAS2) other than
1:1 fsb/ram which is slow for the ram, 41C - 48C cpu temp, MSI K7N2
mboard.

My system was stable already(apic, lapic, pre-empt) after a bios
update which stopped all irq storm and crashes except "IRQ7 disabled"
and "spurious 8259A interrupts" possibly related to the XT-PIC timer
running when the other was expected due to apic and lapic and acpi
and kernel opt 'use HPET timer" all being on. Turning on onboard
ethernet set off the irq7 and 8259a errs so I have not been using
onboard eth. USB did not work. I can now test the timer patch with
the onboard ethernet, forcedeth driver, usb, and the "nvidia" X 
driver, which was crashing linux so I had to use "nv". Those
items are where my stability frontier is.

-Bob



