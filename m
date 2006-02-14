Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWBNDKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWBNDKy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWBNDKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:10:53 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:64447 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030207AbWBNDKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:10:52 -0500
From: David Brownell <david-b@pacbell.net>
To: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Mon, 13 Feb 2006 19:10:49 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200602131116.41964.david-b@pacbell.net> <43F0E724.6000807@cfl.rr.com>
In-Reply-To: <43F0E724.6000807@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131910.50304.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 12:08 pm, Phillip Susi wrote:
> David Brownell wrote:
> > What ide drive?  Oh, you're talking about PC-ish systems, not
> > embedded ones that don't _have_ rotating media to power off.
> 
> Yes, that's exactly what the discussion is about; disk drives with 
> mounted filesystems and what happens to them when you suspend/resume.

Odd, the original stuff I noticed talked about Linux PM in general,
and specifically why STR deserves a heck of a lot more attention than
it's been getting so far ... not just systems with rotating media.
(Too much attention on rotating media means that really low power
systems have been getting a bit shortchanged in Linux.)


Be that as it may:
 
> > Your experience is very different from mine; I've observed that
> > most PC hardware keeps USB powered in suspend-to-ram states, so
> > a keyboard or mouse action may wake the system up, just as it can
> > with many PS2 style keyboards and mice.  Same thing for Ethernet,
> > using various types of wakeup event including "magic packet".
> > See /proc/acpi/wakeup, and the related parts of the ACPI specs.
> > (And USB specs, and lots more ... this info is widespread.)
> 
> As I have said before, some systems can keep the USB bus in a low power 
> mode where it can wake the system, but AFAIK, waking the system is all 
> they can do in this state; they can not tell the kernel that device x 
> has been connected and device y has been disconnected, ... 

No, not "AFAIK" ... since when I told you explicitly that was untrue,
you then ignored that statement.  And didn't look at the specs that
I pointed you towards, which provide the details.  (USB 2.0 spec re
hubs; and of course the Linux-USB hub driver ... www.usb.org)

The events that a hub receives say pretty exactly what happened.
You should know that already, since USB behaves that way even
when the system is _not_ suspended ... 

The full mechanism for USB is more like wakeup signaling on USB triggering
hub wakeup (possibly cascading through a few layers of external hub), at
some point triggering root hub wakeup, which maps to a PME# signal.  That
relies on no more than VBUS being powered at a fraction of a milliAmpere,
and the equivalent of a pair of voltage comparators triggering wakeup when
USB signaling changes from J to K states for something like 10 msec.


> > Read about the #PME signal status in the PCI PM capabilities.
> >
> > And the USB remote wakeup reporting done by USB hubs; you can
> > even look at the drivers/usb/core/hub.c code and see how usb
> > wakeup events (of various types) are handled.
> >
> > You don't seem to know what you're talking about here.   
> 
> Which is why I qualified my statements with "AFAIK".  Maybe you could 
> enlighten me.  Does the #PME signal carry enough information to inform 
> the kernel that the reason the system is being woken up is because you 
> unplugged the mouse from the usb hub? 

Did you read about the PME# signal in the PCI PM spec?  www.pci-sig.com
Maybe you could try that. 

Also the ACPI spec ... the early chapters give a decent overview of the
different components of that model.  (ISTR two chapters try that, with
the second being more to-the-point despite some duplicated graphics.)

- Dave

 
