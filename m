Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319363AbSHVPUQ>; Thu, 22 Aug 2002 11:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319365AbSHVPUQ>; Thu, 22 Aug 2002 11:20:16 -0400
Received: from gra-lx1.iram.es ([150.214.224.41]:43790 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S319363AbSHVPUP>;
	Thu, 22 Aug 2002 11:20:15 -0400
Message-ID: <3D65020D.5070201@iram.es>
Date: Thu, 22 Aug 2002 15:23:57 +0000
From: Gabriel Paubert <paubert@iram.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Yoann Vandoorselaere <yoann@prelude-ids.org>,
       cpufreq@lists.arm.linux.org.uk, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffy calculation
References: <3D64D51C.9040603@iram.es> <20020822143115.15323@192.168.4.1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>Well, first on sane archs which have an easily accessible, fixed
>>frequency time counter, loops_per_jiffy should never have existed :-)
>>
>>Second, putting this code there means that one day somebody will
>>inevitably try to use it outside of its domain of operation (like it
>>happened for div64 a few months ago when I pointed out that it would not
>>work for divisors above 65535 or so).
> 
> 
> Well... it's clearly located inside kernel/cpufreq.c, so there is
> little risk, though it may be worth a big bold comment

Hmm, in my experience people hardly ever read detailed comments even 
when they are well-written. Perhaps if you called the function 
imprecise_scale or coarse_scale, it might ring a bell.

Besides that functions should do one thing and do that *well*[1]. Well, 
I'm usually not too dogmatic, but this function breaks the second rule
beyond what I find acceptable.

>>In this case a generic scaling function, while not a standard libgcc/C
>>library feature has potentially more applications than this simple 
>>cpufreq approximation. But I don't see very much the need for scaling a 
>>long (64 bit on 64 bit archs) value, 32 bit would be sufficient.
> 
> 
> Well... if you can write one, go on then ;) In my case, I'm happy
> with Yoann implementation for cpufreq right now. Though I agree that
> could ultimately be moved to arch code.

Ok, I'll give it a try this week-end (PPC, i386 and all 64 bit should 
archs should be trivial).

	Gabriel.

[1] Documentation/CodingStyle, which also claims that functions should 
be short and *sweet*. Well, I found the patch far too bitter ;-).


