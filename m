Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130092AbRAIP2N>; Tue, 9 Jan 2001 10:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131464AbRAIP2D>; Tue, 9 Jan 2001 10:28:03 -0500
Received: from mons.uio.no ([129.240.130.14]:53672 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S130092AbRAIP14>;
	Tue, 9 Jan 2001 10:27:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14939.11765.649805.239618@charged.uio.no>
Date: Tue, 9 Jan 2001 16:27:49 +0100 (CET)
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101091342.FAA02414@pizda.ninka.net>
In-Reply-To: <200101080124.RAA08134@pizda.ninka.net>
	<shs4rz8vnmf.fsf@charged.uio.no>
	<200101091342.FAA02414@pizda.ninka.net>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> David S Miller <davem@redhat.com> writes:

     >    I would have thought one of the main interests of doing
     >    something like this would be to allow us to speed up large
     >    writes to the socket for ncpfs/knfsd/nfs/smbfs/...

     > This is what TCP_CORK/MSG_MORE et al. are all for, things get
     > coalesced perfectly.  Sending in a vector of pages seems nice,
     > but none of the page cache infrastructure works like this, all
     > of the core routines work on a page at a time.  It actually
     > simplifies a lot.

     > The writepage interface optimizes large file writes to a socket
     > just fine.

OK, but can you eventually generalize it to non-stream protocols
(i.e. UDP)?
After all, it doesn't make sense to differentiate between zero-copy on
stream and non-stream sockets, and Linux NFS, at least, remains
heavily UDP-oriented...

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
