Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965885AbWKXSJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965885AbWKXSJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965904AbWKXSJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:09:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:3479 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965885AbWKXSJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:09:31 -0500
Date: Fri, 24 Nov 2006 10:08:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mike Galbraith <efault@gmx.de>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
In-Reply-To: <1164350350.6128.9.camel@Homer.simpson.net>
Message-ID: <Pine.LNX.4.64.0611240959170.6991@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>  <20061123133904.GD5561@ucw.cz>
 <1164317804.6222.11.camel@Homer.simpson.net>  <200611232236.58444.rjw@sisk.pl>
 <1164350350.6128.9.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Nov 2006, Mike Galbraith wrote:
> 
> I tried the dynticks/hires-timers/kbd suggestion, no difference.  It
> still boots in medicated snail mode, and emits a stream of IRQ9: nobody
> cared messages (fasteoi acpi, irqpoll = nogo) while doing so.

"medicated snail mode". Lol.

The "IRQ9: nobody cared" things are not unheard of. The Mac Mini had the 
same issue, and in that case it was because the firmware on that machine 
was just broken, and didn't re-enable ACPI mode correctly on resume. We 
worked around it by forcing a re-enable by hand, so that _exact_ issue 
isn't going to be your problem (or it would work since 2.6.18), but it's 
not unlikely that there is some other SCI setup that could have been 
missed.

One thing that is often worth testing is to try with APIC support if you 
don't have it already, or if you do have it, try _without_ APIC support. 
The firmware generally is only tested against MS operating systems, so 
it's only ever been tested for the particular irq setup that Windows tends 
to use, and as a result sometimes things work better in one more or 
another.

Based on the "fasteoi", you're obviously right now using the APIC, and 
that's _usually_ the mode that works better. But just in case, try booting 
with "noapic".

Also, can you send out the boot log with APIC information ("apic=debug"). 
Of course, don't disable the apic for that case, or it won't be very 
useful ;)

		Linus
