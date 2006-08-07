Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWHGU5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWHGU5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWHGU5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:57:47 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:23433 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932365AbWHGU5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:57:46 -0400
Date: Mon, 7 Aug 2006 22:57:08 +0200
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: resume from S3 regression [Was: 2.6.18-rc3-mm2]
Message-ID: <20060807205708.GC4007@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <20060807193836.GA4007@inferi.kami.home> <20060807130208.94b58773.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807130208.94b58773.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc1-mm2-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 01:02:08PM -0700, Andrew Morton wrote:
> On Mon, 7 Aug 2006 21:38:36 +0200
> Mattia Dongili <malattia@linux.it> wrote:
> 
> > after resume from ram (tested in single user), I can type commands for a
> > few seconds (time is variable), the processes get stuck in io_schedule.
> > Poorman's screenshots are here:
> > http://oioio.altervista.org/linux/dsc03448.jpg
> > http://oioio.altervista.org/linux/dsc03449.jpg
> 
> That probably measn that the device or device driver has got itself into a
> sick state and IO completions aren't occurring. 

BTW: I tried to reverse ide-reprogram-disk-pio-timings-on-resume.patch
with no luck.

> Which storage device (and which device driver) is being used here?

A dmesg is available here (apart from the already resolved BUGs the boot
process is meaningful):
http://oioio.altervista.org/linux/dmesg-2.6.18-rc3-mm2-1
[    3.168000] ICH3M: chipset revision 1
[    3.168000] ICH3M: not 100% native mode: will probe irqs later
[    3.168000]     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
[    3.168000]     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
[    3.168000] Probing IDE interface ide0...
[    3.460000] hda: FUJITSU MHV2080AH, ATA DISK drive
[    4.132000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    4.136000] Probing IDE interface ide1...
[    4.704000] Probing IDE interface ide1...
[    5.272000] hda: max request size: 128KiB
[    5.344000] hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
[    5.348000] hda: cache flushes supported
[    5.352000]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >

lspci reports:
00:1f.1 IDE interface: Intel Corporation 82801CAM IDE U100 (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 255
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at d0000000 (32-bit, non-prefetchable) [size=1K]

-- 
mattia
:wq!
