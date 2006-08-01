Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWHATd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWHATd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbWHATd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:33:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:44232 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751846AbWHATd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:33:56 -0400
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
References: <20060801030443.GA2221@gondor.apana.org.au>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 21:33:54 +0200
In-Reply-To: <20060801030443.GA2221@gondor.apana.org.au>
Message-ID: <p73psfkz1wd.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:
> --
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 71649ef..b998f08 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2790,6 +2790,7 @@ int submit_bh(int rw, struct buffer_head
>  	BUG_ON(!buffer_locked(bh));
>  	BUG_ON(!buffer_mapped(bh));
>  	BUG_ON(!bh->b_end_io);
> +	WARN_ON(bh_offset(bh) + bh->b_size > PAGE_SIZE);

What happens when someone implements direct large page IO?

-Andi
