Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265743AbUHCWdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265743AbUHCWdj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUHCWdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:33:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:64166 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265743AbUHCWdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:33:37 -0400
Date: Tue, 3 Aug 2004 15:33:35 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803153335.R1924@build.pdx.osdl.net>
References: <20040729185215.Q1973@build.pdx.osdl.net> <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com> <20040803210737.GI2241@dualathlon.random> <20040803211339.GB26620@devserv.devel.redhat.com> <20040803213634.GK2241@dualathlon.random> <20040803213856.GB10978@devserv.devel.redhat.com> <20040803215150.GM2241@dualathlon.random> <20040803150118.Q1924@build.pdx.osdl.net> <20040803221121.GN2241@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040803221121.GN2241@dualathlon.random>; from andrea@suse.de on Wed, Aug 04, 2004 at 12:11:21AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> On Tue, Aug 03, 2004 at 03:01:18PM -0700, Chris Wright wrote:
> > I'm not sure what you mean.  Truncate should only update the accounting,
> > not break the binding, right?
> 
> yep, update the accounting. And with that I meant "releasing" part of
> it (accordingly to the size of the truncate, a truncate(0) should
> release it all).

OK, good.  I thought you meant drop binding to user, rather then reduce
the accounting.

> > It's meant to be done at object destruction.
> 
> where?

I just mean in general the only time it's valid to drop the binding
(which includes dropping refcount on the user struct) should be when
the object is destroyed.

> Maybe it's just that those are incremental patches and I'm missing the
> other part of the patch, but reading those patches I can't see where the
> user_subtract_mlock happens when I truncate an hugetlbfs file (or delete
> it or whatever). Sure it can't be munlock releasing/_updating_ the user-struct
> accounting for fs persistent storage. But if other code takes care of it
> then maybe you want to delete the user_subtract_mlock function and use
> the other piece that already existed for truncate.

Heh, yeah in a place like hugetlb_put_quota?

> Anyways my overall picture of this is that you're trying to do
> filesystem quotas with rlimit which sounds quite flawed.

It's so tempting because of the similarity (and hence ease of
administration) with mlocked pages.  And if they can be merged,
user_struct being a fine placeholder, then it's perhaps simpler.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
