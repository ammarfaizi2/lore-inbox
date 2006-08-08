Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWHHRaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWHHRaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWHHRaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:30:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:11182 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965008AbWHHRaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:30:18 -0400
Subject: Re: + fs-cache-make-kafs-use-fs-cache.patch added to -mm tree
From: Dave Hansen <haveblue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, trond.myklebust@fys.uio.no,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200608050009.k7509mMx019642@shell0.pdx.osdl.net>
References: <200608050009.k7509mMx019642@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 10:30:06 -0700
Message-Id: <1155058206.19249.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 17:09 -0700, akpm@osdl.org wrote:
> The attached patch makes the kAFS filesystem in fs/afs/ use FS-Cache, and
> through it any attached caches.  The kAFS filesystem will use caching
> automatically if it's available.

I get the following warning when compiling AFS, but leaving FSCACHE
compiled out in 2.6.18-rc3-mm2:

fs/afs/vnode.c:522: warning: 'afs_vnode_cache_now_uncached' defined but not used

The attached patch fixes it.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

 lxc-dave/fs/afs/vnode.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/afs/vnode.c~fcache-exports fs/afs/vnode.c
--- lxc/fs/afs/vnode.c~fcache-exports	2006-08-08 10:21:53.000000000 -0700
+++ lxc-dave/fs/afs/vnode.c	2006-08-08 10:22:53.000000000 -0700
@@ -508,7 +508,6 @@ static void afs_vnode_cache_mark_pages_c
 	}
 
 } /* end afs_vnode_cache_mark_pages_cached() */
-#endif
 
 /*****************************************************************************/
 /*
@@ -552,3 +551,4 @@ static void afs_vnode_cache_now_uncached
 	_leave("");
 
 } /* end afs_vnode_cache_now_uncached() */
+#endif
_


-- Dave

