Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268493AbTBWP3H>; Sun, 23 Feb 2003 10:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268502AbTBWP2q>; Sun, 23 Feb 2003 10:28:46 -0500
Received: from [195.223.140.107] ([195.223.140.107]:22662 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268492AbTBWP2l>;
	Sun, 23 Feb 2003 10:28:41 -0500
Date: Sun, 23 Feb 2003 16:40:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ak@suse.de: Re: iosched: impact of streaming read on read-many-files]
Message-ID: <20030223154002.GG29467@dualathlon.random>
References: <20030222054307.GA22074@wotan.suse.de> <20030221230716.630934cf.akpm@digeo.com> <20030222145728.L629@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222145728.L629@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 02:57:28PM +0100, Ingo Oeser wrote:
> On Fri, Feb 21, 2003 at 11:07:16PM -0800, Andrew Morton wrote:
> > You have not defined "fix".  An IO scheduler which attempts to serve every
> > request within ten milliseconds is an impossibility.  Attempting to 
> > achieve it will result in something which seeks all over the place.
> > 
> > The best solution is to implement five or ten seconds worth of buffering
> > in the application and for the kernel to implement a high throughput general
> > purpose I/O scheduler which does not suffer from starvation.
> 
> What about implementing io-requests, which can time out? So if it will
> not be serviced in time or we know, that it will not be serviced
> in time, we can skip that.
> 
> This can easily be stuffed into the aio-api by cancelling
> requests, which are older than a specified time. Just attach a
> jiffie to each request and make a new syscall like io_cancel but
> with a starting time attached. Or even make it a property of the
> aio list we are currently handling and use a kernel timer.
> 
> That way we could help streaming applications and the kernel
> itself (by reducing its io-requests) at the same time.
> 
> Combined with you buffering suggestion, this will help cases,
> where the system is under high load and cannot satisfy these
> applications anyway.
> 
> What do you think?

that works only if the congestion cames from multimedia apps that are
willing to cancel the timed out (now worthless) I/O, that is never the
case normally due the low I/O load they generate (usually it's apps not
going to cancel the I/O that congest the blkdev layer).

still, it's a good idea, you're basically asking to implement the cancel
aio api and I doubt anybody could disagree with that ;).

Andrea
