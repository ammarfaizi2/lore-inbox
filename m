Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264687AbSJOQSa>; Tue, 15 Oct 2002 12:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbSJOQS3>; Tue, 15 Oct 2002 12:18:29 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:1276 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264687AbSJOQS2>; Tue, 15 Oct 2002 12:18:28 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 15 Oct 2002 10:21:19 -0600
To: Christoph Hellwig <hch@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015162119.GF15552@clusterfs.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <20021015125816.A22877@infradead.org> <20021015131507.GC31235@think.thunk.org> <20021015163121.B27906@infradead.org> <20021015160417.GE15552@clusterfs.com> <20021015171606.A29069@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015171606.A29069@infradead.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 15, 2002  17:16 +0100, Christoph Hellwig wrote:
> On Tue, Oct 15, 2002 at 10:04:17AM -0600, Andreas Dilger wrote:
> > > -	mb_cache_lock();
> > > +	spin_lock(&mb_cache_spinlock);
> > >  	l = mb_cache_lru_list.prev;
> > >  	while (l != &mb_cache_lru_list) {
> > >  		struct mb_cache_entry *ce =
> > >  			list_entry(l, struct mb_cache_entry, e_lru_list);
> > 
> > Couldn't these all be "list_for_each{_safe}"?
> 
> They'd have to be list_for_each_safe_prev, which is not currently
> in list.h.  The EVMS folks have a patch to add it, though..

Is there a reason why the code can't just add items into the list in
the reverse order (i.e. list_add_tail()) and then walk in the normal
direction via list_for_each_safe()?

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

