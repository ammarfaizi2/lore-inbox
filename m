Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbVKCUwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbVKCUwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVKCUwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 15:52:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:17324 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932565AbVKCUwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 15:52:43 -0500
Date: Thu, 3 Nov 2005 21:53:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: First steps towards making NO_IRQ a generic concept
Message-ID: <20051103205303.GA8001@elte.hu>
References: <20051103144926.GV23749@parisc-linux.org> <20051103145118.GW23749@parisc-linux.org> <20051103154439.GA28190@elte.hu> <20051103160252.GA23749@parisc-linux.org> <20051103162059.GA495@elte.hu> <20051103170559.GB23749@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103170559.GB23749@parisc-linux.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matthew Wilcox <matthew@wil.cx> wrote:

> On Thu, Nov 03, 2005 at 05:20:59PM +0100, Ingo Molnar wrote:
> > ok, understood. I'm wondering, why is there any need to do a PCI_NO_IRQ?  
> > Why not just a generic NO_IRQ. It's not like we can or want to make them 
> > different in the future. The interrupt vector number is a generic thing 
> > that attaches to the platform via request_irq() - there is nothing 'PCI' 
> > about it. So the PCI layer shouldnt pretend it has its own IRQ 
> > abstraction - the two are forcibly joined. The same goes for 
> > pci_valid_irq() - we should only have valid_irq(). Am i missing 
> > anything?
> 
> The last patch in this vein will delete PCI_NO_IRQ, replacing it with 
> NO_IRQ.  To make that final patch small, I wanted to introduce an 
> abstraction that PCI drivers could use.  Possibly it's not well 
> thought out.  Do you think we should put in the explicit compares 
> against PCI_NO_IRQ as we find drivers that care and then do a big 
> sweep when we think we've found them all?

i missed the detail that we want to have PCI_NO_IRQ at 0, while keeping 
NO_IRQ at -1 - so the namespaces have to be separate, temporarily. So 
your approach is fine.

	Ingo
