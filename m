Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTL2DjU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 22:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbTL2DjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 22:39:20 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43013
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262746AbTL2DjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 22:39:18 -0500
Date: Sun, 28 Dec 2003 19:37:37 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: akmiller@nzol.net
cc: linux-kernel@vger.kernel.org
Subject: Re: ide: "lost interrupt" with 2.6.0
In-Reply-To: <1072657930.3fef760a50062@webmail.nzol.net>
Message-ID: <Pine.LNX.4.10.10312281934150.32122-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Accusys is a stolen technology from Dupli-Disk, there are law suits
pending the last time I heard.

If it was based on the original firmware of the Dupli-Disk, it has totally
wrong state machines for executing hdparm style callers.

I know the FSM's are wrong because I fixed them for Dupli-Disk.
How they operate, I can not disclose.  But Accusys can not handle correct
settings for FSM to Taskfile.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 29 Dec 2003 akmiller@nzol.net wrote:

> I am seeing "lost interrupt" during kernel init, immediately after the drive is
> probed.
> 
> The system boots under 2.2.x, using the kernel supplied with the current stable
> Debian release. I have not yet tried it with 2.4.x(I had to transfer 2.6.x as
> split on floppies as the network device won't work with 2.2.x).
> 
> Data is copied by hand from the monitor, so accuracy not guaranteed(but I think
> its correct)...
> 
> Relevant lspci line, after booting under 2.2.x...
> 00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (rev
> 05)
> 
> We have had problems with these devices(ACS7500, a transparent IDE RAID
> controller from Accusys) on other boards where the BIOS wouldn't boot them, so
> they may be doing something weird with the standards. The BIOS on this board
> can allow the system to boot correctly off this device.
> 
> Relevant part of the output on bootup...
> hda: Accusys ACS7500 C5VL, ATA DISK drive
> ide0 at 0x1f0-0x1f7, 0x3f6 on irq 14
> hdc: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 234441648 sectors(120034 MB) w/2048 KiB Cache, CHS=16383/255/63
> hda:<4>hda: lost interrupt
> lost interrupt
> lost interrupt
> (continues forever)
> 
> I have tried (without success) enabling all workarounds in the kernel config,
> disabling APIC(noapic on command line, this is a single P4), disconnecting the
> CDROM from the secondary IDE, swapping the disk onto the secondary IDE,
> disabling DMA-by-default in the kernel config, disabling DMA in the BIOS setup,
> setting the PIO mode in the BIOS setup to 0, and trying the old driver on the
> primary interface(which failed because the device has too many cylinders).
> 
> Has anyone else seen this sort of problem? (Sorry if this is a known issue, I
> couldn't find anything that seemed to be the same in the archives). Has anyone
> got an ACS7500 running under 2.6.0, or 2.4.x for any recent kernel?
> 
> If you anyone needs any more info I should be able to get it, but remember I
> can't actually boot into 2.6.0 only the 2.2.x kernel.
> -- 
> Yours sincerely,
> Andrew
> 
> 
> -------------------------------------------------
> This mail sent through NZOL Webmail: http://webmail.nzol.net/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

