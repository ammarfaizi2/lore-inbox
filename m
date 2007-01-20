Return-Path: <linux-kernel-owner+w=401wt.eu-S965276AbXATPJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbXATPJh (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 10:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbXATPJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 10:09:37 -0500
Received: from top.qwarx.com ([80.248.178.170]:35850 "EHLO top.qwarx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965276AbXATPJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 10:09:36 -0500
Date: Sat, 20 Jan 2007 15:09:34 +0000 (GMT)
From: Chris Wilson <chris@qwirx.com>
X-X-Sender: chris@top.qwarx.com
To: linux-kernel@vger.kernel.org
cc: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: IRQ: Nobody cared (2.6.19.1)
In-Reply-To: <Pine.LNX.4.62.0701061657010.17685@top.qwarx.com>
Message-ID: <Pine.LNX.4.62.0701201508260.17685@top.qwarx.com>
References: <Pine.LNX.4.44L0.0701052212330.8955-100000@netrider.rowland.org>
 <Pine.LNX.4.62.0701061657010.17685@top.qwarx.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sat, 6 Jan 2007, Chris Wilson wrote:

> Forwarded to lkml as suggested by Alan Stern. Please copy any replies to me, 
> as I'm not on the list (too much traffic, sorry!).

Ping? It's been two weeks.

Cheers, Chris.

> On Fri, 5 Jan 2007, Alan Stern wrote:
>>  On Sat, 6 Jan 2007, Chris Wilson wrote:
>> > 
>> >  I keep getting the following errors:
>> > 
>> >  Jan  5 23:48:38 gcc kernel: irq 10: nobody cared (try booting with the
>> >     "irqpoll" option)
>> 
>> >  Jan  5 23:48:38 gcc kernel: handlers:
>> 
>> >  Jan  5 23:48:38 gcc kernel: [<e0866a00>] (usb_hcd_irq+0x0/0x70 
>> >  [usbcore])
>> >  Jan  5 23:48:38 gcc kernel: Disabling IRQ #10
>> > 
>> >  There are no devices attached to that USB port, and it's the only device
>> >  registered for IRQ 10.
>> > 
>> >  This is a 2.6.19.1 kernel, last booted less than an hour ago. I had the
>> >  same problem with 2.6.14.3 and older kernels, but less frequently.
>> > 
>> >  Hardware is dual p3 coppermine, Gigabyte 6VXDC7 motherboard. Otherwise
>> >  very stable, last up for 297 days (until I booted this kernel).
>> 
>> >  /proc/interrupts:
>> > 
>> >             CPU0       CPU1
>> >     0:     424892     412866   IO-APIC-edge      timer
>> >     1:       2706       2034   IO-APIC-edge      i8042
>> >     4:          5          1   IO-APIC-edge      serial
>> >     5:          0          0   IO-APIC-fasteoi   acpi
>> >     6:          5          0   IO-APIC-edge      floppy
>> >     7:          0          0   IO-APIC-edge      parport0
>> >    10:      75964      63749   IO-APIC-fasteoi   uhci_hcd:usb1,
>> >    uhci_hcd:usb2
>> >    12:      38217      29601   IO-APIC-edge      i8042
>> >    14:      24424      14372   IO-APIC-edge      ide0
>> >    15:          1         10   IO-APIC-edge      ide1
>> >    16:      44129          1   IO-APIC-fasteoi   eth0
>> >    17:         35     209490   IO-APIC-fasteoi   eth1
>> >    18:      49348      50382   IO-APIC-fasteoi   EMU10K1
>> >  NMI:          0          0
>> >  LOC:     837636     837635
>> >  ERR:          0
>> >  MIS:          0
>> > 
>> >  Please let me know if I can provide any more information that might 
>> >  help,
>> >  or anything I can do to help fix this. I expect that the USB port is now
>> >  useless until I reload the module.
>> 
>>  This almost certainly is not caused by a problem in the USB hardware.
>>  More likely some other device is using IRQ 10 and the kernel doesn't
>>  realize it.  In other words, it's a problem in IRQ assignment.
>> 
>>  You can try booting with acpi=off on the boot command line, or acpi=noirq,
>>  or noapic.
>> 
>>  You can go ahead and report this on LKML; you don't have to subscribe to
>>  the list in order to post on it.  (That's what I do.)  Include the dmesg
>>  log showing the IRQ assignments during boot-up.
>> 
>>  Alan Stern
>
> Dmesg boot log attached. Any suggestions gratefully received.
>
> It seems a bit drastic to disable a whole IRQ if it receives spurious 
> interrupts that are not claimed by any driver. That could kill a machine if 
> the IRQ is used for something critical like disks.
>
> I'd rather not boot without ACPI if possible, as I don't want to lose power 
> saving. I'm not sure about the negative consequences of booting with 
> acpi=noirq or noapic, so I haven't tried that yet.
>
> Cheers, Chris.
-- 
_ ___ __     _
  / __/ / ,__(_)_  | Chris Wilson <0000 at qwirx.com> - Cambs UK |
/ (_/ ,\/ _/ /_ \ | Security/C/C++/Java/Perl/SQL/HTML Developer |
\ _/_/_/_//_/___/ | We are GNU-free your mind-and your software |

