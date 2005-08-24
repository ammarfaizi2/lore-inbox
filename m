Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVHXKTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVHXKTP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 06:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVHXKTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 06:19:15 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:31279 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750758AbVHXKTP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 06:19:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PtWnB2LwH6YyjWAsCsrRdJbhT4Neep8XZ6c6jjExMUByb180ARHd5WQnTan8VzlAMKUw9OteSaCSD52vEM4uDgZxQVnYmCQOu94nj9xainJ1TdrsXTFtcFTRUB6zaBPyHTX2224zA6UqIFHHCwp8rGe+/1cuAHWRVjnG7KtHHBM=
Message-ID: <5a2cf1f60508240319256ba61@mail.gmail.com>
Date: Wed, 24 Aug 2005 12:19:14 +0200
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: cache regresions with 2.6.1x ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050822215356.5f6a30fd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a2cf1f60508220421d0914f8@mail.gmail.com>
	 <20050822215356.5f6a30fd.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/05, Andrew Morton <akpm@osdl.org> wrote:
> jerome lacoste <jerome.lacoste@gmail.com> wrote:
> >
> > I am on a Dell Inspiron 8100 laptop with 512 M and 1G disk cache. I
> >  usually have at least 4 big applications running simultaneously: a
> >  Java IDE, firefox, firefox and X. All that under the Gnome desktop.
> >
> >  I've sometimes seen periods where my laptop goes kind of nuts. While
> >  the cpu is still at 0%, the workload goes to 100% (as shown in the
> >  gnome process monitor) (I haven't checked in other means, e.g. top or
> >  /proc info as my machine is unusable).
> >
> >  But with my latest upgrade to 2.6.12 from 2.6.10, the hanging happens
> >  much more often. It lasts for over 30 seconds.
> >
> >  Could this hanging be related to swapping?
> >  Are there any VM regression lately that would make a kernel less
> >  appropriate for desktop use?
> >  How can I investigate that further?
> 
> 10-20 lines of `vmstat 1' output while it's happening would help.

Here it goes. Maybe just some bad swapping?

jerome@expresso> vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  7 588164   7424  18612 106908   13    7    34    44   10    12  8  2 85  5
 2  4 587996   6152  18624 108092  404  664   540  2892 1201  2631 70  9  0 21
 0 12 588276   5160  18620 109188  664 1244   860  1244 1195   615 46  5  0 50
 0 13 588140   4912  18628 109188  216    0   216     8 1156   245  0  0  0 100
 0 17 588536   4892  18628 109972  132  576   132   576 1172   353 32  4  0 64
 0 16 589096   5016  18628 110192    0  608     4   628 1169   247  7  2  0 91
 0 16 589780   5636  18632 110136    0  716     0   808 1181   261  1  0  0 99
 0 11 590272   5388  18532 111548  168  820   176   820 1192   457 52  5  0 43
 0 11 590260   5140  18540 111584    0  320    36   332 1159   743 12  2  0 86
 4 10 590232   9756  17456 109304  100  240  1064   420 1333  2297 47 16  0 38
 1  6 590240  17440  16908 105680   72   80   460  2108 1266  2052 65 24  0 11
 1  5 590004  13596  16988 109060  580    0  3380     0 1356  1743 13  8  0 79
 0  6 589776  10372  17032 110936  968    0  1800  2924 1172  1057 19  4  0 77
 0  7 589368   6544  17104 112468 1652    0  2496   100 1202  1109  8  4  0 88
 1  4 589212   5676  17132 112232  488    0  1204     0 1160  1092  6  3  0 91
 0  6 589032  12724  16772 107000  588    0   844     0 1339  1444 36 12  0 52
 0  6 588664   8012  16792 108440 1448    0  2068     0 1637  1222 12  5  0 83
 0  7 588252   6464  16460 108900 1840    4  2036   236 1629  1156  8 13  0 79
 6  4 588040  13180  14696 107352  460  124   476  4608 1554  1644 70  9  0 21
 1  3 587792  11812  14412 108348  848    0  1096    32 1404  2733 27  8  0 65
 0  5 587464   9332  14444 109596 1380    0  1572     0 1159  1030 21  3  0 76
 0  6 586976   8836  14244 110488 1556   24  1960   684 1210  1562 16  7  0 77
 0  4 586684   6728  14288 111536  748    0  1068   344 1175  1216 12  3  0 85
 0  9 586676   6232  14308 111908   96    0   336    48 1185  1544  7  2  0 91
 0  6 586500  10860  13384 112364  792    0  1108  4516 1163  1588 24  8  0 68
 0  5 586200   9024  13440 113272 1392    0  1528    12 1176  1019  8  4  0 88
 1  6 585848   5596  13456 114888 1968    0  2044    52 1171  1118 11  5  0 84
 0  6 585384   5968  12000 115972 1452    0  1484     0 1156   952 13  5  0 82
 0  6 584984   5224  11880 115800 1916    0  2276     0 1167   780  4  3  0 93
 0  6 584744   5148   9396 118836 1104    0  3352     0 1159   988 12  8  0 80
 0  6 584560   5996   8664 119776  960    4  1492     4 1148   893 17  7  0 76
 0  7 584204   5396   8536 120912 1048    0  1716     0 1186  1118 12  3  0 85
 0  5 583964   5752   8036 121468  772   40   964    40 1154  5811 19 12  0 69
 0  5 583608   5272   7532 121268 1500    0  1552   300 1156   784  3  2  0 95
 0  5 583496   5840   7344 120712  396    0   948  8892 1175  1137 16  6  0 78
 0  8 583448   5004   6016 124748  172    0  2616     4 1154  1027  9  6  0 85
 0  9 583396   4880   4156 130880   96   20  4604   812 1176  1077  4  5  0 91
 0  9 582780   4896   3836 130808 2012    0  2076     0 1184  1103  1  0  0 99
 0 10 582520   5020   3792 130328  992    0  1120     4 1156   783  3  1  0 96
 0 10 581924   4896   3308 130360 1528    0  1712  1756 1183   762  6  2  0 92
 0  9 581916   5196   3256 130632   96   44   364   112 1159  1119 11  3  0 86
 0 13 581704   4896   3264 130796  820    0  1672  3128 1171  1143  4  2  0 94
 0 11 581704   6384   3088 129520    0    0     4    56 1159   706  4  6  0 90
 0 12 581628   5640   3128 130148  328    0   716   612 1140   786  1  1  0 98
 0  7 581492   4880   2336 135580  564    0  3684    92 1176  1788 16  7  0 77
 
> If lots of system time is being consumed then the next step is to generate
> a kernel profile - Documentation/basic_profiling.txt

System time below 10% according to top and what I see in this log.

Jerome
