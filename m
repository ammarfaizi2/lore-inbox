Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290648AbSARKH1>; Fri, 18 Jan 2002 05:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290649AbSARKHS>; Fri, 18 Jan 2002 05:07:18 -0500
Received: from mustard.heime.net ([194.234.65.222]:28647 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S290648AbSARKHD>; Fri, 18 Jan 2002 05:07:03 -0500
Date: Fri, 18 Jan 2002 11:06:45 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Adam Kropelin <akropel1@rochester.rr.com>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] rmap VM 11c
In-Reply-To: <012d01c19fb7$ba1cb680$02c8a8c0@kroptech.com>
Message-ID: <Pine.LNX.4.30.0201181106230.10588-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks a little like my problem...

See http://karlsbakk.net/dev/kernel/vm-fsckup.txt

On Thu, 17 Jan 2002, Adam Kropelin wrote:

> Rik van Riel <riel@conectiva.com.br>:
> > For this release, IO tests are very much welcome ...
>
> Results from a run of my large FTP transfer test on this new release are...
> interesting.
>
> Overall time shows an improvement (6:28), though not enough of one to take the
> lead over 2.4.13-ac7.
>
> More interesting, perhaps, is the vmstat output, which shows this at first:
>
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  0  0      0  47816   2992  84236   0   0    10     0 4462   174   1  33  66
>  1  0  0      0  41704   3004  89320   0   0    10     0 4322   167   0  33  67
>  0  1  0      0  36004   3012  94064   0   0     9   877 4030   163   1  30  69
>  0  1  1      0  33536   3016  96112   0   0     4  1616 1724    62   0  18  82
>  0  1  2      0  31068   3020  98160   0   0     4  2048 1729    52   1  15  83
>  0  1  1      0  28608   3024 100208   0   0     4  2064 1735    56   1  16  82
>  0  1  1      0  26144   3028 102256   0   0     4  2048 1735    50   0  16  84
>  0  1  1      0  23684   3032 104304   0   0     5  2048 1713    45   1  15  84
>  0  1  1      0  21216   3036 106352   0   0     3  2064 1723    52   1  14  85
>  1  0  2      0  18728   3040 108420   0   0     5  2048 1750    59   0  17  82
>  0  1  1      0  16292   3044 110448   0   0     3  2064 1722    60   0  15  84
>  1  0  1      0  13824   3048 112572   0   0     5  2032 1800    61   0  17  83
>  1  0  1      0  11696   3052 114548   0   0     4  2528 1658    47   0  14  86
>  1  0  1      0   9232   3056 116596   0   0     4  2048 1735    51   1  13  86
>  0  1  2      0   6808   3060 118640   0   0     3  1584 1729    84   0  16  84
>
> (i.e., nice steady writeout reminiscent of -ac)
>
> ...but after about 20 seconds, behavior degrades again:
>
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  1  1      0   1500   3124 123268   0   0     0  3788  534    20   0   8  92
>  0  1  1      0   1500   3124 123268   0   0     0     0  107    12   0   0 100
>  0  1  1      0   1500   3124 123268   0   0     0     0  123    10   0   0 100
>  0  1  1      0   1500   3124 123268   0   0     0  3666  123    12   0   2  97
>  0  1  1      0   1500   3124 123268   0   0     1   259  109    12   0   8  92
>  1  0  0      0   1404   3124 123360   0   0     2     0 1078    28   0   7  92
>  1  0  0      0   1404   3136 123444   0   0    11     0 4560   178   0  39  61
>  1  0  0      0   1404   3148 123448   0   0    10     0 4620   175   1  34  64
>  0  0  0      0   1312   3156 123568   0   0    11     0 4276   181   0  36  64
>  0  0  0      0   1404   3168 123492   0   0    10     0 4330   185   1  30  68
>  0  1  1      0   1404   3172 123488   0   0     4  6864 1742    69   0  17  83
>  0  1  1      0   1408   3172 123488   0   0     0     0  111    12   0   0  99
>  0  1  1      0   1408   3172 123488   0   0     0     0  126     8   0   0 100
>  0  1  1      0   1404   3172 123480   0   0     0  7456  518    18   0  10  90
>  0  1  1      0   1404   3172 123480   0   0     0     0  112    10   0   0 100
>  0  1  1      0   1404   3172 123480   0   0     0     0  123     9   0   0 100
>  0  1  1      0   1404   3172 123476   0   0     1  7222  120    16   0   5  95
>  0  1  1      0   1404   3172 123476   0   0     0     0  106     8   0   0 100
>  0  1  1      0   1524   3172 123352   0   0     0  3790  519    18   0   8  92
>  0  1  1      0   1524   3172 123352   0   0     0     0  113     8   0   0 100
>  0  1  1      0   1524   3172 123352   0   0     0     0  125     8   0   0 100
>
> Previous tests showed fluctuating bo values from the start; this is the first
> time I've seen them steady, so something in the patch definitely is showing
> through here.
>
> I've a couple more tests to run, such as combining -rmap11c with cpqarray and
> eepro driver updates from -ac. I'll keep you posted.
>
> --Adam
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

