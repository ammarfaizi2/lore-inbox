Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287625AbRLaTsJ>; Mon, 31 Dec 2001 14:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287623AbRLaTr7>; Mon, 31 Dec 2001 14:47:59 -0500
Received: from ns.suse.de ([213.95.15.193]:38149 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287624AbRLaTro>;
	Mon, 31 Dec 2001 14:47:44 -0500
Date: Mon, 31 Dec 2001 20:47:43 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Prefetching file_read_actor()
In-Reply-To: <3C30BC5F.227349E8@zip.com.au>
Message-ID: <Pine.LNX.4.33.0112312045130.17274-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001, Andrew Morton wrote:

> Looks like you'll need to do a __get_user() against the page to
> populate the tlb.  We're going to need it in the copy_to_user()
> anyway, so the cost is negligible.

Completly puzzled right now. Moving the prefetching to copy_to_user
(and doing the tlb preload & prefetching the whole chunk to be copied
(or cachesize if smaller)) results in a performance drop instead of a win.

My initial guess is that some of the callers of copy_to_user are
doing something that is harmed the prefetching.
(Maybe they are doing additional prefetch() calls)

Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

