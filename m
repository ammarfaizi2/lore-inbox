Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280084AbRJaFhv>; Wed, 31 Oct 2001 00:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280083AbRJaFhb>; Wed, 31 Oct 2001 00:37:31 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:27780 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S280081AbRJaFhZ>;
	Wed, 31 Oct 2001 00:37:25 -0500
Date: Tue, 30 Oct 2001 12:29:08 -0500
From: Theodore Tso <tytso@mit.edu>
To: Alexander Viro <viro@math.psu.edu>
Cc: Christoph Rohland <cr@sap.com>, Larry McVoy <lm@bitmover.com>,
        Jan-Frode Myklebust <janfrode@parallab.uib.no>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>,
        Wayne Scott <wscott@bitmover.com>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Message-ID: <20011030122908.A734@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Alexander Viro <viro@math.psu.edu>, Christoph Rohland <cr@sap.com>,
	Larry McVoy <lm@bitmover.com>,
	Jan-Frode Myklebust <janfrode@parallab.uib.no>,
	ML-linux-kernel <linux-kernel@vger.kernel.org>,
	Wayne Scott <wscott@bitmover.com>
In-Reply-To: <m3pu7gggbf.fsf@linux.local> <Pine.GSO.4.21.0110220556150.2294-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.GSO.4.21.0110220556150.2294-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Oct 22, 2001 at 06:01:32AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 06:01:32AM -0400, Alexander Viro wrote:
> 
> If you are changing directory between the calls of getdents(2) - you have
> no warranty that offsets will stay stable.  It's not just Linux.
> 

Umm... it's not Linux, but it is POSIX.  POSIX states that if a file
is removed or created in a directory in the middle of a readir() scan,
that it's undefined whether or not that file which has been removed or
created will be returned by readdir().  But you're not allowed to
randomly shuffle things around and make files disappear or be returned
multiple times.  Otherwise, it becomes impossible for readdir() to be
used reliably --- after all, even if an individual process isn't
deleting or creating files while doing a readdir(), it can't protect
itself from other processes happening to create or delete files while
it's doing an readdir() scan.

> Frankly, I don't see what could be done, short of doing qsort() by inumber
> or something equivalent...

Yup, that's what you'd have to do.  Readdir() semantics are a bitch,
and a pain in the *ss for filesystems that are doing something other
than a FFS-style linear directory.  Telldir()/seedir() semantics makes
things even worse....

							- Ted
