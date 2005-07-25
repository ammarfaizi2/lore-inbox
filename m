Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVGYNJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVGYNJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 09:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGYNJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 09:09:15 -0400
Received: from pop.gmx.de ([213.165.64.20]:41441 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261159AbVGYNJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 09:09:13 -0400
X-Authenticated: #28678167
Message-ID: <42E4E4B0.6050904@gmx.net>
Date: Mon, 25 Jul 2005 15:10:08 +0200
From: Andreas Baer <lnx1@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local>
In-Reply-To: <20050725051236.GS8907@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for reply.
Sorry, but I've never done any vmstat operation before so next time  I'll send 
the output in the first mail :)

Willy Tarreau wrote:
> Hi,
> 
> On Mon, Jul 25, 2005 at 02:50:05AM +0200, Andreas Baer wrote:
> 
>>Hi everyone,
>>
>>First I want to say sorry for this BIG post, but it seems that I have no 
>>other chance. :)
> 
> 
> It's not big enough, you did not explain us what your database does nor
> how it does work, what type of resource it consumes most, any vmstat
> capture during operation. There are so many possibilities here :
>   - poor optimisation from gcc => CPU bound

I doubt it, because I've run the same binaries (no recompilation) on both 
systems. (you will see vmstat output below)

>   - many random disk accesses => I/O bound, but changing/tuning the I/O
>     scheduler could help

Indeed, the data is stored in random access files.

>   - intensive disk reads => perhaps your windows and linux partitions are
>     on the same disk and windows is the first one, then you have 50 MB/s
>     on the windows one and 25 MB/s on the linux one ?

I have (S-ATA-150 Disk 80GB)

          /dev/sda:  50.59 MB/sec
          /dev/sda1: 50.62 MB/sec    (Windows FAT32)
          /dev/sda6: 41.63 MB/sec    (Linux ReiserFS)

On the Notebook I have at most an ATA-100 Disk with 80GB and it shows the same 
declension.

Here I have

          /dev/hda:  26.91 MB/sec
          /dev/hda1: 26.90 MB/sec    (Windows FAT32)
          /dev/hda7: 17.89 MB/sec    (Linux EXT3)

Could you give me a reason how this is possible?

>   - task scheduling : if your application is multi-process/multi-thread,
>     it is possible that you hit some corner cases. 

There are only a maximum of 2 Threads started and they have more background 
activity or do nothing, should have nothing to do with this problem.

> So please start "vmstat 1" before your 3min request, and stop it at the
> end, so that it covers all the work. It will tell us many more useful
> information.

all output below...

> Regards,
> Willy
> 
> 
>>I have a Asus P4C800-DX with a P4 2,4 GHz 512 KB L2 Cache "Northwood" 
>>Processor (lowest Processor that supports HyperThreading) and 1GB DDR400 
>>RAM. I'm also running S-ATA disks with about 50 MB/s (just to show that 
>>it shouldn't be due to hard disk speed). Everything was bought back in 
>>2003 and I recently upgraded to the lastest BIOS Version. I've installed 
>>Gentoo Linux and WinXP with dual-boot on this system.
>>
>>Now to my problem:
>>
>>I'm currently developing a little database in C++ (runs currently under 
>>Windows and Linux) that internally builds up an R-Tree and does a lot of 
>>equality tests and other time consuming checks. For perfomance issue I 
>>ran a test with 200000 entries and it took me about 3 minutes to 
>>complete under Gentoo Linux.
>>
>>So I ran the same test in Windows on the same platform and it took about 
>>30(!) seconds. I was a little bit surprised about this result so I 
>>started to run several tests on different machines like an Athlon XP 
>>2000+ platform and on my P4 3GHz "Prescott" Notebook and they all showed 
>>something about 30 seconds or below. Then I began to search for errors 
>>or any misconfiguration in Gentoo, in my code and also for people that 
>>have made equal experiences with that hardware configuration on the 
>>internet. I thought I have a problem with a broken gcc or libraries like 
>>glibc or libstdc++ and so I recompiled my whole system with the stable 
>>gcc 3.3.5 release, but that didn't make any changes. I also tried an 
>>Ubuntu and a Suse LiveCD to verify that it has nothing to do with Gentoo 
>>and my kernel version and they had the same problem and ran the test in 
>>about 3 min.
>>
>>Currently I'm at a loss what to do. I'm beginning to think that this is 
>>maybe a kernel problem because I have no problems under Windows and it 
>>doesn't matter whether I change any software or any configuration in 
>>Gentoo. I'm currently running kernel-2.6.12, but the Livecd's had other 
>>kernels.
>>
>>HyperThreading(HT) is also not the reason for the loss of power, because 
>>I tried to disable it and to create a uniprocessor kernel, but that 
>>didn't solve the problem.
>>
>>If you need some output of my configuration/log files or anything like 
>>that, just mail me.
>>
>>Is it possible that the kernel has a lack of support for P4 with 
>>"Northwood" core? Maybe only this one? Could I solve the problem if I 
>>change the processor to a "Prescott" core? Perhaps someone could provide 
>>any information if this would make any sense or not.
>>
>>Thanks in advance for anything that could help.
>>
>>...sorry for bad english :)
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 

Vmstat for Notebook P4 3.0 GHz 512 MB RAM:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  1  0      0 179620  14812 228832    0    0    33    21  557   184  3  1 95  1
  2  0      0 178828  14812 228832    0    0     0     0 1295   819  6  2 92  0
  1  0      0 175948  14812 228832    0    0     0     0 1090   111 37 17 46  0
  1  0      0 175948  14812 228832    0    0     0     0 1064   101 23 28 50  0
  1  0      0 175948  14812 228832    0    0     0     0 1066   100 20 31 49  0
  1  0      0 175980  14820 228824    0    0     0    48 1066   119 20 30 50  0
  1  0      0 175980  14820 228824    0    0     0     0 1067    86 19 31 50  0
  1  0      0 175988  14820 228824    0    0     0     0 1064   115 20 30 50  0
  1  0      0 175988  14820 228824    0    0     0     0 1065   107 20 31 50  0
  1  0      0 176020  14820 228824    0    0     0     0 1063   111 20 30 50  0
  1  0      0 176020  14820 228824    0    0     0     0 1066   104 21 30 49  0
  1  0      0 176276  14828 228816    0    0     0    12 1065   140 21 30 50  0
  1  0      0 176276  14828 228816    0    0     0     0 1065    93 19 31 50  0
  1  0      0 176052  14828 228816    0    0     0     0 1063   119 23 28 50  0
  1  0      0 175796  14828 228816    0    0     0     0 1067   101 23 27 50  0
  1  0      0 175860  14828 228816    0    0     0     0 1064   117 22 29 50  0
  1  0      0 175860  14828 228816    0    0     0     0 1066   103 22 29 49  0
  1  0      0 175860  14836 228808    0    0     0    16 1065   119 21 30 50  0
  1  0      0 175860  14836 228808    0    0     0     0 1063   104 21 29 50  0
  1  0      0 175860  14836 228808    0    0     0     0 1063   111 19 31 50  0
  1  0      0 176180  14836 228808    0    0     0     0 1073   124 22 30 49  0
  1  0      0 176052  14836 228808    0    0     0     4 1113   183 20 32 49  0
  0  0      0 180052  14844 228800    0    0     0    12 1269  1083 17 20 64  0
  0  0      0 180164  14844 228800    0    0     0     0 1255  1311  2  2 96  0

Vmstat for Desktop P4 2.4 GHz 1024 MB RAM:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  1  0      0 594688  39340 292228    0    0    52    29  581   484  5  2 92  2
  1  0      0 591208  39340 292228    0    0     0    68 1116   545 15 14 71  0
  1  0      0 591208  39340 292228    0    0     0     0 1090   112  3 48 50  0
  1  0      0 591208  39340 292228    0    0     0     0 1089   124  2 48 50  0
  1  0      0 591208  39340 292228    0    0     0     0 1089   114  3 48 50  0
  1  0      0 591208  39340 292228    0    0     0     0 1090   120  1 49 50  0
  1  0      0 591208  39340 292228    0    0     0    24 1094   138  2 49 50  0
  1  0      0 591256  39340 292228    0    0     0     0 1090   118  2 48 50  0
  1  0      0 591256  39340 292228    0    0     0     0 1092   125  2 48 50  0
  1  0      0 591256  39340 292228    0    0     0     0 1089   112  2 48 50  0
  1  0      0 591256  39340 292228    0    0     0     0 1089   118  2 49 50  0
  1  0      0 591304  39340 292228    0    0     0    16 1094   129  2 48 50  0
  1  0      0 591304  39340 292228    0    0     0     0 1090   123  2 49 50  0
  1  0      0 591304  39340 292228    0    0     0     0 1089   127  3 48 50  0
  1  0      0 591304  39340 292228    0    0     0     0 1090   106  2 48 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1089   110  2 49 49  0
  1  0      0 591320  39340 292228    0    0     0    16 1093   124  3 48 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1090   122  2 49 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1092   133  3 47 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1089   118  2 49 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1090   128  2 48 50  0
  1  0      0 591320  39340 292228    0    0     0    16 1094   139  3 48 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1089   125  2 49 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1091   126  3 48 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1089   118  2 48 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1089   123  2 49 50  0
  1  0      0 591320  39340 292228    0    0     0    16 1094   125  3 48 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1089   122  2 49 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1091   129  3 48 49  0
  1  0      0 591320  39340 292228    0    0     0     0 1091   118  3 48 50  0
  1  0      0 591320  39340 292228    0    0     0     0 1090   120  2 49 50  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  2  0      0 591304  39340 292228    0    0     0    16 1092   134  3 48 50  0
  1  0      0 591304  39340 292228    0    0     0     0 1090   116  2 48 49  0
  1  0      0 591304  39340 292228    0    0     0     0 1089   125  2 48 49  0
  1  0      0 591304  39340 292228    0    0     0     0 1090   112  3 48 49  0
  1  0      0 591304  39340 292228    0    0     0     0 1091   114  3 48 50  0
  1  0      0 591304  39340 292228    0    0     0    16 1092   132  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   131  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1092   132  3 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   111  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   117  3 48 49  0
  1  0      0 591288  39340 292228    0    0     0    16 1093   130  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   129  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   122  3 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   113  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   109  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0    16 1092   120  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   117  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   126  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   122  3 48 50  0
  2  1      0 591288  39340 292228    0    0     0     8 1091   124  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     8 1093   121  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   126  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   123  2 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   114  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0    12 1092   135  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     4 1092   121  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   127  2 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   126  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   112  3 48 49  0
  1  0      0 591288  39340 292228    0    0     0    12 1092   136  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     4 1090   124  2 49 49  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  2  0      0 591288  39340 292228    0    0     0     0 1091   129  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   124  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   111  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0    12 1093   121  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     4 1090   113  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   131  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1092   134  1 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   120  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0    12 1092   129  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     4 1091   118  3 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   124  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   125  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   130  4 47 50  0
  1  0      0 591288  39340 292228    0    0     0    20 1093   130  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     4 1091   118  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   134  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1092   127  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   126  3 49 49  0
  1  0      0 591288  39340 292228    0    0     0    20 1093   134  3 47 49  0
  1  0      0 591288  39340 292228    0    0     0     4 1090   128  4 47 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   126  3 47 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   121  2 50 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   112  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0    16 1096   125  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   109  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   118  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1093   125  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   112  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0    12 1093   126  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     4 1093   114  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   120  2 49 50  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  2  0      0 591288  39340 292228    0    0     0     0 1090   119  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   108  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0    12 1093   117  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     4 1091   111  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   118  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1092   122  3 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   109  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0    16 1095   125  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   110  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   120  3 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   117  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   110  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0    16 1095   121  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1092   109  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   120  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1093   123  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   110  2 48 49  0
  2  0      0 591288  39340 292228    0    0     0    16 1095   128  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   117  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   116  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   124  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   108  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0    16 1095   131  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   112  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   120  3 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1093   129  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   114  3 48 50  0
  1  0      0 591288  39340 292228    0    0     0    20 1095   134  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1092   114  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   116  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   119  2 49 50  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  2  0      0 591288  39340 292228    0    0     0     0 1091   114  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0    16 1095   128  2 49 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1089   112  2 48 49  0
  1  0      0 591288  39340 292228    0    0     0     0 1090   116  2 49 50  0
  1  0      0 591288  39340 292228    0    0     0     0 1091   121  3 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   124  8 43 49  0
  1  0      0 590792  39340 292228    0    0     0    16 1095   137  4 47 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   117  3 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   122  3 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1091   117  3 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   108  2 48 50  0
  1  0      0 590792  39340 292228    0    0     0    16 1094   122  3 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   115  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   132  2 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1091   124  3 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   118  2 48 49  0
  1  0      0 590792  39340 292228    0    0     0    24 1094   124  2 49 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   113  3 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   116  2 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   123  2 49 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   116  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0    16 1113   153  3 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1275   349  3 49 49  0
  1  0      0 590776  39340 292228    0    0     0     0 1089   123  2 49 50  0
  1  0      0 590776  39340 292228    0    0     0     0 1092   117  2 49 50  0
  1  0      0 590776  39340 292228    0    0     0     0 1089   123  3 48 49  0
  1  0      0 590776  39340 292228    0    0     0    16 1093   139  3 48 50  0
  1  0      0 590776  39340 292228    0    0     0     0 1090   113  2 49 50  0
  1  0      0 590776  39340 292228    0    0     0     0 1090   121  2 49 49  0
  1  0      0 590776  39340 292228    0    0     0     0 1089   110  1 49 50  0
  1  0      0 590776  39340 292228    0    0     0     0 1090   108  3 48 50  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  2  0      0 590792  39340 292228    0    0     0    16 1093   130  3 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   118  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1091   131  1 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1091   118  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   112  3 48 50  0
  1  0      0 590792  39340 292228    0    0     0    16 1094   130  2 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   116  3 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   135  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1091   114  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   109  2 48 50  0
  1  0      0 590792  39340 292228    0    0     0    16 1093   124  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   113  3 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   133  2 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1092   126  2 49 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   120  3 48 50  0
  1  0      0 590792  39340 292228    0    0     0    16 1093   124  2 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   113  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   124  3 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   111  3 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   113  2 49 49  0
  1  0      0 590792  39340 292228    0    0     0    16 1094   135  2 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   121  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   127  2 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1092   116  2 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   112  3 48 49  0
  2  0      0 590792  39340 292228    0    0     0    16 1093   137  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   121  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   137  2 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   112  3 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   110  2 48 50  0
  1  0      0 590792  39340 292228    0    0     0    16 1094   126  2 48 49  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  2  0      0 590792  39340 292228    0    0     0     0 1089   117  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   133  2 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1091   126  2 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   116  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0    16 1095   134  2 49 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   122  2 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   131  3 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   120  2 49 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   118  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0    16 1093   128  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1091   116  2 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   136  2 48 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1091   117  2 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   123  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0    16 1093   132  2 48 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   122  2 49 49  0
  1  0      0 590792  39340 292228    0    0     0     0 1090   128  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   112  2 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   108  2 49 50  0
  2  0      0 590792  39340 292228    0    0     0    16 1094   132  1 49 50  0
  1  0      0 590792  39340 292228    0    0     0     0 1089   121  3 48 50  0
  1  0      0 590668  39340 292228    0    0     0     0 1090   139  2 49 50  0
  1  0      0 590668  39340 292228    0    0     0     0 1092   118  3 48 49  0
  1  0      0 590544  39340 292228    0    0     0     0 1089   112  3 48 50  0
  1  0      0 591040  39340 292228    0    0     0    16 1093   155  3 47 49  0
  0  0      0 595092  39340 292228    0    0     0     0 1102   497  3 35 62  0

