Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbRAINyP>; Tue, 9 Jan 2001 08:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbRAINxz>; Tue, 9 Jan 2001 08:53:55 -0500
Received: from mons.uio.no ([129.240.130.14]:48290 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S130485AbRAINwt>;
	Tue, 9 Jan 2001 08:52:49 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101080124.RAA08134@pizda.ninka.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 09 Jan 2001 14:52:40 +0100
In-Reply-To: "David S. Miller"'s message of "Sun, 7 Jan 2001 17:24:24 -0800"
Message-ID: <shs4rz8vnmf.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David S Miller <davem@redhat.com> writes:

     > I've put a patch up for testing on the kernel.org mirrors:

     > /pub/linux/kernel/people/davem/zerocopy-2.4.0-1.diff.gz

.....

     > Finally, regardless of networking card, there should be a
     > measurable performance boost for NFS clients with this patch
     > due to the delayed fragment coalescing.  KNFSD does not take
     > full advantage of this facility yet.

Hi David,

I don't really want to be chiming in with another 'make it a kiobuf',
but given that you already have written 'do_tcp_sendpages()' why did
you make sock->ops->sendpage() take the single page as an argument
rather than just have it take the 'struct page **'?

I would have thought one of the main interests of doing something like
this would be to allow us to speed up large writes to the socket for
ncpfs/knfsd/nfs/smbfs/...
After all, in both the case of the client WRITE requests and the
server READ responses, we end up with a set of several pages that just
need to be pushed down the network without further ado. Unless I
misunderstood the code, it seems that do_tcp_sendpages() fits the bill
nicely...

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
