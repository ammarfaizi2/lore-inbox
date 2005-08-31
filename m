Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVHaS5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVHaS5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 14:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVHaS5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 14:57:13 -0400
Received: from leviathan.ele.uri.edu ([131.128.51.64]:60114 "EHLO
	leviathan.ele.uri.edu") by vger.kernel.org with ESMTP
	id S932466AbVHaS5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 14:57:12 -0400
Subject: Re: Where is the performance bottleneck?
From: Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>, Jens Axboe <axboe@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1125514340.6617.7.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
	 <20050829202529.GA32214@midnight.suse.cz>
	 <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
	 <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de>
	 <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de>
	 <20050831120714.GT4018@suse.de>
	 <Pine.LNX.4.61.0508311339140.16574@diagnostix.dwd.de>
	 <20050831162053.GG4018@suse.de>
	 <Pine.LNX.4.61.0508311648390.16574@diagnostix.dwd.de>
	 <4315F18A.1060709@tls.msk.ru>
	 <1125514340.6617.7.camel@localhost.localdomain>
Content-Type: text/plain
Organization: no-dole-available
Date: Wed, 31 Aug 2005 14:57:00 -0400
Message-Id: <1125514620.6617.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

forgot to attach lspci output.

it is a 133MB PCI-X card but only run at 66MHZ.

quick question, where I can check if it is running at 64bit?

66MHZ * 32Bit /8 * 80% bus utilization ~= 211MB/s then match the upper
speed I meet now...

Ming


02:01.0 SCSI storage controller: Marvell MV88SX5081 8-port SATA I PCI-X
Controller (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128, Cache Line Size 08
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at fa000000 (64-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk+ DSI- D1- D2- AuxCurrent=0mA PME
(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=3
                Status: Bus=2 Dev=1 Func=0 64bit+ 133MHz+ SCD- USC-,
DC=simple, DMMRBC=0, DMOST=3, DMCRS=0, RSCEM-


On Wed, 2005-08-31 at 14:52 -0400, Ming Zhang wrote:
> join the party. ;)
> 
> 8 400GB SATA disk on same Marvel 8 port PCIX-133 card. P4 CPU.
> Supermicro SCT board.
> 
> # cat /proc/mdstat
> Personalities : [linear] [raid0] [raid1] [raid5] [multipath] [raid6]
> [raid10] [faulty]
> md0 : active raid0 sdh[7] sdg[6] sdf[5] sde[4] sdd[3] sdc[2] sdb[1] sda
> [0]
>       3125690368 blocks 64k chunks
> 
> 8 DISK RAID0 from same slot and card. Stripe size is 512KB.
> 
> run oread
> 
> # vmstat 1
> procs -----------memory---------- ---swap-- -----io---- --system-- ----
> cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
> id wa
>  1  1      0 533216 330424  11004    0    0  7128  1610 1069    77  0  2
> 95  3
>  1  0      0 298464 560828  11004    0    0 230404     0 2595  1389  1
> 23  0 76
>  0  1      0  64736 792248  11004    0    0 231420     0 2648  1342  0
> 26  0 74
>  1  0      0   8948 848416   9696    0    0 229376     0 2638  1337  0
> 29  0 71
>  0  0      0 868896    768   9696    0    0 29696    48 1224   162  0 19
> 73  8
> 
> # time ./oread /dev/md0
> 
> real    0m6.595s
> user    0m0.004s
> sys     0m0.151s
> 
> run dd
> 
> # vmstat 1
> procs -----------memory---------- ---swap-- -----io---- --system-- ----
> cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
> id wa
>  2  2      0 854008   2932  17108    0    0  7355  1606 1071    80  0  2
> 95  3
>  0  2      0 848888   3112  21388    0    0 164332     0 2985  3564  2
> 7  0 91
>  0  2      0 844024   3260  25664    0    0 164040     0 2990  3665  1
> 7  0 92
>  0  2      0 840328   3380  28920    0    0 164272     0 2932  3791  1
> 9  0 90
>  0  2      0 836360   3500  32232    0    0 163688   100 3001  5045  2
> 7  0 91
>  0  2      0 831432   3644  36612    0    0 164120   568 2977  3843  0
> 9  0 91
>  0  1      0 826056   3752  41688    0    0  7872     0 1267  1474  1  3
> 0 96
> 
> # time dd if=/dev/md0 of=/dev/null bs=131072 count=8192
> 8192+0 records in
> 8192+0 records out
> 
> real    0m4.771s
> user    0m0.005s
> sys     0m0.973s
> 
> so the reasonable thing here is because of O_DIRECT, the sys time
> reduced a lot.
> 
> but the time is longer! the reason i found is...
> 
> i attached a new oread.c which allow to set block size of each read and
> total read count. so i read full strip once a time,
> 
> # time ./oread /dev/md0 524288 2048
> 
> real    0m4.950s
> user    0m0.000s
> sys     0m0.131s
> 
> compared to 
> 
> # time ./oread /dev/md0 131072 8192
> 
> real    0m6.633s
> user    0m0.002s
> sys     0m0.191s
> 
> 
> but still, I can get linear speed at 4 DISKS, then no speed gain when
> adding more disk into the RAID.
> 
> Ming
> 

