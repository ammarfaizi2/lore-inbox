Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVA0V0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVA0V0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVA0V0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:26:42 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:18704 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261219AbVA0VY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:24:59 -0500
Date: Thu, 27 Jan 2005 22:07:35 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Prashant Viswanathan <vprashant@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compactflash (Sandisk 512) hangs on access
Message-ID: <20050127210735.GS7048@alpha.home.local>
References: <2ec2c15a05012710356feafc81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec2c15a05012710356feafc81@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you checked that the power connector really provides 5V to the
IDE-CF adapter ? I had the exact same behaviour 5 years ago with a power
wire cut. Signal lines were powerful enough to bring power to the cheap
flash (16 MB), I could even read it, most times. The kernel almost always
booted from it, and when it turned to mount the ext2 fs R/W, it hanged. I
finally partially destroyed it this way, and it got several defects which 
could not be cleaned with a simple write or format.

Other than that, I have lots of CF cards on IDE adapters (some on motherboard,
some hand-made, some bought to serious makers), and never ran into such
problems since.

Willy

On Thu, Jan 27, 2005 at 10:35:28AM -0800, Prashant Viswanathan wrote:
> I have been trying unsuccessfully over the last 2 weeks to get
> compactflash working on my Linux system based on mini-ITX (Via CL
> motherboard, pentium compatible).
> 
> I use a CF->IDE adapter to access it just like a IDE hard disk. My
> compactflash is Sandisk SDCFH-512. Linux can detect it. I can even
> mount it and do a fdisk on it. However, the moment I try to do
> anything substantial like copy multiple files or copy 1000 blocks
> using dd, I lose access to it. Linux loses access to it totally. I
> can't even do a fdisk on it. I get an error like "Unable to open
> /dev/hdc".
> 
> I have looked at newsgroups and tried the following things
> * Used another CF (same brand) to make sure it wasn't due to a bad CF.
>  Moreover I can access it perfectly well using a USB flash
> reader/writer (shows up as a SCSI disk).
> * Tried a compactflash from another manufacturer.
> * Upgraded my Linux kernel from 2.4.26 to 2.6.7
> * Disabled DMA on the IDE drive using hdparm
> * Built and used kernels with and without devfs.
> * Used compactflash as a slave on the IDE channel, as a master and on
> both primary and secondary channels.
> 
> I get errors like (from dmesg)
> "hdc: irq timeout: status=0xff { Busy }" (no dma)
> or
> "hdc: lost interrupt" (when i had dma enabled)
> 
> Is there some nasty race condition that I am hitting?
> 
> Also, now I can't seem to turn dma back on.
> 
> <snip>
> everest root # hdparm -d1 /dev/hdc
> 
> /dev/hdc:
> setting using_dma to 1 (on)
> HDIO_SET_DMA failed: Operation not permitted
> using_dma    =  0 (off)
> </snip>
> 
> 
> I would appreciate any help/suggestions/pointers.
> 
> Thanks a lot in advance for reading through this and any help.
> Prashant
> 
> 
> P.S Please CC me on the responses.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
