Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVCLDe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVCLDe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 22:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVCLDe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 22:34:26 -0500
Received: from peabody.ximian.com ([130.57.169.10]:48825 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261825AbVCLDeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 22:34:23 -0500
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
	interrupts. Fish. Please report.]
From: Adam Belay <abelay@novell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <Pine.LNX.4.58.0502192000140.14916@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
	 <1108863372.8413.158.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502191757170.14706@ppc970.osdl.org>
	 <1108870731.8413.163.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502192000140.14916@ppc970.osdl.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 22:31:31 -0500
Message-Id: <1110598291.12485.269.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 20:02 -0800, Linus Torvalds wrote:
> 
> On Sat, 19 Feb 2005, Steven Rostedt wrote:
> >
> > On Sat, 2005-02-19 at 18:10 -0800, Linus Torvalds wrote:
> > 
> > > I _think_ it's the code in arch/i386/pci/fixup.c that does this. See the
> > > 
> > > 	static void __devinit pci_fixup_transparent_bridge(struct pci_dev *dev)
> > > 
> > > thing, and try to disable it. Maybe that rule is wrong, and triggers much 
> > > too often?
> > > 
> > 
> > Linus,
> > 
> > Thank you very much! That was it.  The following patch made everything
> > look good.
> 
> Ok. I've fired off an email to some Intel people asking what the
> real rules are wrt Intel PCI-PCI bridges. It may be that it's not that 
> particular chip, but some generic rule (like "all Intel bridges act like 
> they are subtractive decode _except_ if they actually have the IO 
> start/stop ranges set" or something like that).
> 
> If anybody on the list can figure the Intel bridge decoding rules out, 
> please holler..
> 
> 			Linus

Actually, I've ran into a similar situation on my hardware.  After
looking into it for a while, I'm pretty sure it's actually a transparent
bridge (despite it not indicating such in the programing interface class
code).  Have you heard anything more?

Thanks,
Adam


