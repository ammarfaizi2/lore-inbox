Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUIPQbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUIPQbD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268425AbUIPQbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:31:01 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:26086 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268430AbUIPQHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:07:13 -0400
Message-ID: <5d6b657504091609072c7be97c@mail.gmail.com>
Date: Thu, 16 Sep 2004 18:07:07 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Stelian Pop <stelian@popies.net>, Buddy Lucas <buddy.lucas@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
In-Reply-To: <20040916155247.GI3146@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040913135253.GA3118@crusoe.alcove-fr>
	 <20040915153013.32e797c8.akpm@osdl.org>
	 <20040916064320.GA9886@deep-space-9.dsnet>
	 <20040916000438.46d91e94.akpm@osdl.org>
	 <20040916104535.GA3146@crusoe.alcove-fr>
	 <5d6b657504091608093b171e30@mail.gmail.com>
	 <20040916152919.GG3146@crusoe.alcove-fr>
	 <5d6b657504091608511f100109@mail.gmail.com>
	 <20040916155247.GI3146@crusoe.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 17:52:47 +0200, Stelian Pop <stelian@popies.net> wrote:
> On Thu, Sep 16, 2004 at 05:51:04PM +0200, Buddy Lucas wrote:
> 
> > > No, because the type is *unsigned* int.
> >
> > Indeed, that would exactly be the reason *why* this would fail. ;-)
> >
> > The expression fifo->size - fifo->tail + fifo->head might be negative
> > at some point, right? (fifo->head has wrapped to some small value and
> > fifo->tail > fifo->size)
> 
> And what is the value of an unsigned int holding that 'negative' value ? :)
> 

Which unsigned int?! ;-) The expression a - b is negative for unsigned
ints a and b where a < b. So, your unsigned ints "total" and
"remaining" won't be negative of
course, but they won't reflect what is actually left in the buffer;
they will equal the
value of len (in some cases) after fifo->head has wrapped (because of the 
unsignedness) and fifo->tail has not. Which would not be correct.


Cheers,
Buddy

> 
> 
> Stelian.
> --
> Stelian Pop <stelian@popies.net>
>
