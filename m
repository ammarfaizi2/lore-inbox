Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266641AbRHAK7S>; Wed, 1 Aug 2001 06:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRHAK7I>; Wed, 1 Aug 2001 06:59:08 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:55821 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S266641AbRHAK6x>;
	Wed, 1 Aug 2001 06:58:53 -0400
From: Andrew Tridgell <tridge@valinux.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br
In-Reply-To: <Pine.LNX.4.21.0108010504160.9379-100000@freak.distro.conectiva>
	(message from Marcelo Tosatti on Wed, 1 Aug 2001 05:13:52 -0300 (BRT))
Subject: Re: 2.4.8preX VM problems
Reply-To: tridge@valinux.com
In-Reply-To: <Pine.LNX.4.21.0108010504160.9379-100000@freak.distro.conectiva>
Message-Id: <20010801105419.8F078424A@lists.samba.org>
Date: Wed,  1 Aug 2001 03:54:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

> The following patch sets the zone free target to freepages.high. Can you
> test it ? (I tried here and got the expected results)

Running just that patch against 2.4.8pre3 gives:

[root@fraud /root]# ~/readfiles /dev/ddisk 
198 MB    198.084 MB/sec
386 MB    188.634 MB/sec
570 MB    183.827 MB/sec
743 MB    172.5 MB/sec
810 MB    67.0501 MB/sec
862 MB    52.1381 MB/sec
901 MB    37.9501 MB/sec
957 MB    55.8253 MB/sec
998 MB    41.1541 MB/sec
1046 MB    48.1661 MB/sec
1088 MB    40.3898 MB/sec
1140 MB    50.8782 MB/sec
1183 MB    42.5749 MB/sec
1229 MB    46.1378 MB/sec
1275 MB    44.8515 MB/sec
1319 MB    43.5389 MB/sec
1368 MB    47.5747 MB/sec
1411 MB    42.8134 MB/sec


which is much better, but is pretty poor performance for a null
device.

Running with that latest patch plus the patch you sent previously
gives roughly the same result. Also, kswapd chews lots of cpu during
these runs:

CPU0 states:  0.0% user, 79.0% system,  0.0% nice, 20.4% idle
CPU1 states:  0.2% user, 77.1% system,  0.0% nice, 22.1% idle
Mem:  2059088K av,  892256K used, 1166832K free,       0K shrd,  784972K buff
Swap: 1052216K av,       0K used, 1052216K free                   10072K cached

  PID USER     PRI  NI  SIZE  RSS SHARE LC STAT %CPU %MEM   TIME COMMAND
  608 root      19   0   452  452   328  1 R    95.2  0.0   1:23 readfiles
    5 root      14   0     0    0     0  1 SW   58.3  0.0   0:52 kswapd
    6 root       9   0     0    0     0  1 RW    2.1  0.0   0:01 kreclaimd

