Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270594AbRHIUjX>; Thu, 9 Aug 2001 16:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270588AbRHIUjI>; Thu, 9 Aug 2001 16:39:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57099 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270587AbRHIUik>; Thu, 9 Aug 2001 16:38:40 -0400
Date: Thu, 9 Aug 2001 22:38:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Acpi] Re: shutdown on pressing the ATX power button
Message-ID: <20010809223850.J11884@atrey.karlin.mff.cuni.cz>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE03A@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE03A@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Thu, Aug 09, 2001 at 01:31:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Just use acpid - it should notice the power button press and do the right
> thing.

This is not hardcoded, you can set it up in init just fine. (Well, I
should not use SIGWINCH but some other signal). C-A-D is handled in
very similar way, and I think it is the right way, and should be
extended to halt, too.

I just don't want to run acpid just because I want
powerdown-on-powerbutton.

								Pavel

> We do not want to hardcode what specific buttons do.
> 
> Regards -- Andy
> 
> > -----Original Message-----
> > From: Pavel Machek [mailto:pavel@suse.cz]
> > Sent: Thursday, August 09, 2001 10:56 AM
> > To: Sergei Haller; linux-kernel@vger.kernel.org; ACPI mailing list
> > Subject: [Acpi] Re: shutdown on pressing the ATX power button
> > 
> > 
> > Hi!
> > 
> > > is there any way to let the system execute something by 
> > pressing the ATX
> > > power button (preferrable executing 'shutdown -h now', but 
> > would be nice
> > > if it was configurable)
> > > 
> > > I looked into the (very large) list archive but didnt find 
> > any answer.
> > > if it is a kind of FAQ or off topic, please point me to the 
> > place I could
> > > find an answer.
> > 
> > Try this, and put this: into inittab
> > 
> > # Action on special keypress (ALT-UpArrow)
> > kb::kbrequest:/etc/rc/rc.reboot 2 0
> > 
> > --- clean/drivers/acpi/events/evevent.c	Sun Jul  8 23:26:27 2001
> > +++ linux/drivers/acpi/events/evevent.c	Sun Jul  8 23:25:01 2001
> > @@ -193,6 +168,8 @@
> >  
> >  	if ((status_register & ACPI_STATUS_POWER_BUTTON) &&
> >  		(enable_register & ACPI_ENABLE_POWER_BUTTON)) {
> > +                printk ("acpi: Power button pressed!\n");
> > +                kill_proc (1, SIGWINCH, 1);
> >  		int_status |= acpi_ev_fixed_event_dispatch 
> > (ACPI_EVENT_POWER_BUTTON);
> >  	}
> >  
> > 
> > -- 
> > I'm pavel@ucw.cz. "In my country we have almost anarchy and I 
> > don't care."
> > Panos Katsaloulis describing me w.r.t. patents at 
> > discuss@linmodems.org
> > 
> > 
> > _______________________________________________
> > acpi maillist  -  acpi@phobos.fs.tum.de
> > http://phobos.fs.tum.de/mailman/listinfo/acpi
> > 

-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
