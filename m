Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130702AbRBGA4m>; Tue, 6 Feb 2001 19:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130705AbRBGA4c>; Tue, 6 Feb 2001 19:56:32 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:60689 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130702AbRBGA4P>; Tue, 6 Feb 2001 19:56:15 -0500
Date: Tue, 6 Feb 2001 18:51:15 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206185115.A23754@vger.timpanogas.org>
In-Reply-To: <20010207003629.M1167@redhat.com> <Pine.LNX.4.10.10102061642330.2045-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10102061642330.2045-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 06, 2001 at 04:50:19PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 04:50:19PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 7 Feb 2001, Stephen C. Tweedie wrote:
> > 
> > That gets us from 512-byte blocks to 4k, but no more (ll_rw_block
> > enforces a single blocksize on all requests but that relaxing that
> > requirement is no big deal).  Buffer_heads can't deal with data which
> > spans more than a page right now.
> 
> Stephen, you're so full of shit lately that it's unbelievable. You're
> batting a clear 0.000 so far.
> 
> "struct buffer_head" can deal with pretty much any size: the only thing it
> cares about is bh->b_size.
> 
> It so happens that if you have highmem support, then "create_bounce()"
> will work on a per-page thing, but that just means that you'd better have
> done your bouncing into low memory before you call generic_make_request().
> 
> Have you ever spent even just 5 minutes actually _looking_ at the block
> device layer, before you decided that you think it needs to be completely
> re-done some other way? It appears that you never bothered to.
> 
> Sure, I would not be surprised if some device driver ends up being
> surpised if you start passing it different request sizes than it is used
> to. But that's a driver and testing issue, nothing more.
> 
> (Which is not to say that "driver and testing" issues aren't important as
> hell: it's one of the more scary things in fact, and it can take a long
> time to get right if you start doing somehting that historically has never
> been done and thus has historically never gotten any testing. So I'm not
> saying that it should work out-of-the-box. But I _am_ saying that there's
> no point in trying to re-design upper layers that already do ALL of this
> with no problems at all).
> 
> 		Linus
> 

I remember Linus asking to try this variable buffer head chaining 
thing 512-1024-512 kind of stuff several months back, and mixing them to 
see what would happen -- result.  About half the drivers break with it.  
The interface allows you to do it, I've tried it, (works on Andre's 
drivers, but a lot of SCSI drivers break) but a lot of drivers seem to 
have assumptions about these things all being the same size in a 
buffer head chain. 

:-)

Jeff


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
