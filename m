Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbRF0Vza>; Wed, 27 Jun 2001 17:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbRF0VzU>; Wed, 27 Jun 2001 17:55:20 -0400
Received: from mail.aslab.com ([205.219.89.194]:25213 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S265423AbRF0VzN>;
	Wed, 27 Jun 2001 17:55:13 -0400
Date: Wed, 27 Jun 2001 14:55:05 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
In-Reply-To: <3B3A4748.D7B9168C@t-online.de>
Message-ID: <Pine.LNX.4.04.10106271442210.21460-100000@mail.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gunther,

It fixes a BUG in CFA, but what will it do to the other stuff?
Parse it exclusive to CFA and there is not an issue.

Also look closely....

No all ./arch have a control register doing this randomly without know the
rest of the driver will kill more than it fixes.

static int try_to_identify (ide_drive_t *drive, byte cmd)
{
        int rc;
        ide_ioreg_t hd_status;
        unsigned long timeout;
        unsigned long irqs = 0;
        byte s, a;

        if (IDE_CONTROL_REG) {
<snip>
        } else {
                ide_delay_50ms();
                hd_status = IDE_STATUS_REG;
        }
<snip>
}

It will not be accepted until it correctly address and handles all HOSTs
correctly, period.

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

On Wed, 27 Jun 2001, Gunther Mayer wrote:

> Andre Hedrick wrote:
> > 
> > PARANIOA.
> 
> This is not a valid reason.
> 
> This clearly fixes a bug in linux. Note: the irq disable
> is local to ide-cs. Are you paranoid enough to believe
> enabling the irq by writing globally to the control register that
> existed since ATA will have ill effects? 
> 
> You claim the relevant PCMCIA ATA behaviour is not ATA(>3?) compliant,
> however you didn`t yet give any facts to support this !
> 
> You claim this locks the driver, again no facts.
> 
> 
> > 
> > Remember that ATAPI is generally screwed beyond reality, so adjusting the
> > probe code in general (global) is a bad thing.
> ...
> > On Wed, 27 Jun 2001, Alan Cox wrote:
> > 
> > > > obsoleting ATA-2 did their attention at CFA become alarmed.  I agree that
> > > > there needs to be a fix, but not at the price of locking the rest of the
> > > > driver.  Since we now the identity of the device prior to assigned the
> > > > interrupt we can handle the execption, but you do not go around blanket
> > > > wacking the control register of all devices.
> 
> The proposed patch is very simple (as per Linus' liking). When considering to
> install an earlier (and  global) irq handler I believe you can see
> this will impose a much greater risk !
> 
> > >
> > > I dont see why it locks up the driver ?
> 


