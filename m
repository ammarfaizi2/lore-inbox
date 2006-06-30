Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWF3VJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWF3VJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 17:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWF3VJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 17:09:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:413 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932460AbWF3VJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 17:09:33 -0400
Date: Fri, 30 Jun 2006 23:09:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@timesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic HZ -V4
Message-ID: <20060630210922.GA1717@elf.ucw.cz>
References: <1150747581.29299.75.camel@localhost.localdomain> <20060629174838.GA1695@elf.ucw.cz> <1151607796.25491.677.camel@localhost.localdomain> <20060630180720.GA1689@elf.ucw.cz> <1151694950.25491.757.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151694950.25491.757.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I briefly tested -dyntick5 on my thinkpad, and it seems to work
> > > > okay... but timer still seems to tick at 250Hz.
> > > 
> > > > ...am I doing something wrong?
> > > 
> > > can you send me the bootlog and your .config file please ?
> > 
> > ...attached. (I do not have to enable anything in sysfs/commandline to
> > enable noidlehz, right?).
> 
> Right. 
> 
> You trapped into the no apic on SMP trap. I did not come around to fix
> that yet. What happens that you don't have lapic on the commandline and
> BIOS has lapic disabled. Therefor Linux switches to IPI broadcasting if
> the PIT interrupt, which does not work with idle_hz and highres timer as
> those are per cpu. I will fix that for SMP kernels which bring up only
> one CPU.
> 
> You can work around that for now by either using an UP kernel or
> enabling local APIC, which is recommended anyway because the APIC timer
> is faster to access and has longer max time than PIT.

Thanks, it works okay with UP kernel.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
