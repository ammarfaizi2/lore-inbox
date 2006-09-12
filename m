Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbWILJU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWILJU6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWILJU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:20:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40359 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965152AbWILJU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:20:56 -0400
Date: Tue, 12 Sep 2006 11:21:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Jim Gettys <jg@laptop.org>, "Brown, Len" <len.brown@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: ACPI: Idle Processor PM Improvements
Message-ID: <20060912092100.GC19482@elf.ucw.cz>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com> <20060830194317.GA9116@srcf.ucam.org> <200608311713.21618.bjorn.helgaas@hp.com> <1157070616.7974.232.camel@localhost.localdomain> <20060904130933.GC6279@ucw.cz> <1157466710.6011.262.camel@localhost.localdomain> <20060906103725.GA4987@atrey.karlin.mff.cuni.cz> <20060906145849.GE2623@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906145849.GE2623@cosmic.amd.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-09-06 08:58:49, Jordan Crouse wrote:
> On 06/09/06 12:37 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > 2.4 and 2.6 are *very* different here. You'll probably need to optimize freezer
> > > > in 2.6 a bit...
> > > > 						
> > > 
> > > Among other problems: e.g. 2.4 did not automatically do a VT switch; 2.6
> > > does; we'll have to have a way to signal "we're a sane display driver;
> > > don't switch away from me on suspend".
> > 
> > Not like that, please.
> > 
> > You are using X running over framebuffer, right? So that kernel is
> > controlling the graphics hardware. In such case it is safe to avoid VT
> > switch.
> 
> Actually not - the Geode GX has full 2D hardware acceleration with a complete
> X driver to match.  No Xfbdev here.

Ok, so what is needed is message to X "we are suspending", and X needs
to respond "okay, I'm ready, no need for console switch".

Alternatively, hack kernel to take control from X without actually
switching consoles. That should be possible even with current
interface.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
