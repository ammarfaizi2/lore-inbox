Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSIEPHb>; Thu, 5 Sep 2002 11:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317642AbSIEPHa>; Thu, 5 Sep 2002 11:07:30 -0400
Received: from cibs9.sns.it ([192.167.206.29]:27656 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S317637AbSIEPHZ>;
	Thu, 5 Sep 2002 11:07:25 -0400
Date: Thu, 5 Sep 2002 17:11:33 +0200 (CEST)
From: venom@sns.it
To: bert hubert <ahu@ds9a.nl>
cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: side-by-side Re: BYTE Unix Benchmarks Version 3.6
In-Reply-To: <20020905134830.GA16149@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.43.0209051652350.2538-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I usually run byte bench regularly with every new kernel, so I see some
strange results here.

>From your numbers, I would say you are using a PIII 600/900 Mhz (more or
less). It is not an AMD AThlon or a PIV, since float and double are too
slow, not it is a K6 because they are too fast.

On Thu, 5 Sep 2002, bert hubert wrote:

> Date: Thu, 5 Sep 2002 15:48:30 +0200
> From: bert hubert <ahu@ds9a.nl>
> To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: side-by-side Re: BYTE Unix Benchmarks Version 3.6
>
> Side-by-side with some marked changes highlighted:
>
>                                         2.4.19           2.5.33
> -----------------------------------------------------------------------
> Dhrystone 2 without register variable   1499020.6 lps    1488327.9 lps
> Dhrystone 2 using register variables    1501168.4 lps    1488265.3 lps
> Arithmetic Test (type = arithoh)        3598100.4 lps    3435944.6 lps

this could vary a little

> Arithmetic Test (type = register)        201521.0 lps     197870.4 lps
> Arithmetic Test (type = short)           190245.9 lps     145140.8 lps

the difference should never be so big

> Arithmetic Test (type = int)             201904.5 lps     104440.5 lps

the difference should never be so big

> Arithmetic Test (type = long)            201906.4 lps     177757.4 lps

the difference should never be so big


seeing this I think you had something running in background using your CPU
while you where running int tests. if you loock at bm/results/log
(log.accum if you did some other run recently)
should find lines like:

Arithmetic Test (type = int)|10.0|lps|227163.1|227158.7|6

that is a little more interesting if you are under load.



> Arithmetic Test (type = float)           210562.7 lps     208476.4 lps
> Arithmetic Test (type = double)          210385.9 lps     208443.3 lps
> System Call Overhead Test                407402.6 lps     397276.7 lps
> >Pipe Throughput Test                    476268.6 lps     434561.9 lps


> >Pipe-based Context Switching Test       218969.9 lps     148653.5 lps

this could vary because of a lot of factors, starting from a bad page
colouring going to sendmail activity.

> >Process Creation Test                     9078.6 lps       5422.1 lps
> Execl Throughput Test                       998.0 lps        771.6 lps

this is interesting, but seeing previous results about int and short,
I am curious about your real load. I am quite curious if with 2.5 you are
using kernel preemption.

> File Read  (10 seconds)                 1571652.0 KBps   1553289.0 KBps
> File Write (10 seconds)                  109237.0 KBps    132002.0 KBps
> >File Copy  (10 seconds)                  24329.0 KBps     17994.0 KBps
> File Read  (30 seconds)                 1562505.0 KBps   1540682.0 KBps
> File Write (30 seconds)                  113152.0 KBps    137781.0 KBps
> File Copy  (30 seconds)                   14334.0 KBps     11460.0 KBps

I saw the save with IDE disks... again, are you using kernel preemption?


> C Compiler Test                             470.9 lpm        450.9 lpm
> Shell scripts (1 concurrent)                980.4 lpm        876.7 lpm
> Shell scripts (2 concurrent)                544.1 lpm        480.3 lpm
> Shell scripts (4 concurrent)                287.0 lpm        251.0 lpm
> Shell scripts (8 concurrent)                147.0 lpm        126.0 lpm

In my tests generally shell scripts are faster with 2.5 kernel.

> >Dc: sqrt(2) to 99 decimal places         42311.6 lpm      33530.4 lpm

> Recursion Test--Tower of Hanoi            18915.4 lps      18514.3 lps
>
>
>                       INDEX VALUES           2.4.19     2.5
>  TEST                                        INDEX      INDEX
>
>  Arithmetic Test (type = double)              82.8       82.0
>  Dhrystone 2 without register variables       67.0       66.5
>  Execl Throughput Test                        60.5       46.8
>  File Copy  (30 seconds)                      80.1       64.0
>  Pipe-based Context Switching Test           166.1      112.7
>  Shell scripts (8 concurrent)                 36.8       31.5
>                                          =========  =========
>       SUM of  6 items                        493.2      403.6
>       AVERAGE                                 82.2       67.3
>

Luigi

> --
> http://www.PowerDNS.com          Versatile DNS Software & Services
> http://www.tk                              the dot in .tk
> http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

