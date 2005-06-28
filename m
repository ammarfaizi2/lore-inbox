Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVF1Jmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVF1Jmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVF1Jmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:42:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7643 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262030AbVF1Jmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:42:38 -0400
Date: Tue, 28 Jun 2005 11:43:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: cfq build breakage
Message-ID: <20050628094341.GG4410@suse.de>
References: <42C0B39E.7070509@pobox.com> <20050627201333.4c7d3d06.akpm@osdl.org> <20050628062108.GA3411@suse.de> <20050627233055.20029d85.akpm@osdl.org> <20050628072520.GA3668@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628072520.GA3668@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28 2005, Jens Axboe wrote:
> > > > @@ -1969,7 +1968,7 @@ __cfq_may_queue(struct cfq_data *cfqd, s
> > > >  		 * only allow 1 ELV_MQUEUE_MUST per slice, otherwise we
> > > >  		 * can quickly flood the queue with writes from a single task
> > > >  		 */
> > > > -		if (rw == READ || !cfq_cfqq_must_alloc_slice) {
> > > > +		if (rw == READ || !cfq_cfqq_must_alloc_slice(cfqq)) {
> > > >  			cfq_mark_cfqq_must_alloc_slice(cfqq);
> > > >  			return ELV_MQUEUE_MUST;
> > > >  		}
> > > 
> > > thanks, clearly a typo but inside if 0.
> > 
> > But the other instance was inside `#if 1'.  This fixup will change behaviour.
> 
> Hrmpf strange, I submitted what I built. Must be some silly slip up
> here.

Ok double checked, and the above actually builds with gcc 3.3.5 without
any warnings. I've verified the change here, it is sound and acts as it
should.

-- 
Jens Axboe

