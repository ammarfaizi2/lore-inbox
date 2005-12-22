Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbVLVUJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVLVUJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 15:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbVLVUJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 15:09:17 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:44986 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030270AbVLVUJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 15:09:17 -0500
Date: Thu, 22 Dec 2005 15:09:06 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, arjanv@infradead.org, nico@cam.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, bcrl@kvack.org,
       hch@infradead.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-Reply-To: <Pine.LNX.4.64.0512220937390.4827@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0512221504540.30825@gandalf.stny.rr.com>
References: <20051222114147.GA18878@elte.hu>  <20051222035443.19a4b24e.akpm@osdl.org>
 <20051222122011.GA20789@elte.hu>  <20051222050701.41b308f9.akpm@osdl.org> 
 <1135257829.2940.19.camel@laptopd505.fenrus.org>  <20051222054413.c1789c43.akpm@osdl.org>
 <1135266369.2806.212.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512220937390.4827@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2005, Linus Torvalds wrote:
>
>
> On Thu, 22 Dec 2005, Thomas Gleixner wrote:
> >
> > Semaphores need a counter, mutexes only a binary representation of the
> > locked/unlocked state
>
> Actually, that's not true.
>
> A _spinlock_ only needs a binary representation of the locked/unlocked
> state.
>
> A mutex needs a _ternary_ representation. It needs an additional
> "contention" state to tell the wakeup that extra action is needed.

True, and that's exactly what Ingo has.

1 unlocked, 0 locked, -1 locked with waiters.  But it still works well
with xchg.

-- Steve

>
> If you don't handle contention (and do extra action all the time), you're
> screwed from a performance standpoint.
>
> 			Linus
>
