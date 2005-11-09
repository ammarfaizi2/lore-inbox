Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbVKICHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbVKICHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 21:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVKICHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 21:07:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965156AbVKICHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 21:07:36 -0500
Date: Tue, 8 Nov 2005 18:07:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Posssible bug in kernel/irq/handle.c
In-Reply-To: <1131501021.24637.18.camel@gaston>
Message-ID: <Pine.LNX.4.64.0511081802160.3247@g5.osdl.org>
References: <1131496739.24637.12.camel@gaston>  <Pine.LNX.4.64.0511081651320.3247@g5.osdl.org>
 <1131501021.24637.18.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Nov 2005, Benjamin Herrenschmidt wrote:
> 
> Hrm... yah, it should... still, I find that a bit fragile.
> 
> > So I think the code is correct. It has certainly worked for years on x86 
> > (and it got serious debugging, since we had some rather nasty and subtle 
> > issues with edge-triggered APIC interrupts that just get lost if they are 
> > disabled at the controller).
> 
> Well, we have a "funny" case with some pSeries... the firmware may
> enable interrupts behind our back, and expects us to call a firmware
> "try to handle that interrupt" kind of call when we get one we don't
> handle. That is, either all the handlers returned IRQ_NONE or there is
> no action. I'm not sure how to do that with the current code without
> having our own __do_IRQ() which I'd rather avoid...

Well, I don't think it would be _wrong_ to change the IRQ_INPROGRESS 
handling to work so that it's usabel for PPC.

Some of it may actually be purely historical: I have this dim memory that 
we may have used IRQ_INPROGRESS for the irq autodetection originally (it 
now uses the IRQ_WAITING flag for that).

So I was really only arguing for it not being actively buggy the way it is 
now - which is not to say that we can't change it to be friendlier to 
whatever your needs are.

Be vewy vewy caweful when changing that code, though. If you end up with a 
patch, please try to give it some nice stress-testing (both on ppc and 
x86), and then post it for comments, ok? Maybe the arch mailing list and 
Ingo (who else has touched that logic?)

		Linus
