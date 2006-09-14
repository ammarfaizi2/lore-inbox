Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWINLaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWINLaM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 07:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWINLaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 07:30:12 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:32670 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751198AbWINLaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 07:30:10 -0400
Subject: Re: ACPI: Idle Processor PM Improvements
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jordan Crouse <jordan.crouse@amd.com>, "Brown, Len" <len.brown@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20060914091849.GA15102@elf.ucw.cz>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
	 <20060830194317.GA9116@srcf.ucam.org>
	 <200608311713.21618.bjorn.helgaas@hp.com>
	 <1157070616.7974.232.camel@localhost.localdomain>
	 <20060904130933.GC6279@ucw.cz>
	 <1157466710.6011.262.camel@localhost.localdomain>
	 <20060906103725.GA4987@atrey.karlin.mff.cuni.cz>
	 <20060906145849.GE2623@cosmic.amd.com> <20060912092100.GC19482@elf.ucw.cz>
	 <1158084871.28991.489.camel@localhost.localdomain>
	 <20060914091849.GA15102@elf.ucw.cz>
Content-Type: text/plain
Organization: OLPC
Date: Thu, 14 Sep 2006 07:29:55 -0400
Message-Id: <1158233396.5871.169.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 11:18 +0200, Pavel Machek wrote:
> On Tue, 2006-09-12 at 11:21 +0200, Pavel Machek wrote:
> > 
> > > Ok, so what is needed is message to X "we are suspending", and X
> needs
> > > to respond "okay, I'm ready, no need for console switch".
> > 
> > This presumes an external agent to X controlling the fast
> > suspend/resume, with messages having to flow to and from X, and to
> and
> > from the kernel, with the kernel in the middle.
> > 
> > Another simpler option is X itself just telling the kernel to suspend
> > without console switch, as the handoff of the display to the DCON chip
> > has to be done with X and with an interrupt signaling completion of the
> > handoff.  This would be triggered by an inactivity timeout in the X
> > server.
> 
> Whoa... that's a hack.. but yes, you can probably do that, and I think
> kernel even has neccessary interfaces already. (They were needed for
> uswsusp).

Glad you like it ;-).  Dunno which way we'll go yet, though it will get
to the top of the pile to implement this fall.  I suspect we may go this
route to get going, but explore the more general solution as we get more
sophisticated power management policies and standards in place.

> 
> > > Alternatively, hack kernel to take control from X without actually
> > > switching consoles. That should be possible even with current
> > > interface.
> > 
> > This would require saving/restoring all graphics state in the kernel
> > (and X already has that state internally).  Feasible, but seems like
> 
> Hmm, save/restore graphics state from the kernel would of course be
> clean solution, but you should have that anyway... what if someone
> suspends without X running?

X knows its graphics state; it has to remember it all to know when it
has to be changed; on resume, resume can reinit the graphics state to
what the console wants/needs.

If you VT switch back to X, X can restore the graphics state to what it
remembers.

> 
> And of course you can just cheat, and not do kernel save-state on your
> system.

Yup, though it isn't clear to me I'd call it cheating.  In some ways,
what I just described to handle suspends when X is not running is really
robust and simple.  And you don't have divided responsibility for
remembering the state. Simple == good in my book.

                                  - Jim

-- 
Jim Gettys
One Laptop Per Child


