Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbUKQJIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbUKQJIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 04:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbUKQJIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 04:08:37 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:61206 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262239AbUKQJIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 04:08:24 -0500
Message-ID: <419B14F9.7080204@tebibyte.org>
Date: Wed, 17 Nov 2004 10:08:09 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Chris Ross <chris@tebibyte.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrea Arcangeli <andrea@novell.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Nick Piggin <piggin@cyberone.com.au>,
       Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de,
       akpm@osdl.org
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet> <20041114170339.GB13733@dualathlon.random> <20041114202155.GB2764@logos.cnet> <419A2B3A.80702@tebibyte.org>
In-Reply-To: <419A2B3A.80702@tebibyte.org>
Content-Type: multipart/mixed;
 boundary="------------080906070204030209020009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080906070204030209020009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Chris Ross escreveu:
> Marcelo Tosatti escreveu:
>> Chris, can you change the "500*HZ" in mm/vmscan.c balance_pgdat() 
>> function to "1000*HZ" and see what you get, please?
> 
> ... I'll leave it running and see how it goes. The daily cron run is
> a usually a popular time for killing off a few essential daemons
> (ntpd, sshd &c), in fact I think the OOM Killer actually looks
> forward to it :)

As I suspected, like a recalcitrant teenager it was sneakily waiting 
until everyone was out then it threw a wild party with several ooms and 
an oops. See below...

This, obviously is still without Kame's patch, just the same tree as 
before with the one change you asked for.

Regards,
Chris R.

--------------080906070204030209020009
Content-Type: text/plain;
 name="today"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="today"

Nov 17 06:19:30 sleepy oom-killer: gfp_mask=0xd0
Nov 17 06:19:30 sleepy DMA per-cpu:
Nov 17 06:19:30 sleepy cpu 0 hot: low 2, high 6, batch 1
Nov 17 06:19:30 sleepy cpu 0 cold: low 0, high 2, batch 1
Nov 17 06:19:30 sleepy Normal per-cpu:
Nov 17 06:19:30 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 17 06:19:30 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 17 06:19:30 sleepy HighMem per-cpu: empty
Nov 17 06:19:30 sleepy
Nov 17 06:19:30 sleepy Free pages:         236kB (0kB HighMem)
Nov 17 06:19:30 sleepy Active:6386 inactive:6367 dirty:0 writeback:0 unstable:0 free:59 slab:1280 mapped:962 pagetables:96
Nov 17 06:19:30 sleepy DMA free:60kB min:60kB low:120kB high:180kB active:5912kB inactive:5788kB present:16384kB pages_scanned:3131 all_unreclaimable? no
Nov 17 06:19:30 sleepy protections[]: 0 0 0
Nov 17 06:19:30 sleepy Normal free:176kB min:188kB low:376kB high:564kB active:19632kB inactive:19680kB present:49144kB pages_scanned:10289 all_unreclaimable? no
Nov 17 06:19:30 sleepy protections[]: 0 0 0
Nov 17 06:19:30 sleepy HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 17 06:19:30 sleepy protections[]: 0 0 0
Nov 17 06:19:30 sleepy DMA: 4293918323*4kB 4294857582*8kB 4294953437*16kB 4294965767*32kB 4294966994*64kB 4294967193*128kB 4294967265*256kB 4294967275*512kB 4294967290*1024kB 4294967293*2048kB 4294967293*4096kB = 4289547244kB
Nov 17 06:19:30 sleepy Normal: 4291283363*4kB 4294690597*8kB 4294945040*16kB 4294963914*32kB 4294966633*64kB 4294966927*128kB 4294967154*256kB 4294967204*512kB 4294967257*1024kB 4294967281*2048kB 4294967286*4096kB = 4277268916kB
Nov 17 06:19:30 sleepy HighMem: empty
Nov 17 06:19:30 sleepy Swap cache: add 189724, delete 189463, find 44119/68973, race 0+0
Nov 17 06:19:30 sleepy Out of Memory: Killed process 21982 (pickup).
Nov 17 06:19:30 sleepy oom-killer: gfp_mask=0xd0
Nov 17 06:19:30 sleepy DMA per-cpu:
Nov 17 06:19:30 sleepy cpu 0 hot: low 2, high 6, batch 1
Nov 17 06:19:30 sleepy cpu 0 cold: low 0, high 2, batch 1
Nov 17 06:19:30 sleepy Normal per-cpu:
Nov 17 06:19:30 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 17 06:19:30 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 17 06:19:30 sleepy HighMem per-cpu: empty
Nov 17 06:19:30 sleepy 
Nov 17 06:19:30 sleepy Free pages:         244kB (0kB HighMem)
Nov 17 06:19:30 sleepy Active:6366 inactive:6386 dirty:0 writeback:0 unstable:0 free:61 slab:1278 mapped:951 pagetables:92
Nov 17 06:19:30 sleepy DMA free:60kB min:60kB low:120kB high:180kB active:5884kB inactive:5828kB present:16384kB pages_scanned:3237 all_unreclaimable? no
Nov 17 06:19:30 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy Normal free:184kB min:188kB low:376kB high:564kB active:19580kB inactive:19716kB present:49144kB pages_scanned:10810 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy DMA: 4293918298*4kB 4294857581*8kB 4294953437*16kB 4294965767*32kB 4294966994*64kB 4294967193*128kB 4294967265*256kB 4294967275*512kB 4294967290*1024kB 4294967293*2048kB 4294967293*4096kB = 4289547136kB
Nov 17 06:19:31 sleepy Normal: 4291283355*4kB 4294690595*8kB 4294945039*16kB 4294963913*32kB 4294966633*64kB 4294966927*128kB 4294967154*256kB 4294967204*512kB 4294967257*1024kB 4294967281*2048kB 4294967286*4096kB = 4277268820kB
Nov 17 06:19:31 sleepy HighMem: empty
Nov 17 06:19:31 sleepy Swap cache: add 189751, delete 189495, find 44119/68977, race 0+0
Nov 17 06:19:31 sleepy Out of Memory: Killed process 6813 (qmgr).
Nov 17 06:19:31 sleepy oom-killer: gfp_mask=0xd0
Nov 17 06:19:31 sleepy DMA per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 2, high 6, batch 1
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 2, batch 1
Nov 17 06:19:31 sleepy Normal per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 17 06:19:31 sleepy HighMem per-cpu: empty
Nov 17 06:19:31 sleepy 
Nov 17 06:19:31 sleepy Free pages:         244kB (0kB HighMem)
Nov 17 06:19:31 sleepy Active:6495 inactive:6257 dirty:0 writeback:0 unstable:0 free:61 slab:1279 mapped:951 pagetables:92
Nov 17 06:19:31 sleepy DMA free:60kB min:60kB low:120kB high:180kB active:6272kB inactive:5440kB present:16384kB pages_scanned:3922 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy Normal free:184kB min:188kB low:376kB high:564kB active:19708kB inactive:19588kB present:49144kB pages_scanned:12326 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy DMA: 4293918298*4kB 4294857581*8kB 4294953437*16kB 4294965767*32kB 4294966994*64kB 4294967193*128kB 4294967265*256kB 4294967275*512kB 4294967290*1024kB 4294967293*2048kB 4294967293*4096kB = 4289547136kB
Nov 17 06:19:31 sleepy Normal: 4291283355*4kB 4294690595*8kB 4294945039*16kB 4294963913*32kB 4294966633*64kB 4294966927*128kB 4294967154*256kB 4294967204*512kB 4294967257*1024kB 4294967281*2048kB 4294967286*4096kB = 4277268820kB
Nov 17 06:19:31 sleepy HighMem: empty
Nov 17 06:19:31 sleepy Swap cache: add 189751, delete 189495, find 44119/68977, race 0+0
Nov 17 06:19:31 sleepy Out of Memory: Killed process 6473 (distccd).
Nov 17 06:19:31 sleepy oom-killer: gfp_mask=0xd0
Nov 17 06:19:31 sleepy DMA per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 2, high 6, batch 1
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 2, batch 1
Nov 17 06:19:31 sleepy Normal per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 17 06:19:31 sleepy HighMem per-cpu: empty
Nov 17 06:19:31 sleepy 
Nov 17 06:19:31 sleepy Free pages:         244kB (0kB HighMem)
Nov 17 06:19:31 sleepy Active:6423 inactive:6337 dirty:0 writeback:0 unstable:0 free:61 slab:1277 mapped:951 pagetables:88
Nov 17 06:19:31 sleepy DMA free:60kB min:60kB low:120kB high:180kB active:5884kB inactive:5828kB present:16384kB pages_scanned:3191 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy Normal free:184kB min:188kB low:376kB high:564kB active:19808kB inactive:19520kB present:49144kB pages_scanned:10581 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy DMA: 4293918298*4kB 4294857581*8kB 4294953437*16kB 4294965767*32kB 4294966994*64kB 4294967193*128kB 4294967265*256kB 4294967275*512kB 4294967290*1024kB 4294967293*2048kB 4294967293*4096kB = 4289547136kB
Nov 17 06:19:31 sleepy Normal: 4291283353*4kB 4294690595*8kB 4294945039*16kB 4294963913*32kB 4294966633*64kB 4294966927*128kB 4294967154*256kB 4294967204*512kB 4294967257*1024kB 4294967281*2048kB 4294967286*4096kB = 4277268812kB
Nov 17 06:19:31 sleepy HighMem: empty
Nov 17 06:19:31 sleepy Swap cache: add 189751, delete 189495, find 44119/68977, race 0+0
Nov 17 06:19:31 sleepy Out of Memory: Killed process 6474 (distccd).
Nov 17 06:19:31 sleepy oom-killer: gfp_mask=0xd0
Nov 17 06:19:31 sleepy DMA per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 2, high 6, batch 1
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 2, batch 1
Nov 17 06:19:31 sleepy Normal per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 17 06:19:31 sleepy HighMem per-cpu: empty
Nov 17 06:19:31 sleepy 
Nov 17 06:19:31 sleepy Free pages:         244kB (0kB HighMem)
Nov 17 06:19:31 sleepy Active:6488 inactive:6273 dirty:0 writeback:0 unstable:0 free:61 slab:1279 mapped:951 pagetables:84
Nov 17 06:19:31 sleepy DMA free:60kB min:60kB low:120kB high:180kB active:6076kB inactive:5636kB present:16384kB pages_scanned:3727 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy Normal free:184kB min:188kB low:376kB high:564kB active:19876kB inactive:19456kB present:49144kB pages_scanned:12483 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy DMA: 4293918298*4kB 4294857581*8kB 4294953437*16kB 4294965767*32kB 4294966994*64kB 4294967193*128kB 4294967265*256kB 4294967275*512kB 4294967290*1024kB 4294967293*2048kB 4294967293*4096kB = 4289547136kB
Nov 17 06:19:31 sleepy Normal: 4291283351*4kB 4294690595*8kB 4294945039*16kB 4294963913*32kB 4294966633*64kB 4294966927*128kB 4294967154*256kB 4294967204*512kB 4294967257*1024kB 4294967281*2048kB 4294967286*4096kB = 4277268804kB
Nov 17 06:19:31 sleepy HighMem: empty
Nov 17 06:19:31 sleepy Swap cache: add 189751, delete 189495, find 44119/68977, race 0+0
Nov 17 06:19:31 sleepy Out of Memory: Killed process 6598 (distccd).
Nov 17 06:19:31 sleepy oom-killer: gfp_mask=0xd0
Nov 17 06:19:31 sleepy DMA per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 2, high 6, batch 1
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 2, batch 1
Nov 17 06:19:31 sleepy Normal per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 17 06:19:31 sleepy HighMem per-cpu: empty
Nov 17 06:19:31 sleepy 
Nov 17 06:19:31 sleepy Free pages:         244kB (0kB HighMem)
Nov 17 06:19:31 sleepy Active:6334 inactive:6427 dirty:0 writeback:0 unstable:0 free:61 slab:1278 mapped:951 pagetables:80
Nov 17 06:19:31 sleepy DMA free:60kB min:60kB low:120kB high:180kB active:5756kB inactive:5956kB present:16384kB pages_scanned:9099 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy Normal free:184kB min:188kB low:376kB high:564kB active:19580kB inactive:19752kB present:49144kB pages_scanned:30953 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy DMA: 4293918298*4kB 4294857581*8kB 4294953437*16kB 4294965767*32kB 4294966994*64kB 4294967193*128kB 4294967265*256kB 4294967275*512kB 4294967290*1024kB 4294967293*2048kB 4294967293*4096kB = 4289547136kB
Nov 17 06:19:31 sleepy Normal: 4291283351*4kB 4294690595*8kB 4294945039*16kB 4294963913*32kB 4294966633*64kB 4294966927*128kB 4294967154*256kB 4294967204*512kB 4294967257*1024kB 4294967281*2048kB 4294967286*4096kB = 4277268804kB
Nov 17 06:19:31 sleepy HighMem: empty
Nov 17 06:19:31 sleepy Swap cache: add 189751, delete 189495, find 44119/68977, race 0+0
Nov 17 06:19:31 sleepy Out of Memory: Killed process 6703 (distccd).
Nov 17 06:19:31 sleepy oom-killer: gfp_mask=0xd0
Nov 17 06:19:31 sleepy DMA per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 2, high 6, batch 1
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 2, batch 1
Nov 17 06:19:31 sleepy Normal per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 17 06:19:31 sleepy HighMem per-cpu: empty
Nov 17 06:19:31 sleepy 
Nov 17 06:19:31 sleepy Free pages:         228kB (0kB HighMem)
Nov 17 06:19:31 sleepy Active:6506 inactive:6263 dirty:0 writeback:0 unstable:0 free:57 slab:1272 mapped:951 pagetables:76
Nov 17 06:19:31 sleepy DMA free:60kB min:60kB low:120kB high:180kB active:6236kB inactive:5476kB present:16384kB pages_scanned:3925 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy Normal free:168kB min:188kB low:376kB high:564kB active:19788kB inactive:19576kB present:49144kB pages_scanned:13009 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy DMA: 4293918298*4kB 4294857581*8kB 4294953437*16kB 4294965767*32kB 4294966994*64kB 4294967193*128kB 4294967265*256kB 4294967275*512kB 4294967290*1024kB 4294967293*2048kB 4294967293*4096kB = 4289547136kB
Nov 17 06:19:31 sleepy Normal: 4291283343*4kB 4294690596*8kB 4294945038*16kB 4294963913*32kB 4294966633*64kB 4294966927*128kB 4294967154*256kB 4294967204*512kB 4294967257*1024kB 4294967281*2048kB 4294967286*4096kB = 4277268764kB
Nov 17 06:19:31 sleepy HighMem: empty
Nov 17 06:19:31 sleepy Swap cache: add 189759, delete 189503, find 44120/68980, race 0+0
Nov 17 06:19:31 sleepy Out of Memory: Killed process 6688 (ntpd).
Nov 17 06:19:31 sleepy oom-killer: gfp_mask=0xd0
Nov 17 06:19:31 sleepy DMA per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 2, high 6, batch 1
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 2, batch 1
Nov 17 06:19:31 sleepy Normal per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 17 06:19:31 sleepy HighMem per-cpu: empty
Nov 17 06:19:31 sleepy 
Nov 17 06:19:31 sleepy Free pages:         228kB (0kB HighMem)
Nov 17 06:19:31 sleepy Active:6448 inactive:6321 dirty:0 writeback:0 unstable:0 free:57 slab:1274 mapped:951 pagetables:76
Nov 17 06:19:31 sleepy DMA free:60kB min:60kB low:120kB high:180kB active:5884kB inactive:5828kB present:16384kB pages_scanned:5865 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy Normal free:168kB min:188kB low:376kB high:564kB active:19908kB inactive:19456kB present:49144kB pages_scanned:20131 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy DMA: 4293918298*4kB 4294857581*8kB 4294953437*16kB 4294965767*32kB 4294966994*64kB 4294967193*128kB 4294967265*256kB 4294967275*512kB 4294967290*1024kB 4294967293*2048kB 4294967293*4096kB = 4289547136kB
Nov 17 06:19:31 sleepy Normal: 4291283343*4kB 4294690596*8kB 4294945038*16kB 4294963913*32kB 4294966633*64kB 4294966927*128kB 4294967154*256kB 4294967204*512kB 4294967257*1024kB 4294967281*2048kB 4294967286*4096kB = 4277268764kB
Nov 17 06:19:31 sleepy HighMem: empty
Nov 17 06:19:31 sleepy Swap cache: add 189759, delete 189503, find 44120/68980, race 0+0
Nov 17 06:19:31 sleepy Out of Memory: Killed process 22018 (sh).
Nov 17 06:19:31 sleepy oom-killer: gfp_mask=0xd0
Nov 17 06:19:31 sleepy DMA per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 2, high 6, batch 1
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 2, batch 1
Nov 17 06:19:31 sleepy Normal per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 17 06:19:31 sleepy HighMem per-cpu: empty
Nov 17 06:19:31 sleepy 
Nov 17 06:19:31 sleepy Free pages:         244kB (0kB HighMem)
Nov 17 06:19:31 sleepy Active:6516 inactive:6253 dirty:0 writeback:0 unstable:0 free:61 slab:1272 mapped:951 pagetables:72
Nov 17 06:19:31 sleepy DMA free:60kB min:60kB low:120kB high:180kB active:6036kB inactive:5676kB present:16384kB pages_scanned:3228 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy Normal free:184kB min:188kB low:376kB high:564kB active:20028kB inactive:19336kB present:49144kB pages_scanned:11010 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy DMA: 4293918298*4kB 4294857581*8kB 4294953437*16kB 4294965767*32kB 4294966994*64kB 4294967193*128kB 4294967265*256kB 4294967275*512kB 4294967290*1024kB 4294967293*2048kB 4294967293*4096kB = 4289547136kB
Nov 17 06:19:31 sleepy Normal: 4291283342*4kB 4294690595*8kB 4294945038*16kB 4294963913*32kB 4294966633*64kB 4294966927*128kB 4294967154*256kB 4294967204*512kB 4294967257*1024kB 4294967281*2048kB 4294967286*4096kB = 4277268752kB
Nov 17 06:19:31 sleepy HighMem: empty
Nov 17 06:19:31 sleepy Swap cache: add 189759, delete 189503, find 44120/68980, race 0+0
Nov 17 06:19:31 sleepy Out of Memory: Killed process 22019 (run-crons).
Nov 17 06:19:31 sleepy oom-killer: gfp_mask=0xd0
Nov 17 06:19:31 sleepy DMA per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 2, high 6, batch 1
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 2, batch 1
Nov 17 06:19:31 sleepy Normal per-cpu:
Nov 17 06:19:31 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 17 06:19:31 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 17 06:19:31 sleepy HighMem per-cpu: empty
Nov 17 06:19:31 sleepy 
Nov 17 06:19:31 sleepy Free pages:         172kB (0kB HighMem)
Nov 17 06:19:31 sleepy Active:6515 inactive:6271 dirty:0 writeback:0 unstable:0 free:43 slab:1273 mapped:966 pagetables:72
Nov 17 06:19:31 sleepy DMA free:44kB min:60kB low:120kB high:180kB active:6168kB inactive:5552kB present:16384kB pages_scanned:14058 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy Normal free:128kB min:188kB low:376kB high:564kB active:19892kB inactive:19532kB present:49144kB pages_scanned:48284 all_unreclaimable? yes
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 17 06:19:31 sleepy protections[]: 0 0 0
Nov 17 06:19:31 sleepy DMA: 4293918298*4kB 4294857580*8kB 4294953436*16kB 4294965767*32kB 4294966994*64kB 4294967193*128kB 4294967265*256kB 4294967275*512kB 4294967290*1024kB 4294967293*2048kB 4294967293*4096kB = 4289547112kB
Nov 17 06:19:31 sleepy Normal: 4291283261*4kB 4294690580*8kB 4294945031*16kB 4294963911*32kB 4294966633*64kB 4294966926*128kB 4294967154*256kB 4294967204*512kB 4294967257*1024kB 4294967281*2048kB 4294967286*4096kB = 4277268004kB
Nov 17 06:19:31 sleepy HighMem: empty
Nov 17 06:19:31 sleepy Swap cache: add 189810, delete 189544, find 44123/68990, race 0+0
Nov 17 06:19:31 sleepy Out of Memory: Killed process 29354 (slocate).
Nov 17 06:19:31 sleepy run-crons: page allocation failure. order:0, mode:0x1d2
Nov 17 06:19:31 sleepy [<c0105247>] dump_stack+0x16/0x18
Nov 17 06:19:31 sleepy [<c0145c75>] __alloc_pages+0x2fe/0x31a
Nov 17 06:19:31 sleepy [<c0148b53>] do_page_cache_readahead+0x101/0x18d
Nov 17 06:19:31 sleepy [<c0141d10>] filemap_nopage+0x163/0x337
Nov 17 06:19:31 sleepy [<c0153f36>] do_no_page+0x10f/0x52a
Nov 17 06:19:31 sleepy [<c0154568>] handle_mm_fault+0xe2/0x261
Nov 17 06:19:31 sleepy [<c01159b0>] do_page_fault+0x1ef/0x578
Nov 17 06:19:31 sleepy [<c0104dc9>] error_code+0x2d/0x38
Nov 17 06:19:31 sleepy run-crons: page allocation failure. order:0, mode:0x1d2
Nov 17 06:19:31 sleepy [<c0105247>] dump_stack+0x16/0x18
Nov 17 06:19:31 sleepy [<c0145c75>] __alloc_pages+0x2fe/0x31a
Nov 17 06:19:31 sleepy [<c0141b1c>] page_cache_read+0x2e/0xbf
Nov 17 06:19:31 sleepy [<c0141d7a>] filemap_nopage+0x1cd/0x337
Nov 17 06:19:31 sleepy [<c0153f36>] do_no_page+0x10f/0x52a
Nov 17 06:19:31 sleepy [<c0154568>] handle_mm_fault+0xe2/0x261
Nov 17 06:19:31 sleepy [<c01159b0>] do_page_fault+0x1ef/0x578
Nov 17 06:19:31 sleepy [<c0104dc9>] error_code+0x2d/0x38
Nov 17 06:19:31 sleepy VM: killing process run-crons
Nov 17 06:19:31 sleepy postfix/master[6783]: warning: process /usr/lib/postfix/qmgr pid 6813 killed by signal 9
Nov 17 06:19:31 sleepy postfix/master[6783]: warning: process /usr/lib/postfix/pickup pid 21982 killed by signal 9

--------------080906070204030209020009--
