Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVLNU5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVLNU5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbVLNU5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:57:16 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:49099 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964963AbVLNU5P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:57:15 -0500
Subject: Re: tsc clock issues with dual core and question about irq
	balancing
From: john stultz <johnstul@us.ibm.com>
To: Adrian Yee <brewt-linux-kernel@brewt.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <GMail.1134592020.1228859.700367237899@brewt.org>
References: <GMail.1134458797.49013860.4106109506@brewt.org>
	 <1134522289.3897.21.camel@leatherman>
	 <GMail.1134551267.12292355.45625751005@brewt.org>
	 <1134591272.16294.3.camel@cog.beaverton.ibm.com>
	 <GMail.1134592020.1228859.700367237899@brewt.org>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 12:57:10 -0800
Message-Id: <1134593830.16294.9.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 12:27 -0800, Adrian Yee wrote:
> Hi John,
> 
> > >>>From your dmesg, you're still running w/ smp, apic, acpi as well.
> > I was curious if you could run just as you had before without issue
> > using "nosmp noapic acpi=off clock=tsc", only drop the clock=tsc bit.
> > 
> > I just want to be sure we're only changing one variable at a time.
> > :)
> 
> I also have a dmesg with those options that I can upload, but I'm not
> completely sure about the validity of the sluggishness "tests" because
> the system felt the same after I booted with the different
> configurations this time around.  ssh seems fine right now, so I guess
> my Internet just happened to go bad at the same time I started play with
> my hardware and kernel configurations.

Hmm. Please keep an eye on this. If there is something going funky
either in accessing the PM Timer hardware on your chipset, or some other
quirk (locking issues, timer starvation, etc) it would be good to
discover.

> I think the only solid problem I've got here is the tsc ocassionally
> counting back.  Is switching to clock=pmtmr the permanent/proper
> solution for this, or is there a bug in the kernel/hardware that should
> be fixable?  Thanks.

If the ACPI PM timer is enabled it should be used by default (is that
not the case? if you do not use clock= at all, what clocksource gets
selected?). Unfortunately using the TSC on some SMP systems is just not
feasible.

thanks
-john


