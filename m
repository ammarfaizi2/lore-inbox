Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVC2MfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVC2MfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 07:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVC2MdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 07:33:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57484 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262262AbVC2McA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 07:32:00 -0500
Date: Tue, 29 Mar 2005 14:31:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: ecashin@noserose.net, linux-kernel <linux-kernel@vger.kernel.org>,
       Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.11] aoe [5/12]: don't try to free null bufpool
Message-ID: <20050329123149.GQ16636@suse.de>
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com> <1111677437.28285@geode.he.net> <1111679884.6290.93.camel@laptopd505.fenrus.org> <1111683853.31205@geode.he.net> <1111684626.6290.103.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111684626.6290.103.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24 2005, Arjan van de Ven wrote:
> On Thu, 2005-03-24 at 09:04 -0800, ecashin@noserose.net wrote:
> > Arjan van de Ven <arjan@infradead.org> writes:
> > 
> > > On Thu, 2005-03-24 at 07:17 -0800, ecashin@noserose.net wrote:
> > >> don't try to free null bufpool
> > >
> > > in linux there is a "rule" that all memory free routines are supposed to
> > > also accept NULL as argument, so I think this patch is not needed (and
> > > even wrong)
> > >
> > 
> > Hmm.  The mm/mempool.c:mempool_destroy function immediately
> > dereferences the pointer passed to it:
> > 
> > void mempool_destroy(mempool_t *pool)
> > {
> > 	if (pool->curr_nr != pool->min_nr)
> > 		BUG();		/* There were outstanding elements */
> > 	free_pool(pool);
> > }
> > 
> > ... so I'm not sure mempool_destroy fits the rule.  Are you suggesting
> > that the patch should instead modify mempool_destroy?
> 
> hmm perhaps... Jens?

Not really my call, but I agree we should make mempool_destroy()
resilient against !pool to follow the path of least surprise.

-- 
Jens Axboe

