Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbUAZRKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 12:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbUAZRKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 12:10:39 -0500
Received: from linux-bt.org ([217.160.111.169]:19089 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S264493AbUAZRKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 12:10:35 -0500
Subject: Re: Bluetooth USB oopses on unplug (2.6.1)
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Max Krasnyansky <maxk@qualcomm.com>
In-Reply-To: <20040126161625.GB227@elf.ucw.cz>
References: <20040126102041.GA1112@elf.ucw.cz>
	 <1075124726.25442.2.camel@pegasus>  <20040126161625.GB227@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1075136997.25442.99.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 26 Jan 2004 18:09:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > However show us the oops (through ksymoops) and show us your USB
> > hardware on your motherboard (lspci).
> 
> pavel@amd:~$ lspci
> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3188 (rev 01)
> 00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b188
> 00:0a.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
> 00:0c.0 Network controller: Broadcom Corporation BCM94306 802.11g (rev 02)
> 00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
> 00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
> 00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
> 00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
> 00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 50)
> 00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 80)
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
> 00:13.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 02)
> pavel@amd:~$
> 
> I'll have to hand-copy the oops, as machine dies after unplug. Here it
> is:
> 
> Oops: 2
> EIP  is at uhci_remov_pending_qhs
> Call trace:
> 	uhci_irq
> 	usb_hcd_irq
> 	handle_irq_event
> 	do_IRQ
> 	common_interrupt_1

as I expected. It is an UHCI host adapter and it looks like the uhci_hcd
driver has problems to unlink the ISOC URB's. Look at the LKML and USB
mailing lists for similiar post. At the moment I don't know of any patch
for it. Sorry.

Regards

Marcel


