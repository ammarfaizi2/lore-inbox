Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUCOLsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 06:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUCOLsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 06:48:35 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:60944
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262542AbUCOLsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 06:48:30 -0500
Date: Mon, 15 Mar 2004 12:49:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org, riel@redhat.com,
       torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-ID: <20040315114914.GA30940@dualathlon.random>
References: <20040310.195707.521627048.nomura@linux.bs1.fc.nec.co.jp> <Pine.LNX.4.44.0403141638390.1554-100000@dmt.cyclades> <20040314121503.13247112.akpm@osdl.org> <20040314230138.GV30940@dualathlon.random> <20040314152253.05c58ecc.akpm@osdl.org> <20040315001400.GX30940@dualathlon.random> <4055335B.30402@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4055335B.30402@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Mon, Mar 15, 2004 at 03:38:51PM +1100, Nick Piggin wrote:
> 
> 
> Andrea Arcangeli wrote:
> 
> >
> >I don't see other ways to optimize it (and I never enjoyed too much the
> >per-zone lru since it has some downside too with a worst case on 2G
> >systems). peraphs a further optimization could be a transient per-cpu
> >lru refiled only by the page reclaim (so absolutely lazy while lots of
> >ram is free), but maybe that's already what you're doing when you say
> >"Adding/removing sixteen pages for one taking of the lock". Though the
> >fact you say "sixteen pages" sounds like it's not as lazy as it could
> >be.
> >
> 
> Hi Andrea,
> What are the downsides on a 2G system?

it is the absolutely worst case since both lru could be of around the same
size (800M zone-normal-lru and 1.2G zone-highmem-lru), maximizing the
loss of "age" information needed for optimal reclaim decisions.
