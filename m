Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVEZKLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVEZKLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 06:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVEZKLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 06:11:33 -0400
Received: from tornado.reub.net ([60.234.136.108]:31668 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261297AbVEZKL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 06:11:26 -0400
Message-ID: <4295A0CE.3020005@reub.net>
Date: Thu, 26 May 2005 22:11:26 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050524)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm3
References: <fa.h3qui0k.n6uf30@ifi.uio.no>	<4247DCBE.7020900@reub.net>	<20050328120200.C9847@flint.arm.linux.org.uk>	<200503301341.59976.dtor_core@ameritech.net>	<6.2.3.0.2.20050402153905.01c9ea08@tornado.reub.net> <20050525212044.67271b83.akpm@osdl.org>
In-Reply-To: <20050525212044.67271b83.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/05/2005 4:20 p.m., Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
>>>Reuben, could you please try the patch below? Thanks!
>>>
>>>Russell, could you please tell me if ldisc->write_wakeup (tty_wakwup) and
>>>ldisc->read are allowed to be called from an IRQ context? IOW I wonder if
>>>I can use spil_lock_bh instead of spil_lock_irqsave to protect serport
>>>flags.
>>>
>>>--
>>>Dmitry
>>>
>>> serport.c |   98 
>>>+++++++++++++++++++++++++++++++++++++++++++-------------------
>>> 1 files changed, 68 insertions(+), 30 deletions(-)
>>>
>>>Index: dtor/drivers/input/serio/serport.c
>>>===================================================================
>>>--- dtor.orig/drivers/input/serio/serport.c
>>>+++ dtor/drivers/input/serio/serport.c
>>>@@ -27,11 +27,15 @@ MODULE_LICENSE("GPL");
>>> MODULE_ALIAS_LDISC(N_MOUSE);
>>
>>
>>I've done some testing this afternoon and it seems that this patch 
>>fixes the problem in -mm4.  I don't even have a serial 
>>mouse/keyboard, but do have a serial PCI card onboard.  The box has a 
>>USB connection to a Belkin KVM instead of directly attached input devices.
>>
>>I also note that it is occurring on kernel-smp-2.6.11-1.1219_FC4 - so 
>>it is probably a problem in mainline as well as -mm.
> 
> 
> Can you please confirm that the above fix is present in 2.6.12-rc5 and that
> 2.6.12-rc5 is working OK?

The fix is definitely in -rc5 (thanks), and without doubt fixed the problem I 
was seeing (thanks Dmitry).  I haven't tested on a vanilla 2.6.12-rc5, but I 
can confirm that 2.6.12-rc4-mm* releases have not had the problem.  The patch 
was of course in -rc4-mm* and possibly earlier?

> >>Now I'm crashing a bit further through the shutdown, here's the stacktrace:
> 
> 
> Is this still occurring in either 2.6.12-rc5 or 2.6.12-rc5-mm1?

2.6.12-rc4-mm* releases have been stable, I haven't seen any oopses for a few 
weeks now.

If confirmation is required in -rc5 then I'm happy to attempt this, but I 
don't think it's at all likely given I haven't seen any oopses at all since 
that patch was included in -mm, and the patch is now in upstream.

Btw, I didn't see a lkml-announce message about -rc5-mm1 being released :(  No 
big deal really...

reuben
