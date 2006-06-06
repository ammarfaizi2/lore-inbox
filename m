Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWFFFhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWFFFhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 01:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWFFFhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 01:37:05 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:7122 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750868AbWFFFhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 01:37:03 -0400
Date: Tue, 06 Jun 2006 14:36:14 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Cc: mbligh@google.com, akpm@osdl.org, apw@shadowen.org,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>
In-Reply-To: <20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060605200727.374cbf05.akpm@osdl.org> <20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060606142347.2AF2.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I looked back into 2.6.15, 2.6.16. 
> It looks -mm's time of initialization of "total_memory" is not changed from them.
> (yes, Andrew's fix looks sane.)
> 
> I'm intersted in the following texts in the log.
> ==
> Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
> Node 0 DMA32: empty
> Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
> Node 0 HighMem: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 1*1024kB 2*2048kB 3962*4096kB = 16233724kB
> Node 1 DMA: empty
> Node 1 DMA32: empty
> Node 1 Normal: empty
> Node 1 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 4065*4096kB = 16651916kB
> Node 2 DMA: empty
> Node 2 DMA32: empty
> Node 2 Normal: empty
> Node 2 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 4065*4096kB = 16651916kB
> Node 3 DMA: empty
> Node 3 DMA32: empty
> Node 3 Normal: empty
> Node 3 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 3811*4096kB = 15611532kB
> ==
> Looks 64GB memory. but there are only HIGHMEM, no NORMAL, DMA. so, shrink_zone() worked.

Its log shows there are some memory in DMA and NORMAL just immediately
before that.....

> Active:2 inactive:15 dirty:0 writeback:0 unstable:0 free:16287272 slab:1823 mapped:0 pagetables:0
> Node 0 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
> Node 0 DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
> Node 0 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:385024kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0

It looks like that something wasted all of DMA(16MB) and NORMAL(385MB)
zone suddenly. Hmmm...

Bye.

-- 
Yasunori Goto 


