Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWAPCjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWAPCjF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 21:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWAPCjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 21:39:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48288 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932175AbWAPCjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 21:39:04 -0500
Date: Sun, 15 Jan 2006 18:38:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [patch 04/10] slab: cache_estimate cleanup
Message-Id: <20060115183822.38b1e807.akpm@osdl.org>
In-Reply-To: <20060114122415.163755000@localhost>
References: <20060114122249.246354000@localhost>
	<20060114122415.163755000@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pekka Enberg" <penberg@cs.helsinki.fi> wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> This patch cleans up cache_estimate() in mm/slab.c and improves the
> algorithm from O(n) to O(1). We first calculate the maximum number of
> objects a slab can hold after struct slab and kmem_bufctl_t for each
> object has been given enough space. After that, to respect alignment
> rules, we decrease the number of objects if necessary. As required
> padding is at most align-1 and memory of obj_size is at least align,
> it is always enough to decrease number of objects by one.
> 
> The optimization was originally made by Balbir Singh with more 
> improvements from Steven Rostedt. Manfred Spraul provider further
> modifications: no loop at all for the off-slab case and added comments
> to explain the background.
> 
> ...
> -	size_t wastage = PAGE_SIZE << gfporder;
> -	size_t extra = 0;
> -	size_t base = 0;
> ...
> +	size_t mgmt_size;
> +	size_t slab_size = PAGE_SIZE << gfporder;

Can anyone think of a reason for using size_t in there instead of plain old
unsigned int?
