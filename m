Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161182AbWF0QpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbWF0QpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161183AbWF0QpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:45:12 -0400
Received: from pat.uio.no ([129.240.10.4]:60860 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161182AbWF0QpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:45:09 -0400
Subject: Re: [patch] fix static linking of NFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jes Sorensen <jes@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
In-Reply-To: <1151426029.23773.7.camel@lade.trondhjem.org>
References: <yq04py7j699.fsf@jaguar.mkp.net>
	 <1151426029.23773.7.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 12:44:57 -0400
Message-Id: <1151426697.23773.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.701, required 12,
	autolearn=disabled, AWL 1.30, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 12:33 -0400, Trond Myklebust wrote:
> On Tue, 2006-06-27 at 05:29 -0400, Jes Sorensen wrote:
> > Hi,
> > 
> > This patch solved the problem where certain functions in the NFS code
> > goes missing due to the __exit section being discarded for static
> > links.
> > 
> > I saw one other version of this patch from David Brownell, but it had
> > clutter left on the lines where the __exit should simply be removed.
> > 
> > Cheers,
> > Jes
> > 
> > Remove __exit declarations from functions called from __init code to
> > avoid link errors when the __exit section is discarded, eg NFS is
> > linked statically into the kernel.
> > 
> > Signed-off-by: Jes Sorensen <jes@sgi.com>
> Acked-by: Trond Myklebust <Trond.Myklebust@netapp.com>

Oops... I was a bit too quick there. Could you clean up  the forward
declarations in "internal.h" too, please.

Cheers,
  Trond


> Cheers,
>  Trond
> 
> 
> > ---
> >  fs/nfs/direct.c   |    2 +-
> >  fs/nfs/inode.c    |    2 +-
> >  fs/nfs/pagelist.c |    2 +-
> >  fs/nfs/read.c     |    2 +-
> >  fs/nfs/write.c    |    2 +-
> >  5 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > Index: linux-2.6/fs/nfs/direct.c
> > ===================================================================
> > --- linux-2.6.orig/fs/nfs/direct.c
> > +++ linux-2.6/fs/nfs/direct.c
> > @@ -909,7 +909,7 @@ int __init nfs_init_directcache(void)
> >   * nfs_destroy_directcache - destroy the slab cache for nfs_direct_req structures
> >   *
> >   */
> > -void __exit nfs_destroy_directcache(void)
> > +void nfs_destroy_directcache(void)
> >  {
> >  	if (kmem_cache_destroy(nfs_direct_cachep))
> >  		printk(KERN_INFO "nfs_direct_cache: not all structures were freed\n");
> > Index: linux-2.6/fs/nfs/inode.c
> > ===================================================================
> > --- linux-2.6.orig/fs/nfs/inode.c
> > +++ linux-2.6/fs/nfs/inode.c
> > @@ -1132,7 +1132,7 @@ static int __init nfs_init_inodecache(vo
> >  	return 0;
> >  }
> >  
> > -static void __exit nfs_destroy_inodecache(void)
> > +static void nfs_destroy_inodecache(void)
> >  {
> >  	if (kmem_cache_destroy(nfs_inode_cachep))
> >  		printk(KERN_INFO "nfs_inode_cache: not all structures were freed\n");
> > Index: linux-2.6/fs/nfs/pagelist.c
> > ===================================================================
> > --- linux-2.6.orig/fs/nfs/pagelist.c
> > +++ linux-2.6/fs/nfs/pagelist.c
> > @@ -390,7 +390,7 @@ int __init nfs_init_nfspagecache(void)
> >  	return 0;
> >  }
> >  
> > -void __exit nfs_destroy_nfspagecache(void)
> > +void nfs_destroy_nfspagecache(void)
> >  {
> >  	if (kmem_cache_destroy(nfs_page_cachep))
> >  		printk(KERN_INFO "nfs_page: not all structures were freed\n");
> > Index: linux-2.6/fs/nfs/read.c
> > ===================================================================
> > --- linux-2.6.orig/fs/nfs/read.c
> > +++ linux-2.6/fs/nfs/read.c
> > @@ -711,7 +711,7 @@ int __init nfs_init_readpagecache(void)
> >  	return 0;
> >  }
> >  
> > -void __exit nfs_destroy_readpagecache(void)
> > +void nfs_destroy_readpagecache(void)
> >  {
> >  	mempool_destroy(nfs_rdata_mempool);
> >  	if (kmem_cache_destroy(nfs_rdata_cachep))
> > Index: linux-2.6/fs/nfs/write.c
> > ===================================================================
> > --- linux-2.6.orig/fs/nfs/write.c
> > +++ linux-2.6/fs/nfs/write.c
> > @@ -1551,7 +1551,7 @@ int __init nfs_init_writepagecache(void)
> >  	return 0;
> >  }
> >  
> > -void __exit nfs_destroy_writepagecache(void)
> > +void nfs_destroy_writepagecache(void)
> >  {
> >  	mempool_destroy(nfs_commit_mempool);
> >  	mempool_destroy(nfs_wdata_mempool);
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

