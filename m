Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUANEmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 23:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUANEmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 23:42:14 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48525 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266295AbUANEmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 23:42:08 -0500
Message-ID: <4004C89E.60703@comcast.net>
Date: Tue, 13 Jan 2004 22:42:06 -0600
From: Ian Pilcher <i.pilcher@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: 2.6.1 - IRQ routing regression on Abit VP6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0 works fine on this hardware, including the twitchy built-in USB
controllers.

Loading the uhci-hcd module on 2.6.1 gives me the following:

drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 225, io base 00009400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: irq 225, io base 00009800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 1-0:1.0: new USB device on port 1, assigned address 2
APIC error on CPU1: 00(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU0: 00(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU1: 40(40)
irq 177: nobody cared!
Call Trace:
  [<c010d74a>] __report_bad_irq+0x2a/0x90
  [<c010d840>] note_interrupt+0x70/0xb0
  [<c010dc35>] do_IRQ+0x195/0x220
  [<c011b7ed>] smp_apic_timer_interrupt+0xdd/0x150
  [<c0105000>] rest_init+0x0/0x80
  [<c010bc24>] common_interrupt+0x18/0x20
  [<c0108ac0>] default_idle+0x0/0xc0
  [<c0105000>] rest_init+0x0/0x80
  [<c0108a19>] hlt_idle+0x29/0x40
  [<c0108bbb>] cpu_idle+0x3b/0x50
  [<c03aa4a0>] unknown_bootoption+0x0/0x120
  [<c03aa940>] start_kernel+0x1b0/0x200
  [<c03aa4a0>] unknown_bootoption+0x0/0x120

handlers:
[<c0263d00>] (ide_intr+0x0/0x2c0)
[<c0263d00>] (ide_intr+0x0/0x2c0)
Disabling IRQ #177
usb 1-1: control timeout on ep0out
uhci_hcd 0000:00:07.2: Unlink after no-IRQ?  Different ACPI or APIC 
settings may help.

And so on, until I shut down the system.

The 20031203 ACPI patch fixes the problem.

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

