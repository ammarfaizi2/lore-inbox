Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRDJRHI>; Tue, 10 Apr 2001 13:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129292AbRDJRG5>; Tue, 10 Apr 2001 13:06:57 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:29663 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129084AbRDJRF1>; Tue, 10 Apr 2001 13:05:27 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE817@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Cc: "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: Let init know user wants to shutdown
Date: Tue, 10 Apr 2001 10:05:13 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not correct, because we want the power button to be configurable.
The user should be able to redefine the power button's action, perhaps to
only sleep the system. We currently surface button events to acpid, which
then can do the right thing, including a shutdown -h now (which I assume
notifies init).

Regards -- Andy

> From: Pavel Machek [mailto:pavel@suse.cz]
> Init should get to know that user pressed power button (so it can do
> shutdown and poweroff). Plus, it is nice to let user know that we can
> read such event. [I hunted bug for few hours, thinking that kernel
> does not get the event at all].
> 
> Here's patch to do that. Please apply,
> 								Pavel
> 
> diff -urb -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* 
> -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x 
> System.map -x autoconf.h -x compile.h -x version.h -x 
> .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* 
> -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build 
> -x build -x configure -x *target* -x *.flags -x *.bak 
> clean/drivers/acpi/events/evevent.c 
> linux/drivers/acpi/events/evevent.c
> --- clean/drivers/acpi/events/evevent.c	Sun Apr  1 00:22:57 2001
> +++ linux/drivers/acpi/events/evevent.c	Wed Apr  4 01:08:11 2001
> @@ -30,6 +30,8 @@
>  #include "acnamesp.h"
>  #include "accommon.h"
>  
> +#include <linux/signal.h>
> +
>  #define _COMPONENT          EVENT_HANDLING
>  	 MODULE_NAME         ("evevent")
>  
> @@ -197,14 +172,18 @@
>  	if ((status_register & ACPI_STATUS_POWER_BUTTON) &&
>  		(enable_register & ACPI_ENABLE_POWER_BUTTON))
>  	{
> +		printk ("acpi: Power button pressed!\n");
> +		kill_proc (1, SIGTERM, 1);
>  		int_status |= acpi_ev_fixed_event_dispatch 
> (ACPI_EVENT_POWER_BUTTON);
>  	}
>  
> +
>  	/* sleep button event */
>  
>  	if ((status_register & ACPI_STATUS_SLEEP_BUTTON) &&
>  		(enable_register & ACPI_ENABLE_SLEEP_BUTTON))
>  	{
> +		printk("acpi: Sleep button pressed!\n");
>  		int_status |= acpi_ev_fixed_event_dispatch 
> (ACPI_EVENT_SLEEP_BUTTON);
>  	}
>  
> 
> -- 
> I'm pavel@ucw.cz. "In my country we have almost anarchy and I 
> don't care."
> Panos Katsaloulis describing me w.r.t. patents at 
> discuss@linmodems.org
> 

