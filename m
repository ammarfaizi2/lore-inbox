Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268577AbRHPAHw>; Wed, 15 Aug 2001 20:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268570AbRHPAHl>; Wed, 15 Aug 2001 20:07:41 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:27910 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S268560AbRHPAHY>;
	Wed, 15 Aug 2001 20:07:24 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15227.3613.529481.433816@cargo.ozlabs.ibm.com>
Date: Thu, 16 Aug 2001 10:04:45 +1000 (EST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: PCMCIA IDE_CS in 2.4.7
In-Reply-To: <E15SJJD-0000eB-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.10.10107312226590.26170-100000@clueserver.org>
	<E15SJJD-0000eB-00@the-village.bc.nu>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> Gunther posted this patch ages ago which seems to solve the problem

I found that the first part (adding outb(0x02, ctl_base)) was
necessary but the second part (outb(0, ...)) was not.  Setting nIEN
early on seems safe to me, but it was not clear to me that enabling
IRQs (clearing nIEN) just before the ide_request_irq call was safe -
fortunately it doesn't seem to be necessary, I presume the IDE code
clears nIEN when it wants to start getting interrupts.

On my powerbook I also use a patch which makes sure that the chipset
gets set to ide_pci so that the IDE code will let me share the irq -
the pcmcia controller here has just one interrupt that is used both
for card interrupts and for controller interrupts.  I'm not sure
whether that came from Gunther or someone else.

Paul.
