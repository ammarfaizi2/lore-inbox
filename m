Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbRAQREU>; Wed, 17 Jan 2001 12:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130022AbRAQREB>; Wed, 17 Jan 2001 12:04:01 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:63754 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129867AbRAQRDt>;
	Wed, 17 Jan 2001 12:03:49 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andrew Morton <andrewm@uow.edu.au>
Date: Wed, 17 Jan 2001 18:02:21 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [linux-fbdev] Re: console spin_lock
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project 
	<linuxconsole-dev@lists.source.redhat.com>
X-mailer: Pegasus Mail v3.40
Message-ID: <12D9032A5156@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jan 01 at 0:49, Andrew Morton wrote:

> Assumption:
> - Once the system is up and running, it's always safe to
>   call down() when in_interrupt() returns false - probably
>   not the case in parts of the exit path - tough.
> 
> Anyway, that's the thoughtware.  Sound sane?

Do not forget to handle printk() done by fbdev driver... It
may invoke printk() from user context, but with console_semaphore
already held... Something like reentrant_semaphore? Also, we
should declare which console/fbdev function can printk/can schedule 
and which must not, as using interrupts & schedule could yield
CPU to other tasks when (hardware assisted) operation is performed.
Some of them (clear, bmove) can take loong time to finish.
                                    Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
