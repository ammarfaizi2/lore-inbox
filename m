Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288234AbSAHSpF>; Tue, 8 Jan 2002 13:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288230AbSAHSoq>; Tue, 8 Jan 2002 13:44:46 -0500
Received: from freeside.toyota.com ([63.87.74.7]:18441 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S288227AbSAHSoa>; Tue, 8 Jan 2002 13:44:30 -0500
Message-ID: <3C3B3E05.5020207@lexus.com>
Date: Tue, 08 Jan 2002 10:44:21 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: FD Cami <stilgar2k@wanadoo.fr>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <Pine.LNX.4.33.0201072222100.15970-100000@localhost.localdomain> <3C3AB284.5070703@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excellent - I'm going to try this one on whatever
machines I have available for testing, and if I am
emboldened by success, I'll  try it on some light
duty production servers as well -

- keep us in the loop, please!

Regards,

jjs

FD Cami wrote:

>
> Hi all
>
> I'm joining the host of beta testers involved in that patch...
>
> It's currently running on a production machine :
> dual PII350 on ASUS P2B-DS
> 3 SCSI hard drives
> 512MB of RAM
> 3C905C
> This is a network server running squid-cache www proxy with
> a medium load (700 clients on a T3), mysqld, apache, proftpd.
> kernel is stock 2.4.17 - and so far, so good.
>
> Cheers,
>
> François Cami
>
>
> Ingo Molnar wrote:
>
>> On Mon, 7 Jan 2002, Linus Torvalds wrote:
>>
>>
>>> Ingo, looks true. A quick -D2?
>>>
>>
>> yep, Brian is right. I've uploaded -D2:
>>
>>         http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-D2.patch
>>
>> other changes:
>>
>>  - make rt_priority 99 map to p->prio 0, rt_priority 0 map to p->prio 
>> 99.
>>
>>  - display 'top' priorities correctly, 0-39 for normal processes, 
>> negative
>>    values for RT tasks. (it works just fine it appears.) We did not 
>> use to
>>    display the real priority of RT tasks, but now it's natural.
>>
>>
>>> Oh, and please move console_init() back, other consoles (sparc?) may
>>> depend on having PCI layers initialized.
>>>
>>
>> (doh, done too, fix is in -D2.)
>>
>>
>>> Oh, and _I_ don't like "cpu()".  What's wrong with the already
>>> existing "smp_processor_id()"?
>>>
>>
>> nothing serious, my main problem with it is that it's often too long for
>> my 80 chars wide consoles, and it's also too long to type and i use it
>> quite often in SMP code.
>>
>> IIRC we had a 'hard_smp_processor_id()' initially, partly to make it
>> harder to use it. (it was very slow because it did an APIC read). But
>> these days smp_processor_id() is just as fast (or even faster) as
>> 'current'. So i wanted to use cpu() in new code to make it easier to 
>> read
>> and to make it more compact. But if this is a problem i can remove it.
>> I've verified that there is no obvious namespace collisions.
>>
>> (i've done a quick UP sanity compile + boot of 2.5.2-pre9 + D2, it all
>> works as expected.)
>>
>>     Ingo
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


