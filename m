Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131152AbRAYVgc>; Thu, 25 Jan 2001 16:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131850AbRAYVgX>; Thu, 25 Jan 2001 16:36:23 -0500
Received: from quattro.sventech.com ([205.252.248.110]:56592 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S131152AbRAYVgH>; Thu, 25 Jan 2001 16:36:07 -0500
Date: Thu, 25 Jan 2001 16:36:06 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: In kernel 2.4.0 in alloc_uhci when doing request_irq()
Message-ID: <20010125163605.F20628@sventech.com>
In-Reply-To: <3A709946.51505EF6@ngforever.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <3A709946.51505EF6@ngforever.de>; from Thunder from the hill on Thu, Jan 25, 2001 at 02:23:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001, Thunder from the hill <thunder@ngforever.de> wrote:
> I am using an usual VIA MPV3 onboard USB device (on a AMD K6-II 400
> machine), and it has ever worked fine on Linux (until including
> 2.4.0-test10). Now I wanted to use the "retail" 2.4.0-kernel, and USB
> gets stuck while booting. Last messages are:
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.251 $time 07:06:37 Jan 14 2001
> usb-uhci.c: high bandwidth mode enabled
> PCI: Assigned IRQ 10 for device 00:07.2
> usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 10
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> 
> That's all.
> I debugged a while and noticed that the error occurs beyond
> drivers/usb/usb-uhci.c in the function alloc_uhci() after start_hc (s);
> when calling request_irq(), the line reads:
> 	if (request_irq (irq, uhci_interrupt, SA_SHIRQ, MODNAME, s)) {
> The called function crashes somewhere on top, as I noticed.
> Is there a patch avariable, or should I do further investigation?

No patches that I've seen. It sounds more like you have an IRQ routing
problem and the IRQ isn't getting acknowledged correctly and is flooding
the machine.

You can try putting a printk in uhci_interrupt to see how often it gets
called.

Also, do you have a PnP setting in your BIOS? Can you try changing it?

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
