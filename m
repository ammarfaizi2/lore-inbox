Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWAGDZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWAGDZd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 22:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWAGDZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 22:25:33 -0500
Received: from cantor2.suse.de ([195.135.220.15]:53160 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030323AbWAGDZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 22:25:32 -0500
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] use local_t for page statistics
Date: Sat, 7 Jan 2006 04:25:24 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20060106215332.GH8979@kvack.org> <200601070401.47618.ak@suse.de> <43BF3355.5060606@yahoo.com.au>
In-Reply-To: <43BF3355.5060606@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601070425.24810.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2006 04:19, Nick Piggin wrote:
> Andi Kleen wrote:
> > On Saturday 07 January 2006 03:52, Nick Piggin wrote:
> > 
> > 
> >>No. On many load/store architectures there is no good way to do local_t,
> >>so something like ppc32 or ia64 just uses all atomic operations for
> > 
> > 
> > well, they're just broken and need to be fixed to not do that.
> > 
> 
> How?

If anything use the 3x duplicated data setup, not atomic operations.

> 
> > Also I bet with some tricks a seqlock like setup could be made to work.
> > 
> 
> I asked you how before. If you can come up with a way then it indeed
> might be a good solution... 

I'll try to work something up.

> The problem I see with seqlock is that it 
> is only fast in the read path. That path is not the issue here.

The common case - not getting interrupted would be fast.

> > 
> >>local_t, and ppc64 uses 3 counters per-cpu thus tripling the cache
> >>footprint.
> > 
> > 
> > and ppc64 has big caches so this also shouldn't be a problem.
> > 
> 
> Well it is even less of a problem for them now, by about 1/3.
> 
> Performance-wise there is really no benefit for even i386 or x86-64
> to move to local_t now either so I don't see what the fuss is about.

Actually P4 doesn't like CLI/STI. For AMD and P-M it's not that much an issue,
but NetBurst really doesn't like it.

-Andi

