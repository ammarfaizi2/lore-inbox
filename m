Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSJ3WMH>; Wed, 30 Oct 2002 17:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264949AbSJ3WMH>; Wed, 30 Oct 2002 17:12:07 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:18862 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S264945AbSJ3WMG>;
	Wed, 30 Oct 2002 17:12:06 -0500
Date: Wed, 30 Oct 2002 22:17:24 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
Message-ID: <20021030221724.GA25231@bjl1.asuk.net>
References: <20021030004457.GC22170@bjl1.asuk.net> <Pine.LNX.3.96.1021030155404.14229A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021030155404.14229A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> I have to think about the point you raise of doing it one way or the other
> but not mixing. I had assumed that the inode of a file which was open
> would remain in core, and I want to look at the code before I form an
> opinion. If the file is not open or the inode is a non-file...

Oh, the inode of a file which is open does remain in core.  It's just
that between runs of a program like "make", the file's aren't open are
they?

> I think you may have missed the point of (4), some of the overhead of
> keeping HRT is the conversion of data to ns from some machine dependent
> information. Where possible the base information, such as a register,
> could be stored with a flag, avoiding the "convert to ns" CPU usage. The
> conversion could be done when the data was used, before save, at the time
> of a stat, etc. I have the feeling that would take some of the sting out
> of keeping HRT. It doesn't matter if it's atime, mtime or ctime, the atime
> was in response to "nobody uses HRT atime" in an earlier post.

That's some of the overhead.  The other overhead is reading the clock,
which is quite high on x86 when TSC is not available.  On a Pentium
with no reliable TSC, I think that the time for a read() system call
is comparable to the time to read the clock.

-- Jamie
