Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSE1OX1>; Tue, 28 May 2002 10:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316620AbSE1OX0>; Tue, 28 May 2002 10:23:26 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:16389 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S316619AbSE1OXZ>; Tue, 28 May 2002 10:23:25 -0400
Date: Tue, 28 May 2002 15:54:19 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: ehci-hcd on CARDBUS hangs when stopping card service
Message-ID: <20020528155419.E681@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <acm1vp$2ak$1@penguin.transmeta.com> <20020523171326.GA11562@kroah.com> <3CED6E0B.8020501@pacbell.net> <acm1vp$2ak$1@penguin.transmeta.com> <28429.1022420490@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 02:41:30PM +0100, David Woodhouse wrote:
> torvalds@transmeta.com said:
> >  Also, it's generally a good idea to "just say no" to endless loops in
> > drivers. Hardware bugs _do_ happen, and it's a lot more pleasant to
> > have the driver do a
> > 	printk("Device does not respond\n");
> > than for the kernel to hang.
> 
> Too late. On some hardware, if you try to talk to the device once it's 
> gone, you're already dead. Not all the world is a PeeCee.

That happens even on a "PeeCee". 

Situation: 
   - Normal readl() of a ioremap()ed register set of a
     PCI device[1]:
   -> machine hangs hard (no magic sysrq possible, no Ooops, no
      panic printed) 
      
   - Several DWORD reads of the same register set succeded before
     and the register is wired according to the SPEC.


Just to provide an argument here

PS: I wish I had an PCI Analyzer available...

[1] TI TMS320C6x EVM Board[2], Rev. 3 
   with PCI-Bridge Chip AMCC S5933[3] hanging the host side on Busmaster DMA.

[2] PCI-ID: 0x104c:0x1002
[3] PCI-ID: 0x10e8:0x4750 or 0x10e8:0x807d or 0x10e8:0x809c
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
