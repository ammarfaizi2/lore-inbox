Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267206AbVBEPTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267206AbVBEPTY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 10:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267203AbVBEPTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 10:19:24 -0500
Received: from netrider.rowland.org ([192.131.102.5]:61453 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S267103AbVBEPTN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 10:19:13 -0500
Date: Sat, 5 Feb 2005 10:19:08 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.11-rc[23]: swsusp & usb regression
In-Reply-To: <20050204231649.GA1057@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0502051006150.31778-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2005, Pavel Machek wrote:

> Hi!
> 
> In 2.6.11-rc[23], I get problems after swsusp resume:
> 
> Feb  4 23:54:39 amd kernel: Restarting tasks...<3>hub 3-0:1.0:
> over-current change on port 1
> Feb  4 23:54:39 amd kernel:  done
> Feb  4 23:54:39 amd kernel: hub 3-0:1.0: connect-debounce failed, port
> 1 disabled
> Feb  4 23:54:39 amd kernel: hub 3-0:1.0: over-current change on port 2
> Feb  4 23:54:39 amd kernel: usb 3-2: USB disconnect, address 2
> 
> After unplugging usb bluetooth key, machine hung. Sysrq still
> responded with help but I could not get any usefull output.

Your logs don't indicate which host controller driver is bound to each of 
your hubs.  /proc/bus/usb/devices will contain that information.  Without 
it, it's hard to diagnose what happened.

At the moment usbcore is undergoing a lengthy, and not terribly rapid,
series of changes to the generic bus glue layer, as are the host
controller drivers themselves.  Part of this change will involve the way
suspend/resume is handled.  (Not to the mention the fact that the power
management core itself is in the midst of change!)

As the uhci-hcd maintainer, I can safely say that the suspend/resume 
support in that driver is badly out of date.  Fixing it up is one of the 
ingredients planned for this series of changes.

As things stand now, however, there's likely to be lots of problems in the 
coordination of suspend/resume activities among the HCDs, the glue layer, 
and the hub driver.  One thing you could try is to turn on 
CONFIG_USB_SUSPEND.  It's likely to change things, although not 
necessarily for the better.  :-)

Alan Stern

