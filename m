Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbRGIUUj>; Mon, 9 Jul 2001 16:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbRGIUU3>; Mon, 9 Jul 2001 16:20:29 -0400
Received: from sciurus.rentec.com ([192.5.35.161]:61096 "EHLO
	sciurus.rentec.com") by vger.kernel.org with ESMTP
	id <S264872AbRGIUUO>; Mon, 9 Jul 2001 16:20:14 -0400
Date: Mon, 9 Jul 2001 16:20:21 -0400 (EDT)
From: Dirk Wetter <dirkw@rentec.com>
To: <linux-kernel@vger.kernel.org>
Subject: dead mem pages -> dead machines
Message-ID: <Pine.LNX.4.33.0107091540220.12902-100000@monster000.rentec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

we have a growing cluster of ia32 SMP machines, each of them with 4GB
physical memory.  the problem we observe with 2.4.5 as well as 2.4.6
is that once we start running simulations on those machines they
become after a short while quite unusable. this is the picture
of a machine, freshly rebooted after the app ran for 30 minutes
or so:

machine018:~ # top -b | head -28
  3:27pm  up  4:02,  2 users,  load average: 2.08, 3.88, 3.05
60 processes: 55 sleeping, 3 running, 2 zombie, 0 stopped
CPU0 states: 89.0% user,  9.0% system, 89.0% nice,  0.1% idle
CPU1 states: 97.0% user,  1.0% system, 97.0% nice,  0.1% idle
Mem:  4058128K av, 4050816K used,    7312K free,       0K shrd,    3152K buff
Swap: 14337736K av, 3380176K used, 10957560K free                 2876028K cached

  PID  PPID USER     PRI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMA
 3759  3684 userid    15 2105M 1.1G 928M  254M  0M R N  94.4 23.4  10:57 ceqsim
 3498  3425 userid    16 2189M 1.5G 609M  205M  0M R N  91.7 15.3  22:12 ceqsim
 4126   819 root      16  1044    0 1044   820  55 R     9.8  0.0   0:00 top
    1     0 root       8    76   12   64    64   4 S     0.0  0.0   0:00 init
    2     1 root       8     0    0    0     0   0 SW    0.0  0.0   0:00 kevent
    3     1 root       9     0    0    0     0   0 SW    0.0  0.0   2:42 kswapd
    4     1 root       9     0    0    0     0   0 SW    0.0  0.0   0:00 krecla
    5     1 root       9     0    0    0     0   0 SW    0.0  0.0   0:00 bdflus
    6     1 root       9     0    0    0     0   0 SW    0.0  0.0   0:03 kupdat
    7     1 root       9     0    0    0     0   0 SW    0.0  0.0   0:00 scsi_e
    8     1 root       9     0    0    0     0   0 SW    0.0  0.0   0:00 scsi_e
   41     1 root       9     0    0    0     0   0 SW    0.0  0.0   0:01 kreise


machine018:~ # cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  4155523072 4148527104  6995968        0  3227648 2940301312
Swap: 1796939776 3461300224 2630606848
MemTotal:      4058128 kB
MemFree:          6832 kB
MemShared:           0 kB
Buffers:          3152 kB
Cached:        2871388 kB
Active:        1936040 kB
Inact_dirty:    499780 kB
Inact_clean:    438720 kB
Inact_target:     3080 kB
HighTotal:     3211200 kB
HighFree:         3988 kB
LowTotal:       846928 kB
LowFree:          2844 kB
SwapTotal:    14337736 kB
SwapFree:     10957560 kB


machine018:~ # cat /proc/swaps
Filename                        Type            Size    Used    Priority
/dev/sda5                       partition       2048248 2048248 -1
/dev/sdb1                       partition       2048248 1331928 -2
/dev/sdc1                       partition       2048248 0       -3
[..]

why does the kernel have 2.8GB of cached pages, and our applications
have to swap 1.5+1.1GB of pages out? also, i do not understand why
the amount of inactive pages is so high. i don't have good statistics
on that, but my impression is that the amount of Inact_dirty pages
increases as longer as the application runs.

not to mention, that the moment the machine is swapping pages out
in the order of gigabytes, the console even doesn't respond and
network wise it only responds to icmp packets.

i don't know how to collect more information, please let me know what
i can do in order send more info (.config is CONFIG_HIGHMEM4G=y).


thx,
	~dirkw


PS: cc me please since i am not subscribed to the list.

