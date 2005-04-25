Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVDYJvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVDYJvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 05:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVDYJvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 05:51:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30178 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262564AbVDYJu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 05:50:58 -0400
Date: Mon, 25 Apr 2005 11:50:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: rjw@sisk.pl, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3: various swsusp problems
Message-ID: <20050425095035.GC9738@elf.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <4267DC2E.9030102@domdv.de> <20050421185717.GB475@openzaurus.ucw.cz> <426806D0.9090507@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426806D0.9090507@domdv.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> >>1. Is it necessary to print the following message during regular boot?
> >>   swsusp: Suspend partition has wrong signature?
> >>   It is a bit annoying and I believe it will confuse some swsusp
> >>   users.
> > 
> > 
> > Hmm, feel free to provide a patch. (I need something to try git on :-).
> 
> I'll have a look over the weekend.

I already have something from Seife in my queue.

> >>2. PCMCIA related hangs during swsusp.
> >>   swsusp hangs after freeing memory when either cardmgr is running
> >>   or pcmcia cards are *physically* inserted. It is insufficient
> >>   to do a 'cardctl eject' the cards must be removed, too, for
> >>   swsusp not to hang. I do suspect some problem with the
> >>   'pccardd' kernel threads.
> > 
> > 
> > Did it work with any older kernel? Which driver is it? yenta?
> 
> 2.6.11.2 works ok and, yes, its yenta. Some excerpt from lspci:
> 
> 00:0b.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
> 00:0b.1 CardBus bridge: Texas Instruments PCI7420 CardBus Controller

Can you try some more binary search?

> >>3. Sometimes during the search for the suspend hang reason the system
> >>   went during suspend into a lightshow of:
> >>   eth0: Too much work at interrupt!
> >>   and some line that ends in:
> >>   release_console_sem+0x13d/0x1c0)
> >>   The start of the line is not readable as it just flickers by in
> >>   the eth0 message limbo. NIC is a built in RTL-8169 Gigabit Ethernet
> >>   (rev 10). Oh, no chance for a serial console capture as there's no
> >>   built in serial device in this laptop.
> > 
> > 
> > How repeatable is that? Will NIC work okay if you rmmod/insmod its driver?
> 
> Happens with a probability of about 10% to 20%. I did comment out the
> 'Too much work...' printk in r8169.c which results in the following
> effect: no more message from the network driver (expected), no other
> printk related to release_console_sem or anything else unusal, but write
> to disk in the case the problem seems to happen is suddenly quite slow
> and suspend eventually succeeds.

Well, I guess that's expected. If r8169 is looping somewhere with too
much work, no wonder it slows suspend down. 

> As the nic driver is built into the kernel insmod/rmmod currently won't
> do:-) Nevertheless there doesn't seem to be any strange behaviour after
> resume though I didn't really try to use the nic then.
> There is, however, definitely no such problem with the nic in 2.6.11.2.

Well, try putting nic driver from 2.6.11.2 into latest kernel and see
what happens.

I assume your kernel command line and config stayed the same, right?

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
