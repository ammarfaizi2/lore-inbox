Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRBGBbz>; Tue, 6 Feb 2001 20:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129662AbRBGBbq>; Tue, 6 Feb 2001 20:31:46 -0500
Received: from zeus.kernel.org ([209.10.41.242]:54976 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129534AbRBGBbf>;
	Tue, 6 Feb 2001 20:31:35 -0500
Date: Wed, 7 Feb 2001 01:27:10 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207012710.N1167@redhat.com>
In-Reply-To: <20010207002107.L1167@redhat.com> <Pine.LNX.4.10.10102061628440.2045-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10102061628440.2045-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 06, 2001 at 04:41:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 06, 2001 at 04:41:21PM -0800, Linus Torvalds wrote:
> 
> On Wed, 7 Feb 2001, Stephen C. Tweedie wrote:
> > No, it is a problem of the ll_rw_block interface: buffer_heads need to
> > be aligned on disk at a multiple of their buffer size.
> 
> Ehh.. True of ll_rw_block() and submit_bh(), which are meant for the
> traditional block device setup, where "b_blocknr" is the "virtual
> blocknumber" and that indeed is tied in to the block size.
> 
> The fact is, if you have problems like the above, then you don't
> understand the interfaces. And it sounds like you designed kiobuf support
> around the wrong set of interfaces.

They used the only interfaces available at the time...

> If you want to get at the _sector_ level, then you do
...
> which doesn't look all that complicated to me. What's the problem?

Doesn't this break nastily as soon as the IO hits an LVM or soft raid
device?  I don't think we are safe if we create a larger-sized
buffer_head which spans a raid stripe: the raid mapping is only
applied once per buffer_head.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
