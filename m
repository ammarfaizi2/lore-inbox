Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUCaVWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbUCaVWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:22:47 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31625
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262538AbUCaVWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:22:43 -0500
Date: Wed, 31 Mar 2004 23:22:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-aa1
Message-ID: <20040331212242.GP2143@dualathlon.random>
References: <20040331030921.GA2143@dualathlon.random> <20040331211620.19a8f725@bongani>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331211620.19a8f725@bongani>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 09:16:20PM +0200, Bongani Hlope wrote:
> On Wed, 31 Mar 2004 05:09:21 +0200
> Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > The xfs warning during truncate will be fixed with a later update
> > (Nathan is currently working on it).
> > 
> > next thing to do is to fixup the merging in mprotect.
> > 
> 
> I'm running 2.6.5-rc2-aa4, when I woke-up in the morning almost all of
> my memory was gone, but my swap was never touched. I managed to get
> only the output of SysRq-M before it hard-locked. For some reason it
> doesn't swap. I'll try to reproduce.

weird, it really loks like it doesn't swap anything. At least it's not a
race condition. Which fs are you using?

can you try to actively push it into swap with a script like this?

#!/usr/bin/env python

while 1:
	try:
		a = 'a'
		while 1:
			a += a
	except MemoryError:
		pass

this should push something into swap.

Can you also upgrade to 2.6.5-rc3-aa1? There were a few bugs in previous
releases, though nothing that would prevent it to swap.

thanks for the feedback!

> 
> SysRq : Show Memory
> Mem-info:
> DMA per-cpu:
> cpu 0 hot: low 2, high 6, batch 1
> cpu 0 cold: low 0, high 2, batch 1
> Normal per-cpu:
> cpu 0 hot: low 28, high 84, batch 14
> cpu 0 cold: low 0, high 28, batch 14
> HighMem per-cpu: empty
> Mar 31 06:48:12 bongani kernel:
> Free pages:        2752kB (0kB HighMem)
> Active:27927 inactive:1585 dirty:4 writeback:0 unstable:0 free:688
> DMA free:1008kB min:28kB low:56kB high:84kB active:308kB inactive:256kB present:16384kB
> Normal free:1744kB min:476kB low:952kB high:1428kB active:111400kB inactive:6084kB present:245696kB
> HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
> DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1008kB
> Normal: 162*4kB 17*8kB 4*16kB 0*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1744kB
> HighMem: empty
> Swap cache: add 0, delete 0, find 0/0, race 0+0
> Free swap:       257000kB
> 65520 pages of RAM
> 0 pages of HIGHMEM
> 1579 reserved pages
> 19651 pages shared
