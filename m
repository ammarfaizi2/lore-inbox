Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135963AbRAMAma>; Fri, 12 Jan 2001 19:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135964AbRAMAmV>; Fri, 12 Jan 2001 19:42:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5126 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135963AbRAMAmI>; Fri, 12 Jan 2001 19:42:08 -0500
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 13 Jan 2001 00:43:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101121631250.8097-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 12, 2001 04:35:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HEn2-0005M6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	interrupt_handler()
> 	{
> 		status = readl(dev->status);
> 		if (status & MY_IRQ_DISABLE)
> 			return;

Unfortunately on the 8390 the IRQ statud register is on page 0. The code
on the other CPU might not be on page 0. That means we can't even safely
check if there is an irq pending or clear it down (bad news on ne2k-pci)
without getting that lock.

That means we have to be able to just block that one irq source to avoid
horrible SMP latency problems. 

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
