Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286478AbRL1RH2>; Fri, 28 Dec 2001 12:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283783AbRL1RHT>; Fri, 28 Dec 2001 12:07:19 -0500
Received: from [212.50.10.141] ([212.50.10.141]:40680 "HELO ns.top.bg")
	by vger.kernel.org with SMTP id <S284090AbRL1RHC>;
	Fri, 28 Dec 2001 12:07:02 -0500
Message-ID: <3C2D334F.DF33197C@top.bg>
Date: Fri, 28 Dec 2001 19:06:55 -0800
From: Anton Tinchev <atl@top.bg>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: "Jeffrey W. Baker" <jwb@saturn5.com>
Subject: Re: 2.4.17 absurd number of context switches
In-Reply-To: <Pine.LNX.4.33.0112280824550.23655-100000@windmill.gghcwest.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is your system heavy loaded?
I'm running Postgres 7.1.2 on 2-way x86 too and noticed that context switches
are high!
Here the slice on about %50 free cpu time, but when goes up to %80-%90 -
context switches going to 10000-15000:
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 1  0  0  87364  15448   2540 1218324   1   1    20    13    7    17  16   4
18
 3  0  0  87364  12596   2552 1219336  36   0   964     0  504  1385  30  16
53
 4  1  0  87364   7684   2556 1220568   0   0  1196   768  687  1645  28  16
56
 2  1  0  87364   6172   2568 1218940   0   0  1156     0  604  1485  31  11
58
10  0  0  87364   5648   2572 1218764   0   0   972     0  366  1012  23  18
60
 5  0  0  87364   6216   2580 1218208   0   0   604     0  411  1154  28  20
52
12  0  0  87364   5832   2580 1216952   0   0   272     0  317  1567  31  23
46
12  0  0  87364   6048   2592 1216100   0   0   168   384  448  2011  47  13
40
11  0  0  87364   5920   2596 1216116   0   0    20     0  284  2307  58  12
30
 9  0  0  87364   6556   2600 1216136   0   0    12     0  284  2164  53   9
38
11  0  0  87364   6536   2608 1216220   0   0    68     0  324  2140  50  12
38
23  0  0  87364   7176   2612 1216232   0   0     4     0  317  2238  46   9
46
12  0  0  87364   6880   2616 1216360  16   0   140   256  440  2367  33  18
49
 9  0  0  87364   6380   2644 1216692   0   0   336     0  454  2874  28  17
55
 7  0  0  87364   5956   2648 1216772   0   0    52     0  550  2659  28  17
55
 1  0  0  87364   5420   2628 1215544   0   0    32     0  538   648  13   2
85
 0  0  0  87364   6180   2632 1215636   0   0    72     0  421   430  11   3
86
 0  0  0  87364   6152   2632 1215664   0   0    20  1152  328   225   6   1
92
 0  0  0  87364   6116   2632 1215696   0   0    36     0  278   242   7   1
91
 0  0  0  87364   5512   2580 1214524   0   0   152     0  433   426  10   4
87
 0  0  0  87364   9072   2580 1214536   0   0     8     0  303   290   8   1
91


"Jeffrey W. Baker" wrote:

> Here's a slice of vmstat 1 on my 2-way x86, 2GB main memory machine
> running Postgres 7.2beta4 on Linux 2.4.17:
>                                                            cpu
> r b w                                bi  bo  in    cs us sy id
> 7 0 0 371612 58272 18576 1568896 0 0  0 168 414 33113 49 38 13
> 9 0 0 371612 59168 18576 1568900 0 0  0  64 215 32143 56 36  8
> 5 0 0 371612 58532 18576 1568924 0 0  0 696 363 33553 52 41  7
> 8 0 0 371612 59344 18576 1568956 0 0 16 240 374 34237 52 38  9
> 3 0 0 371612 58860 18576 1568996 0 0  0 128 254 31848 51 38 11
> 6 0 0 371612 59172 18576 1568996 0 0  0  64 234 36340 56 30 14
> 3 0 0 371612 59092 18576 1569004 0 0  0 232 204 32065 48 42 11
>                                                 ^^^^^
> Check out those figures for context switches!  30,000 switches per second
> with only three runnable processes and practically no block I/O seems
> quite high to me.  You can also see that the system is spending half its
> time in the kernel, presumably in the scheduler.  Postgres is barely
> getting any CPU time at all, and the performance suffers noticeably.
>
> Is this a scheduler worst-case, something to be expected, or something I
> can work around?
>
> Please CC me since vger's majordomo is an impossible chunk of shit.
>
> -jwb
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

