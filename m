Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276535AbRI2Pxm>; Sat, 29 Sep 2001 11:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276536AbRI2Pxc>; Sat, 29 Sep 2001 11:53:32 -0400
Received: from [63.193.79.18] ([63.193.79.18]:27119 "HELO mwg.inxservices.lan")
	by vger.kernel.org with SMTP id <S276535AbRI2PxZ>;
	Sat, 29 Sep 2001 11:53:25 -0400
Date: Sat, 29 Sep 2001 08:53:23 -0700
From: Phil Blecker <tmwg@inxservices.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac10 IDE access slows as uptime increases
Message-ID: <20010929085323.A31121@inxservices.com>
In-Reply-To: <20010928204612.A911@inxservices.com> <E15nLB7-00027t-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15nLB7-00027t-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Sep 29, 2001 at 03:33:17PM +0100
Organization: inX Services, Los Angeles, CA, USA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   DB uses regular file system (ext3) and mmap.
   Nothing in logs from IDE. Only thing there unknown to me from kernel:
	cmpci: dma timed out??
That's from the sound driver, apparently. No idea what it means.
   By the way, would hdparm -i report the change? If so, they're all
still UDMA.
   I'm going to try removing the IDE to SCSI stuff that I installed to
try and get a USB CDRW drive working. Never did, and have not used any
time to pursue it (always timed out on access, now not even in devfs for
some reason). No idea if that's relevant, either, but it looks like
something I botched.

   The last message was so long that this may have been missed: it's not
just the DB that shows the slowdown. It's general. It's just really
obvious with the DB due to visual feedback. Who would notice if gcc-3
took an extra 20 minutes to compile something ;( (I haven't really timed
it. I noticed gcc gets slower, but not timed it to see how much, so its
subjective.)

   This may be irrelevant, but here's meminfo this morning:
        total:    used:    free:  shared: buffers:  cached:
Mem:  1053401088 887148544 166252544    65536 242728960 552976384
Swap: 2147467264 74866688 2072600576
MemTotal:      1028712 kB
MemFree:        162356 kB
MemShared:          64 kB
Buffers:        237040 kB
Cached:         478604 kB
SwapCached:      61412 kB
Active:         421960 kB
Inact_dirty:    352208 kB
Inact_clean:      2952 kB
Inact_target:      260 kB
HighTotal:      130992 kB
HighFree:         2036 kB
LowTotal:       897720 kB
LowFree:        160320 kB
SwapTotal:     2097136 kB
SwapFree:      2024024 kB

On Sat, Sep 29, 2001 at 03:33:17PM +0100, Alan Cox wrote:
> >    I ran a program that's a GUI app/front-end to a data base, on the
> > local drives. It took seconds to access a record.
> 
> Is the data base doing I/O directly to a block device and not using
> O_DIRECT for one question
> 
> Second question is what is in your IDE logs. The IDE layer will change
> down speeds when it hits a repeated problem (eg a DMA timeout) so if
> need be will switch back to PIO or to MWDMA.
