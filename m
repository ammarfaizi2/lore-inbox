Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133023AbREBBCh>; Tue, 1 May 2001 21:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135903AbREBBC1>; Tue, 1 May 2001 21:02:27 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:31500 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S133023AbREBBCO>;
	Tue, 1 May 2001 21:02:14 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15087.23739.557487.505172@argo.ozlabs.ibm.com.au>
Date: Wed, 2 May 2001 11:02:51 +1000 (EST)
To: linux-kernel@vger.kernel.org
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
In-Reply-To: <9cmrcv$20e$1@penguin.transmeta.com>
In-Reply-To: <OF7A9C6B22.E1638E60-ON85256A3F.004EADC7@urscorp.com>
	<9cmrcv$20e$1@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> I would suggest the opposite approach instead: make the PPC just support
> isa_readx/isa_writex instead.

We can certainly do that, no problem.

BUT that won't get a token ring pcmcia card working in the newer
powerbooks, such as the titanium G4 powerbook, because the PCI host
bridge doesn't map any cpu addresses to the bottom 16MB of PCI memory
space.  This is not a problem as far as pcmcia cards are concerned -
the pcmcia stuff just picks an appropriate address (typically in the
range 0x90000000 - 0x9fffffff) and sets the pcmcia/cardbus bridge to
map that to the card.  But it means that the physical addresses for
the card's memory space will be above the 16MB point, so it is
essential to do the ioremap.

Paul.
