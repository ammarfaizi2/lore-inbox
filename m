Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267777AbUHTIfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267777AbUHTIfI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267791AbUHTIdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:33:32 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:47776 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S267827AbUHTIcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:32:14 -0400
Subject: Re: HCI USB on USB 2.0: hci_usb_intr_rx_submit (works with USB 1.1)
From: Marcel Holtmann <marcel@holtmann.org>
To: "Raf D'Halleweyn (list)" <list@noduck.net>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092966777.5230.4.camel@alto.dhalleweyn.com>
References: <1091581193.15561.3.camel@alto.dhalleweyn.com>
	 <1092049263.21815.18.camel@pegasus>
	 <1092966777.5230.4.camel@alto.dhalleweyn.com>
Content-Type: text/plain
Message-Id: <1092990717.18082.60.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 10:31:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

> This was under 2.6.7, using ehci for USB 2.0 and uhci for 1.1.
> 
> Under 2.6.8.1 I get with USB 1.1:
> usb 4-1.3: new full speed USB device using address 3
> bcm203x_probe: Mini driver request failed
> bcm203x: probe of 4-1.3:1.0 failed with error -5
> usb 4-1.3: USB disconnect, address 3
> usb 4-1.3: new full speed USB device using address 4
> 
> but USB 2.0 gives:
> usb 1-3.4: new full speed USB device using address 6
> ehci_hcd 0000:00:1d.7: qh f7d2d200 (#0) state 1
> bcm203x_probe: Mini driver request failed
> bcm203x: probe of 1-3.4:1.0 failed with error -5
> usb 1-3.4: bulk timeout on ep1in
> usb 1-3.4: usbfs: USBDEVFS_BULK failed ep 0x81 len 10 ret -110
> usb 1-3.4: USB disconnect, address 6
> usb 1-3.4: new full speed USB device using address 7
> ehci_hcd 0000:00:1d.7: qh f7d2d280 (#0) state 1
> hci_usb_intr_rx_submit: hci0 intr rx submit failed urb c1ad1994 err -28
> 
> If I try to do 'hciconfig hci0 up' when connected to USB 2.0 I also get
> a 'hci_usb_intr_rx_submit: hci0 intr rx submit failed urb f7e22814 err
> -28'.

your dongle looks like a Broadcom based dongle. Please include the part
from /proc/bus/usb/devices matching your device. The main problem is
that the mini driver and the firmware for the Broadcom dongle can't be
loaded throught request_firmware() by the bcm203x driver. Check the
BlueZ webpage for more details and put these files in the correct place.

Regards

Marcel


