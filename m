Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbTEAOQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbTEAOQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:16:33 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:30736 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261269AbTEAOQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:16:33 -0400
Date: Thu, 1 May 2003 16:26:43 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Cc: Willy TARREAU <willy@w.ods.org>, hugang <hugang@soulinfo.com>,
       akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030501142643.GA1483@pcw.home.local>
References: <200304300446.24330.dphillips@sistina.com> <20030430135512.6519eb53.akpm@digeo.com> <20030501130318.459a4776.hugang@soulinfo.com> <20030430221129.11595e2e.akpm@digeo.com> <20030501133307.158c7e10.hugang@soulinfo.com> <20030501150557.6dc913f7.hugang@soulinfo.com> <20030501135204.GC308@pcw.home.local> <87fzny3gau.fsf@student.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fzny3gau.fsf@student.uni-tuebingen.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 04:14:17PM +0200, Falk Hueffner wrote:
> Willy TARREAU <willy@w.ods.org> writes:
> 
> > On Thu, May 01, 2003 at 03:05:57PM +0800, hugang wrote:
> > Ok, I recoded the tree myself with if/else, and it's now faster than
> > all others, whatever the compiler.
> 
> Have you tried with not simply increasing, but random numbers? I guess
> this could make quite a difference here because of branch prediction.

I thought about this, and indeed, that's what I used in the program I used
to bench the first function I sent yesterday. The problem of the random, is
that it's so slow that you must build a giant table and apply your tests to
this table. So the problem mainly displaces to data cache misses which cost
more than certain operations. If you try it, you'll note that it's difficult
to get comparable results twice.

Other solutions include non-linear suites such as mixing some sequential
values with BSWAP. Eg: x ^ bswap(x) ^ bswap(x << 4).

Willy

