Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318590AbSHGQY4>; Wed, 7 Aug 2002 12:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318572AbSHGQY4>; Wed, 7 Aug 2002 12:24:56 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:43013 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318590AbSHGQYz>; Wed, 7 Aug 2002 12:24:55 -0400
Date: Wed, 7 Aug 2002 18:28:04 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at tg3.c:1557
In-Reply-To: <20020807.082445.03541415.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0208071825500.3705-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, David S. Miller wrote:

>    From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
>    Date: Wed, 7 Aug 2002 17:36:25 +0200 (CEST)
>    
>    How can I help to track this down?
> 
> I'm stumped, sorry.

Just out of curiosity I tried it with

static void tg3_write_mailbox_reg32(struct tg3 *tp, u32 off, u32 val)
{
        unsigned long flags;

        spin_lock_irqsave(&tp->indirect_lock, flags);
        writel(val, tp->regs + off);
        spin_unlock_irqrestore(&tp->indirect_lock, flags);
}

and that plain works. That means that only the mailbox writes have 
additional locking around the otherwise unchanged writel() call. Does the 
spin_lock_irqsave/spin_unlock_irqrestore take care of the PCI ordering?

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

