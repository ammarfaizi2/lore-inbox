Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266121AbTLIQQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbTLIQQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:16:43 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:47111 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S266121AbTLIQQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:16:41 -0500
Message-ID: <3FD5F9C1.5060704@nishanet.com>
Date: Tue, 09 Dec 2003 11:35:13 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog
References: <20031205045404.GA307@tesore.local> <16336.13962.285442.228795@alkaid.it.uu.se> <20031205085829.GL29119@mis-mike-wstn.matchmail.com> <3FD3DFEB.1010902@nishanet.com> <Pine.LNX.4.55.0312091514130.20948@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0312091514130.20948@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>On Sun, 7 Dec 2003, Bob wrote:
>
>  
>
>>I have append="nmi_watchdog=1" ? Nothing "nmi" or "NMI" is logged.
>>
>> cat /proc/interrupts
>>           CPU0      
>>  0:  241105839          XT-PIC  timer...................
>>NMI:          0...........
>>
> You don't have the NMI watchdog working, because the timer interrupt is
>configured as an 8259A interrupt ("XT-PIC" for IRQ 0 in the output above).  
>This usually means the wiring of a particular system doesn't provide any
>other alternative or configuration data provided by the BIOS is broken.
>The timer interrupt has to be configured as an I/O APIC interrupt for the
>watchdog to work, or you can select "nmi_watchdog=2" for an alternative 
>watchdog internal to processors if they support it.
>
>  
>
Using a patch that fixes a number of people's nforce2
lockups while enabling io-apic edge timer, I can now
use nmi_watchdog=2 but not =1

turn on ioapic edge timer--

http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/nforce2-apic.patch

We're all trying to get acpi, apic, lapic, io-apic working
when turned on in cmos/bios and kernel.

The three things that each alone have achieved stability
on somebody's system here are 1) bios update 2) cpu
disconnect off either in cmos if available or by athcool
or kernel patch with same 3) timing delay patch

For CPU disconnect you still need athcool or this one
http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/nforce2-disconnect-quirk.patch 


Both patches are for 2.6.0-test11 kernel.

