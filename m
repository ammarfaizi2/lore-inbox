Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263180AbVG3XEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbVG3XEK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 19:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbVG3XEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 19:04:10 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:37052 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S263180AbVG3XEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 19:04:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: revert yenta free_irq on suspend
Date: Sun, 31 Jul 2005 01:09:16 +0200
User-Agent: KMail/1.8.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com> <200507310000.10229.rjw@sisk.pl> <Pine.LNX.4.61.0507302318090.5286@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0507302318090.5286@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507310109.16876.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 31 of July 2005 00:24, Hugh Dickins wrote:
> On Sun, 31 Jul 2005, Rafael J. Wysocki wrote:
> > On Saturday, 30 of July 2005 23:32, Hugh Dickins wrote:
> > > On Sat, 30 Jul 2005, Rafael J. Wysocki wrote:
> > > > 
> > > > Could you please send the /proc/interrupts from your box?
> > > 
> > >  11:      57443          XT-PIC  yenta, yenta, eth0
> > 
> > Thanks.  It looks like eth0 gets a yenta's interrupt and goes awry.
> > Could you please tell me what driver the eth0 is?
> 
> CONFIG_VORTEX drivers/net/3c59x.c:
> 0000:02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.19

Thanks again.  From the first look the suspend/resume routines of the driver
are missing some calls.  In particular, with the IRQ-freeing patch for yenta it is
likely to get an out-of-order interrupt as I suspected.

Linus has apparently dropped that patch for yenta, but in case it is
reintroduced in the future you will probably need a patch to make the network
driver cooperate.  I'll try to prepare one tomorrow, if I can, but I have no hardware
to test it.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
