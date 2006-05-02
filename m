Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWEAULU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWEAULU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWEAULU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:11:20 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:5257 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932217AbWEAULT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:11:19 -0400
Date: Tue, 2 May 2006 04:11:18 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: splice(SPLICE_F_MOVE) problems
Message-ID: <20060502001118.GA88@oleg>
References: <20060501065953.GA289@oleg> <20060501065412.GP23137@suse.de> <20060501190625.GA174@oleg> <20060501174153.GH3814@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501174153.GH3814@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01, Jens Axboe wrote:
>
> > If readahead doesn't work, SPLICE_F_MOVE is problematic too.
> > add_to_page_cache_lru()->lru_cache_add() first increments
> > page->count and adds this page to lru_add_pvecs. This means
> > page_cache_pipe_buf_steal()->remove_mapping() will probably
> > fail.
> 
> Because of the temporarily elevated page count?

Yes.

On the other hand, if readahead doesn't work we already have a
bigger problem, and SPLICE_F_MOVE is not garanteed, so I think
this is very minor.

Oleg.

