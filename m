Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282190AbRLQS6s>; Mon, 17 Dec 2001 13:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282212AbRLQS6i>; Mon, 17 Dec 2001 13:58:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38027 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282190AbRLQS6d>;
	Mon, 17 Dec 2001 13:58:33 -0500
Date: Mon, 17 Dec 2001 21:56:07 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: bcrl <bcrl@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mempool-2.5.1-D2
In-Reply-To: <20011217171931.1a87bab2.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0112172140430.17088-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Dec 2001, Stephan von Krawczynski wrote:

> [...] You will obviously _not_ shoot down allocated and still used
> bios, no matter how long they are going to take. So your fixed size
> pool will run out in certain (maybe weird) conditions. If you cannot
> resize (alloc additional mem from standard VM) you are just dead.

sure, the pool will run out under heavy VM load. Will it stay empty
forever? Nope, because all mempool users are *required* to deallocate the
buffer after some (reasonable) timeout. (such as IO latency.) This is
pretty much by definition. (Sure there might be weird cases like IO
failure timeouts, but sooner or later the buffer will be returned, and it
will be reused.)

(by the way, this is true for every other reservation solution as well,
just look at the patches. You wont resize on the fly whenever there is
shortage - thats the problem with shortages, there just wont be more RAM.
If anyone uses reserved pools and doesnt release those buffers then we are
deadlocked. Memory reserves *must not* be used as a kmalloc pool. Doing
that can be considered an advanced form of a 'memory leak'.)

(and there is mempool_resize() if some aspect of the device is changed.)

	Ingo

