Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318855AbSIIUo4>; Mon, 9 Sep 2002 16:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318873AbSIIUo4>; Mon, 9 Sep 2002 16:44:56 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30219
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318855AbSIIUox>; Mon, 9 Sep 2002 16:44:53 -0400
Date: Mon, 9 Sep 2002 13:48:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Zwane Mwaikambo <zwane@mwaikambo.name>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <1031604035.29792.27.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10209091343540.16589-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nIEN is set to allow the device to interrupt the host controller.
Some host controllers have the ablity to block and hold sticky that
transaction to the CPU.

You set nIEN and we need a whole new set of state diagrams for the driver.

nIEN = 0,  interrupt driver
nIEN = 1,  polling driver 

You may not switch this in the middle of the execution of a command block.
If you want to try this, go for it, and leave me off the CC for the mess
you will make of your data.

On 9 Sep 2002, Alan Cox wrote:

> On Sun, 2002-09-08 at 11:57, Zwane Mwaikambo wrote:
> > iirc IDE is capable of doing its own masking per device(nIEN) and in fact 
> > does even do unconditional sti's in its isr paths. So i would think it 
> > would be one of the not so painful device drivers to take care of. 
> 
> If I remember rightly nIEN doesnt work everywhere. Also many IDE
> interfaces may be using legacy IRQ wiring rather than PCI irq lines. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

