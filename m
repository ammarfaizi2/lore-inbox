Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268313AbUIPWxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268313AbUIPWxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268311AbUIPWxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:53:35 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:65092 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268310AbUIPWwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:52:09 -0400
Message-ID: <5d6b6575040916155231a859b3@mail.gmail.com>
Date: Fri, 17 Sep 2004 00:52:06 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Stelian Pop <stelian@popies.net>, Buddy Lucas <buddy.lucas@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
In-Reply-To: <20040916183030.GC9886@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040913135253.GA3118@crusoe.alcove-fr>
	 <20040916064320.GA9886@deep-space-9.dsnet>
	 <20040916000438.46d91e94.akpm@osdl.org>
	 <20040916104535.GA3146@crusoe.alcove-fr>
	 <5d6b657504091608093b171e30@mail.gmail.com>
	 <20040916152919.GG3146@crusoe.alcove-fr>
	 <5d6b657504091608511f100109@mail.gmail.com>
	 <20040916155247.GI3146@crusoe.alcove-fr>
	 <5d6b657504091609072c7be97c@mail.gmail.com>
	 <20040916183030.GC9886@deep-space-9.dsnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 20:30:30 +0200, Stelian Pop <stelian@popies.net> wrote:
> On Thu, Sep 16, 2004 at 06:07:07PM +0200, Buddy Lucas wrote:
> 
> > > > Indeed, that would exactly be the reason *why* this would fail. ;-)
> > > >
> > > > The expression fifo->size - fifo->tail + fifo->head might be negative
> > > > at some point, right? (fifo->head has wrapped to some small value and
> > > > fifo->tail > fifo->size)
> > >
> > > And what is the value of an unsigned int holding that 'negative' value ? :)
> > >
> >
> > Which unsigned int?! ;-) The expression a - b is negative for unsigned
> > ints a and b where a < b. So, your unsigned ints "total" and
> > "remaining" won't be negative of
> > course, but they won't reflect what is actually left in the buffer;
> > they will equal the
> > value of len (in some cases) after fifo->head has wrapped (because of the
> > unsignedness) and fifo->tail has not. Which would not be correct.

Argh! Headless chicken routine.
 
> It is, thanks to modular arithmetic.
> 
> Let's imagine we use unsigned char instead of unsigned int (simpler
> to explain), and we have a 200 bytes buffer.
> 
> At the beginning:
>         head = tail = 0
> We add 200 bytes:
>         head = 0, tail = 200
> We extract 200 bytes:
>         head = 200, tail = 200
> We add 200 bytes more:
>         head = 200, tail = (200 + 200) % 256 = 144
> Now the buffer length is:
>         144 - 200 = (-56) % 256 = 200
> 
> Thanks to modular arithmetic magic, we get the correct answer: 200.

Indeed. I didn't notice you were getting at my head. ;-) 
Sorry for the noise, Stelian.

> 
> 
> Stelian.
> --
> Stelian Pop <stelian@popies.net>
>
