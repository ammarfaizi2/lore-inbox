Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVBDWvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVBDWvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264720AbVBDWur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:50:47 -0500
Received: from zork.zork.net ([64.81.246.102]:55491 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266632AbVBDWSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:18:05 -0500
From: Sean Neakums <sneakums@zork.net>
To: benh@kernel.crashing.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1
References: <20050204103350.241a907a.akpm@osdl.org>
Mail-Followup-To: benh@kernel.crashing.org, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Date: Fri, 04 Feb 2005 22:17:42 +0000
In-Reply-To: <20050204103350.241a907a.akpm@osdl.org> (Andrew Morton's message
	of "Fri, 4 Feb 2005 10:33:50 -0800")
Message-ID: <6ud5vgezqx.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gave this a crack on the PowerBook5.4 -- somewhat more successful
than 2.6.11-rc2-mm2.  It boots, radeonfb works and X starts.  However,
suspend seems a tad faster than usual, and resume stops after setting
the hard disk's DMA mode, although the log below made it to disk.

  eth0: suspending, WakeOnLan disabled
  orinoco_lock() called with hw_unavailable (dev=ef89d800)
  radeonfb (0000:00:10.0): suspending to state: 3...
  HID1, before: 8000fc80
  radeonfb (0000:00:10.0): resuming from state: 3...
  PCI: Enabling device 0000:00:10.0 (0000 -> 0003)
  HID1, after: 8000fc80
  Apple USB OHCI 0001:10:18.0 disabled by firmware
  Apple USB OHCI 0001:10:19.0 disabled by firmware
  ehci_hcd 0001:10:1b.2: park 0
  ehci_hcd 0001:10:1b.2: USB 2.0 restarted, EHCI 1.00, driver 10 Dec 2004
  eth1: New link status: Connected (0001)
  eth0: resuming
  hda: Enabling Ultra DMA 5

Here's a resume log with 2.6.9 + sleep patch:

  eth0: suspending, WakeOnLan disabled
  radeonfb: suspending to state: 3...
  HID1, before: 8000fc80
  radeonfb (0000:00:10.0): resuming from state: 0...
  PCI: Enabling device 0000:00:10.0 (0000 -> 0003)
  HID1, after: 8000fc80
  Apple USB OHCI 0001:10:18.0 disabled by firmware
  Apple USB OHCI 0001:10:19.0 disabled by firmware
  enable_irq(29) unbalanced
  enable_irq(63) unbalanced
  enable_irq(63) unbalanced
  eth0: resuming
  PHY ID: 1410cc1, addr: 0
  hda: Enabling Ultra DMA 5
  hdc: MDMA, cycleTime: 120, accessTime: 90, recTime: 30
  hdc: Set MDMA timing for mode 2, reg: 0x00011d26
  hdc: Enabling MultiWord DMA 2
  hub 1-0:1.0: reactivate --> -22
  hub 1-0:1.0: reactivate --> -22
  hub 2-0:1.0: reactivate --> -22
