Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282862AbRLQUol>; Mon, 17 Dec 2001 15:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282860AbRLQUob>; Mon, 17 Dec 2001 15:44:31 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:33258 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282866AbRLQUoZ>; Mon, 17 Dec 2001 15:44:25 -0500
Date: Mon, 17 Dec 2001 15:44:23 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mempool-2.5.1-D2
Message-ID: <20011217154423.B9581@redhat.com>
In-Reply-To: <20011217171931.1a87bab2.skraw@ithnet.com> <Pine.LNX.4.33.0112172140430.17088-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112172140430.17088-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Dec 17, 2001 at 09:56:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 09:56:07PM +0100, Ingo Molnar wrote:
> sure, the pool will run out under heavy VM load. Will it stay empty
> forever? Nope, because all mempool users are *required* to deallocate the
> buffer after some (reasonable) timeout. (such as IO latency.) This is
> pretty much by definition. (Sure there might be weird cases like IO
> failure timeouts, but sooner or later the buffer will be returned, and it
> will be reused.)

loop.  deadlock.  kmap.  deadlock.  You've got a lot of code to fix before 
this statement is remotely true.

> (by the way, this is true for every other reservation solution as well,
> just look at the patches. You wont resize on the fly whenever there is
> shortage - thats the problem with shortages, there just wont be more RAM.
> If anyone uses reserved pools and doesnt release those buffers then we are
> deadlocked. Memory reserves *must not* be used as a kmalloc pool. Doing
> that can be considered an advanced form of a 'memory leak'.)

Absolutely.  That's why I think we should at least do some work on design 
of the code so that we have an idea of what the pitfalls are, plus 
documentation before putting it into the kernel.

		-ben
-- 
Fish.
