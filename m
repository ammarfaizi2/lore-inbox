Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbUC3Jag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbUC3Jag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:30:36 -0500
Received: from imap.gmx.net ([213.165.64.20]:3788 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263572AbUC3JaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:30:21 -0500
X-Authenticated: #4512188
Message-ID: <40693E31.9020308@gmx.de>
Date: Tue, 30 Mar 2004 11:30:25 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross@datscreative.com.au
CC: Len Brown <len.brown@intel.com>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
References: <200403181019.02636.ross@datscreative.com.au> <405C1C0D.9050108@gmx.de> <4068803B.5010208@gmx.de> <200403301057.37177.ross@datscreative.com.au>
In-Reply-To: <200403301057.37177.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> On Tuesday 30 March 2004 05:59, Prakash K. Cheemplavam wrote:
> 
>>Prakash K. Cheemplavam wrote:
>>
>>>Ross Dickson wrote:
>>>
>>>
>>>>On Saturday 20 March 2004 19:29, Prakash K. Cheemplavam wrote:
>>>>
>>>>
>>>>>Len Brown wrote:
>>>>>
>>>>>
>>>>>>On Fri, 2004-03-19 at 14:22, Prakash K. Cheemplavam wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>>Hmm, I just did a cat /proc/acpi/processor/CPU0/power:
>>>>>>>active state:            C1
>>>>>>>default state:           C1
>>>>>>>bus master activity:     00000000
>>>>>>>states:
>>>>>>>  *C1:                  promotion[--] demotion[--] latency[000] 
>>>>>>>usage[00000000]
>>>>>>>   C2:                  <not supported>
>>>>>>>   C3:                  <not supported>
>>>>>>>
>>>>>>>I am currently NOT using APIC mode (nforce2, as well) and using 
>>>>>>>vanilla 2.6.4. It seems C1 halt state isn't used, which exlains why 
>>>>>>>I am having 
>>>>>
>>>>>
>>>>>[snip]
>>>>>
>>>>>
>>>>>>Actually I think it is that we don't _count_ C1 usage.
>>>>>
>>>>>
>>>>>Hmm, OK, then I am really puzzled what specifically about mm sources 
>>>>>make my idle temps hotter, as I still couldn't properly resolve it 
>>>>>what is causing it. I thought ACPI, but no, using APM only does the 
>>>>>same (apm only with vanilla is low temp though.)
>>>>
>>>>
>>>>
>>>>Have you seen this thread, it may be relevant?
>>>>Re: [2.6.4-rc2] bogus semicolon behind if()
>>>>http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/4170.html
>>>
>>>
>>So, I seem to have found the bugger causing higher temps: It is NVidia 
>>binary driver, or rather its AGP part of the 53.36 driver. Using AGPGART 
>>and Nvidia driver leaves my system cool. Using NVAGP it seems as though 
>>C1 state isn't actually used anymore thus making the CPU hotter.
> 
> 
> Hmmm.
> Would you happen to have a copy of athcool handy - it would be interesting to
> see the northbridge disconnect bit status - if its been turned off by their driver?

That is the funny thing: Athcool reports it is on. So something from 
their AGP code seems to prevent the CPU going "full idle", I guess. 
Well, now I am using 53.41 driver with agpgart and everything finally 
seems to be stable, cool and nice. :)

Prakash
