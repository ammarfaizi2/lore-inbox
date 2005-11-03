Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbVKCRGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbVKCRGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbVKCRGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:06:08 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:64980 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030387AbVKCRGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:06:06 -0500
Date: Thu, 3 Nov 2005 10:05:59 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: First steps towards making NO_IRQ a generic concept
Message-ID: <20051103170559.GB23749@parisc-linux.org>
References: <20051103144926.GV23749@parisc-linux.org> <20051103145118.GW23749@parisc-linux.org> <20051103154439.GA28190@elte.hu> <20051103160252.GA23749@parisc-linux.org> <20051103162059.GA495@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103162059.GA495@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 05:20:59PM +0100, Ingo Molnar wrote:
> ok, understood. I'm wondering, why is there any need to do a PCI_NO_IRQ?  
> Why not just a generic NO_IRQ. It's not like we can or want to make them 
> different in the future. The interrupt vector number is a generic thing 
> that attaches to the platform via request_irq() - there is nothing 'PCI' 
> about it. So the PCI layer shouldnt pretend it has its own IRQ 
> abstraction - the two are forcibly joined. The same goes for 
> pci_valid_irq() - we should only have valid_irq(). Am i missing 
> anything?

The last patch in this vein will delete PCI_NO_IRQ, replacing it with
NO_IRQ.  To make that final patch small, I wanted to introduce an
abstraction that PCI drivers could use.  Possibly it's not well thought
out.  Do you think we should put in the explicit compares against
PCI_NO_IRQ as we find drivers that care and then do a big sweep when we
think we've found them all?
