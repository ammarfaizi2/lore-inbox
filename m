Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbRAIKdL>; Tue, 9 Jan 2001 05:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRAIKdF>; Tue, 9 Jan 2001 05:33:05 -0500
Received: from ns.caldera.de ([212.34.180.1]:36103 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130392AbRAIKcv>;
	Tue, 9 Jan 2001 05:32:51 -0500
Date: Tue, 9 Jan 2001 11:31:45 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109113145.A28758@caldera.de>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Rik van Riel <riel@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101081603080.21675-100000@duckman.distro.conectiva> <Pine.LNX.4.30.0101091051460.1159-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.30.0101091051460.1159-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 11:23:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 11:23:41AM +0100, Ingo Molnar wrote:
> 
> On Mon, 8 Jan 2001, Rik van Riel wrote:
> 
> > I really think the zerocopy network stuff should be ported to kiobuf
> > proper.
> 
> yep, we talked to Stephen Tweedie about this already, but it involves some
> changes in kiovec support and we didnt want to touch too much code for
> 2.4. In any case, the zerocopy code is 'kiovec in spirit' (uses vectors of
> struct page *, offset, size entities),

Yep.  That is why I was so worried aboit the writepages file op.
It's rather hackish (only write, looks usefull only for networking)
instead of the proposed rw_kiovec fop.

> 
> > The usefulness of the patch you posted is rather .. umm .. limited.
> > [...]
> 
> i violently disagree :-) The upcoming TUX release is based on David's and
> Alexey's cleaned-up zerocopy framework. [thus TUX and zerocopy are
> separated.] David's patch adds a *very* scalable implementation of
> zerocopy sendfile() and zerocopy sendmsg(), the panacea of fileserver
> (webserver) scalability - it can be used by Apache, Samba and other
> fileservers. The new zerocopy networking code DMA-s straight out of the
> pagecache, natively supports hardware-checksumming and highmem (64-bit DMA
> on 32-bit systems) zerocopy as well and multi-fragment DMA - no
> limitations. We can saturate a gigabit link with TCP traffic, at about 20%
> CPU usage on a 500 MHz x86 UP system. David and Alexey's patch is cool -
> check it out!

Yuck.  A new file_opo just to get a few benchmarks right ...
I hope the writepages stuff will not be merged in Linus tree
(but I wish the code behind it!)

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
