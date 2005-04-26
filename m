Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVDZT3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVDZT3u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 15:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVDZT3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 15:29:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:27294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261752AbVDZT30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 15:29:26 -0400
Date: Tue, 26 Apr 2005 12:28:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: libor@topspin.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, timur.tabi@ammasso.com
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbs implementation
Message-Id: <20050426122850.44d06fa6.akpm@osdl.org>
In-Reply-To: <52mzrlsflu.fsf@topspin.com>
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
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
>     Libor>   Do you mean that the set/clear parameters to do_mlock()
>     Libor> are the actual flags which are set/cleared by the caller? 
>     Libor> Also, the issue remains that the flags are not reference
>     Libor> counted which is a problem if you are dealing with
>     Libor> overlapping memory region, or even if one region ends and
>     Libor> another begins on the same page. Since the desire is to be
>     Libor> able to pin any memory that a user can malloc this is a
>     Libor> likely scenario.
> 
> Good point... we need to figure out how to handle:
> 
>     a) app registers 0x0000 through 0x17ff
>     b) app registers 0x1800 through 0x2fff
>     c) app unregisters 0x0000 through 0x17ff
>     d) the page at 0x1000 must stay pinned

The userspace library should be able to track the tree and the overlaps,
etc.  Things might become interesting when the memory is MAP_SHARED
pagecache and multiple independent processes are involved, although I guess
that'd work OK.

But afaict the problem wherein part of a page needs VM_DONTCOPY and the
other part does not cannot be solved.

