Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264667AbSJOQKR>; Tue, 15 Oct 2002 12:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264668AbSJOQKR>; Tue, 15 Oct 2002 12:10:17 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:3334 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264667AbSJOQKQ>; Tue, 15 Oct 2002 12:10:16 -0400
Date: Tue, 15 Oct 2002 17:16:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015171606.A29069@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <20021015125816.A22877@infradead.org> <20021015131507.GC31235@think.thunk.org> <20021015163121.B27906@infradead.org> <20021015160417.GE15552@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021015160417.GE15552@clusterfs.com>; from adilger@clusterfs.com on Tue, Oct 15, 2002 at 10:04:17AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 10:04:17AM -0600, Andreas Dilger wrote:
> > -	mb_cache_lock();
> > +	spin_lock(&mb_cache_spinlock);
> >  	l = mb_cache_lru_list.prev;
> >  	while (l != &mb_cache_lru_list) {
> >  		struct mb_cache_entry *ce =
> >  			list_entry(l, struct mb_cache_entry, e_lru_list);
> 
> Couldn't these all be "list_for_each{_safe}"?

They'd have to be list_for_each_safe_prev, which is not currently
in list.h.  The EVMS folks have a patch to add it, though..

