Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWDDPRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWDDPRB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWDDPRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:17:01 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:23435 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1750704AbWDDPRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:17:00 -0400
Message-ID: <44328DE5.3010600@lwfinger.net>
Date: Tue, 04 Apr 2006 10:16:53 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Regression since 2.6.15 - Cardbus system interrupt failure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently switched to v2.6.17-rc1 on my HP ze1115 notebook with a mobile AMD Duron stepping 01
processor. I found that none of my cardbus peripherals would work. The relevant lines from a dmesg 
output were:

ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt for device 0000:00:0a.0 disabled
yenta_cardbus: probe of 0000:00:0a.0 failed with error -12

I used 'git bisect' to localize the problem, which turned out to be the changes in commit 
b408cbc704352eccee301e1103b23203ba1c3a0e, which was made on March 23. When I revert this patch, my 
cardbus system behaves normally and the cardbus controller initialization is

ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0022]
Yenta O2: res at 0x94/0xD4: 00/ea
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0038, PCI irq 11
Socket status: 30000821

The memory map at the beginning of the dmesg buffer is

BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000023ff0000 (usable)
  BIOS-e820: 0000000023ff0000 - 0000000023ffffc0 (ACPI data)
  BIOS-e820: 0000000023ffffc0 - 0000000024000000 (ACPI NVS)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
575MB LOWMEM available.
On node 0 totalpages: 147440
   DMA zone: 4096 pages, LIFO batch:0
   Normal zone: 143344 pages, LIFO batch:31

Please let me know if there is any further information that is required or if there are patches to test.

Larry

