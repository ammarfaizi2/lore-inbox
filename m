Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVAYGlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVAYGlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVAYGlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:41:24 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36306 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261839AbVAYGlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:41:22 -0500
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/29] x86-apic-virtwire-on-shutdown
References: <x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<1106625259.2395.232.camel@d845pe>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Jan 2005 23:39:45 -0700
In-Reply-To: <1106625259.2395.232.camel@d845pe>
Message-ID: <m1y8eiggge.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> writes:

> On Wed, 2005-01-19 at 02:31, Eric W. Biederman wrote:
> > When coming out of apic mode attempt to set the appropriate
> > apic back into virtual wire mode.  This improves on previous versions
> > of this patch by by never setting bot the local apic and the ioapic
> > into veritual wire mode.
> > 
> > This code looks at data from the mptable to see if an ioapic has
> > an ExtInt input to make this decision.  A future improvement
> > is to figure out which apic or ioapic was in virtual wire mode
> > at boot time and to remember it.  That is potentially a more accurate
> > method, of selecting which apic to place in virutal wire mode.
> > 
> 
> The call to find_isa_irq_pin() will always fail on ACPI-enabled systems,
> so this patch is a NO-OP unless the system is booted in MPS mode.
> 
> Do we really want to be adding this complexity for obsolete systems? 
> Are there systems that fail without this patch?

Yes there are bleeding edge systems that fail without this patch.
And I have them.  That is why I wrote the code.

I do agree that find_isa_irq_pin is a suboptimal way to get this
information, looking at the ioapics at boot time would be better.
However it works for me, the code is not wrong, and as you said
usually the code becomes a noop. 

If I can find the appropriate place in the boot path to examine
the ioapics before they get stomped I am more than willing to write
code that will handle this even in the presence of acpi data.

In addition this code is not a complete noop because when
find_isa_irq_pin fails it does put the local apic in virtual wire mode.


Eric
