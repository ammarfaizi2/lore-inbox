Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262249AbRENGfv>; Mon, 14 May 2001 02:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262235AbRENGfb>; Mon, 14 May 2001 02:35:31 -0400
Received: from mail3.noris.net ([62.128.1.28]:34715 "EHLO mail3.noris.net")
	by vger.kernel.org with ESMTP id <S262196AbRENGf2>;
	Mon, 14 May 2001 02:35:28 -0400
From: "Matthias Urlichs" <smurf@noris.de>
Date: Mon, 14 May 2001 08:35:23 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: Getting FS access events
Message-ID: <20010514083523.C801@noris.de>
In-Reply-To: <1ete23o.p2cfoe1jnm0e0M%smurf@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1ete23o.p2cfoe1jnm0e0M%smurf@noris.de>; from smurf@noris.de on Mon, May 14, 2001 at 08:26:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch <rgooch@ras.ucalgary.ca>:
> > 
> OK, provided the prefetch will queue up a large number of requests
> before starting the I/O. If there was a way of controlling when the
> I/O actually starts (say by having a START flag), that would be ideal,
> I think.
> 
The START flag is equivalent to the first actual read, whereupon the
elevator code will do the Right Thing.

> That opens up a nasty race: if the dentry is released before the
> pointer is harvested, you get a bogus pointer.
> 
You simply increase the reference count of every dentry you visit, and
free it when the log is read.

> How's that? It won't matter if read(2) synchronises, because I'll be
> issuing the requests in device bnum order.
> 
Of course it does, because the kernel needs to wait for the next read()
system call from your application, which it can only do after the first
one completes, which adds another delay which will slow you down,
especially with high-latency I/O protocols.

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
