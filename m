Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265681AbUGGXYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUGGXYV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 19:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbUGGXYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 19:24:21 -0400
Received: from hera.cwi.nl ([192.16.191.8]:23960 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265681AbUGGXYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 19:24:18 -0400
Date: Thu, 8 Jul 2004 01:24:10 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Frediano Ziglio <freddyz77@tin.it>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>
Subject: Re: EDD enhanchement patch
Message-ID: <20040707232409.GC11556@apps.cwi.nl>
References: <1089132808.4435.8.camel@freddy> <20040707174015.GB11556@apps.cwi.nl> <1089233331.6856.20.camel@freddy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089233331.6856.20.camel@freddy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 10:48:51PM +0200, Frediano Ziglio wrote:

> Did anyone forget about first fields? base-port and control-port ? If
> you have an IDE disk they correspond with IDE port and with slave bit
> you can know exactly which disk is. EDD 3.0 it's not required cause it's
> EDD 2.0 (supported by most recent BIOSes).

True. Below a simple example for hda and hdb.
Yes, having EDD 2.0 helps.

> lba 0 ?? cursize 0 ?? sector > 63 ??
> IMHO this disk doesn't exist...

It was hdh: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive, with geometry
(probably 96/64/32, don't know why C and S are interchanged)
obtained from HDIO_GET_IDENTITY.

> For 0x84 it must be hda cause it's the first IDE.

hda or hdb. Since that system boots from SCSI there is no reason to
prefer seeing the first or second IDE disk in the BIOS setup.
(Don't know anymore what the truth was.)

> I know that some boot loader can however change disk order.

Also Linux can change disk order with boot option "ide=reverse".

Andries

----------------------------------------------------------------------------------------
disk 0: len=30 api=0x1
  flags 2, phys CHS 2100/255/63, totsecs 33736500, seclen 512
iobase 0x1f0  controlport 0x3f6 irq 14 sector_count 16 dma 32 pio 4
flags: 0xe0: LBA, Master; revision 1.1

disk 1: len=30 api=0x1
  flags 2, phys CHS 2100/255/63, totsecs 33736500, seclen 512
iobase 0x1f0  controlport 0x3f6 irq 14 sector_count 16 dma 32 pio 4
flags: 0xf0: LBA, Slave; revision 1.1

Found 2 Linux disks

hda: Size  33750864 LinuxCHS=2100/255/63 FdiskCHS=*/0/63
  LBASize  33750864 CurSize  33750864  RawCHS=33483/16/63 CurCHS=2100/255/63
hdb: Size  33750864 LinuxCHS=2100/255/63 FdiskCHS=*/255/63
  LBASize  33750864 CurSize  33750864  RawCHS=33483/16/63 CurCHS=2100/255/63

Found 2 BIOS disks

0 of 2:   33720435 sectors, C/H/S 1024 / 255 / 63 C*H*S=16450560
1 of 2:   33720435 sectors, C/H/S 1024 / 255 / 63 C*H*S=16450560


hda: 0x80
hdb: 0x81
----------------------------------------------------------------------------------------

