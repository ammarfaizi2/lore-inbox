Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbQKHSWW>; Wed, 8 Nov 2000 13:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129647AbQKHSWM>; Wed, 8 Nov 2000 13:22:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18482 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129551AbQKHSV4>; Wed, 8 Nov 2000 13:21:56 -0500
Subject: Re: Pentium 4 and 2.4/2.5
To: bapper@piratehaven.org (Brian Pomerantz)
Date: Wed, 8 Nov 2000 18:21:54 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20001108101248.A8902@skull.piratehaven.org> from "Brian Pomerantz" at Nov 08, 2000 10:12:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tZrA-0000HQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 		asm volatile("rep ; nop");
> > 
> > (there's not much a "rep nop" _can_ do, after all - the most likely CPU
> > extension would be to raise an "Illegal Opcode" fault).
> 
> Just for the curious, this works on Athlons. :)

What state does it leave the condition codes ?  That matters. 

Take for example

if (!oldval)
                asm volatile(
                        "2:"
                        "cmpl $-1, %0;"
                        "rep; nop;"
                        "je 2b;"
                        	: :"m" (current->need_resched));
}

When running SMP with poll_idle enabled. I can't see it changing condition
codes on an athlon but..

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
