Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265364AbUAJTow (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUAJTov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:44:51 -0500
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:6016 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265364AbUAJTnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:43:01 -0500
Date: Sat, 10 Jan 2004 20:44:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Do not use synaptics extensions by default
Message-ID: <20040110194420.GA1212@elf.ucw.cz>
References: <20040110175930.GA1749@elf.ucw.cz> <20040110193039.GA22654@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110193039.GA22654@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ..aka "make synaptics touchpad usable in 2.6.1" -- synaptics support
> > is not really suitable to be enabled by default. You can not click by
> > tapping the touchpad (well, unless you have very new X with right
> > configuration, but than you can't go back to 2.4), and touchpad senses
> > your finger even when it is not touching, doing spurious movements =>
> > you can't hit anything on screen. Without synaptics extensions
> > everything works just fine. You can reenable synaptics support using
> > commandline.
> > 
> > Plus it documents psmouse_noext option.
> > 
> > Please apply,
> 
> No way. This also kills Logitech mouse detection and Genius and ...
> ... and those cannot be enabled via kernel command line parameters.

I'm setting it to PSMOUSE_IMEX, that's just below PSMOUSE_SYNAPTICS:

#define PSMOUSE_PS2             1
#define PSMOUSE_PS2PP           2
#define PSMOUSE_PS2TPP          3
#define PSMOUSE_GENPS           4
#define PSMOUSE_IMPS            5
#define PSMOUSE_IMEX            6
#define PSMOUSE_SYNAPTICS       7

That should turn off just synaptics, no? 

Okay, so how to do this properly? Synaptics driver with "mouse
emulation" is not usable (tap-to-click is critical), and I want to be
able to boot 2.4...

								Pavel

> > --- tmp/linux/drivers/input/mouse/psmouse-base.c	2004-01-09 20:24:19.000000000 +0100
> > +++ linux/drivers/input/mouse/psmouse-base.c	2004-01-10 16:16:06.000000000 +0100
> > @@ -31,7 +31,7 @@
> >  MODULE_PARM_DESC(psmouse_noext, "[DEPRECATED] Disable any protocol extensions. Useful for KVM switches.");
> >  
> >  static char *psmouse_proto;
> > -static unsigned int psmouse_max_proto = -1U;
> > +static unsigned int psmouse_max_proto = PSMOUSE_IMEX;
> >  module_param(psmouse_proto, charp, 0);
> >  MODULE_PARM_DESC(psmouse_proto, "Highest protocol extension to probe (bare, imps, exps). Useful for KVM switches.");
> >  
> > @@ -678,6 +678,8 @@
> >  			psmouse_max_proto = PSMOUSE_IMPS;
> >  		else if (!strcmp(psmouse_proto, "exps"))
> >  			psmouse_max_proto = PSMOUSE_IMEX;
> > +		else if (!strcmp(psmouse_proto, "synaptics"))
> > +			psmouse_max_proto = PSMOUSE_SYNAPTICS;
> >  		else
> >  			printk(KERN_ERR "psmouse: unknown protocol type '%s'\n", psmouse_proto);
> >  	}
> > 
> > -- 
> > When do you have a heart between your knees?
> > [Johanka's followup: and *two* hearts?]
> 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
