Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWAPBTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWAPBTk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 20:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWAPBTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 20:19:40 -0500
Received: from mail.suse.de ([195.135.220.2]:58556 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932148AbWAPBTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 20:19:40 -0500
To: john stultz <johnstul@us.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	<1137168254.7241.32.camel@localhost.localdomain>
	<1137174463.15108.4.camel@mindpipe>
	<Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
	<1137174848.15108.11.camel@mindpipe>
	<Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
	<1137178506.15108.38.camel@mindpipe>
	<1137182991.8283.7.camel@localhost.localdomain>
	<1137198221.11300.21.camel@cog.beaverton.ibm.com>
	<1137201012.6727.1.camel@localhost.localdomain>
	<1137201250.1408.39.camel@mindpipe>
	<1137201821.11300.30.camel@cog.beaverton.ibm.com>
	<1137202039.1408.42.camel@mindpipe>
	<1137202773.11300.37.camel@cog.beaverton.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 16 Jan 2006 02:19:27 +0100
In-Reply-To: <1137202773.11300.37.camel@cog.beaverton.ibm.com>
Message-ID: <p73d5it0y1s.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> writes:
> 
> With 2.6.15 on x86-64:
> 	If available, alternate timesources (HPET, ACPI PM) will be used if
> available on AMD SMP systems. (clock= is i386 only)

It would be good if it worked on x86-64 too - simply to unconfuse people.
It's somewhere on my todo list, but patches welcome.
 
> With 2.6.15 on i386:
> 	If CONFIG_X86_PM_TIMER is enabled, and available it is the preferred
> clocksource over the TSC.  Some distros have changed this priority
> causing the TSC to be preferred. In these cases clock=pmtmr is needed.

One problem is that it is not obvious enough to people that
CONFIG_X86_PM_TIMER is really needed for correct timing on many system
and they just don't enable it. That is why we got so many bogus reports.
 
I just changed it on x86-64 to be dependent on EMBEDDED, on by
default. i386 probably should do this change too.

-Andi
