Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWF0Sgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWF0Sgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWF0Sgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:36:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030269AbWF0Sgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:36:36 -0400
Date: Tue, 27 Jun 2006 11:36:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] Input update for 2.6.17
In-Reply-To: <20060627063734.GA28135@kroah.com>
Message-ID: <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>
References: <200606260235.03718.dtor_core@ameritech.net>
 <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org> <20060627063734.GA28135@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Jun 2006, Greg KH wrote:
> 
> Yes, if you have the UHCI driver loaded first, then when EHCI is loaded,
> it disconnects everything on the bus and re-enumerates it.
> 
> But EHCI is built into the kernel first, before UHCI, so unless you are
> using modules, nothing should be getting disconnected at boot time.

Yeah, that's not it.

It _seems_ to be triggered by this:

	Bluetooth: HCI device and connection manager initialized
	Bluetooth: HCI socket layer initialized
	usb 5-1: USB disconnect, address 2
	usb 5-1: new full speed USB device using uhci_hcd and address 4
	usb 5-1: configuration #1 chosen from 1 choice
	Bluetooth: HCI USB driver ver 2.9
	usbcore: registered new driver hci_usb

> I really doubt you are using modules, so I don't know why it would be
> disconnected.

I'm actually using modules for the "don't care" things, like bluetooth. 
But yeah, UHCI/EHCI are compiled-in.

> What does the kernel log show right before this happened?
> Any chance to enable CONFIG_USB_DEBUG?

Will try.

Sadly, grub is buggered on this machine (it's the mac mini) and I can't 
switch kernels around easily, so when a kernel fails to boot, I have to go 
into the rescue-CD thing etc. That makes it a bit painful.

But I've got netconsole to capture the logs, at least ;)

		Linus
