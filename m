Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130606AbQKNT0r>; Tue, 14 Nov 2000 14:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131056AbQKNT0h>; Tue, 14 Nov 2000 14:26:37 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:22113 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130361AbQKNT0c>; Tue, 14 Nov 2000 14:26:32 -0500
From: "LA Walsh" <law@sgi.com>
To: "Mike Dresser" <mdresser@windsormachine.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: IDE0 /dev/hda performance hit in 2217 on my HW
Date: Tue, 14 Nov 2000 10:55:07 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHIEJHCJAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3A1149CD.A2A1E4F4@windsormachine.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to hdparm, dma was already on.  It was also suggested I try
setting
32-bit mode and multcount (which I had tried before and not noticed much
difference).
Here's the current settings and results.  Note that the timings still don't
make
alot of sense when comparing them to the vmstat numbers.  All transfers were
256M (bs=256k, count=1k).

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3278/240/63, sectors = 49577472, start = 0
--------
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0  0  0   1004   3028 436452  11372   0   1  1331    18  338   757   3  17
80
 0  0  0   1004   3020 436456  11372   0   0     0     1  103   166   0   1
99
/dev/hda
 1  0  0   1004   2932 436464  11420   0   0     2     1  103   166   0   1
99
 1  0  0   1004   2276 432752  11488   0   0 13751     1  319   594   0  12
88
 0  2  0   1004   2704 428192  11456   0   0 11751     2  286   529   0  14
86
 1  0  0   1004   2764 423784  11456   0   0 12685     4  303   557   0  13
87
 1  0  0   1004   3124 418472  11456   0   0 14144     0  323   597   0  18
82
1024+0 records in
1024+0 records out
0.01user 2.60system 0:20.13elapsed 12%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (105major+76minor)pagefaults 0swaps
/dev/hda1
 3  0  0   1004   2772 414760  11456   0   0 11699     1  285   530   0  11
89
 0  1  0   1004   2828 411688  11328   0   0  9037     0  242   439   0  11
89
 1  0  0   1004   2528 411016  11296   0   0  2854     0  146   253   0   2
98
 1  0  0   1004   2208 409680  10840   0   0 11366     0  279   511   0  13
87
 2  0  0   1004   2344 409584  10808   0   0 13542     0  313   588   0  17
83
1024+0 records in
1024+0 records out
0.01user 2.55system 0:26.65elapsed 9%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (104major+76minor)pagefaults 0swaps
/dev/hda3
 2  0  0   1004   2560 409160  11024   0   0 12850     1  308   568   0  16
84
 0  1  0   1004   2832 408904  11024   0   0  8346     1  232   424   0  11
89
 1  0  0   1004   2560 409160  11024   0   0 13568     0  313   583   0  10
90
 2  0  0   1004   2440 409288  11024   0   0 13952     0  320   597   0  22
78
1024+0 records in
1024+0 records out
0.00user 2.81system 0:21.34elapsed 13%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (105major+76minor)pagefaults 0swaps
/dev/hda4
 1  0  0   1004   2308 410064  11132   0   0  8524     1  275   508   0  12
88
 2  0  0   1004   2096 412124  11124   0   0  2317     1  246   454   0  10
90
 1  0  0   1004   2684 413788  11124   0   0  2406     0  252   456   0   9
91
 2  0  0   1004   2564 416376  11096   0   0  2496     0  257   476   0  10
90
 1  0  1   1004   3104 418168  11096   0   0  2470     0  255   464   0   8
92
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 1  0  0   1004   2884 420344  11096   0   0  2304     1  246   455   0   7
93
1024+0 records in
1024+0 records out
0.00user 2.06system 0:27.79elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (104major+76minor)pagefaults 0swaps
/dev/hda5
 2  0  0   1004   2576 423288  11096   0   0  2880     1  282   521   0  10
89
 1  0  0   1004   2900 425976  11096   0   0  3123     1  297   555   0  11
89
 2  0  0   1004   2164 430124  10916   0   0  3174     0  300   549   0  15
85
 1  0  0   1004   2048 431724  10856   0   0  3072     0  294   548   0  11
89
1024+0 records in
1024+0 records out
0.00user 2.19system 0:21.32elapsed 10%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (104major+76minor)pagefaults 0swaps
/dev/hda6
 2  0  0   1004   2556 432488  10944   0   0  2781     1  278   511   1  10
89
 2  0  0   1004   2104 434284  10944   0   0  3098     1  296   542   0  11
88
 2  0  0   1004   2572 435432  10944   0   0  3174     0  300   564   0  11
89
 1  0  0   1004   3144 435048  10944   0   0  3046     0  292   536   0  12
88
1024+0 records in
1024+0 records out
0.02user 2.15system 0:21.50elapsed 10%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (105major+76minor)pagefaults 0swaps
/dev/hda7
 2  0  0   1004   2556 435672  10944   0   0  3020     1  290   549   0  12
88
 1  0  0   1004   3108 435316  10916   0   0  2278     1  244   441   0   7
93
 2  0  0   1004   2588 436088  10912   0   0  2906     0  283   528   0  10
90
 0  1  0   1004   2324 436596  10908   0   0  2316     0  247   444   0   8
92
 2  0  0   1004   2140 437248  10904   0   0  2893     1  283   527   0  10
90
1024+0 records in
1024+0 records out
0.01user 1.94system 0:24.62elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (104major+76minor)pagefaults 0swaps
 0  0  0   1004   2416 437724  10812   0   0  1920     1  221   399   0   5
95
 0  0  0   1004   2416 437724  10812   0   0     0     0  101   162   0   0
100

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
