Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSHBTCq>; Fri, 2 Aug 2002 15:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSHBTCp>; Fri, 2 Aug 2002 15:02:45 -0400
Received: from ns.escriba.com.br ([200.250.187.130]:5884 "EHLO
	alexnunes.lab.escriba.com.br") by vger.kernel.org with ESMTP
	id <S316750AbSHBTCn>; Fri, 2 Aug 2002 15:02:43 -0400
Message-ID: <3D4AD817.3080200@PolesApart.wox.org>
Date: Fri, 02 Aug 2002 16:05:59 -0300
From: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: some questions using rdtsc in user space
References: <3D4ABCA3.3020402@PolesApart.wox.org> <3D4ACF11.FD7BB5B5@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

>[snip]
>
>>If using rdtsc is a good way, someone knows how do I do some sort of
>>loop, converting the rdtsc difference (is it in cpu clocks, right?) to
>>nano/microseconds, and if there could be bad behaviour from this (I
>>believe there could be some SMP issues, but for now this is irrelavant
>>for us).
>>    
>>
>
>You'd be more portable looping on gettimeofday(), which returns back seconds and
>microseconds.  The disadvantage is that if you change the system time while your
>program is running you can get screwed.
>

I guess ntpd would be the evil on this issue, because at least in some 
machines I have here, it makes minor (sometimes not "that" minor) 
corrections every half hour or so...

>
>If you want to loop on rdtsc (which as you say is often clockspeed, but that is
>not necessarily exactly what is advertised), then the first thing you need to do
>is to figure out how fast you're going.  What I usually do is grab a timestamp,
>sleep for 10 seconds using select(), and grab another timestamp.  Figure out the
>difference in timestamps, divide by 10, and you get ticks/sec.  If it's close to
>your advertised clock rate, then round it up to the clock rate for ease of
>calculation.  As an example, my 550MHz P3 gives 548629000 ticks/sec using this
>method, so for your purposes I'd round it up to 550000000.
>
>Once you have this information, just divide by 5 million to get the number of
>ticks in 200ns.
>
>  
>
Ok, that's exactly where I was trying to get to, I'll do some 
experiments, thank you!

Alexandre

