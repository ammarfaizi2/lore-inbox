Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbUCJIgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 03:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbUCJIgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 03:36:40 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:29313 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262549AbUCJIg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 03:36:29 -0500
Message-ID: <404ED388.5050905@cyberone.com.au>
Date: Wed, 10 Mar 2004 19:36:24 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: VM patches in 2.6.4-rc1-mm2
References: <20040302201536.52c4e467.akpm@osdl.org>	<40469E50.6090401@matchmail.com> <20040303193025.68a16dc4.akpm@osdl.org> <404ECFE5.7040005@matchmail.com>
In-Reply-To: <404ECFE5.7040005@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> Andrew Morton wrote:
>
>> Mike Fedyk <mfedyk@matchmail.com> wrote:
>>
>>> Most of the previous 2.6 kernels I was running on these servers 
>>> would be lightly hitting swap by now.  This definitely looks better 
>>> to me.
>>
>>
>>
>> It sounds worse to me.  "Lightly hitting swap" is good.  It gets rid 
>> of stuff,
>> freeing up physical memory.
>
>
> Andrew, it looks like you're right.  This[1] server doesn't seem to be 
> hitting swap enough.  But my other[2] file server is doing great with 
> it on the other hand (though, it hasn't swapped at all).
>

Just curious, what makes you say [1] isn't hitting swap enough and [2]
is OK? The graphs are better now, by the way. Thank you.

> Maybe a little tuning is in order?
>
> Any patches I should try?
>

Mainline doesn't put enough pressure on slab with highmem systems. This
creates a lot more ZONE_NORMAL pressure and that causes swapping.

Now with the 2.6 VM, you don't do any mapped memory scaning at all
while you only have a small amount of memory pressure. This means that
truely inactive mapped pages never get reclaimed.

The patches you are using do not address this. My split active list
patches should do so. Alternatively you can increase
/proc/sys/vm/swappiness, but that isn't a complete solution, and might
make things too swappy. It is a difficult beast to control.

