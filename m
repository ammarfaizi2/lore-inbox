Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129356AbRBSV44>; Mon, 19 Feb 2001 16:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbRBSV4r>; Mon, 19 Feb 2001 16:56:47 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:31760 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129351AbRBSV4c>; Mon, 19 Feb 2001 16:56:32 -0500
Date: Mon, 19 Feb 2001 21:56:26 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <kuznet@ms2.inr.ac.ru>
cc: <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs
In-Reply-To: <200102191803.VAA12658@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.30.0102192146380.7008-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Feb 2001 kuznet@ms2.inr.ac.ru wrote:

> Wakeup does not happen until _enough_ (1/3 of snbuf) of space in sndbuf
> is released, otherwise you will overschedule. So, as soon as
> write() goes to sleep, it will sleep waiting until 1/3 is released.

Of course. Thank you.

> If it is interrupted, it use all the released space immediately before
> exit. Again, to make more for in this context. This can be even wrong
> and, probably, we should return instantly with -EAGAIN/-EINTR/partial
> count, but it is most likely suboptimal (though I have already changed
> this to instant return). But this does not look essential from
> caller's viewpoint, except for sendfile() of course. 8)

Cool.

I think the proper fix, long term, is to fix our internal I/O routine APIs
so that they are capable of returning a byte count _and_ an error. One
day, that might be a useful thing to export to userspace.

Cheers
Chris

