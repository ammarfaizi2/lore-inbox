Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVAJR5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVAJR5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVAJR4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:56:19 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:46782 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S262387AbVAJRsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:48:15 -0500
Date: Tue, 11 Jan 2005 01:48:04 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: Shaw <shawv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Screwy clock after apm suspend
Message-ID: <20050110174804.GC4641@blackham.com.au>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com> <20050109224711.GF1353@elf.ucw.cz> <200501092328.54092.shawv@comcast.net> <20050110074422.GA17710@mussel> <20050110105759.GM1353@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110105759.GM1353@elf.ucw.cz>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 11:57:59AM +0100, Pavel Machek wrote:
> > > > arch/i386/kernel/time.c, can you comment out
> > > > jiffies += sleep_length * HZ;
> > > 
> > > Worked like a charm.  I'm not seeing any time drift after your suggested 
> > > change.
> > 
> > AIUI, this also means that a machine's uptime does not include time
> > whilst suspended. This was the behaviour prior to 2.6.10 and seems to be
> > more desirable as it counts the time the machine is actually running,
> > not just time since boot. Is there a good reason why we can't go back to
> > this?
> 
> I think it means very wrong system clock in ACPI state.

So would implementing the equivalent of hwclock --hctosys keep both
ACPI & APM happy, but not include time suspended in uptime?

> Plus think something wanting timeout of five minutes, then suspend
> one minute after, machine sleeps for a hour.
> 
> With this approach, timeout should happen just after resume, with your
> approach, it would wait 4 more minutes.

It does depend on whether a timer wants a delay against the wall
clock or the rest of the system.  A process may be sleeping because
it's waiting for some other task to complete, or waiting for input
from the user. In these cases I claim time-whilst-hibernated should
not be counted.

Hibernating shouldn't be noticeable to the system. For example, a
popup window that came up an instant prior to suspending which is
normally on the screen for several seconds would vanish instantly
upon resuming without the user ever seeing it.

It also means that a group of timeouts that would normally occur a
large amount of time apart, will suddenly all expire the instant the
machine resumes, causing unexpected or undesirable behaviours, IMHO.

Bernard.
