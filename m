Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313165AbSEEQQU>; Sun, 5 May 2002 12:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313167AbSEEQQT>; Sun, 5 May 2002 12:16:19 -0400
Received: from [195.63.194.11] ([195.63.194.11]:5902 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313165AbSEEQQT>;
	Sun, 5 May 2002 12:16:19 -0400
Message-ID: <3CD54C17.7000304@evision-ventures.com>
Date: Sun, 05 May 2002 17:13:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: John Weber <john.weber@linuxhq.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>,
        Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@muc.de>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.13 IDE and preemptible kernel problems
In-Reply-To: <Pine.LNX.4.33.0205050850090.15809-100000@gans.physik3.uni-rostock.de> <3CD4E1DC.9040704@linuxhq.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik John Weber napisa?:
> Tim Schmielau wrote:
> 
>> On Sat, 4 May 2002, Linus Torvalds wrote:
>>
>>
>>> Hmm.. Something like
>>>
>>>     #define timeout_expired(x)    time_after(jiffies, (x))
>>>
>>> migth indeed make sense.
>>>
>>> But I'm a lazy bastard. Is there some victim^H^H^H^H^H^Hhero who would
>>> want to do the 'sed s/time_after(jiffies,/timeout_expired(/g' and verify
>>> that it does the right thing and send it to me as a patch?
>>>
>>> The thing is, I wonder if it should be "time_after(jiffies,x)" or
>>> "time_after_eq(jiffies,x)". There's a single-tick difference there..
>>>
>> That probably means we need both, as something like 
>> timeout_expired(x+1) seems to call for new "off by one" errors.
> 
> 
> Here's a patch with the s/time_after(jiffies,/timeout_expired(/g and 
> s/time_after_eq(jiffies,/timeout_expired(/g

Yeep. And now please take the next step and grep for "jiffies + 1"

to realize that a timeout primitive along the following

take_a_nap(temeout_function, timeout_data);

would help simpify the usage of timers and speed up the kernel
due to cache locality for stuff which is added to the global
timer list just for doing short micro-polls and beeing taken
out ther on the next scheduler round. In esp. nearly every
single eth driver out there shows precisely what I mean.

Becouse most of the timers get only added for one jiffie!




