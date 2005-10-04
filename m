Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVJDG7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVJDG7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 02:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVJDG7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 02:59:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13903 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932428AbVJDG7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 02:59:14 -0400
Date: Tue, 4 Oct 2005 08:59:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Paul Mundt <paul.mundt@nokia.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] mempool_alloc() pre-allocated object usage
Message-ID: <20051004065945.GG3511@suse.de>
References: <20051003143634.GA1702@nokia.com> <1128350953.17024.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128350953.17024.17.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03 2005, Arjan van de Ven wrote:
> On Mon, 2005-10-03 at 17:36 +0300, Paul Mundt wrote:
> 
> > Both usage patterns seem valid from my point of view, would you be open
> > to something that would accomodate both? (ie, possibly adding in a flag
> > to determine pre-allocated object usage?) Or should I not be using
> > mempool for contiguity purposes?
> 
> a similar dillema was in the highmem bounce code in 2.4; what worked
> really well back then was to do it both; eg use half the pool for
> "immediate" use, then try a VM alloc, and use the second half of the
> pool for the really emergency cases.
> 
> Technically a mempool is there ONLY for the fallback, but I can see some
> value in making it also a fastpath by means of a small scratch pool

The reason it works the way it does is because of performance, you don't
want to touch the pool lock until you have to. If the page allocations
that happen before falling into the mempool, I would suggest looking at
that specific issue first. I think Nick recently did some changes in
that area, there might be more low hanging fruit.

-- 
Jens Axboe

