Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVAEWCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVAEWCf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 17:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVAEWCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 17:02:35 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:33510 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262580AbVAEWBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 17:01:55 -0500
Subject: Re: Swsusp hanging the second time
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200501052204.34646.oliver@neukum.org>
References: <200501041154.19030.oliver@neukum.org>
	 <20050104110839.GF18777@elf.ucw.cz>  <200501052204.34646.oliver@neukum.org>
Content-Type: text/plain
Message-Id: <1104962577.3127.22.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 06 Jan 2005 09:02:58 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

That makes perfect sense: If you get a hang the second time, it's
generally because something loaded during the first resume didn't handle
the suspend properly, and is in a 'bad' state now. USB and DRI are the
main sources of those issues at the moment. The solution would be to
stop usb and unload the drivers prior to suspending, and reload/restart
afterwards. I do this with my USB mouse (having switched to a text
console) with no ill effects. YMMV.

Regards,

Nigel

On Thu, 2005-01-06 at 08:04, Oliver Neukum wrote:
> Am Dienstag, 4. Januar 2005 12:08 schrieb Pavel Machek:
> > Hi!
> > 
> > > there's a second, more serious problem with this laptop. It hangs the
> > > in the second swsusp cycle on suspension.
> > > As before 2.6.10, i386/UP/no highmem.
> > > On the screen I get the two messages "radeonfb resumed!" and
> > > "setting latency" superimposed and it hangs forever. This is a regression
> > > the previous user commented: "It worked under 2.6.6"
> > 
> > Unless it was on the same hardware/config, I'd not call it regression.
> > 
> > Anyway two suspends in the row seem to work here on 2.6.10+my
> > patches. I suspect you have problems with some more obscure driver.
> > 
> > Can you try going with minimal driver config to see if it is
> > reproducible? If it is broken even with minimal drivers, I'll try
> > harder to reproduce it here (but I believe it will just go away).
> 
> The culprit seems to be EHCI, possibly together with UHCI only.
> 
> 0000:00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03) (prog-if 00 [UHCI])
>         Subsystem: Toshiba America Info Systems: Unknown device ff10
>         Flags: bus master, medium devsel, latency 0, IRQ 11
>         I/O ports at 1200 [size=32]
> 
> 0000:00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03) (prog-if 00 [UHCI])
>         Subsystem: Toshiba America Info Systems: Unknown device ff10
>         Flags: bus master, medium devsel, latency 0, IRQ 11
>         I/O ports at 1220 [size=32]
> 
> 0000:00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03) (prog-if 00 [UHCI])
>         Subsystem: Toshiba America Info Systems: Unknown device ff10
>         Flags: bus master, medium devsel, latency 0, IRQ 11
>         I/O ports at 1240 [size=32]
> 
> 0000:00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03) (prog-if 20 [EHCI])
>         Subsystem: Toshiba America Info Systems: Unknown device ff10
>         Flags: bus master, medium devsel, latency 0
>         Memory at f4000000 (32-bit, non-prefetchable)
>         Capabilities: <available only to root>
> 
> 	Regards
> 		Oliver
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

