Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbUK0G6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUK0G6l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbUKZTIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:08:14 -0500
Received: from zeus.kernel.org ([204.152.189.113]:32190 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261286AbUKZTGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:06:48 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,  and xfs
References: <33rTj-1VZ-13@gated-at.bofh.it> <33wJq-633-25@gated-at.bofh.it>
	<34fwL-P1-21@gated-at.bofh.it> <34fGp-V2-9@gated-at.bofh.it>
	<34fGp-V2-7@gated-at.bofh.it> <34lVr-5WH-1@gated-at.bofh.it>
	<34m5a-61Z-9@gated-at.bofh.it>
From: Andi Kleen <ak@suse.de>
Date: 25 Nov 2004 12:07:32 +0100
In-Reply-To: <34m5a-61Z-9@gated-at.bofh.it>
Message-ID: <p73vfbuuqyz.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> > I can't say I love the idea of adding a bio list structure to the
> > tasklist, it feels pretty hacky. generic_make_request() doesn't really
> > use that much stack, if you just kill the BDEVNAME_SIZE struct.
> 
> Looks like a sensible thing to do, although it would be tidier to move the
> whole thing into a separate function, no?
> 
> 
> --- 25/drivers/block/ll_rw_blk.c~generic_make_request-stack-savings	2004-11-24 23:03:06.347778648 -0800
> +++ 25-akpm/drivers/block/ll_rw_blk.c	2004-11-24 23:07:39.798207864 -0800
> @@ -2584,6 +2584,20 @@ static inline void block_wait_queue_runn
>  	}
>  }
>  
> +static void handle_bad_sector(struct bio *bio)

You need to mark it noinline, otherwise a unit-at-a-time gcc (3.4+) 
will happily inline it anyways.

-Andi
