Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130443AbRBBXd1>; Fri, 2 Feb 2001 18:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130660AbRBBXdS>; Fri, 2 Feb 2001 18:33:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27016 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130443AbRBBXdH>;
	Fri, 2 Feb 2001 18:33:07 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14971.17245.660605.426205@pizda.ninka.net>
Date: Fri, 2 Feb 2001 15:31:41 -0800 (PST)
To: David Lang <dlang@diginsite.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <Pine.LNX.4.31.0102021511330.1221-100000@dlang.diginsite.com>
In-Reply-To: <14971.15897.432460.25166@pizda.ninka.net>
	<Pine.LNX.4.31.0102021511330.1221-100000@dlang.diginsite.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Lang writes:
 > right, assuming that there is enough sendfile() benifit to overcome the
 > write() penalty from the stuff that can't be cached or sent from a file.
 > 
 > my question was basicly are there enough places where sendfile would
 > actually be used to make it a net gain.

There are non-performance issues as well (really, all of these points
have been mentioned in this thread btw).  One is that since paged
SKBs use only single-order page allocations, the memory allocation
subsystem is stressed less than the current scheme where SLAB
allocates multi-order pages to satisfy allocations of linear SKB data
buffers.

This has consequences and benefits system wide.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
