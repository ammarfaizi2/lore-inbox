Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbUKTLaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbUKTLaH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 06:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUKTLaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 06:30:07 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:10377 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261674AbUKTL35
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 06:29:57 -0500
Message-ID: <419F2AB4.30401@ribosome.natur.cuni.cz>
Date: Sat, 20 Nov 2004 12:29:56 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041114
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au, chris@tebibyte.org,
       marcelo.tosatti@cyclades.com, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet>	 <4193E056.6070100@tebibyte.org>	<4194EA45.90800@tebibyte.org>	 <20041113233740.GA4121@x30.random>	<20041114094417.GC29267@logos.cnet>	 <20041114170339.GB13733@dualathlon.random>	 <20041114202155.GB2764@logos.cnet>	<419A2B3A.80702@tebibyte.org>	 <419B14F9.7080204@tebibyte.org>	<20041117012346.5bfdf7bc.akpm@osdl.org>	 <419CD8C1.4030506@ribosome.natur.cuni.cz>	 <20041118131655.6782108e.akpm@osdl.org>	 <419D25B5.1060504@ribosome.natur.cuni.cz>	 <419D2987.8010305@cyberone.com.au>	 <419D383D.4000901@ribosome.natur.cuni.cz>	 <20041118160824.3bfc961c.akpm@osdl.org>	 <419E821F.7010601@ribosome.natur.cuni.cz> <1100946207.2635.202.camel@thomas>
In-Reply-To: <1100946207.2635.202.camel@thomas>
Content-Type: multipart/mixed;
 boundary="------------070007020602080303050503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070007020602080303050503
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Thomas Gleixner wrote:
> On Sat, 2004-11-20 at 00:30 +0100, Martin MOKREJ© wrote:
> 
>>OK, I can say kernel 2.6.7, 2.6.8.1, 2.6.9-rc1 kill just the RNAsubopt
>>application in my test.
>>
>>2.6.9-rc2 kills RNAsubopt and also two xterms, one running vmstat,
>>the other is parent of RNAsubopt program I used to eat memory with.
>>
>>2.6.9 has killed just those 2 xterms, as a sideeffect the RNAsubopt
>>got killed as parent shell got killed.
>>
>>2.6.10-rc1 killed all three.
>>
>>I conclude the major problem got introduced between
>>2.6.9-rc1 and 2.6.9-rc2.
> 
> 
> Can you please try 2.6.10-rc2-mm2 + the patch I posted yesterday night ?
> It will still kill RNAsubopt, but it should not longer touch the xterm,
> which runs vmstat.

No, it doesn't help at all! See attached file.


--------------070007020602080303050503
Content-Type: text/plain;
 name="dm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm"

oom-killer: gfp_mask=0xd2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 14, high 42, batch 7
cpu 0 cold: low 0, high 14, batch 7

Free pages:        3916kB (112kB HighMem)
Active:131900 inactive:121851 dirty:0 writeback:0 unstable:0 free:979 slab:1918 mapped:253638 pagetables:794
DMA free:68kB min:68kB low:84kB high:100kB active:5388kB inactive:5432kB present:16384kB pages_scanned:12292 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:3736kB min:3756kB low:4692kB high:5632kB active:457320kB inactive:416944kB present:901120kB pages_scanned:906311 all_unreclaimable? yes
protections[]: 0 0 0
HighMem free:112kB min:128kB low:160kB high:192kB active:64892kB inactive:65028kB present:131044kB pages_scanned:134185 all_unreclaimable? yes
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 68kB
Normal: 0*4kB 1*8kB 1*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3736kB
HighMem: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 112kB
Swap cache: add 293354, delete 293354, find 65/84, race 0+0
Out of Memory: Killed process 6612 (RNAsubopt).
Out of Memory: Killed process 6603 (bash).
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 14, high 42, batch 7
cpu 0 cold: low 0, high 14, batch 7

Free pages:        3916kB (112kB HighMem)
Active:131832 inactive:121892 dirty:0 writeback:38 unstable:0 free:979 slab:1918 mapped:253573 pagetables:790
DMA free:68kB min:68kB low:84kB high:100kB active:5388kB inactive:5432kB present:16384kB pages_scanned:12292 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:3736kB min:3756kB low:4692kB high:5632kB active:457080kB inactive:417076kB present:901120kB pages_scanned:906479 all_unreclaimable? yes
protections[]: 0 0 0
HighMem free:112kB min:128kB low:160kB high:192kB active:64860kB inactive:65060kB present:131044kB pages_scanned:134217 all_unreclaimable? yes
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 68kB
Normal: 0*4kB 1*8kB 1*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3736kB
HighMem: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 112kB
Swap cache: add 293419, delete 293381, find 65/84, race 0+0
Out of Memory: Killed process 6598 (FvwmPager).
Out of Memory: Killed process 6599 (xterm).
Out of Memory: Killed process 6606 (xterm).
Out of Memory: Killed process 6564 (fvwm2).
mtrr: no MTRR for d8000000,2000000 found
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:drm_unlock] *ERROR* Process 6536 using kernel context 0

--------------070007020602080303050503--
