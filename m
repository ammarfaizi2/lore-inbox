Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVAYJNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVAYJNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 04:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVAYJNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 04:13:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59858 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261751AbVAYJNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 04:13:32 -0500
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/29] x86-apic-virtwire-on-shutdown
References: <x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<1106625259.2395.232.camel@d845pe>
	<m1y8eiggge.fsf@ebiederm.dsl.xmission.com>
	<1106638610.2397.267.camel@d845pe>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jan 2005 02:11:53 -0700
In-Reply-To: <1106638610.2397.267.camel@d845pe>
Message-ID: <m1oefdhnza.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> writes:

> On Tue, 2005-01-25 at 01:39, Eric W. Biederman wrote:
> > Yes there are bleeding edge systems that fail without this patch.
> > And I have them.  That is why I wrote the code.
> 
> What bleeding edge system support MPS and does not support ACPI?

All I was talking about is the hardware here.  Last I looked the
errata on the E7520 E7525 and E7530 chipsets listed using the IOAPIC
in virtual wire mode the only way to get them to get the system
to work stably if you did not have an SMP kernel.  If there is an
updated errata work around I'd love to hear it.

The fact that ACPI is quite common is one of the reasons this code
path needs more work.

I have not seen the problems with ACPI as I have yet to see a
compelling reason to turn it on.  And my few experiences with
it have lead me to put acpi=off on my kernel command-line by default.

> I belive we don't touch the IO_APICS in either MPS or ACPI mode before
> setup_IO_APIC.

Thanks I will have a lookup.  That sounds like a likely place.

> If the goal of this patch is to restore the hardware to the state
> that it was before Linux scribbed on it, then it might be a better
> ideal to save/restore the actual register values the BIOS gave us rather
> than writing hard-coded values, no?

Nope that is not the goal.  The goal is to place system devices in
a state close enough to pc compatibility mode that an unpatched kernel
will start.  A secondary goal is to place the system in a state where
the firmware is likely not to have problems.  

As the apics are architectural hardware and we only touch the bits we
understand there is no reason for us to be modest and pretend we don't
know what we are doing.  The architecture defines a very narrow
set of states that are valid when you are not using the apics.  The
question is only which of those states will work?  pic_mode,
virt_wire mode in local apic, virt_wire mode in ioapic.  Looking at
the hardware is probably the most consistently reliable method of
determining that as the kernel will not boot if the firmware
sets it up wrong.

Eric
