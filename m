Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRACWDS>; Wed, 3 Jan 2001 17:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbRACWC7>; Wed, 3 Jan 2001 17:02:59 -0500
Received: from pm4-1-c0-73.apex.net ([209.250.32.88]:7432 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S129226AbRACWCk>; Wed, 3 Jan 2001 17:02:40 -0500
Date: Wed, 3 Jan 2001 16:02:08 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Jim Studt <jim@federated.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sis5513 fatal udma problems
Message-ID: <20010103160208.A13576@hapablap.dyn.dhs.org>
Mail-Followup-To: Jim Studt <jim@federated.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200101032110.PAA08416@core.federated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101032110.PAA08416@core.federated.com>; from jim@federated.com on Wed, Jan 03, 2001 at 03:10:39PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 03:10:39PM -0600, Jim Studt wrote:
> The sis5513 has for quite a while had fatal problems with udma on some
> machines.  (At least the thelinuxstore PIAs with the P6SET-ML
> motherboard, I have heard other people with the same problem).
> 
> The sis5513 driver deliberatly overrides the CONFIG_IDEDMA_AUTO and
> the BIOS settings that might disable UDMA and forces UDMA which works
> for a while then fails, attempts to fallback to a non-DMA mode and
> fails that as well.
> 
> The logs end up with something along the lines of...
>   hdc: timeout waiting for DMA
>   ide_dmaproc: chipset supported ide_dma_timeout func only: 14
>   hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
>   hdc: status timeout: status=0xd8 { Busy }
>   hdc: DMA disabled
>   hdc: drive not ready for command
>   ide1: reset: success
>   hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>   hdc: drive not ready for command
> ... but it nevers succeeds in the reset.  The drive never becomes ready.
> 
> I will make a patch, but I am uncertain what the `right' policy should
> be.  I am inclined to first and foremost respect the CONFIG_IDEDMA_AUTO
> flag, then to take the fastest mode which is both capable and enabled in
> the bios.
> 
> Thoughts?  Please? :-)

What kernel version is this?  If its a 2.2.x series kernel, try patching
it with Andre's IDE patches.  I've had good luck using UDMA/33 on a
SiS530 (which uses the 5513 ide chipset) using Andre's patches.  I've
also been able to use UDMA/33 and UDMA/66 with the latest 2.4.x kernels
and an 80-conductor cable (very important!).  I haven't tried 2.2.x+ide
with UDMA/66, though it should work as well.
-- 
-Steven
"Voters decide nothing.  Vote counters decide everything."
				-Joseph Stalin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
