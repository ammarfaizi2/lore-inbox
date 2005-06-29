Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVF2M6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVF2M6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 08:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVF2M5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 08:57:51 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:20371 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262570AbVF2M5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 08:57:21 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: oom-killings, but I'm not out of memory!
From: Alexander Nyberg <alexn@telia.com>
To: Anthony DiSante <theant@nodivisions.com>
Cc: andrea@suse.de, akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42C18031.50206@nodivisions.com>
References: <42C179D5.3040603@nodivisions.com>
	 <1119977073.1723.2.camel@localhost.localdomain>
	 <42C18031.50206@nodivisions.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 14:57:15 +0200
Message-Id: <1120049835.1176.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>I'm running a 2.6.11 kernel.  I have 1 gig of RAM and 1 gig of swap.  Lately 
> >>when my RAM gets full, the oom-killer takes out either Mozilla or 
> >>Thunderbird (my two biggest memory hogs), even though my swap space is only 
> >>20% full.  I still have ~800 MB of free swap space, so shouldn't the kernel 
> >>push Moz or T-bird into swap instead of oom-killing it?  At their maximum 
> >>memory-hogging capacity, neither Moz nor T-bird is ever using more than 200 MB.
> >>
> > You cut out the important part where it printed out memory usage
> > information at the time of the OOM, please post it
> > 
> 
> Oops.  I left that out because it line-wrapped so bad, and I didn't realize 
> it was important.  Here it is:
> 
> ... oom-killer: gfp_mask=0x80d2
> ... DMA per-cpu:
> ... cpu 0 hot: low 2, high 6, batch 1
> ... cpu 0 cold: low 0, high 2, batch 1
> ... Normal per-cpu:
> ... cpu 0 hot: low 32, high 96, batch 16
> ... cpu 0 cold: low 0, high 32, batch 16
> ... HighMem per-cpu:
> ... cpu 0 hot: low 14, high 42, batch 7
> ... cpu 0 cold: low 0, high 14, batch 7
> ...
> ... Free pages:       12536kB (112kB HighMem)
> ... Active:240797 inactive:2399 dirty:0 writeback:0 unstable:0 free:3134 
> slab:7144 mapped:240597 pagetables:1073
> ... DMA free:4096kB min:68kB low:84kB high:100kB active:8260kB inactive:0kB 
> present:16384kB pages_scanned:9052 all_unreclaimable? yes
> ... lowmem_reserve[]: 0 880 1007
> ... Normal free:8328kB min:3756kB low:4692kB high:5632kB active:827084kB 
> inactive:9468kB present:901120kB pages_scanned:23361 all_unreclaimable? no
> ... lowmem_reserve[]: 0 0 1023
> ... HighMem free:112kB min:128kB low:160kB high:192kB active:127844kB 
> inactive:128kB present:131008kB pages_scanned:135459 all_unreclaimable? yes
> ... lowmem_reserve[]: 0 0 0
> ... DMA: 0*4kB 28*8kB 16*16kB 1*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 
> 1*2048kB 0*4096kB = 4096kB
> ... Normal: 98*4kB 16*8kB 216*16kB 18*32kB 1*64kB 1*128kB 0*256kB 1*512kB 
> 1*1024kB 1*2048kB 0*4096kB = 8328kB
> ... HighMem: 0*4kB 2*8kB 2*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 
> 0*1024kB 0*2048kB 0*4096kB = 112kB
> ... Swap cache: add 166973, delete 149202, find 1714386/1723885, race 0+0
> ... Free swap  = 781012kB
> ... Total swap = 987988kB
> ... Out of Memory: Killed process 30787 (thunderbird-bin).
> ... Out of Memory: Killed process 18112 (thunderbird-bin).
> ... Out of Memory: Killed process 18116 (thunderbird-bin).
> ... Out of Memory: Killed process 18117 (thunderbird-bin).
> ... Out of Memory: Killed process 18119 (thunderbird-bin).
> ... Out of Memory: Killed process 8857 (thunderbird-bin).

Yeah this indeed looks strange. gfp_mask == GFP_HIGHUSER | __GFP_ZERO

iirc Andrea fixing up some all_unreclaimable bug in 2.6.11 but this
looks like that for some reason it didn't go into the Normal zone which
has plenty of free pages...

