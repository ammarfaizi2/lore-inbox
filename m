Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319290AbSHGTkt>; Wed, 7 Aug 2002 15:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319291AbSHGTkt>; Wed, 7 Aug 2002 15:40:49 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:45318 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S319290AbSHGTkr>; Wed, 7 Aug 2002 15:40:47 -0400
Date: Wed, 7 Aug 2002 21:43:55 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: [SOLVED] kernel BUG at tg3.c:1557
In-Reply-To: <Pine.LNX.4.44.0208072113150.3705-100000@pc40.e18.physik.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0208072143180.3705-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Roland Kuhn wrote:

> > static void tg3_write_mailbox_reg32(struct tg3 *tp, u32 off, u32 val)
> > {
> >         unsigned long flags;
> > 
> >         spin_lock_irqsave(&tp->indirect_lock, flags);
> >         writel(val, tp->regs + off);
> >         spin_unlock_irqrestore(&tp->indirect_lock, flags);
> > }
> > 
> > and that plain works. That means that only the mailbox writes have 
> > additional locking around the otherwise unchanged writel() call. Does the 
> > spin_lock_irqsave/spin_unlock_irqrestore take care of the PCI ordering?
> > 
> While loading properly, this still crashed the machine. After giving it
> some thought I tried to add a dummy pci_read_config_dword() just before
> the writel(), and that works! I use this function both for tr32 and
> tr32_mailbox. I hammered it over one hour with a script that crashed it
> always in five seconds, and not so much as a hiccup :-)
> 
Sorry, I meant tw32 and tw32_mailbox.

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

