Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132193AbRAJQSC>; Wed, 10 Jan 2001 11:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132117AbRAJQRm>; Wed, 10 Jan 2001 11:17:42 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:3335 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132114AbRAJQRd>;
	Wed, 10 Jan 2001 11:17:33 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Robert Kaiser <rob@sysgo.de>
Date: Wed, 10 Jan 2001 17:16:34 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Anybody got 2.4.0 running on a 386 ?
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <12302DEB1F3D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 01 at 17:00, Robert Kaiser wrote:
> > not really. Could you write a small function that just reads the kernel
> > image from the first symbol to the last one, and see whether it crashes?
> > (read it into a volatile variable to make sure GCC reads it.)
> 
> I tried this: Reading the entire image never caused any crashes.
> 
> However, I did have some (rare) instances of the kernel booting
> successfully. Then it would fail again, booting the very same image
> that had worked before.
> 
> I am beginning to suspect that I may be dealing with flaky hardware.
> (I'm working from home today and I only have access to one of my 386
> specimen here).
> 
> I guess I'll better shut up until I can double check on
> some other 386 boards tomorrow....

Could you try to remove 'inb $0x92,%al','orb $02,%al','outb %al,$0x92'
from arch/i386/boot/setup.S ? Maybe it causes something to your A20.
For example A20 through KBC and bit 1 of port 0x92 are wired together
with XOR, and port 0x92 acts immediately, while KBC acts with delay.
So test for a20 succeeds, as KBC did not turned its A20 yet, but then
after KBC gets done its job, it dies... (eventually overwritting kernel
itself; do you use zImage or bzImage? with bzImage at odd megabyte it should
die almost immediately)

But it is pure speculation. Value of %ax after a20_wait loop finishes
could be interesting too - is it zero (no loop), one (0ffff:210 contained
0), or something higher (we had to wait for KBC)?

You can also try loading with loadlin from DOS with XMS manager, 
instead of through LILO, as if you'll load DOS=HIGH, it will enable A20 
for you. And temporary remove whole A20 game from boot.S.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
