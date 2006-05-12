Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWELNRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWELNRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWELNRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:17:13 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:55209 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751282AbWELNRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:17:12 -0400
Date: Fri, 12 May 2006 09:16:50 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: Mark Hounschell <markh@compro.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, akpm@osdl.org
Subject: 3c59x vortex_timer rt hack (was: rt20 patch question)
In-Reply-To: <20060512092159.GC18145@elte.hu>
Message-ID: <Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com>
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
 <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
 <20060512092159.GC18145@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Ingo Molnar wrote:

> --- linux-rt.q.orig/drivers/net/3c59x.c
> +++ linux-rt.q/drivers/net/3c59x.c
> @@ -1897,7 +1897,8 @@ vortex_timer(unsigned long data)
>
>  	if (vp->medialock)
>  		goto leave_media_alone;
> -	disable_irq(dev->irq);
> +	/* hack! */
> +	disable_irq_nosync(dev->irq);
>  	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
>  	EL3WINDOW(4);
>  	media_status = ioread16(ioaddr + Wn4_Media);

BTW, I originally thought about having Mark do this, but I'm nervious
about the side effects that this might have.  Basically, it's doing
ioreads from the device while the interrupt could be doing iowrites.

I don't know the device well enough to know if this is a problem.
I've added Andrew Morton to the CC list, since his name is all over the
code.

Andrew,

Do you know off hand what the side-effects to the vortex card might be
if we use disable_irq_nosync instead of disable_irq?


Mark,

 as Ingo commented, this is a Hack! not a solution.

-- Steve

