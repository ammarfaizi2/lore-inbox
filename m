Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVBFOim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVBFOim (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 09:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVBFOim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 09:38:42 -0500
Received: from rost.dti.supsi.ch ([193.5.152.238]:26507 "EHLO
	rost.dti.supsi.ch") by vger.kernel.org with ESMTP id S261184AbVBFOie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 09:38:34 -0500
Date: Sun, 6 Feb 2005 15:38:30 +0100 (CET)
From: Marco Rogantini <marco.rogantini@supsi.ch>
X-X-Sender: rogantin@rost.dti.supsi.ch
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: rtl8139 (8139too) net problem in linux 2.6.10
In-Reply-To: <87u0oq66ab.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.62.0502061530550.24476@rost.dti.supsi.ch>
References: <Pine.LNX.4.62.0502051818370.4821@rost.dti.supsi.ch>
 <87wttmg77p.fsf@devron.myhome.or.jp> <Pine.LNX.4.62.0502052052560.6832@rost.dti.supsi.ch>
 <87y8e266pu.fsf@devron.myhome.or.jp> <87u0oq66ab.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, 6 Feb 2005, OGAWA Hirofumi wrote:

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
>
>> Umm... Bit strange...
>>
>> I couldn't find the PCI4510 in yenta_table. Did you add the PCI4510 to
>> yenta_table? Could you send "lspci -n" (what vendor-id and device-id)?

0000:02:01.0 CardBus bridge: Texas Instruments PCI4510 PC card Cardbus 
Controller (rev 02)
0000:02:01.0 0607: 104c:ac44 (rev 02)
>
> Grr... Ok, probably that was processed as default bridge.
>
> Could you please try the following patch for debug?

> +#define PCI_DEVICE_ID_TI_4510		0xac44
> +	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4510, TI12XX),

:-) It solved the problem! However I still must use the 'disable_clkrun'
parameter to get the bridge working correctly.

Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:02:01.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:01.0 [1028:013e]
Yenta: Disabling CLKRUN feature
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.0, mfunc 0x012c1202, devctl 0x64
Yenta: ISA IRQ mask 0x04d8, PCI irq 11
Socket status: 30000020


Many, many thanks for your help, you made me a happy man!

 	-marco
