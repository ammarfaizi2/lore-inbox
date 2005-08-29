Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVH2UZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVH2UZV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVH2UZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:25:21 -0400
Received: from styx.suse.cz ([82.119.242.94]:36792 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750706AbVH2UZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:25:20 -0400
Date: Mon, 29 Aug 2005 22:25:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
Message-ID: <20050829202529.GA32214@midnight.suse.cz>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 06:20:56PM +0000, Holger Kiehl wrote:
> Hello
> 
> I have a system with the following setup:
> 
>     Board is Tyan S4882 with AMD 8131 Chipset
>     4 Opterons 848 (2.2GHz)
>     8 GB DDR400 Ram (2GB for each CPU)
>     1 onboard Symbios Logic 53c1030 dual channel U320 controller
>     2 SATA disks put together as a SW Raid1 for system, swap and spares
>     8 SCSI U320 (15000 rpm) disks where 4 disks (sdc, sdd, sde, sdf)
>       are on one channel and the other four (sdg, sdh, sdi, sdj) on
>       the other channel.
> 
> The U320 SCSI controller has a 64 bit PCI-X bus for itself, there is
> no other device on that bus. Unfortunatly I was unable to determine at
> what speed it is running, here the output from lspci -vv:

> How does one determine the PCI-X bus speed?

Usually only the card (in your case the Symbios SCSI controller) can
tell. If it does, it'll be most likely in 'dmesg'.

> Anyway, I thought with this system I would get theoretically 640 MB/s using
> both channels.

You can never use the full theoretical bandwidth of the channel for
data. A lot of overhead remains for other signalling. Similarly for PCI.

> I tested several software raid setups to get the best possible write
> speeds for this system. But testing shows that the absolute maximum I
> can reach with software raid is only approx. 270 MB/s for writting.
> Which is very disappointing.

I'd expect somewhat better (in the 300-400 MB/s range), but this is not
too bad.

To find where the bottleneck is, I'd suggest trying without the
filesystem at all, and just filling a large part of the block device
using the 'dd' command.

Also, trying without the RAID, and just running 4 (and 8) concurrent
dd's to the separate drives could show whether it's the RAID that's
slowing things down. 

> The tests where done with 2.6.12.5 kernel from kernel.org, scheduler
> is the deadline and distribution is fedora core 4 x86_64 with all
> updates.  Chunksize is always the default from mdadm (64k). Filesystem
> was always created with the command mke2fs -j -b4096 -O dir_index
> /dev/mdx.
> 
> I also have tried with 2.6.13-rc7, but here the speed was much lower,
> the maximum there was approx. 140 MB/s for writting.

Now that's very low.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
