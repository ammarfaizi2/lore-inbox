Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbRAIL3c>; Tue, 9 Jan 2001 06:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbRAIL3Y>; Tue, 9 Jan 2001 06:29:24 -0500
Received: from ns.caldera.de ([212.34.180.1]:23816 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129933AbRAIL3J>;
	Tue, 9 Jan 2001 06:29:09 -0500
Date: Tue, 9 Jan 2001 12:28:10 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "David S. Miller" <davem@redhat.com>
Cc: mingo@elte.hu, riel@conectiva.com.br, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109122810.A3115@caldera.de>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, mingo@elte.hu,
	riel@conectiva.com.br, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101081603080.21675-100000@duckman.distro.conectiva> <Pine.LNX.4.30.0101091051460.1159-100000@e2> <20010109113145.A28758@caldera.de> <200101091031.CAA01242@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200101091031.CAA01242@pizda.ninka.net>; from davem@redhat.com on Tue, Jan 09, 2001 at 02:31:13AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 02:31:13AM -0800, David S. Miller wrote:
>    Date: Tue, 9 Jan 2001 11:31:45 +0100
>    From: Christoph Hellwig <hch@caldera.de>
> 
>    Yuck.  A new file_opo just to get a few benchmarks right ...  I
>    hope the writepages stuff will not be merged in Linus tree (but I
>    wish the code behind it!)
> 
> It's a "I know how to send a page somewhere via this filedescriptor
> all by myself" operation.  I don't see why people need to take
> painkillers over this for 2.4.x.  I think f_op->write is stupid, such
> a special case file operation just to get a few benchmarks right.
> This is the kind of argument I am hearing.
> 
> Orthogonal to f_op->write being for specifying a low-level
> implementation of sys_write, f_op->writepage is for specifying a
> low-level implementation of sys_sendfile.  Can you grok that?

Sure.  But sendfile is not one of the fundamental UNIX operations...
If there was no alternative to this I would probably have not said
anything, but with the rw_kiovec file op just before the door I don't
see any reason to add this _very_ specific file operation.

An alloc_kiovec before and an free_kiovec after the actual call
and the memory overhaed of a kiobuf won't hurt so much that it stands
against a clean interface, IMHO.


> 
> Linus has already seen this.  Originally he had a gripe because in an
> older revision of the code used to allow multiple pages to be passed
> in an array to the writepage(s) operation.  He didn't like that, so I
> made it take only one page as he requested.  He had no other major
> objections to the infrastructure.

You get that multiple page call with kiobufs for free...

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
