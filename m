Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbTLIQZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbTLIQZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:25:37 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:49160 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S266131AbTLIQZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:25:32 -0500
Message-ID: <3FD5FBD5.1060400@nishanet.com>
Date: Tue, 09 Dec 2003 11:44:05 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: merged in bk5 Re: Catching NForce2 lockup with NMI watchdog - found?
References: <200312081321.06692.ross@datscreative.com.au> <1070883402.17639.115.camel@athlonxp.bradney.info> <3FD4B785.6010908@nishanet.com>
In-Reply-To: <3FD4B785.6010908@nishanet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if you're following this thread, good news--

nforce2 fixups have been merged in
linux-2.6.0-test11-bk5.patch
>  -bk snapshot (patch-2.6.0-test11-bk5)

nforce2-disconnect-quirk.patch
>  [x86] fix lockups with APIC support on nForce2
>
>nforce2-apic.patch
>  [x86] do not wrongly override mp_ExtINT IRQ

plus promise and sis fixes so I don't need to pay
for a 3ware controller ;-)   that was another
show-stopper for me earlier

> We're all trying to get acpi, apic, lapic, io-apic working
> when turned on in cmos/bios and kernel.
>
> The three things that each alone have achieved stability
> on somebody's system here are 1) bios update 2) cpu
> disconnect off either in cmos if available or by athcool
> or kernel patch with same 3) timing delay patch
>
> For CPU disconnect you still need athcool or this one
> http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/nforce2-disconnect-quirk.patch 
>
>
> Both patches are for 2.6.0-test11 kernel.
>
> turn on ioapic edge timer--
>
> http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/nforce2-apic.patch 
>
>
>
> Other changes offer clues and expose symptoms but
> are not helpful or necessary after da fix is in. udma
> settings are a kludge of a error symptom, just aspirin.
>
> Other kludges are acpi off, local apic off in kernel,
> apic off in cmos/bios. These go away when the real
> problem is fixed.
>
> -Bob
>
> Craig Bradney wrote:
>
>> On Mon, 2003-12-08 at 04:21, Ross Dickson wrote:
>>  
>>
>>> On Monday 08 of December 2003 04:08, Bob wrote: > >>Sounds great.. 
>>> maybe you have come across something. Yes, the CPU > >>Disconnect 
>>> function arrived in your BIOS in revision of 2003/03/27 > 
>>> >>"6.Adds"CPU Disconnect Function" to adjust C1 disconnects. The 
>>> Chipset > >>does not support C2 disconnect; thus, disable C2 
>>> function." > >> > >>For me though.. Im on an ASUS A7N8X Deluxe v2 
>>> BIOS 1007. From what I can > >>see the CPU Disconnect isnt even in 
>>> the Uber BIOS 1007 for this ASUS > >>that has been discussed. > >> > 
>>> >>Craig > >
>>> > >I don't have that in MSI K7N2 MCP2-T near the > >agp and fsb 
>>> spread spectrum items or anywhere >> else.   
>>>
>>>> Use athcool:        
>>>> http://members.jcom.home.ne.jp/jacobi/linux/softwares.html#athcool
>>>> or apply kernel patch (2.4 and 2.6 versions were posted already). 
>>>> --bart     
>>>
>>> Please take a look at
>>> Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
>>>
>>> in mailing list.
>>>
>>> I approached it from another angle regarding delaying the apic ack 
>>> in local timer irq
>>> and achieved stability. It would be good to have others try it. Ian 
>>> Kumlien is also
>>> reporting success so far.
>>>
>>>   
>>
>>
>> Although I had long uptimes before.. and therefore might achieve them
>> again fairly easily.. I'm now on 2 days 10 hours which has included a
>> lot of compilation and a lot of idle time, and plenty of the hdpar and
>> grep tests. I have used only the IRQ0 IO-APIC edge patch.
>>
>> Can someone please note all the patches for 2.6 that people have tried
>> and what they achieve? Im starting to get a bit lost, given the fact
>> that I'm running stable here with only 1 patch. (so far - this is where
>> it crashes after I click Send I suppose ;) )
>>
>> -apic
>>  
>>
>   -local apic("lapic")
>
>   -acpi
>
> kernel local apic issue and acpi and apic go together,
> but turning off lapic first might achieve stability for
> some, updating bios will enable using all bios and
> linux apic, acpi, lapic, ioapic for some(me twice).
>
>> -io-apic (IRQO set to XT-PIC incorrectly)
>>
>> -udma133?
>>  
>>
> udma133 may be a clue but I don't think anyone
> achieves stability one way or the other on that. I
> flogged every possible hdparm change and tried
> three brands of hd controller without every
> achieving stability, but once you're stable by
> using other means you can use 133 and unmask
> irq(not for siig sis?) and other hdparm opts.
>
>> -cpu disconnect patch (missing bios option for ACPI Cx states)
>>
>> Craig
>>  
>>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

