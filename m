Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129850AbRBGTmN>; Wed, 7 Feb 2001 14:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130015AbRBGTmD>; Wed, 7 Feb 2001 14:42:03 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:51209 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129850AbRBGTly>;
	Wed, 7 Feb 2001 14:41:54 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 7 Feb 2001 20:40:21 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Promise, DMA and RAID5 problems running 2.4.1
CC: sajjad@vgkk.com (A.Sajjad Zaidi), linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <14D3DB587F98@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Feb 01 at 19:33, Alan Cox wrote:
> > It is known bug which I reported to Andre already. Open
> > drivers/ide/ide.c in favorite text editor, and replace strange
> > body of ide_delay_50ms() with simple mdelay(50). Promise driver
> > invokes ide_delay_50ms with interrupts disabled, so it freezes
> > here forever. If you have NMI watchdog, you'll get nice oopses.
> 
> Its a bug in the promise driver. ide_delay_50ms() is being friendly to the
> rest of the box. If the reset path for the promise cant be polite then it
> should use mdelay() itself.

Iff CONFIG_BLK_DEV_IDECS is set then yes, doing schedule is better.
But I do not see any benefit in doing

unsigned long timeout = jiffies + ((HZ + 19)/20) + 1;
while (0 < (signed long)(timeout - jiffies));

over

mdelay(50);

And on my box, busy while loop is executed, not schedule(HZ/20)...

                                                Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
