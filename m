Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313187AbSDDNLn>; Thu, 4 Apr 2002 08:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313162AbSDDNLe>; Thu, 4 Apr 2002 08:11:34 -0500
Received: from ppp15.atlas-iap.es ([194.224.1.15]:54472 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id <S313174AbSDDNLW>; Thu, 4 Apr 2002 08:11:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
Subject: REPORT: NFS and ReiserFS very high latencies, with low-latency and preempt applied
Date: Thu, 4 Apr 2002 15:11:19 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Message-Id: <E16t71L-0006X9-00@antoli.gallimedina.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	Linux becomes somehow unusable when I edited sound files and also 
during NFS copy. I've noticed the same effects also during i/o loads, for 
example when closing kmail after I deleted some messages.

I was also surprised that when doing just memory operations in kwave, the X 
server also is blocked and after exiting kwave, kmail just died.

I send this reports just in case is useful. Sorry by the ugly style/grammar, 
I didn't have much time to improve it.

Regards,

-- 
  ricardo
"I just stopped using Windows and now you tell me to use Mirrors?" 
    - said Aunt Tillie, just before downloading 2.5.3 kernel.



-----------------------------
I've noticed that my system, a P3, 1Ghz, 2.4.18+low-latency+preempt patches 
applied (and enabled) did suffered of very high latencies due to disk and 
_memory_ operations when editing wav files with kwave.

_Whithout_ the patches applied the kernel blocks even when reading a wav file 
from kwave, after applying the patches the response was much better. _But_ it 
was suffering very large latencies when editing sund, for example deleting 
fragments or changing zoom. The X server blocked during seconds, even for 
updating the pointer position.

I did another test, copying big files (60-90 MB) from a NFS client via 100mbps 
ethernet. The client was a 2.4.19-pre4 (PPC on a iBook 500 Mhz). cp was executed 
from the client. Every few seconds even the mouse was blocked.

The vmstat of the NFS copy is as follows (it started and ended almost at the 
same time as the cp):

gallir@antoli:~$ vmstat  3
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0  86800 226312  26828 118812   0   0     9    22  195   194   2   0  97
 0  0  2  86800 212080  26936 132856   0   0     0    63 4059  2368   1  17  82
 0  0  1  86800 181260  26968 163436   0   0     0     0 8587  4232   0  40  60
 0  0  1  86800 151192  27092 193380   0   0     0    55 8435  4138   0  37  63
 0  0  1  86800 121060  27124 223464   0   0     0     0 8558  4183   0  37  63
 0  0  2  86800  90536  27252 253856   0   0     0    64 8518  4209   0  34  66
 0  0  1  86800  67836  27376 276416   0   0     1    61 6403  3229   0  32  68
 0  0  1  86800  39916  27408 304304   0   0     0     0 7925  3872   0  38  62
 0  0  2  86800  16952  27532 327144   0   0     0   336 6582  3277   0  32  68
 0  0  2  86800  16716  27532 327380   0   0     0  2504  594   970   0   2  98
 0  0  1  86948   4344  24600 345332   0  59     0  4825 5541  4156   1  27  72
 0  0  3  87056   4416  24244 350796   0   4     0 26520 2222  2974   1  13  86
 2  0  3  87156   4444  19524 360172   0  24     0  2264 7435  7035   7  40  53
 1  0  1  87156   4460  17548 362208   0   0     0    60 6933  7437   6  32  62
 1  0  3  87156   4336  13944 366000   0   0     0     0 8483  8102   4  50  46
 1  0  2  87196   4336  10124 370384   0   0     0  8040 6417  6668   6  35  59
 3  0  3  87196   4440   8400 372220   0   0     0 16776 4567  5760   6  26  68
 1  0  1  87196   4420   8396 372152   0   0     0  7081 4502  5736   2  23  76
 1  0  0  87196   4412   8416 372256   0   0     0     0 7018  7447   9  41  51
 2  0  1  87196   4424   8436 372224   0   0     0  1507 8450  8037   5  50  46
 2  0  2  87196   4400   8520 372180   0   0     0 15876 4346  5856   7  23  70
 2  0  1  87196   4412   8548 372136   0   0     0     0 7972  7891   4  40  56
 1  0  2  87196   4396   8564 372120   0   0     0 11304 6112  6835  10  35  56
 1  0  3  87196   4448   8564 372072   0   0     0 28163 1538  4268   1   8  91
 0  0  2  87196   4324   8540 372036   0   0     0  3419 6686  3508   0  31  69
 0  0  1  87196   4412   8668 371812   0   0     0    61 8458  4342   0  40  60
 0  0  1  87196   4368   8544 372072   0   0     0     0 8825  6344   3  40  57
 1  0  1  87676   4396   8612 372256   0 177     0   243 8482  5064   1  39  59
 1  0  3  87676   4440   8624 372132   0  13     0 20252 3989  4229   1  23  76
 0  0  0  87676   4444   8696 372056   0   0     0  2763  375  1463   1   1  98
 0  0  0  87676   4428   8712 372056   0   0     0     8  162   385   0   0 100
 0  0  0  87676   4428   8712 372056   0   0     0     0  161   386   0   0 100

The files copyied during the test were:

-rw-r--r--    1 root     gallir   10899212 Apr  4 14:49 track01.cdda.wav
-rw-r--r--    1 root     gallir   33360812 Apr  4 14:49 track02.cdda.wav
-rw-r--r--    1 root     gallir   50097644 Apr  4 14:49 track03.cdda.wav
-rw-r--r--    1 root     gallir   41392892 Apr  4 14:49 track04.cdda.wav
-rw-r--r--    1 root     gallir   65195132 Apr  4 14:49 track05.cdda.wav
-rw-r--r--    1 root     gallir   67041452 Apr  4 14:49 track06.cdda.wav
-rw-r--r--    1 root     gallir   54879260 Apr  4 14:49 track07.cdda.wav
-rw-r--r--    1 root     gallir    9285740 Apr  4 14:49 track08.cdda.wav
-rw-r--r--    1 root     gallir   55702460 Apr  4 14:49 track09.cdda.wav
-rw-r--r--    1 root     gallir   51821660 Apr  4 14:50 track10.cdda.wav
-rw-r--r--    1 root     gallir   59940764 Apr  4 14:50 track11.cdda.wav
-rw-r--r--    1 root     gallir   52945916 Apr  4 14:50 track12.cdda.wav
-rw-------    1 root     gallir   56328192 Apr  4 14:50 track13.cdda.wav

After the files were copyed, I edited one of them (track05.cdda.wav).

KWAVE VMSTAT
------------
gallir@antoli:~/tmp$ vmstat  3
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0  87676   4412   9644 368252   0   0     9    24  198   197   2   0  97
 0  0  0  87676   4396   9660 368252   0   0     0    11  382  1740   1   0  98
# read file track05.wav (64 MB) starts here
 1  0  0  87676   4488   9796 367348  31   0   184    41  407  2002   8   2  90
 3  0  0  87676   4432   9836 367352   0   0     1    24  441  2465   8   1  92
 2  0  0  87804   4520   9728 302820  31  16   357   133  221  1211  69  29   2
 2  0  0  87804   4524   9728 302692  21   0  1387     0  202   256  98   2   0
 9  0  0  87804   4472   9744 302692  11   0  1461     8  214   148  96   4   1
 2  0  0  87804   4468   9744 302692  11   0  1461     0  210   148  97   3   0
 8  0  0  87804   4492   9672 302636  21   0  1131     0  194   145  97   2   1
 8  0  0  87804   4504   9672 302636  11   0  1547     0  205   153  95   5   0
 6  0  0  87804   4460   9672 302636   0   0  1280     0  200   146  96   4   0
 7  0  0  87804   4472   9672 302636   0   0  1280     0  206   140  98   2   0
 8  0  0  87804   4472   9672 302636   0   0  1536     0  212   154  96   4   0
 2  0  0  87804   4392   9672 302764   0   0  1237     0  203   143  97   3   0
 2  0  0  87804   4456   9672 302636  11   0  1419     5  213   152  98   2   0
 3  0  0  87804   4488   9672 302636   0   0  1280     0  204   142  98   2   0
 3  0  0  87804   4452   9672 302636   0   0  1451     0  214   152  96   4   0
 7  0  0  87804   4448   9672 302636   0   0  1024     0  195   140  97   3   0
 6  0  0  87804   4468   9672 302636   0   0  1536     0  210   152  96   4   0
 4  0  0  87804   4448   9576 302732   0   0  1280     0  206   147  96   4   0
 0  0  0  87804   5276   9576 302644  21   0   716     0  184  2501  82   5  13
 0  0  0  87804   5208   9644 302644   0   0     0    43  325  1273   0   3  97
 0  0  0  87804   5192   9660 302644   0   0     0     8  375   421  51   1  48
 1  0  0  87804   4360   9640 303584   0   0     1     0  348  1580   2  10  88
 1  0  0  87804   4456   9792 303284   0   0     8    77  326  1883  28   8  64
 2  0  0  87804  51996   9792 279484   0   0    12     0  290  1615  29   3  68
 4  0  1  87804  52000   9792 279484   0   0     0 12399  589  1010  33   6  61
 2  0  0  87804  48484   9880 279484   0   0     0   935  408  1580  17   2  81
 0  0  0  87804  51860   9896 279484   0   0     0     9  453  2740  13   2  85
 0  0  0  87804  51852   9896 279484   0   0     0     0  273  1134  20   1  79
 0  0  0  87804  51836   9912 279484   0   0     0     8  329  1483   2   4  94
 0  0  0  87804  33036   9912 279492   0   0     3     0  347  1798  13   3  83
# delete selection
 2  0  1  87804  31740   9912 279492   0   0     0 15891  584  1675  37  11  52
 1  0  0  87804  29304  10000 279492   0   0     0    68  565  2640  95   5   0
 5  0  0  87804  26968  10016 279492   0   0     0     8  311  1561  99   1   0
 1  0  0  87804  24408  10016 279492   0   0     0     0  262  1067  97   3   0
 1  0  0  87804  21668  10032 280772   0   0     0     9  258  1025  96   4   0
 2  0  0  87804  19592  10036 282820   0   0     0     0  371  1748  94   6   0
# save file
 2  0  1  87804  17552  10036 284868   0   0     0 16413  823  3017  86  14   0
 2  0  1  87804  15508  10040 286916   0   0     0 15073  829  3299  84  16   0
 1  0  1  87804  13492  10040 288908   0   0     0 15233  558  1451  90  10   0
 1  0  0  87804  13912  10108 288908   0   0     0 12271  716  2698  19   4  77
 0  0  0  87804  13908  10108 288908   0   0     0     0  519  2622   2   1  98
 1  0  0  87804  13892  10124 288908   0   0     0    15  438  2134   3   2  96
 0  0  0  87804  13892  10124 288908   0   0     0     0  413  2215   4   6  89
 2  0  0  87804  13368  10152 289192   0   0    37     9  387  2263   8   2  90
 1  0  0  87804   9900  10256 292260  41   0    60   107  300  1996  23   4  73
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0  87804   4356  10256 297924   0   0     0     0  268  2928  88  12   0
# save file
 1  0  0  87804   4448  10228 297732  43   0    43    37  167  2382  89  11   0
 1  0  0  87804   4408  10244 297676  29   0    29     0  164  2394  89  11   0
 2  0  0  87804   4508  10336 297632  11   0    11    59  378  2175  16   4  80
 0  0  0  87804 173012  10436 200736   0   0     9    64  380  2254  21   7  72


After exiting kwave, kmail suddenly just DIED.

--------------------------------------------
END
