Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVLBVYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVLBVYm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVLBVYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:24:42 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:1690 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750772AbVLBVYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:24:41 -0500
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for
	benchmarks
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dirk Henning Gerdes <mail@dirk-gerdes.de>, axboe@suse.de,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051201172520.7095e524.akpm@osdl.org>
References: <1133443051.6110.32.camel@noti>
	 <20051201172520.7095e524.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 13:24:52 -0800
Message-Id: <1133558692.21429.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 17:25 -0800, Andrew Morton wrote:
> Dirk Henning Gerdes <mail@dirk-gerdes.de> wrote:
> >
> >  For doing benchmarks on the I/O-Schedulers, I thought it would be very
> >  useful to disable the pagecache.
> 
> That's an FAQ.   Something like this?
> 
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the kernel
> to discard as much pagecache and reclaimable slab objects as it can.
> 
> It won't drop dirty data, so the user should run `sync' first.
> 
> Caveats:
> 
> a) Holds inode_lock for exorbitant amounts of time.
> 
> b) Needs to be taught about NUMA nodes: propagate these all the way through
>    so the discarding can be controlled on a per-node basis.
> 
> c) The pagecache shrinking and slab shrinking should probably have separate
>    controls.
> 
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Wondering, if this shrinks shared memory pages (since they are backed by
tmpfs) ? (which is not what I want).

Thanks,
Badari

