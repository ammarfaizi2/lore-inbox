Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbRGMPgv>; Fri, 13 Jul 2001 11:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbRGMPgl>; Fri, 13 Jul 2001 11:36:41 -0400
Received: from c009-h018.c009.snv.cp.net ([209.228.34.131]:33447 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S267493AbRGMPga>;
	Fri, 13 Jul 2001 11:36:30 -0400
X-Sent: 13 Jul 2001 15:36:26 GMT
Date: Fri, 13 Jul 2001 08:36:01 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>,
        Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <3B4E7666.EFD7CC89@uow.edu.au>
Message-ID: <Pine.LNX.4.33.0107130834080.313-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2001, Andrew Morton wrote:

> Andrew Morton wrote:
> >
> > Lance Larsh wrote:
> > >
> > > And while we're talking about comparing configurations, I'll mention that
> > > I'm currently trying to compare raw and ext2 (no lvm in either case).
> >
> > It would be interesting to see some numbers for ext3 with full
> > data journalling.
> >
> > Some preliminary testing by Neil Brown shows that ext3 is 1.5x faster
> > than ext2 when used with knfsd, mounted synchronously.  (This uses
> > O_SYNC internally).
>
> I just did some testing with local filesystems - running `dbench 4'
> on ext2-on-iDE and ext3-on-IDE, where dbench was altered to open
> files O_SYNC.  Journal size was 400 megs, mount options `data=journal'
>
> ext2: Throughput 2.71849 MB/sec (NB=3.39812 MB/sec  27.1849 MBit/sec)
> ext3: Throughput 12.3623 MB/sec (NB=15.4529 MB/sec  123.623 MBit/sec)
>
> ext3 patches are at http://www.uow.edu.au/~andrewm/linux/ext3/
>
> The difference will be less dramatic with large, individual writes.

This is a totally transient effect, right?  The journal acts as a faster
buffer, but if programs are writing a lot of data to the disk for a very
long time, the throughput will eventually be throttled by writing the
journal back into the filesystem.

For programs that write in bursts, it looks like a huge win!

-jwb

