Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAIOUq>; Tue, 9 Jan 2001 09:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131058AbRAIOUg>; Tue, 9 Jan 2001 09:20:36 -0500
Received: from zeus.kernel.org ([209.10.41.242]:12753 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129415AbRAIOUV>;
	Tue, 9 Jan 2001 09:20:21 -0500
Date: Tue, 9 Jan 2001 14:18:06 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
        hch@caldera.de, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109141806.F4284@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0101081603080.21675-100000@duckman.distro.conectiva> <Pine.LNX.4.30.0101091051460.1159-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101091051460.1159-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 11:23:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 11:23:41AM +0100, Ingo Molnar wrote:
> 
> > Having proper kiobuf support would make it possible to, for example,
> > do zerocopy network->disk data transfers and lots of other things.
> 
> i used to think that this is useful, but these days it isnt. It's a waste
> of PCI bandwidth resources, and it's much cheaper to keep a cache in RAM
> instead of doing direct disk=>network DMA *all the time* some resource is
> requested.

No.  I'm certain you're right when talking about things like web
serving, but it just doesn't apply when you look at some other
applications, such as streaming out video data or performing
fileserving in a high-performance compute cluster where you are
serving bulk data.  The multimedia and HPC worlds typically operate on
datasets which are far too large to cache, so you want to keep them in
memory as little as possible when you ship them over the wire.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
