Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbTBDUYB>; Tue, 4 Feb 2003 15:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbTBDUYB>; Tue, 4 Feb 2003 15:24:01 -0500
Received: from s142-179-222-244.ab.hsia.telus.net ([142.179.222.244]:8622 "EHLO
	bluetooth.WNI.AD") by vger.kernel.org with ESMTP id <S267453AbTBDUX5>;
	Tue, 4 Feb 2003 15:23:57 -0500
Message-ID: <3E40245E.4010507@WirelessNetworksInc.com>
Date: Tue, 04 Feb 2003 13:36:46 -0700
From: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: P@draigBrady.com
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc 2.95 vs 3.21 performance
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com> <3E3F9C82.7000607@Linux.ie> <3E3FBC1C.167E779A@aitel.hist.no> <3E3FC898.4040809@draigBrady.com>
In-Reply-To: <3E3FC898.4040809@draigBrady.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Feb 2003 20:33:31.0592 (UTC) FILETIME=[AE8F7480:01C2CC8C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

More than anything else, the execution speed on modern processors seem 
to be a factor of code and data allignment.  Some processors are OK with 
16 bit word allignment, other require 32 bit word allignment and the new 
crop of processors will probably require 64 bit word allignment.

If the data accesses are not alligned for your type of processor, then 
SDRAM accesses go to hell as the bursting gets upset.

Unfortunately, this is a factor of processor architecture and the MS and 
Intel compilers support a small number of processors and can therefore 
be more easily optimized than GCC, which supports every processor in the 
whole world.

If some application of yours is very speed sensitive, then you'll have 
to insert specific allignment control switches/pragmas to force GCC to 
do things the right way for speed, but that will typically increase the 
code and data size a little.

Cheers,
-- 

------------------------------------------------------------------------
Herman Oosthuysen
B.Eng.(E), Member of IEEE
Wireless Networks Inc.
http://www.WirelessNetworksInc.com
E-mail: Herman@WirelessNetworksInc.com
Phone: 1.403.569-5687, Fax: 1.403.235-3965
------------------------------------------------------------------------


P@draigBrady.com wrote:
> Helge Hafting wrote:
> 
>>Padraig@Linux.ie wrote:
>>[...]
>>
>>
>>>Interesting. I just noticed that I get 50% decrease in
>>>the speed of my program if I just insert a printf(). I.E.
>>>my program is like:
>>>
>>>printf()
>>>for(;;) {
>>>    do_sorting_loop_test();
>>>}
>>>
>>>If I remove the initial printf it doubles in speed?
>>>I assume this is some weird caching thing?
>>
>>
>>Looks like a cacheline alignment issue to me.
>>This loop of yours occupy x cachelines on your cpu,
>>moving it in memory by adding the printf
>>might cause it to ocupy x+1 cachelines.
>>That might be noticeable if x is a really small number,
>>such as 1.
> 
> 
> OK it is (as I suspected and as you explained nicely)
> related to the cachelines on my CPU (866 celery).
> 
> ===============================
> GCC options		loops/s
> ===============================
> gcc			2283
> gcc -O3 -falign-loops=2	3451
> gcc -O3 -falign-loops=4	3443
> gcc -O3 -falign-loops=8	7045
> gcc -march=i686 -O3	9101
> ===============================
> 
> cheers,
> Pádraig.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



