Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWC0QYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWC0QYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWC0QYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:24:47 -0500
Received: from mail.parknet.jp ([210.171.160.80]:33540 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750988AbWC0QYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:24:46 -0500
X-AuthUser: hirofumi@parknet.jp
To: Jens Axboe <axboe@suse.de>
Cc: Brandon Low <lostlogic@lostlogicx.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1
References: <20060324021729.GL27559@lostlogicx.com>
	<20060323182411.7f80b4a6.akpm@osdl.org>
	<20060324024540.GM27559@lostlogicx.com>
	<20060323185810.3bf2a4ce.akpm@osdl.org>
	<20060324032126.GN27559@lostlogicx.com>
	<20060324033934.161302c1.akpm@osdl.org>
	<20060324125817.GB3381@lostlogicx.com>
	<20060324103301.4e6c5a4b.akpm@osdl.org>
	<20060324183734.GC4173@suse.de> <20060324191506.GC3381@lostlogicx.com>
	<20060327105811.GG8186@suse.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 28 Mar 2006 01:24:35 +0900
In-Reply-To: <20060327105811.GG8186@suse.de> (Jens Axboe's message of "Mon, 27 Mar 2006 12:58:11 +0200")
Message-ID: <8764lzony4.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Fri, Mar 24 2006, Brandon Low wrote:
>
> Hmm, no luck reproducing this so far, strange. I'm using
> 2.6.16-block.git cfq branch exclusively, which is the patch you backed
> out. I guess I'll try 2.6.16-mm1 on the same box next.
>
> Can you try 2.6.16-mm1 with this patch applied on top?
>
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> index 81edf51..89fcc2c 100644
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -1516,6 +1516,7 @@ cfq_cic_rb_add(struct cfq_data *cfqd, st
>  
>  	rb_link_node(&cic->rb_node, parent, p);
>  	rb_insert_color(&cic->rb_node, &ioc->cic_root);
> +	list_add(&cic->queue_list, &cfqd->cic_list);
>  	read_unlock(&cfq_exit_lock);
>  }

I've got a same oops in 2.6.16-mm1, and this patch seems to fix it at
least in my case.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
