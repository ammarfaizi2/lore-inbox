Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbRDBQiH>; Mon, 2 Apr 2001 12:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130834AbRDBQh5>; Mon, 2 Apr 2001 12:37:57 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:44037
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130448AbRDBQho>; Mon, 2 Apr 2001 12:37:44 -0400
Date: Mon, 23 Apr 2001 22:04:23 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: nerijusb@takas.lt
cc: linux-kernel@vger.kernel.org
Subject: RE: Promise 20267 "working" but no UDMA
In-Reply-To: <MPBBJGBJAHHNDMMBBLMIKELIGLAB.nerijus@users.sourceforge.net>
Message-ID: <Pine.LNX.4.10.10104232157390.12531-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2001, Nerijus Baliunas wrote:

> > > PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
> Mode.
> 
> How does MASTER mode differ from PCI?

Master mode is in BIOS RAID, and PCI is BIOS non-RAID
What I have not thought about doing is forcing all "MASTER" modes into
"PCI" modes.  In theory it may work because it changes the properties of
the chips behavior.

> I have:
> PDC20267: IDE controller on PCI bus 00 dev 50
> PDC20267: chipset revision 2
> PDC20267: not 100% native mode: will probe irqs later
> PDC20267: ROM enabled at 0xe8000000
> PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
> 
> Another question - I have Promise Ultra100 and 2 disks:
> 
> hda: QUANTUM FIREBALL CX10.2A, 9787MB w/418kB Cache, CHS=19885/16/63, UDMA(33)
> hdc: IBM-DTLA-305030, 29314MB w/380kB Cache, CHS=59560/16/63, UDMA(100)
> 
> Why Quantum is shown as UDMA 33 when Promise BIOS shows it as UDMA 66?
> 
> Why DMA Mode:       UDMA 4 in /proc/ide/pdc202xx for IBM disk?
> Shouldn't it be UDMA 5?

This is what I love about Promise.
Mode 4 and Mode 5 have the exact same timings to the BUS; however, issuing
a setfeatures command to jump from Mode 4 to Mode 5, the card does voodoo
sensing.  It does internal tracking of the drive betweem these two modes
and auto-sets things in the chip.

If they can put that level of logic in the chips, it would be nice to have
it auto timing based on any setfeatures call to set the transfer rates.

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

