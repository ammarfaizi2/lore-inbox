Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVAYHhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVAYHhs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVAYHhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:37:36 -0500
Received: from fmr15.intel.com ([192.55.52.69]:60392 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261855AbVAYHhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:37:03 -0500
Subject: Re: [PATCH 6/29] x86-apic-virtwire-on-shutdown
From: Len Brown <len.brown@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1y8eiggge.fsf@ebiederm.dsl.xmission.com>
References: <x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	 <1106625259.2395.232.camel@d845pe>
	 <m1y8eiggge.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: 
Message-Id: <1106638610.2397.267.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Jan 2005 02:36:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 01:39, Eric W. Biederman wrote:
> Len Brown <len.brown@intel.com> writes:
> 
> > On Wed, 2005-01-19 at 02:31, Eric W. Biederman wrote:
> > > When coming out of apic mode attempt to set the appropriate
> > > apic back into virtual wire mode.  This improves on previous
> versions
> > > of this patch by by never setting bot the local apic and the
> ioapic
> > > into veritual wire mode.
> > >
> > > This code looks at data from the mptable to see if an ioapic has
> > > an ExtInt input to make this decision.  A future improvement
> > > is to figure out which apic or ioapic was in virtual wire mode
> > > at boot time and to remember it.  That is potentially a more
> accurate
> > > method, of selecting which apic to place in virutal wire mode.
> > >
> >
> > The call to find_isa_irq_pin() will always fail on ACPI-enabled
> systems,
> > so this patch is a NO-OP unless the system is booted in MPS mode.
> >
> > Do we really want to be adding this complexity for obsolete systems?
> > Are there systems that fail without this patch?
> 
> Yes there are bleeding edge systems that fail without this patch.
> And I have them.  That is why I wrote the code.

What bleeding edge system support MPS and does not support ACPI?

> I do agree that find_isa_irq_pin is a suboptimal way to get this
> information, looking at the ioapics at boot time would be better.
> However it works for me, the code is not wrong, and as you said
> usually the code becomes a noop.
> 
> If I can find the appropriate place in the boot path to examine
> the ioapics before they get stomped I am more than willing to write
> code that will handle this even in the presence of acpi data.

I belive we don't touch the IO_APICS in either MPS or ACPI mode before
setup_IO_APIC.
 
> In addition this code is not a complete noop because when
> find_isa_irq_pin fails it does put the local apic in virtual wire
> mode.

If the goal of this patch is to restore the hardware to the state
that it was before Linux scribbed on it, then it might be a better
ideal to save/restore the actual register values the BIOS gave us rather
than writing hard-coded values, no?

-Len


