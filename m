Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVALU0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVALU0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVALU0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:26:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:51608 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261403AbVALUPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:15:39 -0500
Message-ID: <41E58458.2070006@osdl.org>
Date: Wed, 12 Jan 2005 12:11:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question regarding ERR in /proc/interrupts.
References: <Pine.LNX.4.61.0501121410360.11524@p500> <41E57B0C.30905@osdl.org> <Pine.LNX.4.61.0501121447040.11524@p500>
In-Reply-To: <Pine.LNX.4.61.0501121447040.11524@p500>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> The kernel is 2.6.10.
> 
> The patch would effectively increment the ERR counter for each ERR correct?

No, that is already incremented for each ERR, the patch just makes
each and every one of them be printed.  (warning)

> Is there anyway to trace the path or cause of an ERR?

Just the interrupt number and hence what device it is used by
(in /proc/interrupts).  However, the 8259 PIC reports spurious
interrupts on IRQ 7.  That's "normal" for it.

> For instance, I know I can make one occur like this:
> 
> I have 3 promise boards in a box, when I am doing multiple transfers 
> across 2-3 drives and doing an NFS transfer, I may hear the IBM or 
> Hitachi disk click and the ERR will incremement or just a long pause.  
> Also, I have used the IBM drive for 4-5+ yrs, never had any data 
> corruption.  The disks themselves are not bad.  It would just be nice to 
> understand why such spurious interrupts occur.

No idea, sorry.  I've seen a few problems with riser boards (in
general, mostly timing related), but I don't know anything about
this one.

Did this start happening recently?

Have you tried asking the drives if they have any SMART data
(problems) logged?

> Dell Setup:
> 
>  PCI SLOT 1 = PCI1
> 
>  The PCI slots are on a riser board (Dell GX1p)
> 
>  PCI1 = Closest to motherboard.
> 
>  PCI1 = Intel GigE Nic
>  PCI2 = Promise ATA/100
>  PCI3 = Maxtor Promise ATA/133
>  PCI4 = Maxtor Promise ATA/133
>  PCI5 = 4 Port 10/100 NIC
>  ISA1 = Empty
>  ISA2 = Empty
>  ISA3 = Empty
> 
>  Note: Nothing is attached to the system's IDE ports, they are disabled.
>        I also turned off ACPI/stuff I do not use.
> 
> 
> 
>  On Wed, 12 Jan 2005, Randy.Dunlap wrote:
> 
>> Justin Piszcz wrote:
>>
>>> Is there anyway to log each ERR to a file or way to find out what 
>>> caused each ERR?
>>>
>>> For example, I know this is the cause of a few of them:
>>> spurious 8259A interrupt: IRQ7.
>>>
>>> But not all 20, is there any available option to do this?
>>
>>
>> Are you sure about that?
>>
>> MOTD:  what kernel version?
>>
>> 2.6.10 (and probably all) prints such message one time for each
>> "spurious" IRQ, sets a flag for that IRQ, and then doesn't
>> print such message for that IRQ any more (i.e., so that
>> log isn't spammed).  Each distinct spurious IRQ should be
>> logged (one time).  If you want more, you'll need to patch
>> a source file and rebuild the kernel (attached, for i8259
>> PIC, not for APIC, since that's what you seem to have).
>>
>>> $ cat /proc/interrupts
>>>            CPU0
>>>   0:  887759057          XT-PIC  timer
>>>   1:       3138          XT-PIC  i8042
>>>   2:          0          XT-PIC  cascade
>>>   5:       5811          XT-PIC  Crystal audio controller
>>>   9:  265081861          XT-PIC  ide4, eth1, eth2
>>>  10:    9087912          XT-PIC  ide6, ide7
>>>  11:     837707          XT-PIC  ide2, ide3
>>>  12:      13854          XT-PIC  i8042
>>>  14:   63373075          XT-PIC  eth0
>>> NMI:          0
>>> ERR:         20

-- 
~Randy
