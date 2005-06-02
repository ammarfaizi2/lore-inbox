Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVFBCJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVFBCJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 22:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVFBCJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 22:09:52 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:38604 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261564AbVFBCJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 22:09:49 -0400
Date: Wed, 1 Jun 2005 19:09:30 -0700
From: Tony Lindgren <tony@atomide.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-1
Message-ID: <20050602020930.GN21597@atomide.com>
References: <20050602013641.GL21597@atomide.com> <Pine.LNX.4.61.0506011953090.22613@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506011953090.22613@montezuma.fsmlabs.com>
User-Agent: mutt-ng 1.5.9i (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo <zwane@arm.linux.org.uk> [050601 18:51]:
> Hi Tony,
> 
> On Wed, 1 Jun 2005, Tony Lindgren wrote:
> 
> > Here's an updated version of the dynamic tick patch.
> > 
> > It's mostly clean-up and it's now using the standard
> > monotonic_clock() functions as suggested by John Stultz.
> > 
> > Please let me know of any issues with the patch. I'll continue to do
> > more clean-up on it, but I think the basic functionality is done.
> > 
> > Thomas, where do you have the latest version of your ACPI idle
> > patch? I'd like to add that to the dyn-tick page as well.
> > 
> > Older patches and some related links are at:
> > 
> > http://muru.com/linux/dyntick/
> 
> Are there any 'known issues' wrt various timer sources with this version?

AFAIK, these are the remaining issues:

Supported timers are ACPI PM timer and TSC timer. No support for
CONFIG_HPET yet. Anybody feel like adding the HPET support? I don't
have any machines with HPET.

Lost tick code is currently disabled with #ifndef CONFIG_NO_IDLE_HZ
in timer_pm.c and timer_tsc.c. This should be done based on some
variable instead.

Kconfig option DYN_TICK_USE_APIC should be converted to a command
line option, as it only seems to work on P3 and not on P4.

So actually let's say the basic functionality is still missing
some parts :) But these should be pretty easy to fix.

Tony
