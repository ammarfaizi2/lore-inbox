Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVH3Guw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVH3Guw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 02:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVH3Guw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 02:50:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:37079 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750964AbVH3Guw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 02:50:52 -0400
Subject: Re: Ignore disabled ROM resources at setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       greg@kroah.com, helgehaf@aitel.hist.no
In-Reply-To: <Pine.LNX.4.58.0508292226580.3243@g5.osdl.org>
References: <1125371996.11963.37.camel@gaston>
	 <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
	 <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>
	 <20050829.212021.43291105.davem@davemloft.net>
	 <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org>
	 <1125377367.11948.54.camel@gaston>
	 <Pine.LNX.4.58.0508292226580.3243@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 16:46:02 +1000
Message-Id: <1125384362.11963.72.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 22:29 -0700, Linus Torvalds wrote:
> 
> On Tue, 30 Aug 2005, Benjamin Herrenschmidt wrote:
> > 
> > I was just testing a slightly different one that appear to fix the
> > problem :
> ...
> > +	rom_addr = region.start | (res->flags & PCI_REGION_FLAG_MASK);
> 
> I worry about this one. It's not really correct. The low en bits are 
> "reserved", and while I don't know whether writing zero is always correct, 
> I do know that just writing the low 4 bits with the old value is a bit 
> strange. And the flags don't save the other bits.
> 
> So I'd prefer either my previous diff, or one that just re-reads the bits 
> entirely, something like the appended..

Can you keep the part of my patch that adds error checking on the result
of pci_assign_resource() ?

> What does the PCI spec say about the reserved bits? Do we have to save 
> them?

I didn't see anything special about them, but I may have missed it.

Ben.



