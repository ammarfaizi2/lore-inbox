Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264561AbRFSSDW>; Tue, 19 Jun 2001 14:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264562AbRFSSDL>; Tue, 19 Jun 2001 14:03:11 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:64272 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S264561AbRFSSDF>;
	Tue, 19 Jun 2001 14:03:05 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Richard B. Johnson" <root@chaos.analogic.com>
Date: Tue, 19 Jun 2001 20:02:29 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: gnu asm help...
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <6484B6B2F3A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jun 01 at 13:21, Richard B. Johnson wrote:
> On Tue, 19 Jun 2001, Timur Tabi wrote:
> > Oh, I see the problem.  You could do something like this:
> > 
> > cli
> > mov %0, %%eax
> > inc %%eax
> > mov %%eax, %0
> > sti
> > 
> > and then return eax, but that won't work on SMP (whereas the "lock inc" does).
> > Doing a global cli might work, though.

Use spinlocks instead of global cli. Global cli can take milliseconds.
 
> The Intel book(s) state that an interrupt is not acknowledged until
> so many clocks (don't remember the number) after a stack operation.

Reread it. It says 'after operation with ss' - that is after
"mov xxxx,%ss" or "pop %ss", as it is expected that next instruction 
will be "movl yyyy,%esp". 

Before "lss ...." (it is lss in intel mnemonic...) was invented, you 
could not switch your stack safely without this feature, as NMI could 
arrive in the middle of your stack switch without blocking all interrupts 
after "mov xxxx,%ss". 

BTW, if you chain "mov %eax,%ss" back to back, they are executed
in pairs - irq can arrive after even mov, but cannot after odd (at
least on PII and PIII). But it is a bit off topic for L-K (except that 
we can try other clones, maybe someone got it wrong?)
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
                                                
