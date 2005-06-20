Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVFTCZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVFTCZU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 22:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVFTCZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 22:25:20 -0400
Received: from mail.dvmed.net ([216.237.124.58]:56471 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261389AbVFTCZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 22:25:12 -0400
Message-ID: <42B62901.3000500@pobox.com>
Date: Sun, 19 Jun 2005 22:25:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcel Naziri <silent@zwobbl.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: sata_promise KERNEL_BUG on 2.6.12
References: <200506200402.55229.silent@zwobbl.de>
In-Reply-To: <200506200402.55229.silent@zwobbl.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Naziri wrote:
> Now, when I connect the drives to port 1 & 2 of the controller, booting up 
> stops with this:
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
> ata1: SATA max UDMA/133 cmd 0xF8802200 ctl 0xF8802238 bdma 0x0 irq 17
> ata2: SATA max UDMA/133 cmd 0xF8802280 ctl 0xF88022B8 bdma 0x0 irq 17
> ata3: SATA max UDMA/133 cmd 0xF8802300 ctl 0xF8802338 bdma 0x0 irq 17
> ata4: SATA max UDMA/133 cmd 0xF8802380 ctl 0xF88023B8 bdma 0x0 irq 17
> ata1: no device found (phy stat 00000000)
> scsi0 : sata_promise
> ata2: dev 0 ATA, max UDMA/100, 312581808 sectors: lba48
> ------------[ cut here ]------------
> kernel BUG at drivers/scsi/libata-core.c:2077!
> invalid operand: 0000 [#1]
> PREEMPT
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c025f60f>]     Not tainted VLI
> EFLAGS: 00010246   (2.6.12)
> EIP is at ata_dev_set_xfermode+0xcf/0xf0

This is highly strange.  Do you have any patches applied, or is this 
vanilla 2.6.12 kernel?

Can you turn off preempt and try to reproduce ?
Can you provide your full .config ?


> Can it deal with the fact, that the drives are not scanned in port order of 
> the controller? They seem to be mapped like
> port 1 > ata4
> port 2 > ata2
> port 3 > ata1
> port 4 > ata3

The driver scans the ports in the order presented internally in the 
hardware.

	Jeff



