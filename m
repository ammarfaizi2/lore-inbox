Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317340AbSHHMgS>; Thu, 8 Aug 2002 08:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSHHMgS>; Thu, 8 Aug 2002 08:36:18 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:15113 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S317340AbSHHMgR>; Thu, 8 Aug 2002 08:36:17 -0400
Date: Thu, 8 Aug 2002 14:39:56 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: "David S. Miller" <davem@redhat.com>
Cc: kwijibo@zianet.com, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at tg3.c:1557
In-Reply-To: <Pine.LNX.4.44.0208081029320.4709-100000@pc40.e18.physik.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0208081431210.4739-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Roland Kuhn wrote:

> On Wed, 7 Aug 2002, David S. Miller wrote:
> 
> >    From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
> >    Date: Thu, 8 Aug 2002 00:10:31 +0200 (CEST)
> > 
> >    Since the insertion of a dummy write solved the problem, I would say it's 
> >    the chipset's PCI reordering, which is malfunctioning in the 2466.
> > 
> > Roland can you retry using this patch?  The difference from
> > my previous one is that when we use the indirect register
> > writing of the mailbox registers, we offset into the GRCMBOX
> > area of the chip registers.
> > 
> > This seems to be how Broadcom's driver does indirect accesses
> > to mailbox registers.
> > 
> Will try in a minute. Do I understand it correctly, that only the mailbox 
> writes must be done this way? And how do the pci_write_config_dword() 
> functions ensure the right ordering? (Sorry, it was late yesterday and I 
> somehow didn't find the definition of pci_*_config_*().)
> 
Sorry, this was a long minute, however after applying your patch to
vanilla 2.4.19 (tg3 v0.99) by hand (the TG3_FLAG_WOL_SPEED_100MB already
is 0x800 there, and no adjacent bits are free), the kernel simply freezes
when I do "/etc/init.d/network start". The insmod is okay, the messages
look like always, but I could not get any more info on the freeze because
nothing gets written to disk, no output on the screen, no sysrq, ...

If I can do more to help sort this out, please tell me. With my fix to 
prefix every write with a dummy read, the system is rock solid, not a 
single glitch on 12 machines in the last 14 hours.

I'm very curious on how this all works, so would somebody please give me a 
pointer where to start reading concerning linux and PCI 
reordering/pci_write_config_dword?

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+


