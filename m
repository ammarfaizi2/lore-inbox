Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270805AbVBEUGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270805AbVBEUGJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 15:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270803AbVBEUGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 15:06:09 -0500
Received: from rost.dti.supsi.ch ([193.5.152.238]:31370 "EHLO
	rost.dti.supsi.ch") by vger.kernel.org with ESMTP id S273779AbVBEUD7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 15:03:59 -0500
Date: Sat, 5 Feb 2005 21:03:56 +0100 (CET)
From: Marco Rogantini <marco.rogantini@supsi.ch>
X-X-Sender: rogantin@rost.dti.supsi.ch
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: rtl8139 (8139too) net problem in linux 2.6.10
In-Reply-To: <87wttmg77p.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.62.0502052052560.6832@rost.dti.supsi.ch>
References: <Pine.LNX.4.62.0502051818370.4821@rost.dti.supsi.ch>
 <87wttmg77p.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 6 Feb 2005, OGAWA Hirofumi wrote:

> Marco Rogantini <marco.rogantini@supsi.ch> writes:
>
>> sort kernel: NETDEV WATCHDOG: eth1: transmit timed out
>> sort kernel: eth1: Transmit timeout, status 0d 0000 c07f media 00.
>
> This state seems the hardware problem. Probably TX pending was not
> processed, so any pending interrupts is nothing.
>
> What CardBus bridge are you using? If TI12xx bridge, can you try the
> attached patch? (Try "disable_clkrun" module option with yenta_socket.ko)
>

Many thanks for your help,

I'm using a TI-PCI4510 on a Dell Inspiron 8500.
Kernel is linux-2.6.11-rc3 and your patch is already included there.

I tried to load the module with 'disable_clkrun' option but nothing has
changed... :-(


dmesg extract:

Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:02:01.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:01.0 [1028:013e]
Yenta: ISA IRQ mask 0x04d8, PCI irq 11
Socket status: 30000020
8139too Fast Ethernet driver 0.9.27
PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:03:00.0 to 64
eth1: RealTek RTL8139 at 0xe0824000, 00:30:4f:35:da:7f, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139C'


lspci | grep -i cardbus:

0000:02:01.0 CardBus bridge: Texas Instruments PCI4510 PC card Cardbus 
Controller (rev 02)


It is perhaps that IRQ11 is shared with a lot of other devices?

cat /proc/interrupts:

            CPU0
   0:     872193          XT-PIC  timer
   1:        652          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   8:          4          XT-PIC  rtc
   9:          2          XT-PIC  acpi
  11:      32031          XT-PIC  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd, 
yenta, eth0, eth1
  12:        106          XT-PIC  i8042
  14:       4432          XT-PIC  ide0
  15:         12          XT-PIC  ide1
NMI:          0
LOC:     872045
ERR:          0
MIS:          0


In any case, many thanks for your contributions!

 	-marco
