Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIKsl>; Tue, 9 Jan 2001 05:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAIKsb>; Tue, 9 Jan 2001 05:48:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35968 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129383AbRAIKsT>;
	Tue, 9 Jan 2001 05:48:19 -0500
Date: Tue, 9 Jan 2001 02:31:13 -0800
Message-Id: <200101091031.CAA01242@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: hch@caldera.de
CC: mingo@elte.hu, riel@conectiva.com.br, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010109113145.A28758@caldera.de> (message from Christoph
	Hellwig on Tue, 9 Jan 2001 11:31:45 +0100)
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.21.0101081603080.21675-100000@duckman.distro.conectiva> <Pine.LNX.4.30.0101091051460.1159-100000@e2> <20010109113145.A28758@caldera.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 9 Jan 2001 11:31:45 +0100
   From: Christoph Hellwig <hch@caldera.de>

   Yuck.  A new file_opo just to get a few benchmarks right ...  I
   hope the writepages stuff will not be merged in Linus tree (but I
   wish the code behind it!)

It's a "I know how to send a page somewhere via this filedescriptor
all by myself" operation.  I don't see why people need to take
painkillers over this for 2.4.x.  I think f_op->write is stupid, such
a special case file operation just to get a few benchmarks right.
This is the kind of argument I am hearing.

Orthogonal to f_op->write being for specifying a low-level
implementation of sys_write, f_op->writepage is for specifying a
low-level implementation of sys_sendfile.  Can you grok that?

Linus has already seen this.  Originally he had a gripe because in an
older revision of the code used to allow multiple pages to be passed
in an array to the writepage(s) operation.  He didn't like that, so I
made it take only one page as he requested.  He had no other major
objections to the infrastructure.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
