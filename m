Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWISUhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWISUhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbWISUhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:37:06 -0400
Received: from 1wt.eu ([62.212.114.60]:3091 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1751073AbWISUhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:37:04 -0400
Date: Tue, 19 Sep 2006 22:20:29 +0200
From: Willy Tarreau <w@1wt.eu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: Linux 2.4.34-pre3
Message-ID: <20060919202029.GA4017@1wt.eu>
References: <20060919173253.GA25470@hera.kernel.org> <45102BEE.9000501@yahoo.com.au> <20060919181738.GA3467@1wt.eu> <45103D1D.20702@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45103D1D.20702@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 04:55:25AM +1000, Nick Piggin wrote:
> Willy Tarreau wrote:
> >Hi Nick,
> >
> >On Wed, Sep 20, 2006 at 03:42:06AM +1000, Nick Piggin wrote:
> >
> >[cut -pre3 advertisement]
> >
> >
> >>I wonder if 2.4 doesn't need the memory ordering fix to prevent pagecache
> >>corruption in reclaim? (http://www.gatago.com/linux/kernel/14682626.html)
> >>
> >>What would need to be done is to test page_count before testing PageDirty,
> >>and putting an smp_rmb between the two.
> >
> >
> >I've read the thread, and Linus proposed to add an smp_wmb() in
> >set_page_dirty() too.
> 
> I think that isn't needed because put_page is a RMW, which is defined
> to order memory. And presumably you wouldn't set the page dirty without
> a reference to the page.

OK, thanks for the explanation.

> >I see that an smp_rmb() is already present
> >in shrink_cache() with the adequate comment.
> 
> So there is! My mistake then, I was confused and looking at
> try_to_swap_out, but I see that doesn't actually free the page. Fine,
> I think 2.4 is OK then.

Perfect !

Thanks,
Willy

