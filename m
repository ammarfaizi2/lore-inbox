Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131095AbRAWTDm>; Tue, 23 Jan 2001 14:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRAWTDM>; Tue, 23 Jan 2001 14:03:12 -0500
Received: from denise.shiny.it ([194.20.232.1]:34055 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S129710AbRAWTDE>;
	Tue, 23 Jan 2001 14:03:04 -0500
Message-ID: <3A6E2A49.A3905681@denise.shiny.it>
Date: Tue, 23 Jan 2001 20:05:13 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.18 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: blk-13B
In-Reply-To: <3A608538.4D9CF077@denise.shiny.it> <20010114014555.A2701@suse.de> <3A62413F.1202FF08@denise.shiny.it> <20010114191537.C8306@suse.de> <3A6260BF.531297CE@denise.shiny.it> <20010115213343.G5517@suse.de> <3A65038E.8CAAED48@denise.shiny.it> <20010117030118.E30464@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You could try instrumenting the paths in bdflush and kswapd, to see
> what really happens when they run crazy. This would help a lot.

:-( My knowledge of the kernel is too poor and I have too few time to
study it.

I tried the suggestion of A.Arcangeli about size interval. The test is
always the same large files cp. At the beginning it swapped out ~3MB and
during that time (~5 sec.) the system was slow and sluggish. Then it
worked fine for about 10 minutes.
At a certain point it started swapping out without any apparent reason
(I was just looking at the screen) and the system was hardly usable, then
the swapping stopped and everything but disk writes remained frozen for
about 20 sec. Now it's all ok and I have about 20MB of the swap.
I don't think the change in ll_rw_blk caused the swapping, it simply
didn't see it before (I use 2.2.18 most of the time).




   procs                    memory    swap          io     system         cpu
 r  b  w   swpd  free  buff  cache  si  so    bi    bo   in    cs  us  sy  id
 3  0  0   3512  1048  1776 126288   0   0  6682   768  162   981  12  25  63
 3  0  0   3512  1048  1800 126264   0   0  6526  3200  161  1281  23  28  49
 3  0  0   3512  1048  1816 126248   0   0  7373  3776  198  1149  23  21  55
 2  0  0   3512  1048  1816 126248   0   0  7172  3584  206   799   8  26  66
 1  0  0   3512  1048  1820 126256   0   0  7052  3520  153   917  11  29  60
 1  0  1   3512  1048  1820 126256   0   0  7296  1218  177  3136   3  24  73
 2  1  1   3512  1048  1840 126252   0  68  5654   145  101  3316   1  44  55
 1  1  2   3504  1048  1848 126336   0   0  4621    34   69  2505   1  63  36
 4  0  2   3600  1428  1856 128476   0 120  2832    54  191  1747  13  75  12
 2  0  2   3920  1048  1740 129288 200 288  2876   202  135  3262   8  77  15
 1  0  2   3980  1048  1548 129564   0   0  1615    10  143  4388   4  92   4
 3  1  2   4832  1048  1264 130652  64 776  2013   276  268  3048   2  91   8
 3  1  2   4832  1048  1264 130652  64 776  2013   276  268  3048   2  91   8
 0  2  2   6560  1048   956 132696   0 1340 1783   567  150  1973   2  86  12
 5  0  2   8288  1052   968 134400 632 2288 1426   898  242  1452   2  38  60
 0  1  1  10912  1048   984 137004 388 1504 2997   546  127  2510   4  48  48
 6  1  1  10924  1048  1008 136924 192 1088 2368   656   57  1737   4  59  37
 1  0  2  11424  1096   968 137504 104 504  2066   302   42  1815   3  81  16
 0  1  1  14160  1048   888 140372  24 2488 2649  1146   38  1770   2  57  41
 1  2  1  16556  1048   908 142656 700 1512 2512   750   52  1787   0  53  47
 1  0  1  18228  1048   852 144260 348 2260 2657   905   59  2465  10  49  42
 0  1  2  19704  1048   704 145808   0 1772 2827   953   39  1977   2  55  43
 0  2  2  20592  1048   716 146612 304 1076 3087   594   51  2177   1  58  41
 6  1  2  21532  1048   712 147512   0 940  1615   366   31  1961   3  83  14
 2  0  2  23056  1048   716 148972 264 688  3334   316   46  2406   3  66  31
 4  0  2  24676  1048   732 150488   0 2096 2178   837   43  1357   1  52  47
 0  1  1  27116  1048   736 152832 128 1972 2544   869   44  1812   2  43  55
 5  0  2  27768  1048   744 153372  52 1308 2668   777   43  1772   2  61  37
 0  2  1  28360  1048   752 153900 332 564  2311   955   49  2081   1  68  31
<frozen>
 1  7  2  28356  1048   752 153708 3936  0  2175 29091  494 27348   0   1  99
 1  0  2  28356  1048   792 153656 172   0  7166     0  144   838   4  17  80
 1  0  2  28356  1048   836 153592   0   0  7453     0   77   668   0  18  82
 0  1  2  28356  1048   800 153036   0   0  7196     0   63  3981   0  24  76

I wanted to fiddle with /proc/sys/vm/freepages but it's not writable in 2.4

Bye.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
