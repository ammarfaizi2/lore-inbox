Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUBXJa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 04:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbUBXJa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 04:30:58 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:15490 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S262154AbUBXJa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 04:30:57 -0500
Date: Tue, 24 Feb 2004 01:30:56 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
Message-ID: <20040224093056.GA31521@dingdong.cryptoapps.com>
References: <20040222175507.558a5b3d.akpm@osdl.org> <40396ACD.7090109@cyberone.com.au> <40396DA7.70200@cyberone.com.au> <4039B4E6.3050801@cyberone.com.au> <4039BE41.1000804@cyberone.com.au> <20040223005948.10a3b325.akpm@osdl.org> <20040223224723.GA27639@dingdong.cryptoapps.com> <403ACEFC.4070208@cyberone.com.au> <20040224091200.GA31360@dingdong.cryptoapps.com> <20040224012222.453e7db7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224012222.453e7db7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 01:22:22AM -0800, Andrew Morton wrote:

> Sigh.  There is absolutely nothing wrong with having a large slab
> cache.

Unless the slab contains useful data (ie. dentries that will actually
be accessed is some useful amount of time) then arguably those pages
are better used for the page-cache.

> And there is nothing necessarily right about having a small one.

Oh, I'm not claiming one is more right than the other.  The issue for
me is updatedb or even bk clone a few times will cause the slab to
swell with dentries and related contents that never seems to shrink
without forcing swapping.

> Sorry, but your comment is information-free.

I just notice I'm getting debugging output (call traces) for page
allocation failures which I've not seem before.  I was getting these
(swapper: page allocation failure. order:2, mode:0x20) after beating
things to see how bad things will get for Nick.

In this case slab is consuming so much low memory we're getting
allocation failures which was making networking choppy.


  --cw
