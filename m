Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130314AbRBTTJI>; Tue, 20 Feb 2001 14:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130413AbRBTTI6>; Tue, 20 Feb 2001 14:08:58 -0500
Received: from [62.172.234.2] ([62.172.234.2]:53326 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130314AbRBTTIm>; Tue, 20 Feb 2001 14:08:42 -0500
Date: Tue, 20 Feb 2001 19:08:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Andre Hedrick <andre@linux-ide.org>, Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] meaningless #ifndef?
In-Reply-To: <20010220192056.A6846@suse.cz>
Message-ID: <Pine.LNX.4.21.0102201849140.1138-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Vojtech Pavlik wrote:
> On Tue, Feb 20, 2001 at 05:45:52PM +0000, Hugh Dickins wrote:
> > > > byte eighty_ninty_three (ide_drive_t *drive)
> > > > {
> > > >         return ((byte) ((HWIF(drive)->udma_four) &&
> > > > #ifndef CONFIG_IDEDMA_IVB
> > > >                         (drive->id->hw_config & 0x4000) &&
> > > > #endif /* CONFIG_IDEDMA_IVB */
> > > >                         (drive->id->hw_config & 0x6000)) ? 1 : 0);
> > > > }
> 
> Well, the code looks weird. However, it doesn't behave the same when
> CONFIG_IDEDMA_IVB is enabled or not. If it is not, normal case, it's
> just:
> 
> (drive->id->hw_config & 0x6000)
> 
> If CONFIG_IDEDMA_IVB is enabled, it boils down to:
> 
> (drive->id->hw_config & 0x4000)
> 
> because the second bit test includes the earlier test already only
> loosening it. Because of that, it's superfluous. And the code relies on
> the compiler to optimize it out.

Thank you for re-explaining this to me.
Yes, you are right, I was wrong, I now
admit my &s and &&s behave like yours,
and I apologize to Andre!

> If written like:
> 
> #ifndef CONFIG_IDEDMA_IVB
> #define IDE_UDMA_MASK 0x4000
> #else
> #define IDE_UDMA_MASK 0x6000
> #endif /* CONFIG_IDEDMA_IVB */
> 
> byte eighty_ninty_three (ide_drive_t *drive)
> {       
>         return HWIF(drive)->udma_four &&
> 		(drive->id->hw_config & IDE_UDMA_MASK);
> }
> 
> it'd be probably somewhat clearer.

That would certainly have helped us!

Hugh

