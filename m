Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264010AbUEDAHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264010AbUEDAHh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 20:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUEDAHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 20:07:37 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:65530 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264010AbUEDAHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 20:07:35 -0400
Date: Tue, 4 May 2004 10:05:40 +1000
From: Greg Banks <gnb@sgi.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Greg Banks <gnb@melbourne.sgi.com>, Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
Message-ID: <20040504000540.GB24969@sgi.com>
References: <16521.5104.489490.617269@laputa.namesys.com> <16529.56343.764629.37296@cse.unsw.edu.au> <409634B9.8D9484DA@melbourne.sgi.com> <16534.54704.792101.617408@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16534.54704.792101.617408@cse.unsw.edu.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 09:28:48AM +1000, Neil Brown wrote:
> On Monday May 3, gnb@melbourne.sgi.com wrote:
> > Neil Brown wrote:
> > > 
> > *   Dentry_stat.nr_unused can be be spuriously decremented when dput()
> >     races with __dget_unlocked().  Eventual result is nr_unused<0
> >     and kswapd loops.  This is the problem I mentioned earlier.  Note
> >     that this is not an NFS-specific problem.  Fix is:
> > 
> > --- linux.orig/fs/dcache.c	Mon May  3 21:46:30 2004
> > +++ linux/fs/dcache.c	Mon May  3 21:49:07 2004
> > @@ -255,8 +255,8 @@
> >  
> >  static inline struct dentry * __dget_locked(struct dentry *dentry)
> >  {
> > -	atomic_inc(&dentry->d_count);
> > -	if (atomic_read(&dentry->d_count) == 1) {
> > +	if (atomic_inc(&dentry->d_count) == 1) {
> 
> One problem with this is that (in include/asm-i386/atomic.h at least):
>   static __inline__ void atomic_inc(atomic_t *v)
> 
> atomic_inc returns "void".

Doh!  This is what comes from doing all coding and testing on minority
achitectures...I'll think about this a bit more.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
