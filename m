Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVIUTqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVIUTqu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVIUTqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:46:50 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:41973 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932130AbVIUTqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:46:49 -0400
Message-ID: <4331B89B.3080107@nortel.com>
Date: Wed, 21 Sep 2005 13:46:35 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com>
In-Reply-To: <43318FFA.4010706@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 19:46:43.0499 (UTC) FILETIME=[315E77B0:01C5BEE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just for kicks I tried with 2.6.14-rc2, and got the same behaviour. 
/proc/slabinfo gives the following two high-runners within a second of 
the oom-killer running:

dentry_cache      3894397 3894961    136   29    1 : tunables  120   60 
    0 : slabdata 134307 134309      0
filp              1216820 1216980    192   20    1 : tunables  120   60 
    0 : slabdata  60844  60849      0


The oom killer gave the following output:


oom-killer: gfp_mask=0xd0, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:92
cpu 0 cold: low 0, high 62, batch 31 used:0
HighMem per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:161
cpu 0 cold: low 0, high 62, batch 31 used:19
Free pages:     2486564kB (2479256kB HighMem)
Active:2064 inactive:392 dirty:2 writeback:0 unstable:0 free:621641 
slab:216703 mapped:1715 pagetables:91
DMA free:3588kB min:68kB low:84kB high:100kB active:0kB inactive:0kB 
present:16384kB pages_scanned:18 all_unreclaimable? yes
lowmem_reserve[]: 0 880 4080
Normal free:3720kB min:3756kB low:4692kB high:5632kB active:0kB 
inactive:0kB present:901120kB pages_scanned:18 all_unreclaimable? yes
lowmem_reserve[]: 0 0 25600
HighMem free:2479256kB min:512kB low:640kB high:768kB active:8256kB 
inactive:1568kB present:3276800kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 
1*2048kB 0*4096kB = 3588kB
Normal: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 
1*1024kB 1*2048kB 0*4096kB = 3720kB
HighMem: 270*4kB 156*8kB 108*16kB 92*32kB 61*64kB 28*128kB 4*256kB 
0*512kB 0*1024kB 1*2048kB 601*4096kB = 2479256kB
Free swap:            0kB
1048576 pages of RAM
819200 pages of HIGHMEM
205960 reserved pages
4543 pages shared
0 pages swap cached
2 pages dirty
0 pages writeback
1715 pages mapped
216546 pages slab
91 pages pagetables
Out of Memory: Killed process 444 (portmap).
oom-killer: gfp_mask=0xd0, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:92
cpu 0 cold: low 0, high 62, batch 31 used:0
HighMem per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:182
cpu 0 cold: low 0, high 62, batch 31 used:19
Free pages:     2486564kB (2479256kB HighMem)
Active:2043 inactive:392 dirty:7 writeback:0 unstable:0 free:621641 
slab:216707 mapped:1681 pagetables:88
DMA free:3588kB min:68kB low:84kB high:100kB active:0kB inactive:0kB 
present:16384kB pages_scanned:34 all_unreclaimable? yes
lowmem_reserve[]: 0 880 4080
Normal free:3720kB min:3756kB low:4692kB high:5632kB active:0kB 
inactive:0kB present:901120kB pages_scanned:16 all_unreclaimable? yes
lowmem_reserve[]: 0 0 25600
HighMem free:2479256kB min:512kB low:640kB high:768kB active:8172kB 
inactive:1568kB present:3276800kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 
1*2048kB 0*4096kB = 3588kB
Normal: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 
1*1024kB 1*2048kB 0*4096kB = 3720kB
HighMem: 270*4kB 156*8kB 108*16kB 92*32kB 61*64kB 28*128kB 4*256kB 
0*512kB 0*1024kB 1*2048kB 601*4096kB = 2479256kB
Free swap:            0kB
1048576 pages of RAM
819200 pages of HIGHMEM
205960 reserved pages
4479 pages shared
0 pages swap cached
7 pages dirty
0 pages writeback
1681 pages mapped
216521 pages slab
88 pages pagetables
Out of Memory: Killed process 803 (sshd).


Chris
