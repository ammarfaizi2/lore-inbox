Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbRF3IPA>; Sat, 30 Jun 2001 04:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264868AbRF3IOv>; Sat, 30 Jun 2001 04:14:51 -0400
Received: from mail.aslab.com ([205.219.89.194]:30039 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S264867AbRF3IOm>;
	Sat, 30 Jun 2001 04:14:42 -0400
Date: Sat, 30 Jun 2001 01:14:36 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)V3
In-Reply-To: <3B3CC466.9CAC4365@t-online.de>
Message-ID: <Pine.LNX.4.04.10106300108040.7941-100000@mail.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Okay my bad it is ATA-1 but even that does not explain the bit.
only that section 7.2.6 top of page 14 (index numbers) defines it to be
set to 1 with out a reason.

This this is a pre-ATA thing back in IDE.

If you really want to know the answer I can go dig it up, but later.

Cheers,

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

On Fri, 29 Jun 2001, Gunther Mayer wrote:

> Andre Hedrick wrote:
> > 
> > That is a legacy bit from ATA-2 but it is one of those things you can not
> > get rid of :-( even thou things are obsoleted, they are not retired.
> > This means that you have to go back into the past to see how it was used,
> > silly!  I hope you agree to that point.
> 
> No,
> in ANSI X3.279-1996, "AT Attachment Interface with Extensions (ATA-2)",
> Approved September 11, 1996 , control register bit 3-7 are reserved.
> 
> However ANSI X3.221-1994, "AT Attachment Interface for Disk Drives",
> Approved May 12, 1994, bit3 is "1" and bits 4-7 are "x". No further explanation.
> 
> How far back must we go, to get the sense ?
> 
> > 
> > This is the drive->ctrl register pointer.
> > 
> > outp(drive->ctl|0x02, IDE_CONTROL_REG);
> > 
> > typedef union {
> >         unsigned all                    : 8;    /* all of the bits together */
> >         struct {
> >                 unsigned bit0           : 1;
> >                 unsigned nIEN           : 1;    /* device INTRQ to host */
> >                 unsigned SRST           : 1;    /* host soft reset bit */
> >                 unsigned bit3           : 1;    /* ATA-2 thingy */
> >                 unsigned reserved456    : 3;
> >                 unsigned HOB            : 1;    /* 48-bit address ordering */
> >         } b;
> > } control_t;
> > 
> > This is a new struct that is to be added for 48-bit addressing and it will
> > reflect drive->ctl soon.  I have not decided how to use it best or at all,
> > but it has meaning and once I add-in the real def of bit3 then I will not
> > need to look it up again.
> 

