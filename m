Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270720AbUJUPvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270720AbUJUPvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268496AbUJUPq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:46:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55171 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270779AbUJUPlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:41:53 -0400
Date: Thu, 21 Oct 2004 17:41:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: readcd hangs in blk_execute_rq
Message-ID: <20041021154122.GC32465@suse.de>
References: <Pine.GSO.4.44.0410211805010.25972-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0410211805010.25972-100000@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21 2004, Meelis Roos wrote:
> I'm trying to readcd a cd, in 2.6.9+todays BK snapshot.
> 
> I got an error the first time so I started it (readcd dev=/dev/hdc)
> the second time and chose c2scan. This resulted in the messages
> ...
> end:    328460
> C2 in sector: 1864 first at byte: 2256 (0xF0) total:   72 errors
> C2 in sector: 1865 first at byte:   12 (0x0F) total: 2335 errors
> addr:     2499 cnt: 49
> 
> And here it hangs. ps shows readcd is in D state, in blk_execute_rq.
> dmesg shows lines of
> 
> hdc: lost interrupt
> 
> every no and then.
> 
> This a IDE CD on Intel ICH2 ide controller:
> 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH2: IDE controller at PCI slot 0000:00:1f.1
> ICH2: chipset revision 2
> ICH2: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> 
> hdc: CDU5211, ATAPI CD/DVD-ROM drive
> hdc: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
> 
> And after every boot it gets DMA timeout on first read and switches to
> PIO mode and works fine there reading data cd-s (even browsing the same
> CD):
> 
> ide-cd: cmd 0x28 timed out
> hdc: DMA interrupt recovery
> hdc: lost interrupt
> hdc: status timeout: status=0xd0 { Busy }
> hdc: status timeout: error=0x00
> hdc: DMA disabled
> hdc: drive not ready for command
> hdc: ATAPI reset complete

Did it previously work reliably with dma (which kernel)? Does it now
work reliably without dma now? Do send your entire dmesg after a boot
too, btw.

-- 
Jens Axboe

