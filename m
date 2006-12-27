Return-Path: <linux-kernel-owner+w=401wt.eu-S1753621AbWL0Ijj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbWL0Ijj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 03:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbWL0Ijj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 03:39:39 -0500
Received: from [85.204.20.254] ([85.204.20.254]:42089 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753608AbWL0Iji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 03:39:38 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, tbm@cyrius.com, a.p.zijlstra@chello.nl,
       akpm@osdl.org, hugh@veritas.com, nickpiggin@yahoo.com.au,
       arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612262254090.4473@woody.osdl.org>
References: <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
	 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
	 <20061226161700.GA14128@yamamaya.is-a-geek.org>
	 <20061226.205518.63739038.davem@davemloft.net>
	 <Pine.LNX.4.64.0612262254090.4473@woody.osdl.org>
Content-Type: text/plain
Organization: I-NEO
Date: Wed, 27 Dec 2006 10:39:31 +0200
Message-Id: <1167208771.7006.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have corrupted files...

> ---
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 263f88e..4652ef1 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1653,19 +1653,7 @@ static int __block_write_full_page(struct inode *inode, struct page *page,
>  	do {
>  		if (!buffer_mapped(bh))
>  			continue;
> -		/*
> -		 * If it's a fully non-blocking write attempt and we cannot
> -		 * lock the buffer then redirty the page.  Note that this can
> -		 * potentially cause a busy-wait loop from pdflush and kswapd
> -		 * activity, but those code paths have their own higher-level
> -		 * throttling.
> -		 */
> -		if (wbc->sync_mode != WB_SYNC_NONE || !wbc->nonblocking) {
> -			lock_buffer(bh);
> -		} else if (test_set_buffer_locked(bh)) {
> -			redirty_page_for_writepage(wbc, page);
> -			continue;
> -		}
> +		lock_buffer(bh);
>  		if (test_clear_buffer_dirty(bh)) {
>  			mark_buffer_async_write(bh);
>  		} else {

