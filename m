Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRIZHbq>; Wed, 26 Sep 2001 03:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274864AbRIZHbh>; Wed, 26 Sep 2001 03:31:37 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:20073 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S274862AbRIZHb1> convert rfc822-to-8bit; Wed, 26 Sep 2001 03:31:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: __alloc_pages: 0-order allocation failed
Date: Wed, 26 Sep 2001 09:29:23 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Paul Larson <plars@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        =?iso-8859-1?q?Jacek=5Biso-8859-2=5DPop=B3awski?= 
	<jpopl@interia.pl>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1001319223.4613.34.camel@plars.austin.ibm.com> <E15m1a6-0000K1-00@mrvdom00.schlund.de> <20010926014603.S1782@athlon.random>
In-Reply-To: <20010926014603.S1782@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15m99f-0004FL-00@mrvdom03.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ok, this sounds like a normal oom condition but of course I assume it
> isn't. Can you show a `vmstat 1` during the oom kill + some
> /proc/meminfo? thanks for the great feedback!

As the VM sometimes killed me some long lasting root processes, like klogd, I 
think it is not the normal oom behaviour........ :-)

vmstat: 

   procs                      memory    swap          io     system         
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy id
 0  0  0      0 457824   8476  28856   0   0   225   140  156   163   4  51 45
 0  0  0      0 457440   8476  28860   0   0     0   280  143   103   1  52 47
 0  0  0      0 457440   8476  28860   0   0     0     0  101    70   1  60 39
 0  0  0      0 457440   8476  28860   0   0     0     0  109    86   1  56 43
 0  0  0      0 457436   8476  28864   0   0     0     0  102    73   1  59 40
 0  0  1      0 457436   8476  28864   0   0     0     0  101    70   1  58 41
 0  0  0      0 457436   8476  28864   0   0     0   236  130    88   0  59 41
 0  0  0      0 457436   8476  28864   0   0     0     0  101    69   1  60 39
 0  0  0      0 457436   8476  28864   0   0     0     0  101    71   1  60 39
 0  0  0      0 457436   8476  28864   0   0     0     0  101    71   0  60 40
 1  0  0      0 168236   8476  28928   0   0    64     0  117    79  11  72 17
 1  2  0      0 496532    236   1660   0   0  2948   252  415   303   5  75 20
 0  0  0      0 495568    408   2364   0   0   708     0  184   206   1  26 73
 0  0  1      0 495532    412   2396   0   0    36     0  105    78   1  59 40
 0  0  0      0 495528    416   2396   0   0     0     0  106    81   1  60 39
 0  0  0      0 495376    560   2396   0   0     0   272  139   103   1  56 43
 0  0  0      0 495376    560   2396   0   0     0     0  104    78   1  60 39

meminfo: (a made a looping bash script with sleep 1 after a cat 
/proc/meminfo. But During the kill there is a 3 second gap)
Mit Sep 26 09:14:58 CEST 2001

        total:    used:    free:  shared: buffers:  cached:
Mem:  526491648 58064896 468426752        0  8679424 29556736
Swap:        0        0        0
MemTotal:       514152 kB
MemFree:        457448 kB
MemShared:           0 kB
Buffers:          8476 kB
Cached:          28864 kB
SwapCached:          0 kB
Active:          19084 kB
Inactive:        18256 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514152 kB
LowFree:        457448 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Mit Sep 26 09:14:59 CEST 2001
        total:    used:    free:  shared: buffers:  cached:
Mem:  526491648 162996224 363495424        0  8679424 29622272
Swap:        0        0        0
MemTotal:       514152 kB
MemFree:        354976 kB
MemShared:           0 kB
Buffers:          8476 kB
Cached:          28928 kB
SwapCached:          0 kB
Active:          19112 kB
Inactive:        18292 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514152 kB
LowFree:        354976 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Mit Sep 26 09:15:02 CEST 2001
        total:    used:    free:  shared: buffers:  cached:
Mem:  526491648 18993152 507498496        0   409600  2408448
Swap:        0        0        0
MemTotal:       514152 kB
MemFree:        495604 kB
MemShared:           0 kB
Buffers:           400 kB
Cached:           2352 kB
SwapCached:          0 kB
Active:           1388 kB
Inactive:         1364 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514152 kB
LowFree:        495604 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Mit Sep 26 09:15:03 CEST 2001
        total:    used:    free:  shared: buffers:  cached:
Mem:  526491648 19054592 507437056        0   421888  2453504
Swap:        0        0        0
MemTotal:       514152 kB
MemFree:        495544 kB
MemShared:           0 kB
Buffers:           412 kB
Cached:           2396 kB
SwapCached:          0 kB
Active:           1496 kB
Inactive:         1312 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514152 kB
LowFree:        495544 kB
SwapTotal:           0 kB
SwapFree:            0 kB
