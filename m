Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbRFBQKB>; Sat, 2 Jun 2001 12:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbRFBQJv>; Sat, 2 Jun 2001 12:09:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17423 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262604AbRFBQJn>; Sat, 2 Jun 2001 12:09:43 -0400
Subject: Re: APIC problem or 3com 3c590 driver problem in smp kernel 2.4.x
To: fxian@fxian.jukie.net (Feng Xian)
Date: Sat, 2 Jun 2001 17:06:59 +0100 (BST)
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        bogdan.costescu@iwr.uni-heidelberg.de (Bogdan Costescu),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106020005170.4773-100000@tiger> from "Feng Xian" at Jun 02, 2001 12:08:03 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156DvX-0001rf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's our own's card. so it could be the card's problem. does the pci
> device have to do some special thing to support APIC? my card won't work

Nope. APIC is invisible to a correctly built piece of hardware. It just changes
how INTA-INTD are handled at the host end of things

> properly on uni-processor with APIC enable kernel or smp kernel when the
> card is sharing IRQ with some other pci devices.

That sounds like the driver isnt testing the irq was sourced by that card. You
also see hangups on insmod/rmmod when people do

		writel(ENABLE_MY_IRQ, my_card->control);

before they request the IRQ and are able to clear it
