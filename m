Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266220AbUHQOCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUHQOCq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268244AbUHQOCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:02:46 -0400
Received: from [195.23.16.24] ([195.23.16.24]:19859 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S266220AbUHQOCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:02:21 -0400
Message-ID: <41220FEA.9050106@grupopie.com>
Date: Tue, 17 Aug 2004 15:02:18 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <6450.1092747900@ocs3.ocs.com.au>
In-Reply-To: <6450.1092747900@ocs3.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.13; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Tue, 17 Aug 2004 13:14:32 +0100, 
> Paulo Marques <pmarques@grupopie.com> wrote:
> 
>>Keith Owens wrote:
>>
>>>On Sat, 14 Aug 2004 05:50:50 +0100, 
>>>Paulo Marques <pmarques@grupopie.com> wrote:
>>>
>>>
>>>>Well, I found some time and decided to give it a go :)
>>>
>>>
>>>This patch regresses some recent changes to kallsyms which handle
>>>aliased symbols, IOW symbols with the same address.  The speed up is
>>>very good, but it has two problems with repeated addresses.
>>
>>Hi,
>>
>>I've been messing with scripts/kallsyms.c to try to follow Andi Kleen's 
>>suggestion of calculating the markers at compile time. This would make 
>>the code in kernel/kallsyms.c much simpler.
>>
>>In the process I could get rid of the aliased symbols at compile time 
>>also. There are only 2 places where they might matter:
>>
>> - the kallsyms_lookup_name function. GREP'ing through the code shows 
>>that this function is only used in arch/ppc64/xmon/xmon.c. Does xmon 
>>need to know about aliased symbols?
> 
> 
> kdb uses aliased symbols as well.  The user can enter any kernel symbol
> name and have it converted to an address.

Ok, I'll leave them alone, then.

Just another quick question: is kallsyms_names only used by the 
functions in kallsyms.c and everyone else simply uses those functions, 
or are there direct users of kallsyms_names?

This is because another thing I was pondering was to change the stem 
compression scheme into a different one, changing all the stuff in 
kallsyms.c accordingly. If there are direct users of kallsyms_names, 
this would break them. There are none in the vanilla kernel as far as I 
can grep, but there might be outside (like in kdb).

I've done some tests with a different scheme and my uncompressed 170kb 
symbol table goes to about 134kb with stem compression and to about 90kb 
with the new scheme. This is not usable right now because compression 
still takes a long time (although the decompression inside 
kernel/kallsyms.c is even simpler than it is now). I'm now trying to 
speed up compression.

As always, comments will be greatly appreciated :)

-- 
Paulo Marques - www.grupopie.com
