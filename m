Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132561AbRDKMUh>; Wed, 11 Apr 2001 08:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRDKMU1>; Wed, 11 Apr 2001 08:20:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45833 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132561AbRDKMUQ>; Wed, 11 Apr 2001 08:20:16 -0400
Date: Wed, 11 Apr 2001 14:20:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010411142012.C32104@atrey.karlin.mff.cuni.cz>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE817@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE817@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Tue, Apr 10, 2001 at 10:05:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is not correct, because we want the power button to be configurable.
> The user should be able to redefine the power button's action, perhaps to
> only sleep the system. We currently surface button events to acpid, which
> then can do the right thing, including a shutdown -h now (which I assume
> notifies init).

There's no problem with configurability -- you can configure init as
well. I saw it pretty much analogic to situation with Ctrl-Alt-Del: it
also sends signal to init. Init then decides what to do. [I believe
requiring acpid for such easy stuff is not neccessary...]
								Pavel


> Regards -- Andy
> 
> > From: Pavel Machek [mailto:pavel@suse.cz]
> > Init should get to know that user pressed power button (so it can do
> > shutdown and poweroff). Plus, it is nice to let user know that we can
> > read such event. [I hunted bug for few hours, thinking that kernel
> > does not get the event at all].
> > 
> > Here's patch to do that. Please apply,
> > 								Pavel
> > 
> > diff -urb -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* 
> > -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x 
> > System.map -x autoconf.h -x compile.h -x version.h -x 
> > .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* 
> > -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build 
> > -x build -x configure -x *target* -x *.flags -x *.bak 
> > clean/drivers/acpi/events/evevent.c 
> > linux/drivers/acpi/events/evevent.c
> > --- clean/drivers/acpi/events/evevent.c	Sun Apr  1 00:22:57 2001
> > +++ linux/drivers/acpi/events/evevent.c	Wed Apr  4 01:08:11 2001
> > @@ -30,6 +30,8 @@
> >  #include "acnamesp.h"
> >  #include "accommon.h"
> >  
> > +#include <linux/signal.h>
> > +
> >  #define _COMPONENT          EVENT_HANDLING
> >  	 MODULE_NAME         ("evevent")
> >  
> > @@ -197,14 +172,18 @@
> >  	if ((status_register & ACPI_STATUS_POWER_BUTTON) &&
> >  		(enable_register & ACPI_ENABLE_POWER_BUTTON))
> >  	{
> > +		printk ("acpi: Power button pressed!\n");
> > +		kill_proc (1, SIGTERM, 1);
> >  		int_status |= acpi_ev_fixed_event_dispatch 
> > (ACPI_EVENT_POWER_BUTTON);
> >  	}
> >  
> > +
> >  	/* sleep button event */
> >  
> >  	if ((status_register & ACPI_STATUS_SLEEP_BUTTON) &&
> >  		(enable_register & ACPI_ENABLE_SLEEP_BUTTON))
> >  	{
> > +		printk("acpi: Sleep button pressed!\n");
> >  		int_status |= acpi_ev_fixed_event_dispatch 
> > (ACPI_EVENT_SLEEP_BUTTON);
> >  	}
> >  
> > 
> > -- 
> > I'm pavel@ucw.cz. "In my country we have almost anarchy and I 
> > don't care."
> > Panos Katsaloulis describing me w.r.t. patents at 
> > discuss@linmodems.org
> > 

-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
