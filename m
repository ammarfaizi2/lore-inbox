Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTJMMHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 08:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbTJMMHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 08:07:44 -0400
Received: from linux-bt.org ([217.160.111.169]:29089 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261748AbTJMMHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 08:07:43 -0400
Subject: Re: Weird stuff with USB and Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Stian Jordet <liste@jordet.nu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031011023158.GE19749@kroah.com>
References: <1065744760.1344.2.camel@chevrolet.hybel> 
	<20031011023158.GE19749@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 13 Oct 2003 14:06:49 +0200
Message-Id: <1066046816.14514.257.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > I get these lines in my dmesg at boot-time:
> > 
> > usb 1-2: device not accepting address 3, error -110
> > hci_usb: probe of 1-2:1.1 failed with error -5
> > hci_usb: probe of 1-2:1.2 failed with error -5
> > usb 1-2: USB disconnect, address 4
> > usb 1-2: device not accepting address 5, error -110
> > hci_usb: probe of 1-2:1.1 failed with error -5
> > hci_usb: probe of 1-2:1.2 failed with error -5
> > 
> > Which often means that the usb-hc can't get an interrupt, I have read.
> > The "problem" is that I have several usb devices (scanner, printer,
> > usbserial, hid) and I get no such error with them, only the Bluetooth.
> > And even weirder, the BT-dongle works just perfect.
> > 
> > So my question is; what does this messages means?
> 
> You have a broken device, sorry.

this is not the complete story. Some USB Bluetooth devices are buggy,
that's right, but in some cases the USB host controller is acting very
weird. The ACER BT-500 for example shows the same error on all of my
UHCI based devices (with usb-uhci.o and uhci.o in 2.4), but with a NEC
USB 2.0 card and usb-ohci.o it works fine every time. But if the device
is already plugged in and the UHCI host driver is loaded later, the
device works. Also unloading/reloading of the UHCI host driver helps to
get this device working.

This problem was already mentioned some times in the USB mailing list,
but nobody found the real problem and nobody was able to solve it. From
my experiences this is a problem in combination with some UHCI chips and
the USB part of the Bluetooth devices.

Regards

Marcel


