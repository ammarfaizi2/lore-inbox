Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUBEV2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUBEV1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:27:51 -0500
Received: from lgsx13.lg.ehu.es ([158.227.2.28]:39112 "EHLO lgsx13.lg.ehu.es")
	by vger.kernel.org with ESMTP id S266881AbUBEV1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:27:21 -0500
Message-ID: <4022B55B.1090309@wanadoo.es>
Date: Thu, 05 Feb 2004 22:27:55 +0100
From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Ford <david+challenge-response@blue-labs.org>
CC: akpm@digeo.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>
In-Reply-To: <40229D2C.20701@blue-labs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:

> I have the same problem.  I "solved" it a while ago by mucking with 
> the AGP stuff.  IIRC, it was turning off AGP fast writes or 8x or 
> something similar in cmos.  Went from incredibly broken to stable 
> instantly.  I'll check my cmos settings in a bit and refresh my memory.
>
> What patches are you using?


I'm using nforce2-apic.patch and nforce2-disconnect-quirk.patch that 
Andrew Morton have sent to me. I think they have been included in 
previous mm kernels but now are droped because they caused some 
temperature problems for some people with no nforce motherboards.

If you want it, I can send it to you.

By the way, is anyone involved in solving the IO-APIC thing in nforce 
motherboards? Anyone trying a different approach? Anyone contacting 
nvidia about this problem?


> p.s. reiserfs is pretty useless against crashes.  hundreds of files 
> around the harddrive get messed up everytime the machine locks 
> up...files that haven't been used in weeks, as well as files opened 
> read-only, i.e. libraries.

I don't think this could be a reiserfs problem, because all the computer 
gets frezzed and locked, but perhaps someone at Namesys can realize why 
files gets deleted all over the hard disc.



Thanks.

Luis Miguel Garcia


>
> p.s. reiserfs is pretty useless against crashes.  hundreds of files 
> around the harddrive get messed up everytime the machine locks 
> up...files that haven't been used in weeks, as well as files opened 
> read-only, i.e. libraries.
>
> Luis Miguel García wrote:
>
>> (sorry with my sucking english)
>>
>> ok, let me know if you know for me to test something with this newer 
>> mm kernels.
>>
>> by the way, yes, I'm experiencing the lockups. Not with heavy io, but 
>> almost when I boot and enter X. The system gets completly frozzened 
>> and the HD led keps on. When I reboot with a sane kernel, I found 
>> several files from my /home directory are deleted or filled with 
>> garbage.
>>
>> Now, I patch each kernel I use with the two patches Andrew sent to me 
>> and I'm having no problems.
>>
>> Actually i'm running 2.6.2-ck1 + nforce-patches and the temperature 
>> of the system is 55º while idle, and 631 while compiling (only cpu 
>> fan, no case fans). I don't know if it's high (some people reported 
>> high temperatures with this patches) but it runs very well this way.
>>
>> If you want for me to test some patches or something, please drop me 
>> a note.
>>
>> Thanks a lot...
>>
>> Luis Miguel García
>>
>> P.S.: by the way, why am I getting strage "arabesque" characters when 
>> I reply to your emails? Perhaps something with wrong encoding?
>>
>>> This is interesting, I will test it myself later on. At one point Len
>>> admitted to owning "foreign hardware :p" so maybe this could get 
>>> resolved.
>>>
>>> Personally I haven't tried kernels with newer forcedeth drivers, 
>>> because I
>>> can no longer explicitely set the power state of the NIC to D3. The
>>> machine complains about irqs (new debugging code since forcedeth 
>>> v.20 or
>>> so) and will not powerdown.
>>>
>>> On another note, have you noticed lockups of your system with heavy io?
>>> Think of fsck'ing, burning cdroms, du on large dirs etc? Maybe it is
>>> helpful to set up a list of boards and document what works or 
>>> doesn't work
>>> with which kernel. For instance the lockups with heavy io seem to be
>>> resolved here if I leave APIC from my kernel.
>>>
>>> Arjen
>>>
>>> On Thu, 5 Feb 2004, [ISO-8859-15] Luis Miguel Garc?a wrote:
>>>
>>>  
>>>
>>>>> Hi:
>>>>>
>>>>> Since Andrew Morton picked up latest acpi bk updates, nforce 
>>>>> motherboards have problems, mainly with ethernet adapters. 
>>>>> Reporters say that with acpi=off, the problm gets fixed, so we 
>>>>> think the problem could be acpi. Some more useful info:
>>>>>
>>>>>
>>>>>
>>>>> On Tue, 3 Feb 2004, [ISO-8859-1] Luis Miguel Garc?a wrote:
>>>>>
>>>>  
>>>>
>>>>>>> >> When I try to boot with latest mm series (such as actual 
>>>>>>> rc3-mm1 or
>>>>>>> >> rc2-mm2), my nforce ethernet device doesn't works. It worked 
>>>>>>> in the past
>>>>>>> >> with the forcedeth reverse engineered driver but now it keeps 
>>>>>>> for 30 or
>>>>>>> >> more seconds halted (at boot) and then the network device 
>>>>>>> dosn't run.
>>>>>>> >>
>>>>>>> >> Here is the dmesg of rc3-mm1. Do you want for me to test 
>>>>>>> something? Thanks!
>>>>>>> >>
>>>>>>> >> P.S.:   The ACPI related messages are larger that in rc3.
>>>>>>
>>>>>>
>>>>>    
>>>>> My e100 on an nforce2 won't work in rc3-mm1.
>>>>> The "acpi=off" boot parameter makes it go.
>>>>>
>>>>>
>>>>> And for the record, I can boot with that kernel and save one dmesg 
>>>>> for you if you want. Only send me a request and I'll send it to you.
>>>>>
>>>>> P.S.: Sent any messages you want directly to me as i'm not 
>>>>> subscribed to acpi-devel.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Luis Miguel Garc?a
>>>>>
>>>>>
>>>>>
>>>>  
>>>>
>>>>>> >Which part of nforce support are you talking about luis?
>>>>>
>>>>
>>>>>> >On Thu, 5 Feb 2004, Andrew Morton wrote:
>>>>>
>>>>  
>>>>
>>>>>>> >> Luis Miguel Garc?a <ktech@wanadoo.es> wrote:
>>>>>>
>>>>>
>>>>>>>>> >>> >
>>>>>>>>> >>> > Andrew Morton wrote:
>>>>>>>>> >>> >
>>>>>>>>
>>>>>>> >>>>> > >> 
>>>>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2/2.6.2-mm1/ 
>>>>>>>
>>>>>>>
>>>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>>>> >>>>> > >> - Merged some page reclaim fixes from Nick and 
>>>>>>>>>>>>> Nikita.  These yield some
>>>>>>>>>>>>> >>>>> > >>  performance improvements in low memory and 
>>>>>>>>>>>>> heavy paging situations.
>>>>>>>>>>>>> >>>>> > >>
>>>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> >>> >
>>>>>>>>> >>> > Andrew, do you know if this acpi pull down has nforce 
>>>>>>>>> support fixed?
>>>>>>>>
>>>>>>>
>>>>>>> >>
>>>>>>> >> It doesn't appear that way.
>>>>>>> >>
>>>>>>
>>>>>   
>>>>>
>>>>>>>>> >>> > Or perhaps it's even unnotified to the acpi team?
>>>>>>>>
>>>>>>>
>>>>>>> >>
>>>>>>> >> I do not know.  Sending them a bugzilla ID would help, if 
>>>>>>> such a thing exists.
>>>>>>

