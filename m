Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRJOGRG>; Mon, 15 Oct 2001 02:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274989AbRJOGQ5>; Mon, 15 Oct 2001 02:16:57 -0400
Received: from [212.17.18.2] ([212.17.18.2]:38411 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id <S274862AbRJOGQv> convert rfc822-to-8bit;
	Mon, 15 Oct 2001 02:16:51 -0400
Message-Id: <200110150617.f9F6HKX29867@gw.ac-sw.com>
Content-Type: text/plain; charset=US-ASCII
From: Stepan Kalichkin <step@ac-sw.com>
Organization: NGTS
To: <twoity@ukonline.co.uk>
Subject: Re: qsbench on old kernels
Date: Mon, 15 Oct 2001 13:18:10 +0700
X-Mailer: KMail [version 1.3.5]
In-Reply-To: <3.0.6.32.20011011104544.01e9bea0@pop.tiscalinet.it> <200110130655.f9D6tfX00768@gw.ac-sw.com> <001301c153d2$ea1448c0$731086d4@aitjgumcdtb6u>
In-Reply-To: <001301c153d2$ea1448c0$731086d4@aitjgumcdtb6u>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use MSVC on windows 2000 and use Release build.
However I realy forgot turn on optimization in gcc.
When I compiled qsbench with -O2 situation was a little changed.

I have Pentium III (Coppermine) 800MHz with 512MB RAM
when qsbench runing with 90 million integers his fill 343 MB in RAM and swap 
realy don't used.
localhost:~free
                  total        used       free     shared    buffers    cached
Mem:        513768      25412     488356          0       1724      13120
-/+ buffers/cache:      10568     503200
Swap:       514072          0     514072

localhost:~/test/qs_bench > time ./qsbench -n 90000000 -p 1 -s 14538
seed = 14538
 
real    1m2.093s
user    1m0.540s
sys     0m1.550s

I was running from the command shell under linux too.
That's more best results but windows has 48s on same operation however

Then I decide to try use swap. And run qsbench with -n 140000000
This is require 534Mb in ram
My results is:

localhost:~/test/qs_bench > time ./qsbench -n 140000000 -p 1 -s 14538
seed = 14538
 
real    2m46.062s
user    1m36.910s
sys     0m3.960s
----------------------------------
localhost:~/test/qs_bench > time ./qsbench -n 140000000 -p 1 -s 14538
seed = 14538
 
real    2m51.967s
user    1m36.670s
sys     0m3.810s

And under windows 2000:

seed = 14538
time = 511s

[System Summary]
 
OS Name Microsoft Windows 2000 Server
Version 5.0.2195  Build 2195
OS Manufacturer Microsoft Corporation
System Name     STEP
System Manufacturer     ABIT
System Model    6A69RA1K
System Type     X86-based PC
Processor       x86 Family 6 Model 8 Stepping 3 GenuineIntel ~806 Mhz
BIOS Version    BIOS Rev:0.1
Windows Directory       C:\WINNT
System Directory        C:\WINNT\System32
Boot Device     \Device\Harddisk0\Partition4
Locale  Russia
User Name       STEP\step
Time Zone       N. Central Asia Daylight Time
Total Physical Memory   523760 KB
Available Physical Memory       442444 KB
Total Virtual Memory    1530844 KB
Available Virtual Memory        1313744 KB
Page File Space 1007084 KB
Page File       C:\pagefile.sys

So in my conclusion. Windows have more performance in comparison with linux 
when swap is't used. And when swap is start using linux be ahead like hell

On Saturday 13 October 2001 17:36, you wrote:
> I have to admit, I was curious to see what the respective performances
> would be;  I tried the original program on my athlon700 with 256Mb ram
> and IDE disk under both a recent linux kernel and windows 2000 SP2.
>
> With 90 million integers being sorted the memory required is ~360 Mb
> so that I had to enable swap in linux(iirc the idea of the exercise
> was to measure performance under a swap load).  Windows 2000 was set
> to use 400Mb of swap.
>
> Linux took 6 1/2 minutes, windows 2000 took 20+ minutes.  This makes
> perfect sense to me - windows was running a full graphical shell, its
> memory usage amounted to about 70Mb without the program running, on
> the other hand I was running from the command shell under linux, and
> so the portion of data in swap was lower, decreasing drastically the
> number of slow swapouts/ins.
>
> From your results, it seems that the program is not swapping.  In this
> case linux and windows 2000 should come up with identical numbers (as
> 95+% of time is spent in the user program).
>
> I suspect the difference therefore is in your qsbench - did you compile
> with optimization on linux, but use "Release build" on windows 2000?
> (Assuming you use MSVC for the windows executable).
>
> If this is the case, try
>
> gcc -O2 qsbench.c -o qsbench
>
> to produce a new linux executable; then the times should be the same.
>
> Alternatively try increasing the number of integers sorted until the
> program begins to swap, the performance should become dominated by
> the speed of the disk.
>
> I think a more interesting comparison would be where identical amounts
> of the program are in swap on both windows 2000 & linux - this could
> be achieved by passing mem= options to the linux kernel at boot to
> emulate the effect of MS's memory filling programs.
>
> Or maybe windows 2000 is 2x the performance of linux?  I'm ready to be
> pleasantly suprised.
>
> ----- Original Message -----
> From: "Stepan Kalichkin" <step@ac-sw.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Saturday, October 13, 2001 7:56 AM
> Subject: Re: qsbench on old kernels
>
> > Hi
> > I compiled qsbench under windows 2000
> > And get some interesting results:
> >
> > Under my linux kernel  2.4.9-ac18
> >
> > localhost:~/test/qs_bench > time ./qsbench -n 90000000 -p 1 -s 14538
> > seed = 14538
> >
> > real    1m50.442s
> > user    1m48.410s
> > sys     0m1.660s
> >
> > And under windows with same parameters:
> > seed = 14538
> > time = 48s
> >
> > --
> > seed = 14538
> > time = 47s
> >
> > --
> > seed = 14538
> > time = 48s
> >
> > May be this comparison is't correctly
> > but so large difference!
> > Any comments?
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

