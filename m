Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWINJSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWINJSk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 05:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWINJSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 05:18:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7622 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751493AbWINJSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 05:18:39 -0400
Date: Thu, 14 Sep 2006 11:18:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jim Gettys <jg@laptop.org>
Cc: Jordan Crouse <jordan.crouse@amd.com>, "Brown, Len" <len.brown@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: ACPI: Idle Processor PM Improvements
Message-ID: <20060914091849.GA15102@elf.ucw.cz>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com> <20060830194317.GA9116@srcf.ucam.org> <200608311713.21618.bjorn.helgaas@hp.com> <1157070616.7974.232.camel@localhost.localdomain> <20060904130933.GC6279@ucw.cz> <1157466710.6011.262.camel@localhost.localdomain> <20060906103725.GA4987@atrey.karlin.mff.cuni.cz> <20060906145849.GE2623@cosmic.amd.com> <20060912092100.GC19482@elf.ucw.cz> <1158084871.28991.489.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158084871.28991.489.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-09-12 14:14:30, Jim Gettys wrote:
> On Tue, 2006-09-12 at 11:21 +0200, Pavel Machek wrote:
> 
> > Ok, so what is needed is message to X "we are suspending", and X needs
> > to respond "okay, I'm ready, no need for console switch".
> 
> This presumes an external agent to X controlling the fast
> suspend/resume, with messages having to flow to and from X, and to and
> from the kernel, with the kernel in the middle.
> 
> Another simpler option is X itself just telling the kernel to suspend
> without console switch, as the handoff of the display to the DCON chip
> has to be done with X and with an interrupt signaling completion of the
> handoff.  This would be triggered by an inactivity timeout in the X
> server.

Whoa... that's a hack.. but yes, you can probably do that, and I think
kernel even has neccessary interfaces already. (They were needed for
uswsusp).

> > Alternatively, hack kernel to take control from X without actually
> > switching consoles. That should be possible even with current
> > interface.
> 
> This would require saving/restoring all graphics state in the kernel
> (and X already has that state internally).  Feasible, but seems like

Hmm, save/restore graphics state from the kernel would of course be
clean solution, but you should have that anyway... what if someone
suspends without X running?

And of course you can just cheat, and not do kernel save-state on your
system.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
