Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271941AbRIDPdQ>; Tue, 4 Sep 2001 11:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271978AbRIDPdF>; Tue, 4 Sep 2001 11:33:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25867 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271937AbRIDPc7>; Tue, 4 Sep 2001 11:32:59 -0400
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
To: fred@arkansaswebs.com (Fred)
Date: Tue, 4 Sep 2001 16:36:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rastos@woctni.sk,
        linux-kernel@vger.kernel.org
In-Reply-To: <01090410264000.14864@bits.linuxball> from "Fred" at Sep 04, 2001 10:26:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15eIFx-0003m2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm  curious, Alan, Why? I'm a hardware developer, and I would have assumed 
> that linux would have been ideal for real time / embedded projects? (routers 
> / controllers / etc.) Is there, for instance, a reason to suspect that linux 
> would not be able to respond to interrupts at say 8Khz?
> of course I know nothing of rtlinux so I'll read.

Routers aren't real time for example

The specific issues you have to watch are mostly from user space. Kernel irq
handlers will run very rapidly providing another driver is not holding the
interrupts off for a long time. Certain types of PC device require this 
(some IDE controllers for example). You also have to watch PCI graphics
cards some of which will stall the PCI bus locking the CPU off it for 
milliseconds at a time [its a hack to get better benchmark numbers - sick
isnt it]

So with the kernel you should be able to respond to irqs at 8Khz, with
RtLinux you can make that a definitive mathematically hard guarantee

Depends which you need

Alan
