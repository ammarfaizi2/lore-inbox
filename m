Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbVLNBEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbVLNBEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 20:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbVLNBEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 20:04:53 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:665 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932624AbVLNBEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 20:04:52 -0500
Subject: Re: tsc clock issues with dual core and question about irq
	balancing
From: john stultz <johnstul@us.ibm.com>
To: Adrian Yee <brewt-linux-kernel@brewt.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <GMail.1134458797.49013860.4106109506@brewt.org>
References: <GMail.1134458797.49013860.4106109506@brewt.org>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 17:04:48 -0800
Message-Id: <1134522289.3897.21.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 23:26 -0800, Adrian Yee wrote:
> I've been having tsc issues where it counts back occasionally causing
> things like ping to break with errors: "Warning: time of day goes back
> (-1451987us), taking countermeasures."  It seems related to
> http://bugzilla.kernel.org/show_bug.cgi?id=5105 , but that bug seems to
> be closed (and more x86_64 related).  I also get other timing issues
> like single clicks registering as double clicks, and at times double
> clicks that don't register.  In addition, if I stress the system with
> something like prime95, then after about 2 minutes the system clock will
> speed up where the clock advances by minutes every second.  As suggested
> in bug 5105, I switched to use the pmtimer (clock=pmtmr, my system
> doesn't seem to support hpet) and it has fixed the ping and clock issue,
> but my system doesn't 'feel' right.  For example, ssh'ing out of the
> machine is fine, but when ssh'ing into the system a dmesg is very slow
> (spurts out a few pages then pauses for 10-20 seconds, then repeat). 
> Also, general desktop usage seems a little sluggish and not what a smp
> system should feel like.

I can't speak about the irq routing issue, but I'm interested in your
issues with the ACPI PM timer.

> I'm currently running an i386 (ie. not x86_64) 2.6.15-rc5 kernel w/ SMP,
> APIC and ACPI enabled (AMD Cool & Quiet disabled), an Athlon 64 X2 3800+
> and EVGA nForce4 SLI (NF41) motherboard.  I previously had the processor
> running on an Abit AV8 (K8T800 Pro chipset) board and was having similar
> issues, so it seems to be a dual core issue.  I'd just like to add that
> I'm currently testing the system with "nosmp noapic acpi=off clock=tsc"
> (it was losing interrupts and wouldn't boot properly with apic/acpi on)
> and so far everything seems to work (this includes ssh and desktop usage
> is better).

So keeping the above settings, does removing just the "clock=tsc" cause
the sluggishness to appear?

The TSC is *much* faster then the ACPI PM, however it is just not usable
for reliable timekeeping on many SMP systems. That said, the ACPI PM
should not cause performance issues unless you are constantly calling
gettimeofday().

Also would you open a bugzilla bug on this and attach your .config and
dmesg?

thanks
-john


