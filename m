Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289383AbSAODPB>; Mon, 14 Jan 2002 22:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289376AbSAODOm>; Mon, 14 Jan 2002 22:14:42 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:29748 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S289380AbSAODO3>; Mon, 14 Jan 2002 22:14:29 -0500
Message-ID: <3C439E6D.B2B8C5B8@m3its.de>
Date: Tue, 15 Jan 2002 04:13:49 +0100
From: Klaus Meyer <k.meyer@m3its.de>
Organization: m3ITS
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: highmem=system killer, 2.2.17=performance killer ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, i'm a little bit confused now after reading all comments in this
list since
the release of kernel 2.4.17 (without patch) concerning problems in vm +
swap.

Perhaps somebody with more kernel experience can give a hint to clarify
the situation.

i've got serious problems using 2.4.x kernels using highmem support.
It seems to me that i'm not the only one, but the difference to most
other ones is,
that i can't use highmem because the system performance is terrible
slow.

the testbed:
1) Asus CUR-DLS (Server Set LE III) with two 1Ghz Pentiums, 2GB of ram
Suse 7.3, Redhat
   7.2  Kernel 2.4.7, 2.4.16, official 2.4.17 i(without patch) in
different versions
   (smp,no_smp,4GB,64GB highmem support)
2) Asus A7V 900 Mhz Athlon, 256 MB of RAM   Suse 7.0, Kernel 2.2.16
2x DGE-500SX (Gigabit Ethernet)

my test: copy 2.6 GB of data from machine b) to machine a) via rcp or
nfs
using the gigabit ethernet network

a) using redhat 7.2 with kernel 2.4.7 on machine 1)
   the copy process runs fine until 1.4 GB are cached (30 MB/s)
   after that the performance is degraded to unusability of the system
   (very high load, network throuput < 100k/s)
b) using Suse 7.3 with kernel 2.4.16 on machine 1)
   booting into runlevel 3 is a pain, loading modules become very slow
   after starting the copy process the load of the machine a) will
   raise and raise and raise ... here a snapshot of top as long as it
was possible to get one:

-----------------------------------------------------------------------------
  9:17pm  up 28 min,  2 users,  load average: 1.42, 0.36,
0.12                                                                     
36 processes: 31 sleeping, 5 running, 0 zombie, 0 stopped
CPU0 states:  1.2% user, 100.3% system,  0.0% nice, -1.-5% idle
CPU1 states:  5.2% user, 145.0% system,  0.0% nice, -50.-3% idle
Mem:  2061536K av,  410072K used, 1651464K free,       0K shrd,   20964K
buff
Swap:  136512K av,       0K used,  136512K free                  359084K
cached
-----------------------------------------------------------------------------

  i didnt know that it seems to be possible to get a negative idle value
???

c) using Suse 7.3 with kernel 2.4.17 in all configurations (smp,no_smp,
4,64 GB highmem support on machine 1)
   the same as in b)


I just want to state that there were no oops, so the system were always
running but
inacceptable slow, eg starting xosview leads to a relativly high load:
-----------------------------------------------------------------------------
  4:34am  up 17 min,  1 user,  load average: 0.16, 0.23, 0.26
35 processes: 33 sleeping, 1 running, 1 zombie, 0 stopped
CPU0 states: 23.0% user,  5.0% system,  0.0% nice, 70.1% idle
CPU1 states: 13.0% user,  6.0% system,  0.0% nice, 79.1% idle
Mem:  2061656K av,   37676K used, 2023980K free,       0K shrd,    7628K
buff
Swap:  136512K av,       0K used,  136512K free                   11876K
cached
 
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  755 root      11   0  1484 1484  1176 S    21.8  0.0   0:21
xosview.bin                                                           
-----------------------------------------------------------------------------




Then i shrinked the available memory to 1024M using the mem= boot
parameter.
The result was amazing:

the above mentioned configurations lead to the following details:
all configuration a) b) c) were running flawless without any performance
losses.

the network throughput of configuration a) and b) was constantly at
above 30MB/s, but
using kernel 2.4.17 (configuration c) degrades the network throughput to
15 MB/s.

all in all there are two questions left:
a) what can i do to use highmem support (which patches do i have to
apply ?)
b) Does have other users made experiences with network performance
degration using 2.2.17
   instead of 2.2.16 ?


Any hints ?

thanx in advance
		
	Klaus
