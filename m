Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTFJP13 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTFJPYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:24:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62169 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263234AbTFJPXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:23:51 -0400
Date: Tue, 10 Jun 2003 17:37:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop 2/9 absorb bio_copy
Message-ID: <20030610153730.GC17164@suse.de>
References: <Pine.LNX.4.44.0306101606080.2285-100000@localhost.localdomain> <Pine.LNX.4.44.0306101630210.2285-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306101630210.2285-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10 2003, Hugh Dickins wrote:
> bio_copy is used only by the loop driver, which already has to walk the
> bio segments itself: so it makes sense to change it from bio.c export
> to loop.c static, as prelude to working upon it there.
> 
> bio_copy itself is unchanged by this patch, with one exception.  On oom
> failure it must use bio_put, instead of mempool_free to static bio_pool:
> which it should have been doing all along - it was leaking the veclist.

I don't think this is is a particularly good idea, it's pretty core bio
functionality that should be left alone in bio.c imho.

Is there a real reason you want to do this apart from 'loop is the only
(current) user'?

-- 
Jens Axboe

