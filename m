Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131385AbRCWTpB>; Fri, 23 Mar 2001 14:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRCWTow>; Fri, 23 Mar 2001 14:44:52 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:45832 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S131385AbRCWToo>; Fri, 23 Mar 2001 14:44:44 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mojomofo@mojomofo.com (Aaron Tiensivu), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac22
In-Reply-To: <E14gODD-0004MR-00@the-village.bc.nu>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Alan Cox's message of "Fri, 23 Mar 2001 09:50:25 +0000 (GMT)"
Date: 23 Mar 2001 13:43:45 -0600
Message-ID: <vbar8zoxocu.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > > o Fix ppp memory corruption (Kevin Buhr)
> > > | Bizzarely enough a direct re-invention of a 1.2 ppp bug
> > 
> > Could this explain my MPPP skb corruption I've reported since 2.3.x?

Unless you saw this corruption immediately after a hardware-initiated
TTY hangup, my patch wouldn't have had anything to do with it.

> At most it explains some weird corruption cases with small kernel blocks.
> I really doubt they are related

And, because I screwed up, the patch doesn't have any effect on PPP
over async TTYs in 2.4.2, anyway.  The compatibility code for
pre-2.4.0 versions of "pppd", which was the real source of the
problem, was removed in kernel 2.4.2, and the patch has no effect.

The compatibility code is still in the PPP-over-sync-TTY code, but
once that's removed, we can back the patch out.

There are still horrible locking problems, but they represent a
problem with the TTY line discipline switching code.  It's possible
for the line discipline to be "close"d asynchronously by the "eventd"
kernel thread while other line discipline functions (even "open"!) are
sleeping.  Once this is fixed, the vanilla 2.4.2 "ppp_async.c" code
(i.e., without my patch) should be lock-proof.

Kevin <buhr@stat.wisc.edu>
