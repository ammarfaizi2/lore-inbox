Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWAYKoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWAYKoo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 05:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWAYKoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 05:44:44 -0500
Received: from tornado.reub.net ([202.89.145.182]:35287 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751108AbWAYKon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 05:44:43 -0500
Message-ID: <43D7567E.60003@reub.net>
Date: Wed, 25 Jan 2006 23:44:14 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060124)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org>
In-Reply-To: <20060124232406.50abccd1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/01/2006 8:24 p.m., Andrew Morton wrote:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm3/
> 
> - Dropped the timekeeping patch series due to a complex timesource selection
>   bug.
> 
> - Various fixes and updates.

Generally quite good again :)

I'm seeing this USB "handoff" warning message logged when booting up:

0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?)

This is not new to this -mm release, looking back over my bootlogs I note that 
2.6-15-rc5-mm1 was OK, but 2.6.15-mm4 was showing this message.  I'll narrow it 
down if it doesn't appear obvious what the problem is.

When it was working OK in earlier releases it was showing this at the same place 
in the boot as the message above is appearing (ie at the top near the scheduler 
registration stuff)

ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xff2ff800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004

On newer kernels this is appearing later on in the boot sequence instead, with 
the early and only message at the top being the single line failure message.

The box has the latest bios available, and it's an Intel D925XCV.  USB is 
working on the box (at least, a USB keyboard is...)

reuben


