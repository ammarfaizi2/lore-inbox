Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131269AbRDBUS4>; Mon, 2 Apr 2001 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131309AbRDBUSq>; Mon, 2 Apr 2001 16:18:46 -0400
Received: from hera.cwi.nl ([192.16.191.8]:47554 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131269AbRDBUSb>;
	Mon, 2 Apr 2001 16:18:31 -0400
Date: Mon, 2 Apr 2001 22:17:02 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200104022017.WAA89061.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: Larger dev_t
Cc: alan@lxorguk.ukuu.org.uk, hpa@transmeta.com, linux-kernel@vger.kernel.org,
   tytso@MIT.EDU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK - everybody back from San Jose - pity I couldnt come -
and it is no longer April 1st, so we can continue quarreling
a little.

Interesting that where I had divided stuff in the trivial part,
the interesting part and the lot-of-work part we already start
fighting on the trivial part. Maybe it is not very important -
still I'd prefer to do things right from the start.

Yes. We need a larger dev_t as everybody agrees.
How large?

What is dev_t used for? It is a communication channel from
filesystem to user space (via the stat() system call)
and from user space to filesystem (via the mknod() system call).

So, it seems the kernel interface must allow passing the values
that actually occur, in present or future file systems.
Making the interface narrow is only asking for problems later.
Are there already any filesystems that use 64-bits?
I would say that that is irrelevant - what we don't have today
may come tomorrow - but in fact the NFSv3 interface uses
a 64-bit device number.

So glibc comes with 64 bits, the kernel has to hand these bits
over to NFS but is unwilling to - you are not going to get
more than 32. Why?

> I have a holy crusade.

I fail to see the connection. There is no bloat here, the kernel
is hardly involved. Some values are passed. If the values are
larger than the filesystem likes it will probably return EINVAL.
But the kernel has no business getting in the way.

There is no matter of efficiency either - mknod is not precisely
the most frequently used system call, and our stat interface, which
really is important, is 64 bits today.

Not using 64 also gives interesting small problems with Solaris or
FreeBSD NFS mounts. One uses 14+18, the other 8+24, so with 12+20
we cannot handle Solaris' majors and we cannot handle FreeBSD's minors.

[Then there were discussions about naming.
These are interesting, but independent.
The current discussion is almost entirely about mknod.]

Andries
