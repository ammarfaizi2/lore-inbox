Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVDFUdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVDFUdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 16:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVDFUdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 16:33:08 -0400
Received: from mail.yosifov.net ([193.200.14.114]:55956 "EHLO home.yosifov.net")
	by vger.kernel.org with ESMTP id S262310AbVDFUc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 16:32:59 -0400
Subject: Re: Out of memory with Java 1.5 and 2.6.11.6
From: Ivan Yosifov <ivan@yosifov.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200504062131.36204.robin.rosenberg.lists@dewire.com>
References: <200504062131.36204.robin.rosenberg.lists@dewire.com>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 23:32:56 +0300
Message-Id: <1112819576.20857.8.camel@home.yosifov.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apr  5 22:05:20 xine kernel: oom-killer: gfp_mask=0xd0

The oom-killer a piece of code which starts killing processes when you
run out of memory. OOM-killer = Out Of Memory Killer. My guess is that
the second jvm consumed all the memory left ( this may me be a memory
leak, if so report it to SUN, not lkml ) and eclipse , being a
memory-heavyweight got slaughtered. The first thing that came to mind :)

On Wed, 2005-04-06 at 21:31 +0200, Robin Rosenberg wrote:
> I see regular crashes with 2.6.11.6 (mandrake-patched) and Java 1.5.02 (01 too 
> btw, but not 1.4.2). Gentoo people report the same problem sugesting that it
> may have appeared between 2.6.11.4 and 2.6.11.5.
> 
> If I start eclipse and then, outside of eclipse, starts a java 1.5 process 
> eclipse dies instantly. Not always, but usually when I stop watching.
> 
> Any clues?
> 
> -- robin
> 
> oh, here is an excerpt from /var/log/messages.
> 
> Apr  5 22:05:20 xine kernel: oom-killer: gfp_mask=0xd0
> Apr  5 22:05:20 xine kernel: DMA per-cpu:
> Apr  5 22:05:20 xine kernel: cpu 0 hot: low 2, high 6, batch 1
> Apr  5 22:05:20 xine kernel: cpu 0 cold: low 0, high 2, batch 1
> Apr  5 22:05:20 xine kernel: Normal per-cpu:
> Apr  5 22:05:20 xine kernel: cpu 0 hot: low 32, high 96, batch 16
> Apr  5 22:05:20 xine kernel: cpu 0 cold: low 0, high 32, batch 16
> Apr  5 22:05:20 xine kernel: HighMem per-cpu: empty
> Apr  5 22:05:20 xine kernel:
> Apr  5 22:05:20 xine kernel: Free pages:        5684kB (0kB HighMem)
> Apr  5 22:05:20 xine kernel: Active:107335 inactive:5929 dirty:0 writeback:4 
> unstable:0 free:1421 slab:9726 mapped:113240 pagetables:1705
> Apr  5 22:05:20 xine kernel: DMA free:2068kB min:88kB low:108kB high:132kB 
> active:8392kB inactive:0kB present:16384kB pages_scanned:8802 
> all_unreclaimable? yes
> Apr  5 22:05:20 xine kernel: lowmem_reserve[]: 0 495 495
> Apr  5 22:05:21 xine kernel: Normal free:3616kB min:2800kB low:3500kB 
> high:4200kB active:420948kB inactive:23716kB present:507576kB pages_scanned:0 
> all_unreclaimable? no
> Apr  5 22:05:21 xine kernel: lowmem_reserve[]: 0 0 0
> Apr  5 22:05:21 xine kernel: HighMem free:0kB min:128kB low:160kB high:192kB 
> active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
> Apr  5 22:05:21 xine kernel: lowmem_reserve[]: 0 0 0
> Apr  5 22:05:21 xine kernel: DMA: 1*4kB 0*8kB 1*16kB 0*32kB 2*64kB 1*128kB 
> 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 2068kB
> Apr  5 22:05:21 xine kernel: Normal: 208*4kB 8*8kB 2*16kB 6*32kB 7*64kB 
> 0*128kB 0*256kB 0*512kB 0*1024kB 1*2048kB 0*4096kB = 3616kB
> Apr  5 22:05:21 xine kernel: HighMem: empty
> Apr  5 22:05:21 xine kernel: Swap cache: add 1267612, delete 1246233, find 
> 7825455/7951372, race 0+6
> Apr  5 22:05:21 xine kernel: Free swap  = 760276kB
> Apr  5 22:05:21 xine kernel: Total swap = 1060248kB
> Apr  5 22:05:21 xine kernel: Out of Memory: Killed process 23770 (java).
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

