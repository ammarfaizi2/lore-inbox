Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278470AbRJVKBX>; Mon, 22 Oct 2001 06:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278469AbRJVKBP>; Mon, 22 Oct 2001 06:01:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11724 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278470AbRJVKBA>;
	Mon, 22 Oct 2001 06:01:00 -0400
Date: Mon, 22 Oct 2001 06:01:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Rohland <cr@sap.com>
cc: Larry McVoy <lm@bitmover.com>,
        Jan-Frode Myklebust <janfrode@parallab.uib.no>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>,
        Wayne Scott <wscott@bitmover.com>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
In-Reply-To: <m3pu7gggbf.fsf@linux.local>
Message-ID: <Pine.GSO.4.21.0110220556150.2294-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 22 Oct 2001, Christoph Rohland wrote:

> Hi Larry,
> 
> On Sun, 21 Oct 2001, Larry McVoy wrote:
> > One of the engineers here has also seen this.  The root cause is
> > that readdir() is returning a file multiple times.  We've seen it on
> > tmpfs.  We also have seen in in NFS and had a workaround, the
> > workaround depended that the file would be returned twice right next
> > to each other and that's not the case in tmpfs.  wscott@bitmover.com

That's not guaranteed for NFS, BTW.

> > can provide you with the details of his machine config, here's the
> > mail he sent a while back about it:
> 
> tmpfs does not know anything about directory handling. It uses
> generic_read_dir and dcache_readdir. So this must be a bug in the vfs
> layer. Al, what do you say?

If you are changing directory between the calls of getdents(2) - you have
no warranty that offsets will stay stable.  It's not just Linux.

Frankly, I don't see what could be done, short of doing qsort() by inumber
or something equivalent...

