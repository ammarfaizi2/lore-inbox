Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277758AbRJWPPd>; Tue, 23 Oct 2001 11:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277751AbRJWPPS>; Tue, 23 Oct 2001 11:15:18 -0400
Received: from mail1.home.nl ([213.51.129.225]:6130 "EHLO mail1.home.nl")
	by vger.kernel.org with ESMTP id <S277732AbRJWPM1>;
	Tue, 23 Oct 2001 11:12:27 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_JMZNCXHEFIC99GNHLE3E"
From: elko <elko@home.nl>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] updated preempt-kernel
Date: Tue, 23 Oct 2001 17:13:31 +0200
X-Mailer: KMail [version 1.2]
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <1003562833.862.65.camel@phantasy> <0110222243171D.05096@ElkOS> <1003792292.1496.65.camel@phantasy>
In-Reply-To: <1003792292.1496.65.camel@phantasy>
X-Owner: ElkOS
MIME-Version: 1.0
Message-Id: <01102317133101.00754@ElkOS>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_JMZNCXHEFIC99GNHLE3E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Tuesday 23 October 2001 01:11, Robert Love wrote:
> On Mon, 2001-10-22 at 16:43, elko wrote:
> > My current conclusion: this combination of kernel and patches
> > is the  most responsive I've ever used, normally, when I run
> > these command's, my systems would freeze to the point I had
> > to give them the VNP.
>
> Excellent.  Give a lot of credit to Rik too because his VM work has
> relieved a lot of thrashing/storming in high-load situations such as
> yours.
> 	Robert Love

Hereby, I also give *a lot of* credit to Rik, by CC'ing him ;^)
(Hi Rik! No worries, I'm not from Vries <g>)

This system has not been running as smooth as now, since I switched
from 2.4.0 to 2.4.10-ac12 and a few days later to 2.4.12-ac3,
so I did some testing, that I could never complete with
the previous kernels I used (as was asked on the list).

I've attached the results of my latest tests..

-- 
ElkOS: 4:34pm up 1:05, 3 users, load average: 2.61, 2.58, 2.83
bofhX: Network failure -  call NBC


--------------Boundary-00=_JMZNCXHEFIC99GNHLE3E
Content-Type: text/plain;
  charset="iso-8859-1";
  name="tests"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="tests"

Tests done just after a reboot:

test1: In console, play a mp3-file with mpg123
test2: In console, play a mp3-file with mpg123 and run the find command
test3: Run test1 in X, play with freeamp
test4: Run test2 in X, play with freeamp
test5: Run test2 in X, play with mpg123
       no reboot after test 4, since memory was released, a bit of swap
       stayed behind... read the output below...

Extra apps in X: gkrellm, 2x setiathome, 4 konsoles, freeamp playing,
                 kmail, 2x konqueror, licq

- Fire up mpg123:
[elko@ElkOS mp3]$ while :; do mpg123 "Aphex Twin - Come to Daddy.mp3"; do=
ne

- `find' command to stress the system (~3,7G, ~81946 files):
[elko@ElkOS ~]# find .|xargs slocate|sort|uniq -c|head -1

- Make sure I'm using /dev/dsp:
[elko@ElkOS ~]# /usr/sbin/lsof|grep dsp
esd    605 elko  5w   CHR   14,3    22742 /dev/dsp

- Watch the system:
[elko@ElkOS ~]# vmstat -n 60 15 |tee -a ~elko/tests
=2E..

- Audio driver used (in kernel): ES1371

- System info:
[elko@ElkOS ~]# /sbin/swapon -s
Filename                        Type            Size    Used    Priority
/dev/hda7                       partition       104380  33648   -1
/dev/hdd5                       partition       1465592 35144   -2

[elko@ElkOS ~]# dmesg | egrep "clock |Mem"
Memory: 577440k/589824k available \
(1177k kernel code, 12000k reserved, \
347k data, 236k init, 0k highmem)
=2E.... CPU clock speed is 852.0020 MHz.
=2E.... host bus clock speed is 100.2353 MHz.


* Now for the tests:
-------------------------------------

test1: 2.4.12-ac3-vmpatch-freeswap-preempt

- No skips in mp3 playing, nothing special to report

- vmstat output:
   procs                     memory    swap       io     system         c=
pu
 r  b  w  swpd   free   buff  cache  si  so   bi  bo   in    cs  us  sy  =
id
 1  1  0     0 455808  83428  13192   0   0  341   4  220   262   1   3  =
96
 1  0  0     0 454752  83428  14152   0   0   16   2  792  1390   2   1  =
97
 1  0  0     0 453768  83428  15112   0   0   16   1  790  1388   2   1  =
97
 1  0  0     0 452700  83428  16136   0   0   17   0  790  1387   2   1  =
97
 1  0  0     0 451856  83428  16948   0   0   14   0  790  1386   2   1  =
97
 1  0  0     0 451856  83428  16948   0   0    0   1  789  1385   2   1  =
97
 1  0  0     0 451856  83428  16948   0   0    0   0  789  1386   2   1  =
97
 1  0  0     0 451852  83428  16948   0   0    0   0  789  1386   2   1  =
97
 1  0  0     0 451852  83428  16948   0   0    0   0  789  1386   2   1  =
97
 1  0  0     0 451856  83428  16948   0   0    0   1  789  1386   2   1  =
97
 1  0  0     0 451856  83428  16948   0   0    0   0  789  1386   2   1  =
97
 1  0  0     0 451856  83428  16948   0   0    0   0  789  1386   2   1  =
97
 1  0  0     0 451852  83428  16948   0   0    0   0  789  1386   2   1  =
97
 1  0  0     0 451856  83428  16948   0   0    0   0  789  1387   2   1  =
97
 1  0  0     0 451856  83428  16948   0   0    0   1  789  1386   2   1  =
97
-------------------------------------

test2: 2.4.12-ac3-vmpatch-freeswap-preempt

- This stressed my system a little, she couldn't handle the load perfect,
  but she managed to stay alive ;^)

- Top1 when vmstat was finished, but the find command still running (top)=
:
  658 elko      19   0  766M 321M   536 R    321M 98.0 57.0   1:01 slocat=
e

- Uptimes shows no big load (uptime):
  2:18pm  up  9 min,  4 users,  load average: 1.45, 0.85, 0.38
  2:19pm  up  9 min,  4 users,  load average: 1.47, 0.91, 0.41
  2:21pm  up 12 min,  4 users,  load average: 1.56, 1.14, 0.57
  2:27pm  up 18 min,  4 users,  load average: 1.45, 1.34, 0.84

- Memory suddenly released (free):
             total       used       free     shared    buffers     cached
Mem:        577676     451124     126552          0        168       7124
-/+ buffers/cache:     443832     133844
Swap:      1569972       6696    1563276

- Skips of mp3-file during test:
  1st 5 mins.: 5 skips ~1,5 second each
  2nd 5 mins.: 14 skips, same length
  3rd 5 mins.: 15 skips, same length

- vmstat output:
   procs                    memory    swap         io     system         =
cpu
r  b  w   swpd   free  buff cache  si   so   bi    bo   in    cs  us  sy =
 id
1  0  0      0 445268 83860 17560   0    0  308     4  186   199   2   3 =
 95
2  0  0 356740   3064   228  6372   3  3950  18  4054  820  1473  74  19 =
  8
2  0  0   6904 266992   244  6196  15  4692  39  4692  806  1295  77  17 =
  6
2  0  0   6908 366392   280  6116  15  4190  39  4191  810  1291  76  19 =
  6
2  0  0 557888   3064   140  5816  25  4617  61  4620  783  1433  70  18 =
 12
2  0  0  14200 454988   224  6704  31  9375  60  9377  771  1116  66  24 =
 10
2  0  0 451308   2860   120  5856   9  3477  26  3477  769  1409  75  16 =
  9
2  0  0 946388   3900   124  5900  45 10954  75 10963  797  1170  62  21 =
 18
2  0  0 492616   2860   100  5520  16  4142  39  4142  795  1267  75  18 =
  7
2  0  0 979576   3060   104  5172   8  9130  26  9130  815  1174  70  25 =
  5
2  0  0 450700   3064   108  5352  27  1696  72  1697  799  1313  73  15 =
 12
2  0  0 860220   2844   104  5212   6 10968  22 10968  790  1386  64  22 =
 14
2  0  0 445292   2588    96  5448  13  3835  43  3835  869  1399  71  16 =
 12
2  0  0 895300   3060   104  4988   6  7457  23  7457  787  1187  70  21 =
  9
2  0  0 443772   3064   164  4752  37  4832  86  4834  808  1277  68  17 =
 15
-------------------------------------

test3: 2.4.12-ac3-vmpatch-freeswap-preempt

- No skips in mp3 playing, nothing special to report

- Using /dev/dsp with freeamp:
[elko@ElkOS ~]$ /usr/sbin/lsof | grep dsp
freeamp   716 elko   17w   CHR       14,3            22742 /dev/dsp
freeamp   717 elko   17w   CHR       14,3            22742 /dev/dsp
freeamp   718 elko   17w   CHR       14,3            22742 /dev/dsp
freeamp   719 elko   17w   CHR       14,3            22742 /dev/dsp
freeamp   720 elko   17w   CHR       14,3            22742 /dev/dsp
freeamp   721 elko   17w   CHR       14,3            22742 /dev/dsp
freeamp   723 elko   17w   CHR       14,3            22742 /dev/dsp
freeamp   852 elko   17w   CHR       14,3            22742 /dev/dsp
freeamp   853 elko   17w   CHR       14,3            22742 /dev/dsp
freeamp   854 elko   17w   CHR       14,3            22742 /dev/dsp

- vmstat output:
   procs                     memory    swap      io    system         cpu
 r  b  w  swpd   free   buff  cache  si  so   bi bo   in   cs  us  sy  id
 4  0  0     0 301868  86072  62260   0   0  114  5  138  280  73   8  19
 2  0  0     0 305256  86072  62680   0   0    8  3  303  752  90  10   0
 2  0  0     0 302248  86084  63716   0   0   17  4  316  575  88  12   0
 7  0  0     0 298572  86104  64876   0   0   17  9  296  507  90  10   0
 4  0  0     0 297036  86108  65976   0   0   18  5  311  453  91   9   0
 2  0  0     0 295916  86112  66916   0   0   16  3  300  523  88  12   0
 4  0  0     0 295220  86112  67812   0   0   15  1  274  322  92   8   0
 2  0  0     0 293344  86112  68728   0   0   15  1  276  344  93   7   0
 3  0  0     0 291392  86184  70644   0   0   33  5  286  403  90  10   0
 3  0  0     0 290636  86196  71588   0   0   16  1  296  551  89  11   0
 2  0  0     0 291744  86196  72484   0   0   15  1  278  371  92   8   0
 2  0  0     0 290828  86196  73380   0   0   15  1  282  389  93   7   0
 2  0  0     0 290024  86200  74168   0   0   13  0  279  385  89  11   0
 2  0  0     0 287168  86212  75412   0   0   21  2  291  509  91   9   0
 2  0  0     0 286228  86212  76308   0   0   15  2  274  332  92   8   0
-------------------------------------

test4: 2.4.12-ac3-vmpatch-freeswap-preempt

- This is a strange one, since I've loaded more apps. in X, I would think=
 the
  system would be even more stressed then in test 2 (same test in console=
);
  maybe it's freeamp that's doing so well, since I only had 2 skips;
  therefore, I'll run this test again with mpg123, like in test2

- Skips of mp3-file during test (4 skips total):
  1st 5 mins.: none
  2nd 5 mins.: none
  3rd 5 mins.: 1 at 12 mins. and 1 at ~14,9678 mins.

- Note: 3 times, when memory began to get full, swap took over without sl=
owing
        anything down at all, you couldn't notice it...

- vmstat output:
   procs                     memory    swap         io    system         =
cpu
 r  b  w   swpd   free   buff cache  si  so    bi   bo   in   cs  us  sy =
 id
 3  2  0      0 281596 100628 61968   0   0   218    6  176  309  26   5 =
 69
 4  0  0      0 225064 108032 81312   0   0   403   26  368  516  85  15 =
  0
 3  0  0      0 116020 113436 96648   0   0   303   62  347  484  88  12 =
  0
 4  0  0 212492   3068 103368 32608   0   0    42   20  280  333  86  14 =
  0
 3  3  0 327916   3060    776 21440  13 4180   47 4183  322  331  83  17 =
  0
 3  0  0 487860   3064    636 14908  89 3045  121 3054  302  309  86  14 =
  0
 3  0  0 750580   3060    384 12788  36 3023   52 3024  301  315  82  18 =
  0
 3  0  0  68756 292060    704 18208 131   0   226    3  277  347  86  14 =
  0
 3  0  0  68756  31500    704 19232   3   0    20    1  273  309  88  12 =
  0
 3  0  0 472564   3064    424 13860  34 3912   68 3913  314  377  77  17 =
  7
 3  0  0  68992 318612    812 20552 415 1911  555 1913  291  357  86  14 =
  0
 3  0  0  68960  63564    988 22088  15   0    43    1  277  318  88  12 =
  0
 3  0  0 480228   2552    476 13688  37 3446   67 3447  292  325  76  20 =
  4
 4  0  0 551760   3120    584 14076 281 3791  333 3792  324  357  84  15 =
  1
 3  0  0 863540   2896    428  8616  14 4522   32 4523  305  309  76  17 =
  7
-------------------------------------

test5: 2.4.12-ac3-vmpatch-freeswap-preempt

- Some skips, but not as much as I would have thought:
  1st skip at 7 mins. (during a desktop-switch)
  2nd skip at 9,5 mins.
  3rd skip at 13 mins.
  4th skip at 14 mins. (just before the end of vmstat)

- I would have expected much more skips during this test, since it's
  the same as test2, only much more programs running (X etc.)...

- When running these tests in X, the machine would freeze when trying to
  switch kde-desktops or switch apps., but when nothing is touched, she
  just (about) keeps on playing...

- vmstat output:
   procs                     memory    swap         io    system         =
cpu
 r  b  w   swpd   free  buff  cache  si  so    bi   bo  in    cs  us  sy =
 id
 5  1  0  68120 465408  1188  24364  45 766   161  773 216   317  66  10 =
 24
 4  0  0  68120 412296  8892  41464   5   0   384   27 884  1508  88  12 =
  0
 4  0  0  68120 316464 14652  58128   1   0   323   53 868  1477  88  12 =
  0
 4  0  0  68120  63152 15636  59784   0   0    44   28 798  1364  85  15 =
  0
 5  1  0 440360   3064  1132  13772  15 3964   38 3964 847  1335  81  19 =
  0
 4  0  0 487248   3064   916  21280 381 1927  552 1938 817  1358  85  15 =
  0
 4  0  0 815376   3064   684  19176 274 3886  386 3889 837  1448  81  19 =
  0
 4  0  0  70248 259996   924  22368 134   0   190    4 801  1372  86  14 =
  0
 6  0  0  70208   3064   988  24160  18   0    57    0 796  1421  87  13 =
  0
 4  0  0 467696   2804   508  15660  30 4383   68 4384 784  1246  74  21 =
  5
 4  0  0  70356 322744   648  14424   8 1546   29 1549 807  1345  85  15 =
  0
 4  0  0  70352  60732   872  15580  11   0    34    1 792  1372  87  13 =
  0
 4  0  0 505900   3064   392  11020  33 4972   95 4973 793  1237  79  18 =
  3
 4  0  0 568404   3064   520  10104  13 2317   35 2317 785  1298  85  15 =
  0
 4  0  0 858932   3064   564  10796  43 3068   93 3069 767  1235  79  21 =
  0
-------------------------------------

BTW: the `find' command never got to finish...
     should I let it and `time -v' it for fun ????


~~
End of testing 2.4.12-ac3-vmpatch-freeswap-preempt (23-10-2001 16:51)
~~

--
elko

--------------Boundary-00=_JMZNCXHEFIC99GNHLE3E--
