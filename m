Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129698AbRBTRqQ>; Tue, 20 Feb 2001 12:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130184AbRBTRqG>; Tue, 20 Feb 2001 12:46:06 -0500
Received: from [62.172.234.2] ([62.172.234.2]:1751 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S129578AbRBTRpu>;
	Tue, 20 Feb 2001 12:45:50 -0500
Date: Tue, 20 Feb 2001 17:45:52 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] meaningless #ifndef?
In-Reply-To: <Pine.LNX.4.21.0102201705280.11260-100000@alloc>
Message-ID: <Pine.LNX.4.21.0102201730260.1046-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Andre Hedrick wrote:
> On Mon, 19 Feb 2001, Pozsar Balazs wrote:
> 
> > from drivers/ide/ide-features.c:
> > 
> > /*
> >  *  All hosts that use the 80c ribbon mus use!
> >  */
> > byte eighty_ninty_three (ide_drive_t *drive)
> > {
> >         return ((byte) ((HWIF(drive)->udma_four) &&
> > #ifndef CONFIG_IDEDMA_IVB
> >                         (drive->id->hw_config & 0x4000) &&
> > #endif /* CONFIG_IDEDMA_IVB */
> >                         (drive->id->hw_config & 0x6000)) ? 1 : 0);
> > }
> > 
> > If i see well, then this is always same whether CONFIG_IDEDMA_IVB is
> > defined or not.
> > What's the clue?
> 
> (drive->id->hw_config & 0x4000)
> 	mask off 0x4000 for presence.
> (drive->id->hw_config & 0x6000) 
> 	mask off 0x2000 ot 0x4000 for presence.
> 
> The first is true only if bit 14 is set.
> The second is true if either bit 13 or 14 is set.
> 
> Togather they test for two bits.
> The first test is exclusive to bit 14
> The second test is inclusive of bits 13 and 14.
> 
> Because some older drives set only bit 13 for the device side cable-detect,
> then newer drives than these did a supported mode bit 14 and no bits 13,
> then others do both.
> 
> So in order to have a test that supports ATA-4/5/6 you have to allow
> users the option to disable the newer sense code that is only valid for
> ATA-5/6.  It will get messier still.

Andre, please read through that code again, and through your reply.
It seems to me that Poszar is absolutely right, and your reply is
(once again) just saying "there's lots of confusion out there, so
my code has to be confused too".  Or do your &s and &&s behave
differently from ours?

Hugh

