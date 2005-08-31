Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVHaHsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVHaHsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVHaHsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:48:03 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:48865 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S932464AbVHaHsC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:48:02 -0400
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1bfdf760c6246233502b9d91661972b7@helenandmark.org>
Content-Transfer-Encoding: 8BIT
Cc: Asterisk Developers Mailing List <asterisk-dev@lists.digium.com>
From: Mark Burton <mark@helenandmark.org>
Subject: PCI Master Aborts effect multiple subsystems?
Date: Wed, 31 Aug 2005 09:47:53 +0200
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.622)
X-Spam-Virus: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am trying to do a small amount of work on the wcfxo device driver 
(or an fxo card), which is part of zapatel, which is used by asterisk, 
the linux open source PBX (hence cross post).

question 1: Are PCI Master Aborts delivered to all subsystems, if they 
are, do I need to "fix" ALL the drivers in my system to handle them?

Here's more detail on my problem:

My problem is that my (2) machines both deliver interrupts from the fxo 
card to both the cards driver and to a.n.other sub system. In one case, 
the scsi driver, in the other the eth0 driver. In both cases, of 
course, the drivers get a little upset.

I can not find out why my machines delivers these interrupts (they are 
PCI Master Aborts). I would be VERY grateful for any help in tracking 
that problem. Some information on what could cause a PCI Master Abort 
would be helpful!

My approach has been to fix the driver to do the right thing in the 
case of a PCI Master Abort. I believe I now have a patch that does 
indeed fix the wcfxo driver (it picks the card up again, and continues 
working). However, meanwhile the other subsystem has crashed and burnt.

So, at the same time that the wcfxo driver receives an IRQ 
(reportedly because of a master abort),
e.g. the eth0 driver (3c59x) gives:
Aug 30 22:46:04 localhost kernel: eth0: Too much work in interrupt, 
status e003.
Aug 30 22:46:05 localhost kernel: ACPI: PCI interrupt 0000:02:08.0[A] 
-> GSI 18 (level, low) -> IRQ 185
Aug 30 22:46:05 localhost last message repeated 32 times
(repeated over and over)

I have tried on several kernel versions, but this is Linux version 
2.6.11-1-386 (dannf@firetheft) (gcc version 3.3.6 (Debian 1:3.3.6-6)) 
#1 Mon Jun 20 20:53:17 MDT 2005

I'm afraid I dont have a record of the /proc/interrupts from this run, 
but I did look at them, and the wcfxo driver was on a different IRQ 
than the 3c59x...


I have tried with, and without APIC (noapic on the boot line), I've 
tried playing with bios options, I've even tried, with noapic (when the 
eth0 card is on IRQ 3) reserving IRQ 3, forcing the eth0 card onto irq 
7. But it still received the IRQ :-(((((((((

Can anybody help?
Has anybody seen similar effects before?

Cheers

Mark.

