Return-Path: <linux-kernel-owner+w=401wt.eu-S1750786AbXAOOyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbXAOOyd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 09:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbXAOOyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 09:54:33 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:59673 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbXAOOyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 09:54:32 -0500
Message-ID: <45AB956A.5070103@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2007 20:23:30 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Soeren Sonnenburg <kernel@nn7.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: prioritize PCI traffic ?
References: <1168859265.15294.8.camel@localhost> <45AB8768.7000907@linux.vnet.ibm.com> <1168869630.15294.44.camel@localhost>
In-Reply-To: <1168869630.15294.44.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Soeren Sonnenburg wrote:
> On Mon, 2007-01-15 at 19:23 +0530, Vaidyanathan Srinivasan wrote:
>> Soeren Sonnenburg wrote:
>>> Dear all,
>>>
>>> is it possible to explicitly tell the kernel to prioritize PCI traffic
>>> for a number of cards in pci slots x,y,z ?
>>>
>>> I am asking as severe ide traffic causes lost frames when watching TV
>>> using 2 DVB cards + vdr... This is simply due to the fact that the PCI
>>> bus is saturated...
>> How do you know that the bus is saturated?
> 
> I simply dd if=/dev/sd? of=/dev/null from four brand new sata-harddisks.
> 
>> Are you streaming data to/from the ide hard disks/CDROM?
> 
> yes.
>
>> Do you have DMAs 'ON' for the hard disks?
> 
> yes.

Good.

>> Is everything just fine if there are no IDE traffic?
> 
> yes.

Good.

>> Are you running 2.6 kernel with preempt 'ON'?
> 
> no: CONFIG_PREEMPT_NONE=y
> 

Try CONFIG_PREEMPT=y it may help. It made the system more responsive
for me.

>> Are all hardware on the same IRQ line? (shared interrupts)
> 
> no: libata devices are on IRQ 16 and DVB devices on IRQ 20

Watch the interrupt count (/proc/interrupts) and interrupt rate,
that may give some clue on what is happening on the PCI bus.

> 
>>> So, is any prioritizing of the PCI bus possible ?
>> The drivers + application indirectly can control priority on the
>> bus.  Just reduce the priority of the application that uses IDE and
>> see if adjusting nice values of applications can change the scenario.
> 
> That unfortunately did not help... no change...

33Mhz 32-bit PCI bus on typical PC can do around 100MB/sec... watch
your individual disk transfer rates and data rate to each DVB.
dd from 4 new SATA drive will probably fillup the bus.  However,
depending on your motherboard, the integrated SATA controllers may
be on a different PCI bus than the one for the slots.

You can watch the lspci output to determine which bus the devices
are located.

--Vaidy

> 
> Soeren
> --
> Sometimes, there's a moment as you're waking, when you become aware of
> the real world around you, but you're still dreaming.
