Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLAAl2>; Thu, 30 Nov 2000 19:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129520AbQLAAlT>; Thu, 30 Nov 2000 19:41:19 -0500
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:2788 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S129257AbQLAAlH>; Thu, 30 Nov 2000 19:41:07 -0500
Date: Fri, 1 Dec 2000 00:15:45 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
To: "David S. Miller" <davem@redhat.com>
cc: <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: TCP push missing with writev()
In-Reply-To: <200011302301.PAA07267@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0011302342590.1741-100000@bagpipe.bogo.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2000, David S. Miller wrote:

> 	       vector[ 1 ].iov_base = NULL;
> 	       vector[ 1 ].iov_len = 0;
>
> "Don't do that" :-)
>
> I'll doubt I will bother to fix it (it's not %100 trivial to fix and
> it will put a cost into a hot path).  Even if I did, you're going to
> need to fix Zeus not to do writev's with empty iovec's like this so
> that you get the PSH's in current kernels.

Its OK, our web server currently doesn't have this problem :)

I ran into the problem developing code that wrote data out of a circular
buffer - so the data being written may potentially be in two sections if
the buffer wraps around. A generic writev() call then emptied as much data
out of the buffer as possible, and so tripping the bug. I guess what I'm saying
is that you don't have to have plain dumb code (like the example code I
gave) in order to hit this problem.

Paranoia check: can this bug occur with writev() and other combinations of
sizes, or is it only when there is a 0-length buffer in there?


Ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
