Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131403AbRAKUfb>; Thu, 11 Jan 2001 15:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130571AbRAKUfW>; Thu, 11 Jan 2001 15:35:22 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:13323 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S130229AbRAKUfN>; Thu, 11 Jan 2001 15:35:13 -0500
Date: Thu, 11 Jan 2001 12:35:12 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Dan Kegel <dank@alumni.caltech.edu>
cc: <angelcode@myrealbox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Poll and Select not scaling
In-Reply-To: <3A5CF471.17C03480@alumni.caltech.edu>
Message-ID: <Pine.LNX.4.30.0101111231370.1672-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Dan Kegel wrote:

> select() is usually limited to 1024 file descriptors

oh hey, this limit is only a libc limit these days.  you can do this:

#define MY_FD_SETSIZE (16384)
typedef struct {
        __fd_mask __fds_bits[MY_FD_SETSIZE / __NFDBITS];
} my_fd_set;
#define MY_FD_ZERO(_f)  (memset((_f), 0, sizeof(my_fd_set)))

and do select()s of 16384 descriptors.

> poll() is a slightly better choice.  However, although
> it can handle 30000 file descriptors, the performance sucks;
> see http://www.kegel.com/dkftpbench/Poller_bench.html#results

poll() stops working at 16384 file descriptors (as of 2.2.14-foo original
redhat 6.2 kernel).  at least that's where i think it is, maybe it's
32768.  it's limited by the maximum kmalloc() size of 128k.  this is
somewhat unfortunate.  even though we know it'll stop performing well.

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
