Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbTJJRwF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbTJJRwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:52:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:31698 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263090AbTJJRwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:52:02 -0400
Date: Fri, 10 Oct 2003 10:51:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <20031010173344.GC29301@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0310101046060.20420-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Oct 2003, Joel Becker wrote:
> 
> 	I know that, I agree with it, and I said as much a few emails
> past.  Linux should refuse to corrupt your data.  But you've taken the
> tack "It is unsafe today, so we should abandon it altogether, never mind
> fixing it.", which doesn't logically follow.

No, we've fixed it, the problem is that it ends up being a lot of extra
complexity that isn't obvious when just initially looking at it. For
example, just the IO scheduler ended up having serious problems with
overlapping IO requests. That's in addition to all the issues with
out-of-sync ordering etc that could cause direct_io reads to bypass
regular writes and read stuff off the disk that was a potential security
issue.

So right now we have extra code and extra complexity (which implies not
only potential for more bugs, but there are performance worries etc that
can impact even users that don't need it).

And these are fundamental problems to DIRECT_IO. Which means that likely
at some point we will _have_ to actually implement DIRECT_IO entirely
through the page cache to make sure that it's safe. So my bet is that
eventually we'll make DIRECT_IO just be an awkward way to do page cache
manipulation.

And maybe it works out ok. And we'll clearly have to keep it working. The 
issue is whether there are better interfaces. And I think there are bound 
to be.

		Linus

