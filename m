Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWI2GKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWI2GKg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWI2GKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:10:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932542AbWI2GKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:10:35 -0400
Date: Thu, 28 Sep 2006 23:10:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add flag __GFP_NOFAIL when allocating block
Message-Id: <20060928231033.ff2d022b.akpm@osdl.org>
In-Reply-To: <1159494812.20092.727.camel@ymzhang-perf.sh.intel.com>
References: <1159494812.20092.727.camel@ymzhang-perf.sh.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 09:53:33 +0800
"Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:

> Function journal_write_metadata_buffer doesn't estimate the return
> value of jbd_slab_alloc. If the allocation fails, later jbd_slab_free
> or memcpy will cause kernel oops.
> 
> Add flag __GFP_NOFAIL when allocating block. The patch is against
> 2.6.18-mm1.
> 
> Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>
> 
> ---
> 
> --- linux-2.6.18_mm1/fs/jbd/journal.c	2006-09-29 07:19:49.000000000 -0600
> +++ linux-2.6.18_mm1_fix/fs/jbd/journal.c	2006-09-30 03:01:38.000000000 -0600
> @@ -329,7 +329,7 @@ repeat:
>  		char *tmp;
>  
>  		jbd_unlock_bh_state(bh_in);
> -		tmp = jbd_slab_alloc(bh_in->b_size, GFP_NOFS);
> +		tmp = jbd_slab_alloc(bh_in->b_size, GFP_NOFS|__GFP_NOFAIL);

jbd_slab_alloc() does that internally.
