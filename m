Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130669AbQLISQx>; Sat, 9 Dec 2000 13:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131178AbQLISQm>; Sat, 9 Dec 2000 13:16:42 -0500
Received: from www.wen-online.de ([212.223.88.39]:59408 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130669AbQLISQj>;
	Sat, 9 Dec 2000 13:16:39 -0500
Date: Sat, 9 Dec 2000 18:46:12 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: swapoff/on leak test12-pre7
Message-ID: <Pine.Linu.4.10.10012091822230.602-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stumbled over a small leak.. and some funny looking numbers.

while true; do swapoff -a; swapon -a; done

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0      0  73120   4392   7984   0   0     0     0  104    12   0   1  99
 1  0  0      0  73120   4392   7984  44   0    11     0  117   114   5   8  87
 1  0  0      0  72676   4392   7984 364   0    91     0  196   824  32  68   0
 1  0  0      0  72436   4392   7984 360   0    90     0  191   818  43  56   1
 1  0  0      0  72032   4392   7984 364   0    91     0  192   827  32  68   0
 1  0  0      0  71564   4392   7984 364   0    91     0  192   824  37  62   1
 1  0  0      0  71316   4392   7984 360   0    90     1  192   821  37  61   2
 2  0  0      0  70976   4392   7984 364   0    91     0  192   825  38  61   1
 1  0  0      0  70580   4392   7984 364   0    91     0  192   825  40  58   2
 1  0  0      0  70124   4392   7984 364   0    91     0  192   826  36  63   1
 1  0  0      0  69876   4392   7984 360   0    90     0  191   819  43  54   3

 ....

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 3  0  0      0   1980    424   5048 380   0    95    16  211   859  33  66   1
 1  0  0      0   2244    424   5040 372   0    93    28  221   860  39  60   1
 1  0  0      0   2104    424   5028 376   0    95    26  222   863  32  66   2
 1  0  0      0   1944    296   4888 376   0    95    18  214   867  39  60   1
 1  0  0      0   2068    144   4732 320   0    88    18  207   741  29  55  16
 1  0  0      0   2064    144   4376 368   0    93    18  212   838  33  65   2
 1  0  0      0   1956    144   4040 364   0    92    10  203   848  30  70   0
 1  0  1    212   1940    120   4104 180 412    76   186  245   468  17  64  19
 1  0  1      0   1956    120   3708 192 564    52   255  274   480  18  77   5
 1  0  1      0   1956    112   3556 184   0    76    70  235   454  19  72   9
 2  0  1      0   1992    112   3388 212   0    56    98  255   494  28  72   0
 1  0  1      0   2064    112   3200 220   0    56    91  249   506  19  81   0
 2  0  1      0   1940    112   2992 204   0    52   107  260   477  24  76   0
 1  0  2      0   2076    112   2908  84 1580    75   433  209   259  10  61  29
 1  0  2      0   2064    112   2732 208   0    55    92  247   485  23  74   3
 1  0  1      0   1880    112   2684 128 1344    45   403  230   326  12  64  24
 1  0  2      0   2040    112   2548  84 1992    55   543  210   233   7  66  27
 1  0  1      0   1872    112   2548 172 520    46   220  246   415  20  78   2
 1  0  1      0   1872    112   2532  16 3012    41   795  211   101   2  71  27
 0  1  1   1488   1740    104   4020  20 2984    45   794  217   124   2  56  42
 0  0  0   1268   1804     92   3800   8 2232    19   578  187    76   1  50  50

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
