Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130406AbRCTOuE>; Tue, 20 Mar 2001 09:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbRCTOty>; Tue, 20 Mar 2001 09:49:54 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:8342 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130406AbRCTOte>; Tue, 20 Mar 2001 09:49:34 -0500
Message-ID: <3AB76C62.272041FD@coplanar.net>
Date: Tue, 20 Mar 2001 09:42:42 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jules Bean <jules@jellybean.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA resets with ALI15X3 on Aladdin V
In-Reply-To: <20010320111737.B8625@blueberry.jellybean.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jules Bean wrote:

> Hi,
>
> I have an intermittent problem with my IDE setup:
>
> pear# dmesg | grep -i ide
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ALI15X3: IDE controller on PCI bus 00 dev 78
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> {snip}
>
> It works absolutely fine under normal load; I see the very occasional
>
> Mar 18 12:23:01 pear kernel: hda: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Mar 18 12:23:01 pear kernel: hda: dma_intr: error=0x84 {
> DriveStatusError BadCRC }
>

This is clue #1 - BadCRC

>
> but they don't seem to affect performance.
>
> However, very occasionally, normally when the HD is under very heavy
> load, I get messages like this:
>
> Mar 20 10:24:05 pear kernel: hda: timeout waiting for DMA
> Mar 20 10:24:05 pear kernel: ide_dmaproc: chipset supported
> ide_dma_timeout func only: 14
> Mar 20 10:24:05 pear kernel: hda: irq timeout: status=0x58 {
> DriveReady SeekComplete DataRequest }
> Mar 20 10:24:05 pear kernel: hda: status timeout: status=0xd0 { Busy }
> Mar 20 10:24:05 pear kernel: hda: drive not ready for command
> Mar 20 10:24:05 pear kernel: ide0: reset: success
>
> This is accompanied by a freeze of the machine, which in this
> particular instance sorted itself out.  Sometimes, the machine goes
> down hard, causing some disk corruption (always minor, thankfully, so
> far).
>
> This all sounds very like that described in the thread which starts at
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0006.1/0924.html
> although he didn't seem to get an actually crashes from it.
>
> Sometimes I also hear alarming clicking sounds from the disk; on those

This is clue #2.

>
> occasions, the crash is hard, and the machine has to be reset.
>
> Is this a hardware fault?  I would think so, except for the
> intermittent dma_intr errors suggesting there could be a motherboard
> problem too?
>
> The disk is as follows:
>
> pear# cat /proc/ide/hda/model
> Maxtor 91080D5

If memory serves me correctly, this disk is the same model as
one I send back for RMA... I think your disk is toast.
you could try using badblocks to scan it, prefferably in read-write
mode (you'll have to move your data to another disk first, of course,
since this erases data)  You could try just a read scan first.
The clicking is likely the drive trying to re-read the bad sectors.
You should try to exchange it under warranty, before your data
disappears.

You could try using an Ultra-DMA 66 cable to improve signal quality,
even though this chipset (I think) only supports UDMA33.  Also,
try it with the drive by itsself (not sharing cable with a cdrom or
another disk) on an interface.

Cheers,

Jeremy

>
>
> (It does normally seem to be that disk, but the other disk is much
> smaller anyhow).
>
> I do also sometime see problems with hdd, which is an ATAPI
> cd-rom. This normally happens after there's been some problem with
> hda, and I get:

{snip}

