Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVBTECY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVBTECY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 23:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVBTECX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 23:02:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:41155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261511AbVBTECT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 23:02:19 -0500
Date: Sat, 19 Feb 2005 20:02:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
 interrupts. Fish. Please report.]
In-Reply-To: <1108870731.8413.163.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0502192000140.14916@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org> 
 <1108863372.8413.158.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0502191757170.14706@ppc970.osdl.org>
 <1108870731.8413.163.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Feb 2005, Steven Rostedt wrote:
>
> On Sat, 2005-02-19 at 18:10 -0800, Linus Torvalds wrote:
> 
> > I _think_ it's the code in arch/i386/pci/fixup.c that does this. See the
> > 
> > 	static void __devinit pci_fixup_transparent_bridge(struct pci_dev *dev)
> > 
> > thing, and try to disable it. Maybe that rule is wrong, and triggers much 
> > too often?
> > 
> 
> Linus,
> 
> Thank you very much! That was it.  The following patch made everything
> look good.

Ok. I've fired off an email to some Intel people asking what the
real rules are wrt Intel PCI-PCI bridges. It may be that it's not that 
particular chip, but some generic rule (like "all Intel bridges act like 
they are subtractive decode _except_ if they actually have the IO 
start/stop ranges set" or something like that).

If anybody on the list can figure the Intel bridge decoding rules out, 
please holler..

			Linus
