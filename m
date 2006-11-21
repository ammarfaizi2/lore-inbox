Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031293AbWKUU71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031293AbWKUU71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031362AbWKUU71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:59:27 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44690 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1031293AbWKUU70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:59:26 -0500
Date: Tue, 21 Nov 2006 15:59:25 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5: possible regression - OHCI dead
 after several STD/resume cycles
In-Reply-To: <200611212108.28154.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.44L0.0611211555360.6410-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Andrey Borzenkov wrote:

> Using 2.6.9-rc5 + Alan Stern fix for "can't disable OHCI wakeup via sysfs". I 
> started noticing strange messages after resume:
> 
> ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
> IRQ 11
> ACPI: PCI interrupt for device 0000:00:06.0 disabled
> ACPI: PCI interrupt for device 0000:00:0a.0 disabled
> pccard: card ejected from slot 0
> Stopping tasks... 
> ===========================================================================================done.
> Shrinking memory... done (27344 pages freed)
> Suspending console(s)
>  usbdev1.1_ep81: PM: suspend 0->1, parent 1-0:1.0 already 1
> hub 1-0:1.0: PM: suspend 1->1, parent usb1 already 1
>  usbdev1.1_ep00: PM: suspend 0->1, parent usb1 already 1
> usb usb1: PM: suspend 1->1, parent 0000:00:02.0 already 2
...
>  usbdev1.1_ep00: PM: resume from 0, parent usb1 still 1
>  usbdev1.1_ep81: PM: resume from 0, parent 1-0:1.0 still 1
> Restarting tasks... done.
> 
> those strange are usbdev1.1_ep00/81.

Those aren't real devices at all; they are merely entries in sysfs which
represent logical communication endpoints in the OHCI controller.  It's  
not meaningful to speak of suspending or resuming them, but the PM core 
tries to do anyway.  You can ignore those messages; they are harmless.

> Now I needed to read from USB stick - it was not detected. Actually even HUB 
> itself has not been shown in lsusb output. Reloading ohci did fix it.
> 
> This never happend to me in all previous versions (since 2.6.15 I guess). Also 
> it did not start immediately after Alan's patch so I do not believe it is 
> related.
> 
> Please tell me what can I sensibly test and which input info should I collect. 
> Thank you. Configuration, dmesg etc available on request. lspci:

Turn on CONFIG_USB_DEBUG and then post the dmesg log showing what happens
when you plug in your USB stick.

Alan Stern

