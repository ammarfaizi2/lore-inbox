Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUGHIM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUGHIM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 04:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUGHIM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 04:12:56 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:65410 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265910AbUGHIMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 04:12:51 -0400
Message-ID: <40ED01FF.6010206@yahoo.com.au>
Date: Thu, 08 Jul 2004 18:12:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, nigelenki@comcast.net,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: Autoregulate swappiness & inactivation
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net> <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org> <cone.1089268800.781084.4554.502@pc.kolivas.org> <40ECF278.7070606@yahoo.com.au> <cone.1089270749.964538.4554.502@pc.kolivas.org> <40ECF86D.3060707@yahoo.com.au> <cone.1089273829.122131.4554.502@pc.kolivas.org>
In-Reply-To: <cone.1089273829.122131.4554.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Nick Piggin writes:
> 

>> OK that's easy then. The OOM algorithm can be changed if it is
>> OOMing too easily.
> 
> 
> I didn't say it was easy, just harder with; but whatever - I can get rid 
> of it.
> 

Please.

>>>> Secondly, can you please not mess with the exported sysctl. If you
>>>> think your "autoswappiness" calculation is better than the current
>>>> swappiness one, just completely replace it. Bonus points if you can
>>>> retain the swappiness knob in some capacity.
>>>
>>>
>>>
>>> I agree and would like them all removed, but people just love to 
>>> leave the knobs in place. While I dont think the knobs should still 
>>> be there either, I'm not reluctant to leave something that innocuous 
>>> if the users want them.
>>>
>>
>> Well, get rid of the auto-tuning thing to start with, and merge
>> it into the swappiness calculation..
>>
>> Regarding all these knobs, the main thing you want to avoid is
>> having loads of them because you can't find acceptable defaults.
>> I think "swappiness" is in the category of a good sysctl: it is
>> simple, meaningful to the admin, works, etc.
>>
>> It has proven somewhat useful in testing ("set it to blah and see
>> if it still happens"). Or for people who know what they are doing.
> 
> 
> Umm I think we're agreeing, no? I'm trying to leave the swappiness knob 
> in for those who (think?) they know what they're doing. Somehow it needs 
> to be turned to "manual" again.
> 

No. Fold your all "autoswappiness" stuff directly into the
reclaim_mapped calculation that was previously keyed off swappiness.
Don't have it modify vm_swappiness at all: work directly on
reclaim_mapped.

Then, you should be able to retain the user's vm_swappiness input
into the system as well. If you can't figure out a good place to
put this in, don't worry about it to start with.

