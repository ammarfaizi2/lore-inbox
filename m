Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265586AbSKAD0z>; Thu, 31 Oct 2002 22:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSKAD0z>; Thu, 31 Oct 2002 22:26:55 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:57523 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265586AbSKAD0x>;
	Thu, 31 Oct 2002 22:26:53 -0500
Date: Fri, 1 Nov 2002 03:32:08 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
Message-ID: <20021101033208.GA31592@bjl1.asuk.net>
References: <20021030221724.GA25231@bjl1.asuk.net> <Pine.LNX.3.96.1021031203329.22444D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021031203329.22444D-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> > Oh, the inode of a file which is open does remain in core.  It's just
> > that between runs of a program like "make", the file's aren't open are
> > they?
> 
> I thought we were talking about parallel make, rather than "between runs."

A parallel build often does call "make" separately many times, in
parallel but not guaranteed to overlap all file opens.  Between those,
the files are closed.

> Your point is valid, but given the certainty that the inode has been
> recently used, hopefully the kernel is smart on releasing them.

That's a "hopefully", and it depends on how much RAM you have as well
as pure luck.  I can live with that for building programs at home, but
there are many applications where "hopefully" affecting correctness of
behaviour is not acceptable.

> My first thought is that the commonly used filesystems, other than ext2,
> do or will support high resolution time. NFS is its own nasty little
> problem.

Do they support nanosecond time, though, or do they round it to
microseconds or something like that?

> [stuff about atime]

There seems to be general agreement that atime is not a very important
value, with which I concur.  (Why do we even bother with nanosecond atimes?)

I am only concerned about mtime, which is very useful indeed when we
talk about building things which can detect changes to files.

Andi, I belive there is space in every architecture's stat64 (i.e. all
those that have one) for a word describing the mtime resolution.  If I
code a patch to create that field, would you be interested?

-- Jamie
