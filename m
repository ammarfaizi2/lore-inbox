Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbRGMPtC>; Fri, 13 Jul 2001 11:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267495AbRGMPsx>; Fri, 13 Jul 2001 11:48:53 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:41713 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267494AbRGMPst>; Fri, 13 Jul 2001 11:48:49 -0400
Message-ID: <3B4F1890.12005981@uow.edu.au>
Date: Sat, 14 Jul 2001 01:49:36 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeffrey W. Baker" <jwbaker@acm.org>
CC: Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <3B4E7666.EFD7CC89@uow.edu.au> <Pine.LNX.4.33.0107130834080.313-100000@desktop>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeffrey W. Baker" wrote:
> 
> > ...
> > ext2: Throughput 2.71849 MB/sec (NB=3.39812 MB/sec  27.1849 MBit/sec)
> > ext3: Throughput 12.3623 MB/sec (NB=15.4529 MB/sec  123.623 MBit/sec)
> >
> > ext3 patches are at http://www.uow.edu.au/~andrewm/linux/ext3/
> >
> > The difference will be less dramatic with large, individual writes.
> 
> This is a totally transient effect, right?  The journal acts as a faster
> buffer, but if programs are writing a lot of data to the disk for a very
> long time, the throughput will eventually be throttled by writing the
> journal back into the filesystem.

It varies a lot with workload.  With large writes such as 
'iozone -s 300m -a -i 0' it seems about the same throughput
as ext2.  It would take some time to characterise fully.

> For programs that write in bursts, it looks like a huge win!

yes - lots of short writes (eg: mailspools) will benefit considerably.
The benefits come from the additional merging and sorting which
can be performed on the writeback data.

I suspect some of the dbench benefit comes from the fact that
the files are unlinked at the end of the test - if the data hasn't
been written back at that time the buffers are hunted down and
zapped - they *never* get written.

If anyone wants to test sync throughput, please be sure to use
0.9.3-pre - it fixes some rather sucky behaviour with large journals.

-
