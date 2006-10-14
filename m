Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWJNCdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWJNCdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 22:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWJNCdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 22:33:06 -0400
Received: from mx2.rowland.org ([192.131.102.7]:47876 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1030213AbWJNCdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 22:33:05 -0400
Date: Fri, 13 Oct 2006 22:33:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <matthew@wil.cx>,
       Adam Belay <abelay@MIT.EDU>, Arjan van de Ven <arjan@infradead.org>,
       Greg KH <greg@kroah.com>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
In-Reply-To: <1160780425.4792.275.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006, Benjamin Herrenschmidt wrote:

> Well, we have two different things here.
> 
> One is short term block. For example, PM transitions, or BIST. In that
> case, I reckon it might be worth just making the user space PCI config
> space accessors block in the kernel during the transition (a wait
> queue ?)

That seems like a reasonable thing to do.  (BTW, can anyone explain 
quickly what "BIST" means?)

> One is long term block: the device is off. That's where it becomes
> tricky. For D3, I suppose it's actually correct to return cached infos
> provided that those do actually cache the PM capability indicating D3
> state (that is we need to update the cache after the transition). And
> it's correct to prevent writes too I suppose.
> 
> Then there are problems with things like embedded or some Apple ASICs
> where we toggle power/clock lines of devices but not directly using PCI
> PM (in fact, those devices might not even have PCI PM capability
> exposed). Returning cached info is fine, but we can't tell userland
> about the powered off (or unclocked) state of the device that way.

Now you're starting to tread in the dangerous waters of runtime PM
userspace APIs.  So far nobody has figured out a good general way of
exposing internal power states to userspace.  There may not even be such a 
thing.

Alan Stern

