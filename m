Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVBXFdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVBXFdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 00:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVBXFdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 00:33:23 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:20142 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261819AbVBXFdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 00:33:03 -0500
Date: Thu, 24 Feb 2005 05:12:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
In-Reply-To: <421D1737.1050501@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0502240457350.5427@goblin.wat.veritas.com>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au> 
    <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston> 
    <20050217230342.GA3115@wotan.suse.de> 
    <20050217153031.011f873f.davem@davemloft.net> 
    <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au> 
    <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com> 
    <421B0163.3050802@yahoo.com.au> 
    <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com> 
    <421D1737.1050501@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005, Nick Piggin wrote:
> Hugh Dickins wrote:
> 
> > I'm inlining pmd and pud levels, but not pte and pgd levels.
> 
> OK - that's probably sufficient for debugging. There is only so
> much that can go wrong in the middle levels... 

Yes, that was my thinking.

> how does it look
> performance wise? (I can give it a test when it gets split out)

Yesterday shattered in various directions, I hope to try today.

> > One point worth making, I do believe throughout that whatever the
> > address layout, "end" cannot be 0 - BUG_ON(addr >= end) assures.

Of course, that does allow some simplifications in your for_each
macros; but it still looked like my p??_limits were better for
shortest codepath, and close to yours for codesize.

> OK after sleeping on it, I'm warming to your way.
> 
> I don't think it makes something like David's modifications any
> easier, but mine didn't go a long way to that end either. And
> being a more incremental approach gives us more room to move in
> future (for example, maybe toward something that really *will*
> accommodate the bitmap walking code nicely).

I'll take a quick look at David's today.
Just so long as we don't make them harder.

> So I'd be pretty happy for you to queue this up with Andrew for
> 2.6.12. Anyone else?

Oh, okay, thanks.  You weren't very happy with p??_limit(addr, end),
and good naming is important to me.  I didn't care for your tentative
p??_span or p??_span_end.  Would p??_end be better?  p??_enda would
be fun for one of them...

Hugh
