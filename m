Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267911AbRHFK4m>; Mon, 6 Aug 2001 06:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267892AbRHFK4c>; Mon, 6 Aug 2001 06:56:32 -0400
Received: from ns.suse.de ([213.95.15.193]:16147 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267911AbRHFK4R>;
	Mon, 6 Aug 2001 06:56:17 -0400
Date: Mon, 6 Aug 2001 12:57:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010806125705.I15925@athlon.random>
In-Reply-To: <997080081.3938.28.camel@typhaon> <20010806105904.A28792@athlon.random> <15214.24938.681121.837470@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15214.24938.681121.837470@pizda.ninka.net>; from davem@redhat.com on Mon, Aug 06, 2001 at 02:20:42AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 02:20:42AM -0700, David S. Miller wrote:
> 
> Andrea Arcangeli writes:
>  > Can somebody see a problem with this design?
> 
> As someone who was involved when the merge_segments stuff got tossed
> by Linus, the reason was that the locking is utterly atrocious.
> 
> After trying to get the SMP locking correct _four_ times, Linus
> basically said to me "This merging so stupidly complex, and we don't
> need it at all.  We only need merging for very simple cases."
> 
> I think he's right.  The old code was trying to do everything and
> made the locking more difficult than it needed to be.

The point here is not if it's simple or difficult. The point is what can
be done or not and what is faster or slower. All I'm saying is that I
don't see why it's not possible to implement the merge_segments with
only an O(1) additional cost of a few cycles per mmap syscall, which
will render the feature an obvious improvement (instead of being a
dubious improvement like in 2.2 that is walking the tree two times).

If it was simple to implement it you would just find the patch attached
to this email 8).

Andrea
