Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUBBTLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUBBTLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:11:16 -0500
Received: from s4.uklinux.net ([80.84.72.14]:5771 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S265792AbUBBTLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:11:07 -0500
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>
	<20040201151111.4a6b64c3.akpm@osdl.org>
	<401D9154.9060903@cyberone.com.au> <87llnm482q.fsf@codematters.co.uk>
	<401DDCD7.3010902@cyberone.com.au> <401E1131.6030608@cyberone.com.au>
From: Philip Martin <philip@codematters.co.uk>
Date: Mon, 02 Feb 2004 18:36:53 +0000
Message-ID: <87d68xcoqi.fsf@codematters.co.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> writes:

> Another thing I just saw - you've got quite a lot of memory in
> buffers which might be something going wrong.
>
> When the build finishes and there is no other activity, can you
> try applying anonymous memory pressure until it starts swapping
> to see if everything gets reclaimed properly?

How do I apply anonymous memory pressure?

> Was each kernel freshly booted and without background activity
> before each compile?

Each kernel was freshly booted.  There were a number of daemons
running, and I was running X, but these don't appear to use much
memory or CPU and the network was disconnected.  Just after a boot
there is lots of free memory, but in normal operation the machine uses
its memory, so to make it more like normal I ran "find | grep" before
doing the build.  Then I ran make clean, make, make clean, make and
took numbers for the second make.

You can have the numbers straight after a boot as well.  In this case
I rebooted, logged in, ran make clean and make -j4.

I can hear disk activity on this machine. During a 2.4.24 build the
activity happens in short bursts a few seconds apart.  During a 2.6.1
build it sounds as if there is more activity, with each burst of
activity being a little longer.  However that just the impression I
get, I haven't tried timing anything, I may be imagining it.


2.4.24
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 6  0      0 379328  17100  45608    0    0    16     0  115   466 89 11  0  0
 5  0      0 388180  17108  45412    0    0    72     0  113   727 75 25  0  0
 4  0      0 376448  17108  45540    0    0    48     0  128   602 82 18  0  0
 5  0      0 378692  17112  45824    0    0    44     0  111   477 90 10  0  0
 3  3      0 376968  17408  46036    0    0   116   592  146   734 80 20  0  0
 4  0      0 383832  17924  47080    0    0    36  1484  295   490 80 11  9  0
 5  0      0 388620  17928  46268    0    0    36     0  116   933 71 29  0  0
 4  0      0 376864  17928  46360    0    0    52     0  116   659 81 19  0  0
 5  0      0 389580  17928  46772    0    0    20     0  115   502 86 14  0  0
 4  0      0 382452  17928  46656    0    0    68     0  115  1082 66 34  0  0
 5  1      0 384800  17980  47000    0    0     4   108  125   296 94  6  0  0
 6  1      0 385140  18484  46956    0    0    76  1088  274  1282 62 38  0  0
 6  0      0 381352  18904  47272    0    0    20  1544  221   522 88 12  0  0
 4  0      0 381636  18904  47448    0    0   104     0  126   829 75 25  0  0
 5  0      0 376732  18904  47408    0    0    32     0  114   727 83 17  0  0
 5  0      0 384100  18904  47572    0    0     0     0  108   686 76 24  0  0
 5  0      0 378904  18908  47724    0    0   100     0  121   897 71 29  0  0
 3  2      0 372608  19344  47960    0    0    56   832  198   319 87  7  5  0
 8  0      0 385204  19428  48096    0    0    12   656  199   819 80 19  0  0
 4  0      0 374144  19428  48312    0    0    80     0  120   801 71 29  0  0
 6  0      0 376628  19428  48604    0    0    32     0  109   512 88 12  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 6  0      0 380208  19428  48836    0    0    32     0  116   777 78 22  0  0
 5  0      0 378016  19428  48800    0    0    32     0  114   679 75 25  0  0
 4  1      0 376360  20092  49052    0    0    56  1244  282   723 79 21  0  0
 4  0      0 379996  20588  48980    0    0     0  1804  307   888 80 20  0  0
 4  0      0 372924  20596  49480    0    0    28     0  140   582 82 18  0  0
 5  0      0 382632  20596  49260    0    0    20     0  127   946 72 28  0  0
 4  0      0 374536  20596  49704    0    0    20     0  128   662 80 20  0  0
 6  0      0 383852  20596  49536    0    0    12     0  110   838 79 21  0  0
 4  1      0 371160  20888  49572    0    0    20   576  176   768 75 25  0  0
 5  0      0 383564  21236  49800    0    0    12  1280  226   803 79 20  0  0
 4  0      0 372592  21236  49908    0    0   108     0  120   919 66 34  0  0
 5  0      0 367796  21236  50368    0    0    56     0  118   427 90 10  0  0
 5  0      0 373172  21244  50344    0    0    72     0  121   714 78 22  0  0
 5  0      0 375740  21244  50500    0    0    64     0  110   498 86 14  0  0
 3  2      0 371356  21536  50936    0    0   108   584  175   716 79 21  0  0
 5  0      0 374716  21900  51324    0    0    24  1436  229   599 86 14  0  0
 5  0      0 375416  21900  51236    0    0    48     0  106   826 78 22  0  0
 5  0      0 372428  21900  51116    0    0    16     0  111   582 83 17  0  0
 4  0      0 367116  21908  51524    0    0    68     0  118   542 88 12  0  0
 5  0      0 372548  21916  51452    0    0    44     0  115   883 78 22  0  0
 5  1      0 372824  22240  51596    0    0    32   644  192   426 87 13  0  0

2.6.1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 6  0      0 379508  26148  42532    0    0    72     0 1024   716 81 19  0  0
 6  0      0 375028  26148  43076    0    0    64     0 1028   674 84 17  0  0
 5  0      0 374196  26148  43144    0    0    12     0 1017   836 81 19  0  0
 4  0      0 374580  26156  43068    0    0   112     0 1032   740 83 17  0  0
 6  1      0 379188  26560  43140    0    0    12   776 1119   889 79 19  0  2
 4  2      0 380076  27260  43392    0    0    20  1368 1178  1225 72 28  0  0
 5  3      0 380844  27808  43388    0    0    44  1004 1161  1559 52 33  2 12
 3  3      0 375148  28428  43584    0    0   108  1216 1224  1162 71 28  0  2
 4  1      0 373036  28984  44184    0    0    36  1068 1217   774 80 19  0  1
 6  1      0 380460  29528  44116    0    0     4  1024 1189   950 73 17  2 10
 4  0      0 377452  29772  43940    0    0    20  1408 1141  1809 39 45  5 11
 4  0      0 375596  29772  44144    0    0    56     0 1052   768 81 19  0  0
 5  0      0 380588  29772  44280    0    0     0     0 1020  1088 74 26  0  0
 4  0      0 376748  29780  44408    0    0    92     0 1019  1458 62 38  0  0
 5  0      0 374956  29784  44676    0    0     4     0 1012   659 85 16  0  0
 5  2      0 377004  30080  44584    0    0    28   584 1086  1678 57 41  0  2
 3  3      0 370412  30824  44656    0    0   104  1464 1185   804 72 19  0 10
 6  3      0 379884  31272  45024    0    0    16   844 1161   995 73 20  0  6
 6  2      0 373420  31840  44932    0    0     8  1072 1167  1635 48 35  1 17
 3  2      0 369516  32584  45140    0    0   108  1428 1159  1458 58 33  1  7
 3  2      0 364268  33072  45196    0    0    48   952 1190   811 71 16  0 13
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 5  3      0 373548  33512  45912    0    0     0   784 1129   710 86 12  0  2
 6  3      0 373676  34056  45708    0    0     0  1036 1159  1444 53 32  4 12
 1  4      0 368812  34728  45648    0    0   100  1280 1173  1700 44 39  3 16
 4  2      0 368044  35336  45992    0    0    32  1176 1186   561 74 10  0 15
 6  2      0 366508  35808  45860    0    0    12   868 1143   820 85 13  0  2
 0  5      0 371628  36260  46020    0    0     0   812 1136  1732 42 33  6 20
 4  1      0 363308  36836  46056    0    0    68  1116 1168  1130 44 25  1 30
 4  2      0 360684  37496  46348    0    0     0  1264 1186   675 83 13  2  3
 2  1      0 369068  37992  46328    0    0     0   844 1148  1499 58 31  2  9
 3  2      0 365868  38588  46480    0    0    44  1188 1173  1468 58 35  0  8
 5  1      0 360044  39256  46424    0    0    16  1316 1188  1020 69 26  0  5
 0  1      0 367788  39860  46704    0    0     0  1112 1170   967 75 21  2  3
 0  4      0 364716  40020  46748    0    0    40  2544 1226  1911 29 48  1 22
 4  0      0 355180  40020  46952    0    0     0     0 1079   297 78  8  0 15
 4  0      0 366636  40020  47020    0    0     0     0 1038  1381 65 35  0  0
 4  1      0 362604  40028  47148    0    0    32     0 1047  1309 66 34  0  0
 6  0      0 366060  40032  47484    0    0    12     0 1029   775 81 19  0  0
 1  4      0 362220  40580  47276    0    0    76  1080 1146  1845 45 50  1  5
 4  1      0 355116  41040  47700    0    0   128   864 1201   548 60 10  1 29
 5  0      0 352492  41292  47788    0    0    16  1276 1129   507 92  8  0  0
 6  0      0 363436  41296  47852    0    0    20     0 1028  1277 67 33  0  0

-- 
Philip Martin
