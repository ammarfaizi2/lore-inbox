Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVDZOdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVDZOdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVDZOdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:33:06 -0400
Received: from mail.shareable.org ([81.29.64.88]:8617 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261550AbVDZOdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:33:00 -0400
Date: Tue, 26 Apr 2005 15:32:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
Cc: Ville Herva <v@iki.fi>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050426143247.GF10833@mail.shareable.org>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426E4EBD.6070104@oktetlabs.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artem B. Bityuckiy wrote:
> Jamie Lokier wrote:
> >I think I've wanted something like that for _years_ in unix.
> >
> >It's an old, old idea, and I've often wondered why we haven't implemented 
> >it.
> >
> 
> I thought it is possible to rather easily to implement this on top
> of non-transactional FS (albeit I didn't try) and there is no need
> to overcomplicate an FS. Just implement a specialized user-space
> library and utilize it.

No.  A transaction means that _all_ processes will see the whole
transaction or not.

It does _not_ mean that only a subset of programs, which happen to
link with a particular user-space library, will see it or not.

For example, you can use transactions for distro package management: a
whole update of a package would be a single transaction, so that at no
time does any program see an inconsistent set of files.  See why
_every_ process in the system must have the same view?

[ If you meant that you can implement it with a user-space library
that every process in the system links to, that's true.  But it would
rather misses the point of having filesystems in the kernel at all :) ]

-- Jamie
