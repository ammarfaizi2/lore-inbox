Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317018AbSGSUar>; Fri, 19 Jul 2002 16:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317020AbSGSUar>; Fri, 19 Jul 2002 16:30:47 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:12043 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S317018AbSGSUaq>; Fri, 19 Jul 2002 16:30:46 -0400
Date: Fri, 19 Jul 2002 16:33:50 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19rc2aa1 VM too aggressive?
Message-ID: <20020719163350.D28941@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded a web server I run to a the 2.4.19rc2aa1 kernel to
see how much better the VM is.

It seems to be better than the older 2.4 kernels used on this machine,
but there seems to be lots of motion in the cache for all of the free
memory that exists:

   procs                      memory    swap          io     system  cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 8  0  1 106764 460152  10688 102432   0   0    76     0  971   620  55  44   1
12  0  3 106764 321564  10712 237828   0   0    16   296 1286   860  34  65   0
 2  1  0 106760 529488  10712  42284   4   0     4     0  707   481  28  72   0
 7  0  0 106760 529496  10736  42468   0   0   204     0 1105   730  28  17  56
 5  0  0 106760 515220  10740  53544   0   0   152     0 1237   929  50  22  29
 5  0  0 106760 525364  10740  42680   0   0    32     0  918   611  50  29  21
 2  0  1 106756 527248  10772  42672   0   0     4   308  994   692  52  32  17
10  1  1 106744 486112  10776  78788 192   0   300     0 1127   638  75  24   2
 3  0  1 106744 517516  10776  49696   0   0     4     0 1005   623  55  45   0
 4  0  0 106128 528812  10780  42992   0   0   192     0  644   367  13  22  65
 3  0  0 106128 527444  10804  43012   0   0    12   276  561   386  16  14  70
 1  0  1 106108 527540  10804  43412   8   0     8     0 1224   794  40  47  13
 4  0  0 106108 510192  10804  59356   0   0     4     0  481   322  21  17  61
 3  0  0 106076 527712  10812  43476   0   0    64     0 1333   968  46  38  16
 3  0  0 106036 502288  10812  67236   0   0     0     0  802   494  46  37  17
 5  0  2 106032 476188  10844  91496   0   0     4   316  905   573  54  37   8
16  0  2 106032 355400  10844 203880   0   0     4     0  909   540  51  49   0
10  0  2 106024 340108  10852 221548   0   0    28     0  975   659  36  64   0
 0  0  0 106024 528340  10852  43572   0   0     4     0  569   426  17  17  67
 0  1  0 106024 531304  10852  43612   0   0     4     0  542   342   9  14  77
16  0  1 106024 452508  10876 111588   0   0    20   308  986   621  49  38  13
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
26  0  1 106024 326064  10884 226384   0   0   324     0 1347   841  52  48   0
21  0  1 106016 241296  10896 308532   4   0    56     0 1154   737  53  46   1
15  6  1 137612  51136   8432 480368  40 1700   412  2044 3657  2514  31 69   0
12 22  0 115336 490416   8216  85448   0 1256    52  1320  381  7918   8 92   0
23  0  1 115260 435232   8252 133128  52  24  1168   292 2158  3848  43  47  10
11  0  1 115228 451688   8252 120776   0   0    76     0 1261   775  46  54   0
 9  0  1 115180 454820   8296 118996  36   0  1532     0 1844  1530  52  48   0
11  0  1 115176 445800   8340 124312 128   0   656   412  892   796  48  52   0
 9  0  1 114916 463744   8352 111960  12   0   452     0  708   673  23  77   0
 6  0  1 114888 465108   8356 110332  24   0   248     0  745   696  33  67   0
12  0  1 114876 513064   8356  63196   0   0   420     0 1113   825  41  59   0
 2  1  0 114876 550504   8368  28976   0   0   772     0 1614  1066  51  48   1
 2  0  0 114868 558216   8408  21820   0   0   220   432 1453  1269  49  27  24
 1  0  0 114868 566768   8412  14456   0   0   288     0  909   674  41  17  43
 1  0  0 114864 565844   8428  14640   0   0   108     0  920   744  39  13  49

This is with a 1 second interval. Why is it that most of the time I have
~400MB of memory free (this machine has 1GB of memory). Why does the
cache size vary so wildly?

This machine is busy, as you can see, but it looks like the VM is trying
to be a bit too aggressive here.

Any ideas?

JE

