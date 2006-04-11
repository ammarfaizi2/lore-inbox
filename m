Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWDKRHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWDKRHo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 13:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWDKRHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 13:07:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5255 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751022AbWDKRHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 13:07:31 -0400
Date: Tue, 11 Apr 2006 19:07:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Neil Brown <neilb@suse.de>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to correct ELCR? - was Re: [PATCH 2.6.16] Shared interrupts sometimes lost
Message-ID: <20060411170728.GB1893@elf.ucw.cz>
References: <5Zd5E-3vi-7@gated-at.bofh.it> <4437C45E.8010503@shaw.ca> <17464.55398.270243.839773@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17464.55398.270243.839773@cse.unsw.edu.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  However there is room for a race here.  If an event occurs between
> > >  the read and the write, then this will NOT de-assert the IRQ line.
> > >  It will remain asserted throughout.
> > > 
> > >  Now if the IRQ is handled as an edge-triggered line (which I believe
> > >  they are in Linux), then losing this race will mean that we don't see
> > >  any more interrupts on this line.
> > 
> > PCI interrupts should always be level triggered, not edge triggered 
> 
> Ok... so I guess I jumped to the wrong conclusion. Thanks for
> straightening me out.
> But it is behaving like edge-triggered..
> 
> So I have explored about the i8259 (wikipedia helped) and discovered
> the ELCR (Edge/Level Control Register).  Apparently this is meant to
> be set up by the BIOS to the correct values.  It seems that this isn't
> happening. 
> 
> It seems to get the value 0x0800 which corresponds to IRQ11 being the
> only level-triggered interrupt.  But I need IRQ10 to be level
> triggered.  I hacked the code to set the 0x0400 bit, and it seems to
> work OK without my other patch.
> 
> Now I just need a way to set this correctly at boot time without a
> hack.
> 
> I currently have Linux compiled without ACPI support (as I don't
> really want that and being an oldish notebook I gather it has a good
> chance of causing problems) so that isn't fiddling with the ELCR.

Can you try to enable ACPI and/or APIC? Some machines are known to
require APIC...
								Pavel

-- 
Thanks for all the (sleeping) penguins.
