Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270585AbRHIUcX>; Thu, 9 Aug 2001 16:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270581AbRHIUcE>; Thu, 9 Aug 2001 16:32:04 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:19700 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S270570AbRHIUbu>; Thu, 9 Aug 2001 16:31:50 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE03A@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
        Sergei Haller <Sergei.Haller@math.uni-giessen.de>,
        linux-kernel@vger.kernel.org,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: [Acpi] Re: shutdown on pressing the ATX power button
Date: Thu, 9 Aug 2001 13:31:43 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just use acpid - it should notice the power button press and do the right
thing.

We do not want to hardcode what specific buttons do.

Regards -- Andy

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@suse.cz]
> Sent: Thursday, August 09, 2001 10:56 AM
> To: Sergei Haller; linux-kernel@vger.kernel.org; ACPI mailing list
> Subject: [Acpi] Re: shutdown on pressing the ATX power button
> 
> 
> Hi!
> 
> > is there any way to let the system execute something by 
> pressing the ATX
> > power button (preferrable executing 'shutdown -h now', but 
> would be nice
> > if it was configurable)
> > 
> > I looked into the (very large) list archive but didnt find 
> any answer.
> > if it is a kind of FAQ or off topic, please point me to the 
> place I could
> > find an answer.
> 
> Try this, and put this: into inittab
> 
> # Action on special keypress (ALT-UpArrow)
> kb::kbrequest:/etc/rc/rc.reboot 2 0
> 
> --- clean/drivers/acpi/events/evevent.c	Sun Jul  8 23:26:27 2001
> +++ linux/drivers/acpi/events/evevent.c	Sun Jul  8 23:25:01 2001
> @@ -193,6 +168,8 @@
>  
>  	if ((status_register & ACPI_STATUS_POWER_BUTTON) &&
>  		(enable_register & ACPI_ENABLE_POWER_BUTTON)) {
> +                printk ("acpi: Power button pressed!\n");
> +                kill_proc (1, SIGWINCH, 1);
>  		int_status |= acpi_ev_fixed_event_dispatch 
> (ACPI_EVENT_POWER_BUTTON);
>  	}
>  
> 
> -- 
> I'm pavel@ucw.cz. "In my country we have almost anarchy and I 
> don't care."
> Panos Katsaloulis describing me w.r.t. patents at 
> discuss@linmodems.org
> 
> 
> _______________________________________________
> acpi maillist  -  acpi@phobos.fs.tum.de
> http://phobos.fs.tum.de/mailman/listinfo/acpi
> 

