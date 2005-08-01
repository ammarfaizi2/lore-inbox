Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVHAVwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVHAVwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVHAVt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:49:58 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:56713 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261293AbVHAVtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:49:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: revert yenta free_irq on suspend
Date: Mon, 1 Aug 2005 23:54:57 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com> <200507312215.04494.rjw@sisk.pl> <Pine.LNX.4.61.0508012117431.6027@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508012117431.6027@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508012354.58105.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 1 of August 2005 22:34, Hugh Dickins wrote:
> On Sun, 31 Jul 2005, Rafael J. Wysocki wrote:
> > On Sunday, 31 of July 2005 01:09, Rafael J. Wysocki wrote:
> > > 
> > > Linus has apparently dropped that patch for yenta, but in case it is
> > > reintroduced in the future you will probably need a patch to make the network
> > > driver cooperate.  I'll try to prepare one tomorrow, if I can, but I have no hardware
> > > to test it.
> > 
> > The patch follows.  It compiles and should work, though I haven't tested it.
> 
> Thanks for making the effort, Rafael,
> but I'm afraid your patch does not solve it.
> 
> Prior to -rc4, or in current -git which has the yenta patch reverted,
> my laptop manages APM resume from RAM with the following 8 messages
> (I won't complain that it could list even more permutations!)
> 
> PCI: Found IRQ 11 for device 0000:00:1f.1
> PCI: Sharing IRQ 11 with 0000:02:00.0
> PCI: Found IRQ 11 for device 0000:02:00.0
> PCI: Sharing IRQ 11 with 0000:00:1f.1
> PCI: Found IRQ 11 for device 0000:02:01.0
> PCI: Sharing IRQ 11 with 0000:02:01.1
> PCI: Found IRQ 11 for device 0000:02:01.1
> PCI: Sharing IRQ 11 with 0000:02:01.0
> 
> Unpatched -rc4 locks up on resume, showing none of those messages.
> -rc4 with your drivers/net/3c59x.c patch locks up on resume,
> after showing just the first four of those messages.

Thanks for testing.  The results you observe mean that the problem is
in fact more complicated than I thought.  It seems to make up a good
test case but I wouldn't like to bother you any more. :-)

> Whatever, I very much share the position Linus has expressed so
> forcefully: it's foolish suddenly to demand changes in an indeterminate
> number of drivers (surely yenta and 3c59x aren't the end of it?),
> especially in the final days leading up to a release.

Fully agreed.

> I surely would not have asked him to revert the yenta patch, nor would
> he have done so (thank you, Linus), if my machine were the only problem.
> It's very easy for me to carry my own patches to get working, but we
> fear the trouble seen here gives a foretaste of others' trouble if
> the changes were to remain in the release.

Indeed.

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
