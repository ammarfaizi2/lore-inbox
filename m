Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966303AbWKTR7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966303AbWKTR7H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966307AbWKTR7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:59:07 -0500
Received: from brick.kernel.dk ([62.242.22.158]:57669 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S966303AbWKTR7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:59:04 -0500
Date: Mon, 20 Nov 2006 18:58:49 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061120175848.GD8055@kernel.dk>
References: <20061119214315.GI4427@us.ibm.com> <Pine.LNX.4.44L0.0611201212040.3224-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611201212040.3224-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20 2006, Alan Stern wrote:
> Paul:
> 
> Here's my version of your patch from yesterday.  It's basically the same, 
> but I cleaned up the code in a few places and fixed a bug (the sign of idx 
> in srcu_read_unlock).  Also I changed the init routine back to void, since 
> it's no longer an error if the per-cpu allocation fails.
> 
> More importantly, I added a static initializer and included the fast-path 
> in synchronize_srcu.  It's protected by the new symbol 
> SMP__STORE_MB_LOAD_WORKS, which should be defined in arch-specific headers 
> for those architectures where the store-mb-load pattern is safe.

Must we introduce memory allocations in srcu_read_lock()? It makes it
much harder and nastier for me to use. I'd much prefer a failing
init_srcu(), seems like a much better API.

-- 
Jens Axboe

