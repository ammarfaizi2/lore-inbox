Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUKVU7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUKVU7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbUKVU4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:56:14 -0500
Received: from fmr99.intel.com ([192.55.52.32]:20436 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262384AbUKVUw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:52:28 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411221226310.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe>
	 <Pine.LNX.4.58.0411200831560.20993@ppc970.osdl.org>
	 <1101150469.20006.46.camel@d845pe>
	 <Pine.LNX.4.58.0411221116480.20993@ppc970.osdl.org>
	 <1101155077.20006.110.camel@d845pe>
	 <Pine.LNX.4.58.0411221226310.20993@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1101156677.20006.139.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Nov 2004 15:51:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 15:31, Linus Torvalds wrote:
> 
> On Mon, 22 Nov 2004, Len Brown wrote:
> > >
> > > And not doing it breaks systems.
> >
> > I'm not aware (yet) of any systems where disabling all the links
> (which
> > we've been doing since June, BTW)
> 
> We have been doing it since June, but we also immediately _re-enabled_
> them.

Mostly true.

We re-enabled all the links for which we found PCI devices.
This is a super-set of all the links with device-drivers.

But it is also a sub-set of the total population of links -- some BIOSs
enabled links for which there were no devices attached.  This caused two
problems.  First there were suprious interrupts on some boxes, and
second in the case where we enabling balacing IRQs (default in IOAPIC
mode, requires "acpi_irq_balance" in PIC mode) it ate up IRQs and forced
more sharing.

> IOW, I'll claim that the only thing that has really gotten testing
> since June is the thing that disables and immediately re-enables the
> links.
> 
> And that's exactly why I think the "minimally disruptive" fix is to
> not disable them at all, but just fix up ELCR for anything that was
> already enabled. Since that _is_ what "disable + re-enable" ends up
> actually doing.
> 
> See my argument?

"minimally distruptive" undertood, Yes.

"minimal risk", OTOH is to return to what we did in 2.6.9.

Note, for the record, that Bjorn's patch to remove the paranoia loop and
add the pci=routeirq override came to you through the -mm tree, not
through the ACPI tree.  I think that Bjorn was as surprised as I was
that it appeared in 2.6.10-rc2.

-Len


