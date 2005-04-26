Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVDZUi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVDZUi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVDZUgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:36:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261660AbVDZUdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:33:08 -0400
Date: Tue, 26 Apr 2005 13:32:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: libor@topspin.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, timur.tabi@ammasso.com
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbs implementation
Message-Id: <20050426133229.416a5e66.akpm@osdl.org>
In-Reply-To: <5264y9s3bs.fsf@topspin.com>
References: <20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com>
	<20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com>
	<20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com>
	<20050425171145.2f0fd7f8.akpm@osdl.org>
	<52acnmtmh6.fsf@topspin.com>
	<20050425173757.1dbab90b.akpm@osdl.org>
	<52wtqpsgff.fsf@topspin.com>
	<20050426084234.A10366@topspin.com>
	<52mzrlsflu.fsf@topspin.com>
	<20050426122850.44d06fa6.akpm@osdl.org>
	<5264y9s3bs.fsf@topspin.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
>     Roland>     a) app registers 0x0000 through 0x17ff
>     Roland>     b) app registers 0x1800 through 0x2fff
>     Roland>     c) app unregisters 0x0000 through 0x17ff
>     Roland>     d) the page at 0x1000 must stay pinned
> 
>     Andrew> The userspace library should be able to track the tree and
>     Andrew> the overlaps, etc.  Things might become interesting when
>     Andrew> the memory is MAP_SHARED pagecache and multiple
>     Andrew> independent processes are involved, although I guess
>     Andrew> that'd work OK.
> 
> I used to think I knew how to handle this, but in your scheme where
> the kernel is doing accounting for pinned memory by marking vmas with
> VM_KERNEL_LOCKED, at step c), I don't see why the kernel won't unlock
> vmas covering 0x0000 through 0x1fff and credit 8K back to the
> process's pinning count.
> 
> Sorry to be so dense but can you spell out what you think should
> happen at steps a), b) and c) above?

Well I was vaguely proposing that the userspace library keep track of the
byteranges and the underlying page states.  So in the above scenario
userspace would leave the page at 0x1000 registered until all
registrations against that page have been undone.
