Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbUKVUal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbUKVUal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbUKVU2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:28:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12774 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262376AbUKVU2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:28:01 -0500
Date: Mon, 22 Nov 2004 13:58:36 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, riel@redhat.com,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: Lazily add anonymous pages to LRU on v2.4? was Re: [2.4] heavy-load under swap space shortage
Message-ID: <20041122155836.GE27753@logos.cnet>
References: <20040310.195707.521627048.nomura@linux.bs1.fc.nec.co.jp> <Pine.LNX.4.44.0403141638390.1554-100000@dmt.cyclades> <20040314121503.13247112.akpm@osdl.org> <20040314230138.GV30940@dualathlon.random> <20040314152253.05c58ecc.akpm@osdl.org> <20041122150138.GB27753@logos.cnet> <20041122194953.GJ10782@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122194953.GJ10782@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 08:49:53PM +0100, Andrea Arcangeli wrote:
> On Mon, Nov 22, 2004 at 01:01:38PM -0200, Marcelo Tosatti wrote:
> > On Sun, Mar 14, 2004 at 03:22:53PM -0800, Andrew Morton wrote:
> > > Andrea Arcangeli <andrea@suse.de> wrote:
> > > >
> > > > > 
> > > > > Having a magic knob is a weak solution: the majority of people who are
> > > > > affected by this problem won't know to turn it on.
> > > > 
> > > > that's why I turned it _on_ by default in my tree ;)
> > > 
> > > So maybe Marcelo should apply this patch, and also turn it on by default.
> > 
> > I've been pondering this again for 2.4.29pre - the thing I'm not sure about 
> > what negative effect will be caused by not adding anonymous pages to LRU 
> > immediately on creation.
> > 
> > The scanning algorithm will apply more pressure to pagecache pages initially 
> > (which are on the LRU) - but that is _hopefully_ no problem because swap_out() will
> > kick-in soon moving anon pages to LRU soon as they are swap-allocated.
> > 
> > I'm afraid that might be a significant problem for some workloads. No?
> > 
> > Marc-Christian-Petersen claims it improves behaviour for him - how so Marc, 
> > and what is your workload/hardware description? 
> > 
> > This is known to decrease contention on pagemap_lru_lock.
> > 
> > Guys, doo you have any further thoughts on this? 
> > I think I'll give it a shot on 2.4.29-pre?
> 
> I think you mean the one liner patch that avoids the lru_cache_add
> during anonymous page allocation (you didn't quote it, and I can't see
> the start of the thread). I develoepd that patch for 2.4-aa and I'm
> using it for years, and it runs in all latest SLES8 kernels too, plus
> 2.4-aa is the only kernel I'm sure can sustain certain extreme VM loads
> with heavy swapping of shmfs during heavy I/O. So you can apply it
> safely I think.

Yes it is your patch I am talking about Andrea. Ok, good to hear that.

