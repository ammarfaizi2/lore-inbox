Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUHJTC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUHJTC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267680AbUHJTBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 15:01:36 -0400
Received: from ida.rowland.org ([192.131.102.52]:34308 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S267645AbUHJSya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:54:30 -0400
Date: Tue, 10 Aug 2004 14:54:25 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Michael Guterl <mguterl@gmail.com>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>,
       =?ISO-8859-1?Q?Luis_Miguel_Garc=FD_Mancebo?= <ktech@wanadoo.es>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
Subject: Re: [linux-usb-devel] Re: USB troubles in rc2
In-Reply-To: <944a0377040810101612b0b7bc@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0408101450560.7558-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Michael Guterl wrote:

> I turned USB and ACPI debugging on in the kernel.  I am recreating
> this problem by booting the machine with no USB devices plugged in,
> then plugging the keyboard in, and then unplugging the keyboard.  I am
> recreating the problem with 2.6.8-rc3-mm1, but any 2.6.8-rc* kernel
> seems to reproduce the same errors, and yes I have tried 2.6.8-rc4 as
> well.
> 
> When I plug the USB keyboard in here is what dmesg shows.
<...>
> usb 3-1: control timeout on ep0in
> drivers/usb/input/hid-core.c: ctrl urb status -2 received
> drivers/usb/input/hid-core.c: timeout initializing reports
> 
> input: USB HID v1.10 Keyboard [ABBAHOME USB Keyboar?] on usb-0000:00:02.1-1
> usb 3-1: adding 3-1:1.1 (config #1, interface 1)
> usb 3-1:1.1: hotplug
> usbhid 3-1:1.1: usb_probe_interface
> usbhid 3-1:1.1: usb_probe_interface - got id
> drivers/usb/input/hid-core.c: ctrl urb status -2 received
> drivers/usb/input/hid-core.c: usb_submit_urb(ctrl) failed
> 
> When I unplug the keyboard this is what is shown, and the latter
> portion is repeated over and over again.
> 
> :00:02.1: urb c134c460 path 1 ep1in 5f160000 cc 5 --> status -110
> ohci_hcd 0000:00:02.1: urb c134c460 path 1 ep1in 5f160000 cc 5 --> status -110
> ohci_hcd 0000:00:02.1: urb c134c460 path 1 ep1in 5f160000 cc 5 --> status -110
> ohci_hcd 0000:00:02.1: urb c134c460 path 1 ep1in 5f160000 cc 5 --> status -110

This is very strange.  You might get a little more helpful information if
you edit drivers/usb/input/hid-core.c and replace the line that says
"#undef DEBUG" with "#define DEBUG".

Alan Stern

