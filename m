Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272937AbTGaJmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 05:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272946AbTGaJmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 05:42:52 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:22737 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S272937AbTGaJmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:42:50 -0400
Date: Thu, 31 Jul 2003 11:42:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Message-ID: <20030731094231.GA464@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F288CAB.6020401@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>root; and resume in the reverse order.  Is that behaving now?
> >
> >
> >Yes.
> 
> Well, partially; but it's not used consistently.  Could you
> (or someone) explain what the plan is?  I see:
> 
>  - Three separate x86 PM "initiators":  APM, ACPI, swsusp.
>    (Plus ones for ARM and MIPS.)
> 
>  - Two driver registration infrastructures, the driver model
>    stuff and the older pm_*() stuff.
> 
> The pm_*() is how a handful of sound drivers and other random
> stuff register themselves -- and how PCI does it.
> 
> I'd sure have expected PCI to only use the driver model stuff,
> and I'll hope all those users will all be phased out by the
> time that 2.6 gets near the end of its test cycle.

Ouch, PCI really should use new driver model. I have not known about
that. I'll look into it.

> The "initiators" all talk to _both_ infrastructures, but they
> don't talk to the driver model stuff in the same way.  For
> example, on suspend:
> 
>  - ACPI issues a NOTIFY, which can veto the suspend;
>    then SAVE_STATE, ditto; finally POWER_DOWN.
> 
>  - APM uses the pm_*() calls for a vetoable check,
>    never issues SAVE_STATE, then goes POWER_DOWN.

IIRC, I had SAVE_STATE there at some point, and there was some
problem. I do not really use APM :-(.

>  - While swsusp is more like ACPI except that it doesn't
>    support vetoing from either NOTIFY or SAVE_STATE.

Good. I figured vetoing support is not critical. I should add it.

> That all seems more problematic to me.  Seems to me that
> APM should issue SAVE_STATE (and RESTORE_STATE), and all
> three PM "initiators" should agree on vetoing.

Yes, agreed.

> All of which is a roundabout way of adding to what I
> said:  the PM infrastructure USB will need to rely on
> seems like it needs polishing yet!  :)

Do you need vetoing? Otherwise it should be ready, except for APM.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
