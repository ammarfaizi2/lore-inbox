Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130086AbRBSWcc>; Mon, 19 Feb 2001 17:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130213AbRBSWcY>; Mon, 19 Feb 2001 17:32:24 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:64014
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130086AbRBSWcN>; Mon, 19 Feb 2001 17:32:13 -0500
Date: Mon, 19 Feb 2001 14:31:55 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Pozsar Balazs <pozsy@sch.bme.hu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] meaningless #ifndef?
In-Reply-To: <Pine.GSO.4.30.0102192252130.7963-100000@balu>
Message-ID: <Pine.LNX.4.10.10102191421140.4861-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Pozsar Balazs wrote:

> from drivers/ide/ide-features.c:
> 
> /*
>  *  All hosts that use the 80c ribbon mus use!
>  */
> byte eighty_ninty_three (ide_drive_t *drive)
> {
>         return ((byte) ((HWIF(drive)->udma_four) &&
> #ifndef CONFIG_IDEDMA_IVB
>                         (drive->id->hw_config & 0x4000) &&
> #endif /* CONFIG_IDEDMA_IVB */
>                         (drive->id->hw_config & 0x6000)) ? 1 : 0);
> }
> 
> If i see well, then this is always same whether CONFIG_IDEDMA_IVB is
> defined or not.
> What's the clue?

(drive->id->hw_config & 0x4000)
	mask off 0x4000 for presence.
(drive->id->hw_config & 0x6000) 
	mask off 0x2000 ot 0x4000 for presence.

The first is true only if bit 14 is set.
The second is true if either bit 13 or 14 is set.

Togather they test for two bits.
The first test is exclusive to bit 14
The second test is inclusive of bits 13 and 14.

Because some older drives set only bit 13 for the device side cable-detect,
then newer drives than these did a supported mode bit 14 and no bits 13,
then others do both.

So in order to have a test that supports ATA-4/5/6 you have to allow
users the option to disable the newer sense code that is only valid for
ATA-5/6.  It will get messier still.

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

