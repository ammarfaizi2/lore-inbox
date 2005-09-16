Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161142AbVIPJ2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbVIPJ2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 05:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbVIPJ2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 05:28:17 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:19726 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161142AbVIPJ2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 05:28:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=t40H6nS1lBlZct0RmPg79ncJp0akoRwkEi8o5JKot9YdHuilhWfbzB/TODyYVzNZfkq15FWShPmsm5JXQ6NO1qgbKZ++nDe89mZH5/Xjw0AP/VqrUHMyc8H88znVkyH+2BK4L+LM48K0tuw6lfz50mC2tHxTslnni6AHtWVhdKY=
Message-ID: <432A9026.9060603@gmail.com>
Date: Fri, 16 Sep 2005 11:28:06 +0200
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050810)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: acpi oops, irq 14: nobody cared
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.14-rc1 vanilla.
On my notebook acpi suspend works perfectly but i get:

Stopping tasks: =================|
Freeing memory... done (41592 pages freed)
ACPI: PCI interrupt for device 0000:00:01.4 disabled
ACPI: PCI interrupt for device 0000:00:01.3 disabled
ACPI: PCI interrupt for device 0000:00:01.2 disabled
swsusp: Need to copy 24667 pages
ACPI: PCI Interrupt 0000:00:00.1[A]: no GSI - using IRQ 14
eth0: Media Link Off
ACPI: PCI Interrupt 0000:00:01.2[D] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:00:01.2[D] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:00:01.3[D] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:00:01.3[D] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:00:01.4[B] -> Link [LNKB] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKC] -> GSI 5 (level, low) 
-> IRQ 5
irq 14: nobody cared (try booting with the "irqpoll" option)
 [<c013926a>] __report_bad_irq+0x2a/0x90
 [<c0139390>] note_interrupt+0xa0/0x100
 [<c0138d09>] __do_IRQ+0xa9/0xc0
 [<c0105139>] do_IRQ+0x19/0x30
 [<c0103a76>] common_interrupt+0x1a/0x20
 [<c011e5ce>] __do_softirq+0x2e/0xa0
 [<c011e666>] do_softirq+0x26/0x30
 [<c010513e>] do_IRQ+0x1e/0x30
 [<c0103a76>] common_interrupt+0x1a/0x20
 [<c0236ee7>] acpi_processor_idle+0x11d/0x27f
 [<c01010e2>] cpu_idle+0x42/0x60
 [<c045c89d>] start_kernel+0x17d/0x1c0
 [<c045c3b0>] unknown_bootoption+0x0/0x1f0
handlers:
[<c0294a50>] (ide_intr+0x0/0x170)
Disabling IRQ #14

i have the "irqpoll" option as suggested.

problems:
1) seems that before writing data to disk it waits for:
hda: dma_timer_expiry: dma status == 0x24
this lasts some seconds..

2) compared to 2.6.12 it seems working a bit slower.
on suspend...probably due to the timeout
on resume console is painted, but if i press keys i get nothing on 
console tty.
i have to wait some random seconds...
seems strange because i can switch from consoles...so that's not a real 
freeze.


