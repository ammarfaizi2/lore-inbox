Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbUCJXxh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbUCJXxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:53:37 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:21421 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262895AbUCJXx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:53:28 -0500
Message-ID: <404FAA04.1020300@cyberone.com.au>
Date: Thu, 11 Mar 2004 10:51:32 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: VM patches in 2.6.4-rc1-mm2
References: <20040302201536.52c4e467.akpm@osdl.org>	<40469E50.6090401@matchmail.com> <20040303193025.68a16dc4.akpm@osdl.org> <404ECFE5.7040005@matchmail.com> <404ED388.5050905@cyberone.com.au> <404F651B.1030202@matchmail.com>
In-Reply-To: <404F651B.1030202@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> Nick Piggin wrote:
>
>>
>>
>> Mike Fedyk wrote:
>>
>>> Andrew Morton wrote:
>>>
>>>> Mike Fedyk <mfedyk@matchmail.com> wrote:
>>>>
>>>>> Most of the previous 2.6 kernels I was running on these servers 
>>>>> would be lightly hitting swap by now.  This definitely looks 
>>>>> better to me.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> It sounds worse to me.  "Lightly hitting swap" is good.  It gets 
>>>> rid of stuff,
>>>> freeing up physical memory.
>>>
>>>
>>>
>>>
>>> Andrew, it looks like you're right.  This[1] server doesn't seem to 
>>> be hitting swap enough.  But my other[2] file server is doing great 
>>> with it on the other hand (though, it hasn't swapped at all).
>>>
>>
>> Just curious, what makes you say [1] isn't hitting swap enough and [2]
>> is OK? The graphs are better now, by the way. Thank you.
>
>
> Well, with [1], I know most of those apps aren't being used, so I'm 
> sure it should be hitting swap more.
>
> And with [2], it isn't fair since I'm just happy it's not swapping 
> throughout the day and all of userspace is in ram, but it's probably 
> not good either.  And I'm sure there are some gettys and such that 
> aren't being used, so they should have swapped out by now.
>


Yep OK.


>>
>>> Maybe a little tuning is in order?
>>>
>>> Any patches I should try?
>>>
>>
>> Mainline doesn't put enough pressure on slab with highmem systems. This
>> creates a lot more ZONE_NORMAL pressure and that causes swapping.
>>
>
> Yep, saw that.  Especially with 128MB Highmem (eg, 1G RAM)
>
>> Now with the 2.6 VM, you don't do any mapped memory scaning at all
>
>
> You mean 2.6-mm?
>

Yes, either mm or linus.

>> while you only have a small amount of memory pressure. This means that
>> truely inactive mapped pages never get reclaimed.
>>
>
> If I have enough pressure, they will be eventually?  But my caches 
> will still be smaller than optimal, right?
>

If you get a lot of pressure at one time it should push out your
inactive mapped pages. Will get most of the really inactive ones,
but it won't help pages becoming inactive in future.

>> The patches you are using do not address this. My split active list
>> patches should do so. Alternatively you can increase
>> /proc/sys/vm/swappiness, but that isn't a complete solution, and might
>> make things too swappy. It is a difficult beast to control.
>
>
> Has akpm said that he would be including the active split patch in -mm?
>

Hasn't looked at it much. Probably not until some of the more basic
VM patches can get merged into -linus.

> Do you have a patch against -mm (you wrote to ask for your latest...)?
>

Yep...

