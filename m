Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966573AbWKOEPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966573AbWKOEPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966571AbWKOEPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:15:48 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21378
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S966101AbWKOEPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:15:47 -0500
Date: Tue, 14 Nov 2006 20:15:49 -0800 (PST)
Message-Id: <20061114.201549.69019823.davem@davemloft.net>
To: jeff@garzik.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: David Miller <davem@davemloft.net>
In-Reply-To: <455A938A.4060002@garzik.org>
References: <20061114.192117.112621278.davem@davemloft.net>
	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
	<455A938A.4060002@garzik.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Tue, 14 Nov 2006 23:11:54 -0500

> Linus Torvalds wrote:
> > HOWEVER - that's only true on systems with no other PCI bridges. Even if 
> > you have an Intel NB/SB, what about other bridges in that same system, and 
> > the devices behind them? 
> > 
> > Now, I think that a MSI thing should look like a PCI write to a magic 
> > address (I'm really not very up on it, so correct me if I'm wrong), and 
> > thus maybe bridges are bound to get it right, and the only thing we really 
> > need to worry about is the host bridge. Maybe. In that case, it might be 
> > sensible to have a host-bridge white-table, and if we know all Intel 
> > bridges that claim to support MSI do so correctly, then maybe we can just 
> > say "ok, always enable it for Intel host bridges".
> 
> That's pretty much the idea behind MSI... it looks like any other PCI 
> bus transaction, rather than needing a separate pin.

Yep.

> > But right now I'm not convinced we really know what all goes wrong. Maybe 
> > it's just broken NVidia and AMD bridges. But maybe it's also individual 
> > devices that continue to (for example) raise _both_ the legacy IRQ line 
> > _and_ send an MSI request.
> 
> That reminds me of a potential driver bug -- MSI-aware drivers need to 
> call pci_intx(pdev,0) to turn off the legacy PCI interrupt, before 
> enabling MSI interrupts.

Is this absolutely true?  I've never been sure about this point, and I
was rather convinced after reading various documents that once you
program up the MSI registers to start generating MSI this implicitly
disabled INTX and this was even in the PCI specification.

It would be great to get a definitive answer on this.

If it is mandatory, perhaps the driver shouldn't be doing it and
rather the PCI layer MSI enabling should.
