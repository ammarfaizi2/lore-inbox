Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUBCRhX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 12:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUBCRhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 12:37:23 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:56514 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S263561AbUBCRhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 12:37:21 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-rc3-mm1
Date: Tue, 3 Feb 2004 17:39:43 +0000
User-Agent: KMail/1.5.94
References: <20040202235817.5c3feaf3.akpm@osdl.org>
In-Reply-To: <20040202235817.5c3feaf3.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402031739.43321.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 February 2004 07:58, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc3/2.6
>.2-rc3-mm1/
>
>
> - There is a debug patch in here which detects when someone calls
>   i_size_write() without holding the inode's i_sem.  It generates a warning
>   and a stack backtrace.  We know that XFS generates such a trace.  It will
>   turn itself off after the first ten warnings.  Please don't report the
> XFS case.
>
> - Added the CPU hotplug code.
>
> - This kernel is currently broken on ppc64.  Something to do with the
>   sched-domains patch although at this stage we do not know whether the
>   problem lies with that patch or with the ppc64 code.
>
> - A big Altix update
>
> - Latest versions of various other developers' trees.  See below for
>   details.
>
> - Various other fixes
>

Doesn't boot on this machine. It hangs after:

NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-RW CR52, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG DVD-ROM SD-616Q, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20270: IDE controller at PCI slot 0000:01:09.0
PDC20270: chipset revision 2
PDC20270: 100% native mode on irq 17
    ide2: BM-DMA at 0xd000-0xd007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd008-0xd00f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 6Y120P0, ATA DISK drive
ide2 at 0xc000-0xc007,0xc402 on irq 17
hdg: Maxtor 6Y120P0, ATA DISK drive
ide3 at 0xc800-0xc807,0xcc02 on irq 17
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hde: max request size: 128KiB

30 seconds later, I get something like:

hde: lost interrupt
hde: lost interrupt

The kernel does not recover. Presumably it is a problem specific to my PDC IDE 
controller.

In addition, I've caught another (unrelated) interruptible_sleep_on bug in msp 
audio for my v4l WinTV PCI card. I couldn't get the call addresses written 
down, but it goes something like..

interruptible_sleep_on 0xe9/0x120
default_make_function ..
msp_3400c_setbass ..
msp_3410d_thread ..
kernel_thread_helper 0x5/0x10

I guess this is something the v4l2 maintainer needs to look at.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
