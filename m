Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282890AbRLGQbd>; Fri, 7 Dec 2001 11:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282878AbRLGQbX>; Fri, 7 Dec 2001 11:31:23 -0500
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:23307 "HELO
	light-brigade.mit.edu") by vger.kernel.org with SMTP
	id <S282874AbRLGQbL>; Fri, 7 Dec 2001 11:31:11 -0500
Date: Fri, 7 Dec 2001 11:31:10 -0500
From: Gerald Britton <gbritton@mit.edu>
To: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: IDE-DMA woes
Message-ID: <20011207113110.A3673@light-brigade.mit.edu>
In-Reply-To: <3C115106.BED6616D@sltnet.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C115106.BED6616D@sltnet.lk>; from ioshadi@sltnet.lk on Fri, Dec 07, 2001 at 05:30:14PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 05:30:14PM -0600, Ishan Oshadi Jayawardena wrote:
> Greetings.
> 	I run Linux on an IBM PC300GL with Intel's
> 82371AB PIIX4 chipset. With DMA enabled (by doing a
> hdparm -d1 /dev/hda) on the hdd, I
> _sometimes_ get the following message from the kernel
> after resuming from APM standby mode:

I have very similar behavior on an IBM Thinkpad T23.  It's got this IDE
controller:

00:1f.1 IDE interface: Intel Corporation: Unknown device 248a (rev 01)
        Subsystem: IBM: Unknown device 0220

And, I also only sometimes get roughly:

ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
ide_dmaproc: chipset supported ide_dma_timeout func only: 14

> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: status error: status=0x59 { DriveReady SeekComplete DataRequest
> Error }
> hda: status error: error=0x84 { DriveStatusError BadCRC }
> hda: drive not ready for command
> 
> then the drive stalls for a few seconds, and the driver
> disables DMA. This behaviour doesn't seem to depend on the
> kernel version (current: 2.4.14; error seen with 2.2 series also.)
> The weird thing is that this is not reliably reproducable; most of
> the time the system goes to apm standby (not suspend) and resumes fine.

Unfortunately, when mine hits this condition, it seems to never recover
from it.  It also seems to only happen sometimes and I've been unable to
reliably reproduce the problem.  I told Andre about the problem and he
suggested doing a "hdparm -d0 -X08 /dev/hda" prior to suspend and that
seems to work around the problem.  I "hdparm -d1 -X69 /dev/hda" on resume
to get it back to speedy udma5 mode.  I think the problem is the BIOS doing
things to the IDE chipset during the suspend, and the driver not properly
correcting the changes on resume.

				-- Gerald

