Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWHXKLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWHXKLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWHXKLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:11:34 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:64268 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750931AbWHXKLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:11:34 -0400
Date: Thu, 24 Aug 2006 11:11:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Re : [HELP] Power management for embedded system
Message-ID: <20060824101125.GA21439@flint.arm.linux.org.uk>
Mail-Followup-To: moreau francis <francis_moreau2000@yahoo.fr>,
	linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
References: <20060824090455.GA18202@flint.arm.linux.org.uk> <20060824093739.5085.qmail@web25802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824093739.5085.qmail@web25802.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 09:37:39AM +0000, moreau francis wrote:
> Russell King wrote:
> > On Thu, Aug 24, 2006 at 08:44:25AM +0000, moreau francis wrote:
> >> Mips one seems to be a copy and paste of arm one and both of them
> >> have removed all APM bios stuff orginally part of i386 implementation.
> > 
> > The BIOS stuff makes no sense on ARM - there isn't a BIOS to do anything
> > with.
> 
> I haven't said that it has been widely/wrongly removed...

ROTFL!  No, you were stating that the APM bios stuff was removed, and
I gave the reason for it.  Why are you now objecting to my explaination?

> >> It doesn't seem that APM is something really stable and finished.
> > 
> > It's complete.  It's purpose is to provide the interface to userland so
> > that programs know about suspend/resume events, and can initiate suspends.
> > Eg, the X server.
> > 
> 
> Is there something specific to ARM in this implementation ? I don't think
> so and it's surely the reason why MIPS did copy it with almost no changes.

MIPS copied it because presumably it was useful for them.

> I understand that ARM implementation has been the first one but maybe now
> why not making it the common power management for embedded system that
> could be used by all arches which need it ?

It could well become a common interface.  But it is NOT power management
infrastructure.  It is merely a _userland_ interface.  Nothing more.  It
does not do anything other than that.

> BTW, why has apm_cpu_idle() logic been removed from ARM implementation ?

This APM is just a userland interface.  It has nothing to do with actual
power management.  CPU idling is handled entirely differently on ARM.

> > The power management really comes from the Linux drivers themselves,
> > which are written to peripherals off when they're not in use.  The other
> > power saving comes from things like cpufreq - again, nothing to do with
> > the magical "APM" or "ACPI" terms.
> 
> BTW why is it still called "APM" on ARM ?

That's what the userland interface is called on x86.  We could've called it
apm_userland_interface_emulation_and_not_a_power_management_infrastructure.c
but although that clearly states what it is, it would've been far too long
a name. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
