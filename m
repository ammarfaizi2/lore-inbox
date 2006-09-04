Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWIDMk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWIDMk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWIDMk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:40:26 -0400
Received: from brick.kernel.dk ([62.242.22.158]:24878 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S964802AbWIDMkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:40:25 -0400
Date: Mon, 4 Sep 2006 14:43:35 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Milan Broz <mbroz@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix creating zero sized bio mempools in low memory system
Message-ID: <20060904124335.GM25434@kernel.dk>
References: <44FC1C90.200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FC1C90.200@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04 2006, Milan Broz wrote:
> In the very low memory systems is in the init_bio call
> scale parameter set to zero and it leads to creating
> zero sized mempool.
> 
> This patch prevents pool_entries parameter become zero,
> so the created pool have at least 1 entry.
> 
> Mempool with 0 entries lead to incorrect behaviour 
> of mempool_free. (Alloc requests are not waken up
> and system stalls in mempool_alloc->ioschedule). 

Good catch, queued. Maybe this is the only such scaling problem,
otherwise it may be a good idea to add a WARN_ON(!min_nr) to the mempool
setup in mm/mempool.c to catch such errors.

-- 
Jens Axboe

