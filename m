Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUCYOaD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUCYOZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:25:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38106 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263157AbUCYOYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:24:51 -0500
Date: Thu, 18 Mar 2004 07:36:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Karol Kozimor <sziwan@hell.org.pl>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: Broken PM semantics (WAS: PATCH: Shutdown IDE before powering off).
Message-ID: <20040318063631.GA597@openzaurus.ucw.cz>
References: <1gC8S-6UB-5@gated-at.bofh.it> <1gIHq-3JU-23@gated-at.bofh.it> <1gPzb-1OM-17@gated-at.bofh.it> <1gQET-2Qn-9@gated-at.bofh.it> <20040311214601.GA3109@hell.org.pl> <1079146102.2302.60.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079146102.2302.60.camel@gaston>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thus wrote Bartlomiej Zolnierkiewicz:
> > > 
> > > On Thursday 22 of January 2004 17:02, Jeff Garzik wrote:
> > > > I'm either shock or very very worried that the reboot notifier that
> > > > flushes IDE in 2.4.x, ide_notifier, is nowhere to be seen in 2.6.x :(
> > > > That seems like the real problem -- the code _used_ to be there.
> > > 
> > > Yep, it should be re-added.  I wonder when/why it was removed?
> 
> Ideally, it should use the same mecanism as the PM requests...
> 
> In fact, the shutdown is just a special case of PM request. I think
> ultimately, we should drop the various "shutdown()" functions in the
> drivers in favor of a "state" selector for PM. That goes along with
> the current problem of "state" in PM beeing completely bogus. The
> constants defined by linux/pm.h are in no way related to what
> the various drivers have come to expect.
> 
> enum {
>         PM_SUSPEND_ON,
>         PM_SUSPEND_STANDBY,
>         PM_SUSPEND_MEM,
>         PM_SUSPEND_DISK,
>         PM_SUSPEND_MAX,
> };
>                                                                                                                    
> Which basically gives is MEM=2 and DISK=3, while drivers usually
> expect MEM=3 and DISK=4 while nobody really cares about 2 except
> some specific stuffs in the arch code (or radeonfb on pmacs...)
> 
> We should get rid of this assumption that we are passing a D-type
> anyway. I suggest we define once for all that what we are passing
> down the driver is really the overall system state we are getting
> to, that is MEM,DISK,KEXEC,SHUTDOWN, eventually STANDBY if we
> ever do something like that (useful for handhelds that have a
> special idle state and really don't care about scheduling whne
> nothing happens for a while).

Agreed. Or at least document that it takes D states
and BUG-ON on invalid values...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

