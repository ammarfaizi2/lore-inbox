Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbRA3UQx>; Tue, 30 Jan 2001 15:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131799AbRA3UQn>; Tue, 30 Jan 2001 15:16:43 -0500
Received: from smtppop3pub.gte.net ([206.46.170.22]:33634 "EHLO
	smtppop3pub.verizon.net") by vger.kernel.org with ESMTP
	id <S129886AbRA3UQ3>; Tue, 30 Jan 2001 15:16:29 -0500
Message-ID: <3A7720C3.FFE5C981@gte.net>
Date: Tue, 30 Jan 2001 15:14:59 -0500
From: Stephen Clark <sclark46@gte.net>
Reply-To: sclark46@gte.net
Organization: Paradigm 4
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Tobias Ringstrom <tori@tellus.mine.nu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] No VIA IDE DMA unless configured
In-Reply-To: <Pine.LNX.4.30.0101232239280.27097-100000@svea.tellus> <20010124102418.B1031@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

from .config on 2.4.1
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y

Shouldn' t the value be CONFIG_IDEDMA_PCI_AUTO instead of CONFIG_IDEDMA_AUTO
in the code below?

Steve

Vojtech Pavlik wrote:

> On Tue, Jan 23, 2001 at 10:46:14PM +0100, Tobias Ringstrom wrote:
>
> > Linus, please consider this patch for 2.4.1.  It makes sure the VIA IDE
> > driver does not enable DMA automatically, unless the user has requested it
> > using "make whateverconfig".
> >
> > /Tobias
> >
> > --- via82cxxx.c.orig  Tue Jan 23 22:26:25 2001
> > +++ via82cxxx.c       Tue Jan 23 22:27:05 2001
> > @@ -602,7 +602,9 @@
> >  #ifdef CONFIG_BLK_DEV_IDEDMA
> >       if (hwif->dma_base) {
> >               hwif->dmaproc = &via82cxxx_dmaproc;
> > +#ifdef CONFIG_IDEDMA_AUTO
> >               hwif->autodma = 1;
> > +#endif /* CONFIG_IDEDMA_AUTO */
> >       }
> >  #endif /* CONFIG_BLK_DEV_IDEDMA */
> >  }
> >
>
> Linus, if you haven't applied my disable-dma-in-all-cases patch I've
> sent you earlier, please do apply this one - it's correct and should be
> there. It conflicts with the older one, obviously.
>
> --
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
