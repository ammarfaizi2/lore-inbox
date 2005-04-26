Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVDZUOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVDZUOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVDZUOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:14:44 -0400
Received: from vanguard.topspin.com ([12.162.17.52]:42891 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261773AbVDZUOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:14:32 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: libor@topspin.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, timur.tabi@ammasso.com
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com> <20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com> <20050425171145.2f0fd7f8.akpm@osdl.org>
	<52acnmtmh6.fsf@topspin.com> <20050425173757.1dbab90b.akpm@osdl.org>
	<52wtqpsgff.fsf@topspin.com> <20050426084234.A10366@topspin.com>
	<52mzrlsflu.fsf@topspin.com> <20050426122850.44d06fa6.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 26 Apr 2005 13:14:31 -0700
In-Reply-To: <20050426122850.44d06fa6.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 26 Apr 2005 12:28:50 -0700")
Message-ID: <5264y9s3bs.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Apr 2005 20:14:32.0073 (UTC) FILETIME=[8EC7A790:01C54A9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland>     a) app registers 0x0000 through 0x17ff
    Roland>     b) app registers 0x1800 through 0x2fff
    Roland>     c) app unregisters 0x0000 through 0x17ff
    Roland>     d) the page at 0x1000 must stay pinned

    Andrew> The userspace library should be able to track the tree and
    Andrew> the overlaps, etc.  Things might become interesting when
    Andrew> the memory is MAP_SHARED pagecache and multiple
    Andrew> independent processes are involved, although I guess
    Andrew> that'd work OK.

I used to think I knew how to handle this, but in your scheme where
the kernel is doing accounting for pinned memory by marking vmas with
VM_KERNEL_LOCKED, at step c), I don't see why the kernel won't unlock
vmas covering 0x0000 through 0x1fff and credit 8K back to the
process's pinning count.

Sorry to be so dense but can you spell out what you think should
happen at steps a), b) and c) above?

    Andrew> But afaict the problem wherein part of a page needs
    Andrew> VM_DONTCOPY and the other part does not cannot be solved.

Yes, I agree.  If an app wants to register half a page and pass the
other half to a child process, I think the only answer is "don't do
that then."

 - R.
