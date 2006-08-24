Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030490AbWHXV47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbWHXV47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWHXV46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:56:58 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:27923 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030490AbWHXV45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:56:57 -0400
Date: Thu, 24 Aug 2006 22:56:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Re : Re : [HELP] Power management for embedded system
Message-ID: <20060824215650.GB21439@flint.arm.linux.org.uk>
Mail-Followup-To: moreau francis <francis_moreau2000@yahoo.fr>,
	linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
References: <20060824101125.GA21439@flint.arm.linux.org.uk> <20060824105743.60250.qmail@web25811.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824105743.60250.qmail@web25811.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 10:57:43AM +0000, moreau francis wrote:
> Russell King wrote:
> > On Thu, Aug 24, 2006 at 09:37:39AM +0000, moreau francis wrote:
> >> Russell King wrote:
> >>> On Thu, Aug 24, 2006 at 08:44:25AM +0000, moreau francis wrote:
> >>>> It doesn't seem that APM is something really stable and finished.
> >>> It's complete.  It's purpose is to provide the interface to userland so
> >>> that programs know about suspend/resume events, and can initiate suspends.
> >>> Eg, the X server.
> >>>
> >> Is there something specific to ARM in this implementation ? I don't think
> >> so and it's surely the reason why MIPS did copy it with almost no changes.
> > 
> > MIPS copied it because presumably it was useful for them.
> 
> Actually my point is that it could be usefull for _all_ embedded systems,
> whatever the arches it comes from, couldn't it ?

Yes, I agree, it should be.

> >> why not making it the common power management for embedded system that
> >> could be used by all arches which need it ?
> > 
> > It could well become a common interface.  But it is NOT power management
> > infrastructure.  It is merely a _userland_ interface.  Nothing more.  It
> > does not do anything other than that.
> 
> apm_queue_event() (and kapmd) doens't seem something usefull for user space.
> It seems to be designed to be used by the kernel no ?

We have some folk who want a method to trigger emergency suspends when
batteries got low, or if you move the battery cover, etc.  These are
events which require fast reactions from the system, and coding up some
additional interface to pass such events to userland, have some daemon
running to monitor for those events, and issue a PM event is completely
overkill and, actually, unreliable.

> >> BTW, why has apm_cpu_idle() logic been removed from ARM implementation ?
> > 
> > This APM is just a userland interface.  It has nothing to do with actual
> > power management.  CPU idling is handled entirely differently on ARM.
> 
> Could you point out where it is handled ?

It's both machine class and CPU specific.  I couldn't point you at
anything specific, except to say that different machines and ARM CPUs
handle it differently.

Some CPUs have "wait for interrupt" instructions, some don't.  Some
need special cache handling around this instruction, some don't.  Some
machines have a CPU capable of "wait for interrupt" but must not use it.

It's all handled by the CPU abstraction, and the machine class abstraction.

See arch_idle in include/asm-arm/arch-*/system.h as the starting point
for the "default" (== always used) idle implementations.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
