Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAISRS>; Tue, 9 Jan 2001 13:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRAISRH>; Tue, 9 Jan 2001 13:17:07 -0500
Received: from zeus.kernel.org ([209.10.41.242]:41162 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129431AbRAISQ5>;
	Tue, 9 Jan 2001 13:16:57 -0500
Date: Tue, 9 Jan 2001 18:12:24 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Benjamin C.R. LaHaise" <blah@kvack.org>
Cc: Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109181224.M9321@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0101091720030.4491-100000@e2> <Pine.LNX.3.96.1010109114407.5051E-100000@kanga.kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.96.1010109114407.5051E-100000@kanga.kvack.org>; from blah@kvack.org on Tue, Jan 09, 2001 at 12:30:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 12:30:39PM -0500, Benjamin C.R. LaHaise wrote:
> On Tue, 9 Jan 2001, Ingo Molnar wrote:
> 
> > this is why i ment that *right now* kiobufs are not suited for networking,
> > at least the way we do it. Maybe if kiobufs had the same kind of internal
> > structure as sk_frag (ie. array of (page,offset,size) triples, not array
> > of pages), that would work out better.
> 
> That I can agree with, and it would make my life easier since I really
> only care about the completion of an entire io, not the individual
> fragments of it.

Right, but this is why the kiobuf IO functions are supposed to accept
kiovecs (ie. counted vectors of kiobuf *s, just like ll_rw_block
receives buffer_heads).

The kiobuf is supposed to be a unit of memory, not of IO.  You can map
several different kiobufs from different sources and send them all
together to brw_kiovec() as a single IO.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
