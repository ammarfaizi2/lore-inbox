Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVDJLwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVDJLwu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 07:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVDJLwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 07:52:50 -0400
Received: from idmailgate1.unizh.ch ([130.60.68.105]:16474 "EHLO
	idmailgate1.unizh.ch") by vger.kernel.org with ESMTP
	id S261479AbVDJLu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 07:50:27 -0400
Message-ID: <425912FF.3000106@access.unizh.ch>
Date: Sun, 10 Apr 2005 13:50:23 +0200
From: Moritz Gartenmeister <moritz.gartenmeister@access.unizh.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: de-ch, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: trigon3 driver memory leak -> crash
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

it's my first post in this list, so please point me to another source of inspiration if needed.

i'm using a dell poweredge 2650 with four nic (two of them tg3). this server works as transparent 
bridge. (bridge code and netfilter).
currently i am running linux 2.6.11.6.

i observe a steady decrease of free memory and at the same time an increase of active memory 
/proc/meminfo. i stopped almost all services and unloaded most of the iptables-modules. and still 
there was this phenomenon. after a while the server crashes with help of netconsole i was able to 
fetch the latest messages (postet below). there was no unusual traffic or something wired in my 
logfiles. btw, the decrease doesn't not reache the bottom, i.e., there was still some memory free 
befor crash. the server was running perfectly with kernel 2.6.6.

is there an issue with trigon3 network cards?

regards
moritz

here the messages capturated by netcat from netconsole:

NETDEV WATCHDOG: eth2: transmit timed out
tg3: eth2: transmit timed out, resetting
tg3: tg3_stop_block timed out, ofs=2c00 enable_bit=2
tg3: tg3_stop_block timed out, ofs=3400 enable_bit=2
tg3: tg3_stop_block timed out, ofs=2400 enable_bit=2
tg3: tg3_stop_block timed out, ofs=1800 enable_bit=2
tg3: tg3_stop_block timed out, ofs=4800 enable_bit=2
tg3: eth2: Link is down.
br0: port 2(eth2) entering disabled state
tg3: eth2: Link is up at 100 Mbps, half duplex.
tg3: eth2: Flow control is off for TX and off for RX.
br0: port 2(eth2) entering learning state
br0: topology change detected, propagating
br0: port 2(eth2) entering forwarding state
Ebtables v2.0 registered
HTB: quantum of class 10033 is small. Consider r2q change.
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      433920kB (420416kB HighMem)
Active:186580 inactive:1496 dirty:38836 writeback:0 unstable:0 free:108480 slab:218645 mapped:4893 
pagetables:131
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:32kB present:16384kB 
pages_scanned:399 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9808kB min:9820kB low:12272kB high:14728kB active:4kB inactive:108kB present:901120kB 
pages_scanned:14744 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:420416kB min:512kB low:640kB high:768kB active:746316kB inactive:5844kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9808kB
HighMem: 0*4kB 18*8kB 63*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
420416kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 13539 (apache).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      433920kB (420480kB HighMem)
Active:186531 inactive:1495 dirty:38835 writeback:0 unstable:0 free:108480 slab:218665 mapped:4837 
pagetables:125
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:24kB present:16384kB 
pages_scanned:2265 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:0kB inactive:112kB present:901120kB 
pages_scanned:24068 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:420480kB min:512kB low:640kB high:768kB active:746124kB inactive:5844kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 0*4kB 26*8kB 63*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
420480kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 29873 (apache).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      434176kB (420736kB HighMem)
Active:186472 inactive:1489 dirty:38835 writeback:0 unstable:0 free:108544 slab:218665 mapped:4769 
pagetables:119
DMA free:3696kB min:176kB low:220kB high:264kB active:36kB inactive:0kB present:16384kB 
pages_scanned:2276 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:0kB inactive:112kB present:901120kB 
pages_scanned:24068 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:420736kB min:512kB low:640kB high:768kB active:745852kB inactive:5844kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 36*4kB 38*8kB 64*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
420736kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 6467 (apache).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      434432kB (420992kB HighMem)
Active:186395 inactive:1498 dirty:38835 writeback:0 unstable:0 free:108608 slab:218665 mapped:4701 
pagetables:113
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:36kB present:16384kB 
pages_scanned:2285 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:0kB inactive:112kB present:901120kB 
pages_scanned:24068 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:420992kB min:512kB low:640kB high:768kB active:745580kB inactive:5844kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 84*4kB 46*8kB 64*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
420992kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 6468 (apache).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      434688kB (421248kB HighMem)
Active:186327 inactive:1498 dirty:38835 writeback:0 unstable:0 free:108672 slab:218665 mapped:4633 
pagetables:107
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:36kB present:16384kB 
pages_scanned:2285 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:0kB inactive:112kB present:901120kB 
pages_scanned:24068 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:421248kB min:512kB low:640kB high:768kB active:745308kB inactive:5844kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 134*4kB 53*8kB 64*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
421248kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 6478 (apache).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      434688kB (421248kB HighMem)
Active:186329 inactive:1470 dirty:38835 writeback:0 unstable:0 free:108672 slab:218665 mapped:4607 
pagetables:101
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:36kB present:16384kB 
pages_scanned:2285 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:112kB inactive:0kB present:901120kB 
pages_scanned:24098 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:421248kB min:512kB low:640kB high:768kB active:745204kB inactive:5844kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 134*4kB 53*8kB 64*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
421248kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 6479 (apache).
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      434688kB (421248kB HighMem)
Active:186329 inactive:1470 dirty:38835 writeback:0 unstable:0 free:108672 slab:218665 mapped:4607 
pagetables:101
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:36kB present:16384kB 
pages_scanned:2285 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:112kB inactive:0kB present:901120kB 
pages_scanned:24098 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:421248kB min:512kB low:640kB high:768kB active:745204kB inactive:5844kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 134*4kB 53*8kB 64*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
421248kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 6479 (apache).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
oom-killer: gfp_mask=0xd0
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      434816kB (421376kB HighMem)
Active:186275 inactive:1498 dirty:38835 writeback:0 unstable:0 free:108704 slab:218666 mapped:4581 
pagetables:95
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:36kB present:16384kB 
pages_scanned:2285 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:0kB inactive:112kB present:901120kB 
pages_scanned:24126 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:421376kB min:512kB low:640kB high:768kB active:745100kB inactive:5844kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 158*4kB 57*8kB 64*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
421376kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 10546 (apache).
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      435200kB (421760kB HighMem)
Active:186198 inactive:1490 dirty:38835 writeback:0 unstable:0 free:108800 slab:218666 mapped:4488 
pagetables:89
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:36kB present:16384kB 
pages_scanned:2305 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:0kB inactive:112kB present:901120kB 
pages_scanned:24126 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:421760kB min:512kB low:640kB high:768kB active:744792kB inactive:5812kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 206*4kB 81*8kB 64*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
421760kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
oom-killer: gfp_mask=0xd0
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      435200kB (421760kB HighMem)
Active:186198 inactive:1490 dirty:38835 writeback:0 unstable:0 free:108800 slab:218666 mapped:4488 
pagetables:89
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:36kB present:16384kB 
pages_scanned:2305 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:0kB inactive:112kB present:901120kB 
pages_scanned:24126 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:421760kB min:512kB low:640kB high:768kB active:744792kB inactive:5812kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 206*4kB 81*8kB 64*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
421760kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 10679 (apache).
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      435520kB (422080kB HighMem)
Active:186119 inactive:1490 dirty:38835 writeback:0 unstable:0 free:108880 slab:218667 mapped:4341 
pagetables:83
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:36kB present:16384kB 
pages_scanned:2305 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:0kB inactive:112kB present:901120kB 
pages_scanned:24126 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:422080kB min:512kB low:640kB high:768kB active:744476kB inactive:5812kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 254*4kB 87*8kB 69*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
422080kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
oom-killer: gfp_mask=0xd0
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1

Free pages:      435520kB (422080kB HighMem)
Active:186147 inactive:1462 dirty:38835 writeback:0 unstable:0 free:108880 slab:218667 mapped:4341 
pagetables:83
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:36kB present:16384kB 
pages_scanned:2305 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:112kB inactive:0kB present:901120kB 
pages_scanned:24156 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:422080kB min:512kB low:640kB high:768kB active:744476kB inactive:5812kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
254*4kB 87*8kB 69*16kB 6*32kB 4*64kB 2*128kB Normal per-cpu:
1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 422080kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 22754 (sh).
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      435520kB (422080kB HighMem)
Active:186147 inactive:1462 dirty:38835 writeback:0 unstable:0 free:108880 slab:218667 mapped:4341 
pagetables:83
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:36kB present:16384kB 
pages_scanned:2305 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:112kB inactive:0kB present:901120kB 
pages_scanned:24156 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:422080kB min:512kB low:640kB high:768kB active:744476kB inactive:5812kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 254*4kB 87*8kB 69*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
422080kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 22754 (sh).
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16

Free pages:      435520kB (422080kB HighMem)
Active:186147 inactive:1462 dirty:38835 writeback:0 unstable:0 free:108880 slab:218673 mapped:4341 
pagetables:83
DMA free:3696kB min:176kB low:220kB high:264kB active:0kB inactive:36kB present:16384kB 
pages_scanned:2305 all_unreclaimable? yes
lowmem_reserve[]: 0 880 2031
Normal free:9744kB min:9820kB low:12272kB high:14728kB active:112kB inactive:0kB present:901120kB 
pages_scanned:24156 all_unreclaimable? yes
lowmem_reserve[]: 0 0 9215
HighMem free:422080kB min:512kB low:640kB high:768kB active:744476kB inactive:5812kB 
present:1179520kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3696kB
Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 9744kB
HighMem: 254*4kB 87*8kB 69*16kB 6*32kB 4*64kB 2*128kB 1*256kB 1*512kB 2*1024kB 21*2048kB 91*4096kB = 
422080kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 979924kB
Total swap = 979924kB
Out of Memory: Killed process 22754 (sh).
swapper: page allocation failure. order:0, mode:0x20
  [<c0139923>] __alloc_pages+0x2b3/0x420
  [<c013c861>] kmem_getpages+0x31/0xa0
  [<c013d5de>] cache_grow+0xae/0x160
  [<c013d80f>] cache_alloc_refill+0x17f/0x230
  [<c013db8a>] __kmalloc+0x8a/0xa0
  [<c02e99b7>] alloc_skb+0x47/0xf0
  [<c02398dc>] tg3_alloc_rx_skb+0x7c/0x130
  [<c0239efc>] tg3_rx+0x3ac/0x420
  [<c0239ffe>] tg3_poll+0x8e/0x130
  [<c02f0661>] net_rx_action+0x81/0x100
  [<c011cf95>] __do_softirq+0xb5/0xd0
  [<c011cfe1>] do_softirq+0x31/0x40
  [<c011d0cb>] irq_exit+0x3b/0x40
  [<c0104d98>] do_IRQ+0x28/0x40
  [<c010326e>] common_interrupt+0x1a/0x20
  [<c01006d3>] default_idle+0x23/0x30
  [<c010077f>] cpu_idle+0x5f/0x70
  [<c043898d>] start_kernel+0x15d/0x180
  [<c0438390>] unknown_bootoption+0x0/0x1e0
swapper: page allocation failure. order:0, mode:0x20
  [<c0139923>] __alloc_pages+0x2b3/0x420
  [<c013c861>] kmem_getpages+0x31/0xa0
  [<c013d5de>] cache_grow+0xae/0x160
  [<c013d80f>] cache_alloc_refill+0x17f/0x230
  [<c013db8a>] __kmalloc+0x8a/0xa0
  [<c02e99b7>] alloc_skb+0x47/0xf0
  [<c02398dc>] tg3_alloc_rx_skb+0x7c/0x130
  [<c0239efc>] tg3_rx+0x3ac/0x420
  [<c0239ffe>] tg3_poll+0x8e/0x130
  [<c02f0661>] net_rx_action+0x81/0x100
  [<c011cf95>] __do_softirq+0xb5/0xd0
  [<c011cfe1>] do_softirq+0x31/0x40
  [<c011d0cb>] irq_exit+0x3b/0x40
  [<c0104d98>] do_IRQ+0x28/0x40
  [<c010326e>]<4>swapper: page allocation failure. order:0, mode:0x20
  [<c0139923>] __alloc_pages+0x2b3/0x420
  [<c013c861>] kmem_getpages+0x31/0xa0
  [<c01181b7>] printk+0x17/0x20
  [<c013d5de>] cache_grow+0xae/0x160
  [<c013d80f>] cache_alloc_refill+0x17f/0x230
  [<c013db8a>] __kmalloc+0x8a/0xa0
  [<c02e99b7>] alloc_skb+0x47/0xf0
  [<c02fc0d2>] find_skb+0x32/0xa0
  [<c02fc231>] netpoll_send_udp+0x41/0x260
  [<f89b1040>] write_msg+0x40/0x50 [netconsole]
  [<c0117ee2>] __call_console_drivers+0x62/0x70
  [<c0117ff0>] call_console_drivers+0x70/0x130
  [<c0118401>] release_console_sem+0x51/0xc0
  [<c01182e0>] vprintk+0x120/0x170
  [<c010326e>] common_interrupt+0x1a/0x20
  [<c01181b7>] printk+0x17/0x20
  [<c010364f>] show_trace+0x4f/0x90
  [<c010326e>] common_interrupt+0x1a/0x20
  [<c010374c>] dump_stack+0x1c/0x20
  [<c0139923>] __alloc_pages+0x2b3/0x420
  [<c013c861>] kmem_getpages+0x31/0xa0
  [<c013d5de>] cache_grow+0xae/0x160
  [<c013d80f>] cache_alloc_refill+0x17f/0x230
  [<c013db8a>] __kmalloc+0x8a/0xa0
  [<c02e99b7>] alloc_skb+0x47/0xf0
  [<c02398dc>] tg3_alloc_rx_skb+0x7c/0x130
  [<c0239efc>] tg3_rx+0x3ac/0x420
  [<c0239ffe>] tg3_poll+0x8e/0x130
  [<c02f0661>] net_rx_action+0x81/0x100
  [<c011cf95>] __do_softirq+0xb5/0xd0
