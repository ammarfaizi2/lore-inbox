Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbRETCc2>; Sat, 19 May 2001 22:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261380AbRETCcS>; Sat, 19 May 2001 22:32:18 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:2699 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261379AbRETCb6>;
	Sat, 19 May 2001 22:31:58 -0400
Date: Sat, 19 May 2001 22:31:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <200105191851.f4JIpNK00364@mobilix.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0105192217260.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Richard Gooch wrote:

> There is another reason to use ioctl(2): when you need to send data to
> the kernel/driver and wait for a response. It supports transactions,
> which read(2) and write(2) cannot. Therefore it remains useful.

Somebody, run to database vendors and tell them that they were selling
snake oil all that time - Richard had just shown that support of remote
transactions is impossible. Can't do that with read() and write(),
dontcha know?

Richard, I hate to break it on you, but
	fd = open(foo, 2);
		/* kernel creates a new struct file, as usual */
	write(fd, data, len);
		/* kernel starts the operation */
	read(fd, reply, size);
		/* we block */
		/* operation is completed */
		/* kernel passes reply to user and wakes it up */
_is_ a support of transactions. And yes, we can trivially distinguish
between requests from different sources - struct file * passed to
->write() is more than enough for that. Moreover, we can easily block
other writers until the action is completed.

Please, get a bloody clue. There are reasons for and against ioctls, but
need to send data and wait for responce is _NOT_ one of them.

