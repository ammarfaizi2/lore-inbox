Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbRBIByo>; Thu, 8 Feb 2001 20:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129072AbRBIByf>; Thu, 8 Feb 2001 20:54:35 -0500
Received: from yoda.planetinternet.be ([195.95.30.146]:23315 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S129069AbRBIByV>; Thu, 8 Feb 2001 20:54:21 -0500
Date: Fri, 9 Feb 2001 02:54:06 +0100
From: Kurt Roeckx <Q@ping.be>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
Message-ID: <20010209025406.A243@ping.be>
In-Reply-To: <E14QwU4-0004QE-00@the-village.bc.nu> <Pine.LNX.4.21.0102082005400.2378-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <Pine.LNX.4.21.0102082005400.2378-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii

On Thu, Feb 08, 2001 at 08:12:39PM -0200, Rik van Riel wrote:
> On Thu, 8 Feb 2001, Alan Cox wrote:
> 
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> > 
> > 2.4.1-ac7
> > o	Rebalance the 2.4.1 VM				(Rik van Riel)
> > 	| This should make things feel a lot faster especially
> > 	| on small boxes .. feedback to Rik
> 
> I'd really like feedback from people when it comes to this
> change. The change /should/ fix most paging performance bugs
> because it makes kswapd do the right amount of work in order
> to solve the free memory shortage every time it is run.

I just tested ac8.

If I run this test, the system gets really slow.  It takes about
a second between the time I press a key, and the time it appears
on the screen.  The load goes way up.  Everything seems to block.

This is a box with 64 MB or RAM, and 32 MB of swap.  There isn't
much running on the box while doing this, only dnetc.

It starts to get slow from the time the process starts is about
70 MB.  Then you really hear the disk work.  It ended up at about
75 MB, where it got killed by the OOM killer. (For once it killed
the right thing!)

I ran a vmstat 1, while doing this, and have attached the output.

It ran for serval minutes.  The process itself took about 1
minutes of CPU time, and so did kswapd.  It took atleast 5
minutes real time.

I once did just the same with 2.4.0, it took more like 30 minutes
then, and I ended up killing the process myself.


Kurt


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vmstat.out"

 procs                  memory    swap        io    system         cpu
 r b w  swpd  free  buff cache  si  so   bi   bo   in   cs  us  sy  id
 1 0 0 16580  1808  1200 43336   0   0   83    4  130   25  93   2   5
 1 0 0 16704  1804  1200 43460   0   0    0    0  116    4 100   0   0
 1 0 0 16704  1804  1200 43460   0   0    0    0  120    4 100   0   0
 1 0 0 16784  1808  1200 43540   0   0    0    0  102    6  99   1   0
 1 0 0 16904  1808  1200 43660   0   0    0    0  101    7  99   1   0
 1 0 0 16988  1808  1200 43744   0   0    0    0  130   32  99   1   0
 1 0 0 16988  1808  1200 43744   0   0    0    0  136   18 100   0   0
 1 0 0 17152  1808  1200 43908   0   0    0    0  110   14 100   0   0
 1 0 0 17152  1808  1200 43908   0   0    0    3  110   10 100   0   0
 2 0 0 17112  1428  1204 43960   0   0  384    4  142   63  98   2   0
 2 0 0 17268  1428  1204 43016   0   0  130    0  133   46 100   0   0
 2 0 0 17344  1428  1204 41980   0   0  128    0  110   47  97   3   0
 2 0 0 17548  1428  1204 41104   0   0  129    0  116   48  98   2   0
 2 0 0 17604  1428  1204 40056   0   0  128    0  102   45  97   3   0
 2 0 0 17820  1428  1208 39188   0   0  129    0  106   49  97   3   0
 2 0 0 17972  1428  1208 38288   0   0  128    0  108   48  99   1   0
 2 0 0 18136  1428  1208 37352   0   0  129    0  104   46  95   5   0
 2 0 0 18140  1428  1208 36296   0   0  128    0  107   49  98   2   0
 2 0 0 18140  1428  1208 35212   0   0  129    0  108   54  96   4   0
 2 0 0 18140  1428  1208 34108   0   0  128    0  105   44  99   1   0
 2 0 0 18140  1428  1208 33208   0   0    0    0  126   47  96   4   0
 procs                  memory    swap        io    system         cpu
 r b w  swpd  free  buff cache  si  so   bi   bo   in   cs  us  sy  id
 2 0 0 18116  1456  1168 32144   0   0  129    0  127   49  96   4   0
 2 0 0 18116  1368  1100 31236   0   0  128    0  110   46  97   3   0
 2 0 0 18752  1304  1016 30944   0   0  129    1  107   51  97   3   0
 2 0 0 18752  2020   908 29944   0   0  128    0  109   49 100   0   0
 2 0 0 18752  1296   904 29596   0   0  129    0  104   45  95   5   0
 2 0 0 18752  1300   880 28788   0 248  128   62  106   42  97   3   0
 2 1 0 18752  1236   880 27864   0 1896   73  531  162   52  95   5   0
 2 0 0 18752   948   880 27056   0   0  184    0  128   43  96   4   0
 2 0 0 18752   948   856 26008   0   0    0    0  105   41  98   2   0
 2 0 0 19688   980   840 26024   0 1360  129  340  133   50  97   3   0
 2 0 0 19688   948   828 25028   0 624  128  156  114   46  98   2   0
 2 0 0 20628   948   812 25008   0 192  129   48  108   45  95   5   0
 2 0 0 23420   948   784 26956   0 1140  128  285  125   49  97   3   0
 2 0 0 23464   948   676 26604   0   0  130    0  105   49  99   1   0
 2 0 0 23560   948   564 25780   0 820  128  214  132   43  95   5   0
 2 1 0 23840   948   560 25036   0 244   73   61  109   47  96   4   0
 2 0 0 23940   948   556 24184   0 1768   56  445  152   61  94   6   0
 2 0 0 23928   948   540 23144   0   0  143    0  111   55  98   2   0
 2 0 0 24168   948   532 22352   0 164  129   41  106   48  96   4   0
 2 0 0 29044   948   504 26240   0 120  128   30  105   42  97   3   0
 2 0 0 31476   948   412 28256   0 316  129   79  126   48  96   4   0
 procs                  memory    swap        io    system         cpu
 r b w  swpd  free  buff cache  si  so   bi   bo   in   cs  us  sy  id
 3 0 0 31476   948   416 27300   0 1580  193  413  269   68  97   3   0
 2 0 0 32580   948   416 27404   0   0   41    0  214  183  98   2   0
 2 0 0 33256   952   344 27208   0 2624  129  661  224   62  95   5   0
 2 0 0 33256   948   344 26176   0   0  128    0  107   46  99   1   0
 2 1 0 33256   948   320 25064 216 360  183   90  156   62  98   2   0
 2 0 0 33256   952   320 24012   0 1348  128  343  217   68  92   8   0
 2 1 0 33256   952   324 22760 156 4192  168 1052  232   80  97   3   0
 2 0 0 33244  1104   324 21676  60   0  143    1  113   54  98   2   0
 2 0 0 33244   948   324 20792   0   0  129    0  112   45  99   1   0
 2 0 0 33256   948   324 19744   0   0  128    0  108   47  98   2   0
 2 0 0 33256   948   264 18792   0 956  129  258  142   51  95   5   0
 1 3 0 33256   948   216 16628 1380 3540  936  892  640  443  97   3   0
 2 0 0 33256   948   204 16012 908 596  292  150  312  124  97   3   0
 2 2 0 33256   948   212 15252 812 3084  585  778  783  230  97   3   0
 2 0 0 33256   948   196 14180 888 148  222   37  229   79  92   8   0
 2 0 0 33256   948   176 13384 196  84  177   27  166   69  95   5   0
 2 0 0 33244   952   140 12780 324 444   81  111  231   47  96   4   0
 1 1 0 33240   948   120 12168 820 120  593   30  260   97  91   9   0
 1 1 0 33252   948   112 12272 656 596  317  149  338   88  94   6   0
 1 1 0 33156   948   108 11588 1616  24  444    6  273  114  88  12   0
 1 2 0 33008   948   104 11504 1104 908  742  231  511  139  97   3   0
 procs                  memory    swap        io    system         cpu
 r b w  swpd  free  buff cache  si  so   bi   bo   in   cs  us  sy  id
 0 3 0 33256   948   108 11684  96 840  200  215  372   64  69   3  29
 2 1 0 33252   948   112 11536 1240  76  646   19  271  128  62  11  27
 2 1 0 33192   948   116 11328 1140 424  661  115  350  163  95   5   0
 3 0 0 33220   948   108 10940 1040 104  486   26  249  104  95   5   0
 2 2 1 33212   948   104 10304 1192 888 1055  222  483  167  92   8   0
 0 5 2 33256   960   128 10144 776 984 1034  249  532  309  15   5  80
 1 3 2 33092   948   172  9256 25272 5204 13656 1353 5175 3290  75   7  18
 1 5 0 33160   948   188  8988 9124 1848 5505  481 2059 1207  73   8  19
 1 4 0 33256   948    92  9244 27840 1348 12610  366 3909 2472  63  10  27
 0 4 0 33244   952   100  9184 3680 1208 2197  309  880  548  38   6  56
 1 2 0 33228   948   100  9032 4000   0 2305    0  530  288  87  13   0
 2 0 0 33244   948    92  8668 5596   0 1710    0  519  308  82  18   0
 2 1 0 33240   948    84  8196 21760 780 9027  206 2871 2039  74  16   9
 1 2 0 33256   956   100  8036 8924 768 4927  195 1508  881  48  13  39
 1 4 0 33204   948   120  7080 72404 4228 36881 1125 10094 7076  73  16  12
 1 1 2 33256   980   120  7248 668 1148  359  304  556  182  55   8  37
 0 1 2 33256   948    96  7272 5924   0 2162    0  444  355  21  79   0
 3 0 0 33252   948   120  7140 9884   0 4819    0  971  749  69  26   5
 0 1 2 33256   948   112  7016 5444   0 1933    0  434  335  25  75   0
 1 1 1 33256   952   112  6928 6428   0 2756    0  576  430  16  84   0
 0 2 2 33224   952   120  6552 23472 1168 9974  319 2949 2222  56  28  16
 procs                  memory    swap        io    system         cpu
 r b w  swpd  free  buff cache  si  so   bi   bo   in   cs  us  sy  id
 1 1 1 33236   948    80  6460 5148   0 1783    0  451  441  75  25   0
 0 2 1 33252   948    84  6300 8000 636 2663  164  833  596  61  19  20
 0 1 2 33256   948    84  6220 7644   0 2763    0  546  457  41  59   0
 1 1 1 33256   948    92  6124 7268   0 2660    0  576  447  19  81   0
 1 1 1 33256   948    80  6024 4584   0 1310    0  330  226  27  73   0
 1 3 1 33252   952    80  5424 109560 6484 60432 1726 13842 10005  50  31  19
 1 2 1 33256   948    84  5296 4120 124 1710   33  385  305  54  46   0
 0 1 1 33244   948    84  5076 5612 188 2583   52  614  418  59  33   8
 1 2 0 33256   948    76  4812 5952 120 1922   35  486  363  73  25   1
 1 3 1 33256   948    80  4464 95892 4760 65812 1311 13520 8549  44  32  24
 0 5 1 33256   948    84  4328 16700 860 9344  223 2114 1367  43  40  17
 1 4 0 11040 46048   240  9420 26120 1968 15365  516 4394 3664  59  23  18
 2 0 0 11040 45092   336 10020 260   0  482    6  351  315  95   5   0
 2 0 1 11040 44880   340 10168 148   0   41    0  308   43  99   1   0
 1 0 0 11040 44880   340 10168   0   0    0    0  110    6 100   0   0
 1 0 0 11040 44880   340 10168   0   0    0    0  100    4  99   1   0
 1 0 0 11040 44824   344 10200  12   0   22    0  110   24  98   2   0
 1 0 0 11040 44660   344 10344   0   0  139    0  120   24  88   0  12
 1 0 0 11040 44672   344 10340   0   0    0    0  102    8 100   0   0
 1 0 0 11040 44672   344 10340   0   0    0    0  105    6  99   1   0

--zhXaljGHf11kAtnf--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
