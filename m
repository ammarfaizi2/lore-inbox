Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSHAREd>; Thu, 1 Aug 2002 13:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSHAREd>; Thu, 1 Aug 2002 13:04:33 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:20752 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S315783AbSHAREb>;
	Thu, 1 Aug 2002 13:04:31 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Marcin Dalecki <dalecki@evision.ag>
Date: Thu, 1 Aug 2002 19:07:21 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE from current bk tree, UDMA and two channels...
CC: linux-kernel@vger.kernel.org, mingo@elte.hu
X-mailer: Pegasus Mail v3.50
Message-ID: <C94E6D2807@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jul 02 at 22:01, Marcin Dalecki wrote:
> 
> Well OK this was my next idea, but apparently you already did the
> experient on your own. Thanks for the result. I'm still scratching my
> head and I have already observed this before myself.
> It's always funny to see what happens when one stops a driver
> from deliberately disabling IRQs for eons of jiffies :-).

I finally managed to compile older kernels, and I found that
2.5.27 (and 2.4.19-rc1 and 2.5.26) works fine (modulo endless loop 
in ide_do_request... but it takes at least 5 minutes to trigger it), 
while 2.5.28 dies in one second with UDMA status 0x25 (irq requested, 
transfer in progress) and IDE status 0x58 (drq asserted).

Because of only change in IDE system between 2.5.27 and 2.5.28 is
renaming __save_flags => local_save_flags, fixing get_request for
ioctl commands (so 2.5.28 should be correct while 2.5.27 is not),
and moving some ioctls around, it looks like that problem is triggered
by something else.

I currently suspect IRQ handling changes, but maybe someone has
better idea? Also, I cannot reproduce problem with Seagate UDMA66
drive switched to UDMA33 mode, so it looks like that problem is 
timming/firmware (Toshiba MK6409MAV) dependent.

And I did all these tests with UP kernel, just to eliminate cli/sti 
changes.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
