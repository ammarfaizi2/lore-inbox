Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271848AbRIVQpA>; Sat, 22 Sep 2001 12:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271847AbRIVQov>; Sat, 22 Sep 2001 12:44:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59148 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271845AbRIVQol>; Sat, 22 Sep 2001 12:44:41 -0400
Subject: Re: USB lockup on Thinkpad i1300
To: taral@taral.net (Taral)
Date: Sat, 22 Sep 2001 17:50:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010922044527.A23908@taral.net> from "Taral" at Sep 22, 2001 04:45:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kpyd-0003hF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> load usb-ohci. Tracing with kdb shows that the system locks up right
> after executing this: (usb-ohci.c:2137)
> 
>         /* HC Reset requires max 10 ms delay */
>         writel (OHCI_HCR,  &ohci->regs->cmdstatus);
> 
> Anyone have any idea? The processor apparently never gets to the next
> instruction.
As an experiment stick

	unsigned long flags;


	save_flags(flags);
	cli();
	printh("Not dead yet\n");
	/* HC ...
	..

	printk("Writel returned\n");
	readl(&ohci->regs->cmdstatus);
	printk("Write definitely occurred now\n");
	restore_flags(flags);
	printk("Ok with IRQ on\n");


Into that piece of code.

That will tell you if for example it is an IRQ storm of some kind.
