Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbUDBCs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbUDBCs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:48:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:48571 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263202AbUDBCsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:48:24 -0500
Date: Thu, 1 Apr 2004 18:48:22 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401184822.A21045@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040402011804.GL18585@dualathlon.random> <20040401173014.Z22989@build.pdx.osdl.net> <20040402013547.GM18585@dualathlon.random> <20040401180441.B22989@build.pdx.osdl.net> <20040402021323.GP18585@dualathlon.random> <20040401182122.Y21045@build.pdx.osdl.net> <20040402023817.GR18585@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040402023817.GR18585@dualathlon.random>; from andrea@suse.de on Fri, Apr 02, 2004 at 04:38:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> On Thu, Apr 01, 2004 at 06:21:27PM -0800, Chris Wright wrote:
> > Ah, yes I see what you are saying.  This is the same issue with normal
> > pages and SHM_LOCK that I mentioned earlier, I believe.  I don't see the
> > best solution, because once you detach w/out any destroy, there could be
> > nobody to assign the accounting to.  Do you agree?
> 
> yes, rlimit just can't account for shmget(SHM_HUGETLB) and
> shmctl(SHM_LOCK) either, because it can only account the stuff that you
> temporarily have in the address space.
> 
> the exploit is simply to shmget tons of 2M hugepage segments, and to
> shmat/shmdt all of them, then you'll pin N times those 2M largepages,
> and they will not be accounted anywhere allowing anybody to pin as much
> memory as they want.

Yup.  I had an earlier patch against 2.4 that created a max count for
pages lockable by unprivileged users.  So the accounting was done
against a global pool, and mitigated the DoS damage to those trying to
share this pool.  I think it was more of a hack, though.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
