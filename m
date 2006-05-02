Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWEBF2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWEBF2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWEBF2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:28:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54359 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932374AbWEBF2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:28:06 -0400
Date: Tue, 2 May 2006 07:28:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: splice(SPLICE_F_MOVE) problems
Message-ID: <20060502052850.GP3814@suse.de>
References: <20060501065953.GA289@oleg> <20060501065412.GP23137@suse.de> <20060501190625.GA174@oleg> <20060501174153.GH3814@suse.de> <20060502001118.GA88@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502001118.GA88@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02 2006, Oleg Nesterov wrote:
> On 05/01, Jens Axboe wrote:
> >
> > > If readahead doesn't work, SPLICE_F_MOVE is problematic too.
> > > add_to_page_cache_lru()->lru_cache_add() first increments
> > > page->count and adds this page to lru_add_pvecs. This means
> > > page_cache_pipe_buf_steal()->remove_mapping() will probably
> > > fail.
> > 
> > Because of the temporarily elevated page count?
> 
> Yes.
> 
> On the other hand, if readahead doesn't work we already have a
> bigger problem, and SPLICE_F_MOVE is not garanteed, so I think
> this is very minor.

Yes, clearly readahead has to work as expected. I haven't noticed any
problems, even on half cached workloads. With your handle_ra_miss()
addition and possibly killing the redundant !offset || nr_pages check,
it should be fine.

-- 
Jens Axboe

