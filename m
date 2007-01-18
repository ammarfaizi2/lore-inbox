Return-Path: <linux-kernel-owner+w=401wt.eu-S932255AbXARN3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbXARN3h (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbXARN3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:29:37 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:36212 "EHLO
	amsfep12-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932311AbXARN3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:29:36 -0500
Subject: Re: [PATCH] nfs: fix congestion control
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1169070886.6523.8.camel@lade.trondhjem.org>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org> <1168985323.5975.53.camel@lappy>
	 <Pine.LNX.4.64.0701171158290.7397@schroedinger.engr.sgi.com>
	 <1169070763.5975.70.camel@lappy>
	 <1169070886.6523.8.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 14:27:48 +0100
Message-Id: <1169126868.6197.55.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-17 at 16:54 -0500, Trond Myklebust wrote:
> On Wed, 2007-01-17 at 22:52 +0100, Peter Zijlstra wrote:
> 
> > > 
> > > > Index: linux-2.6-git/fs/inode.c
> > > > ===================================================================
> > > > --- linux-2.6-git.orig/fs/inode.c	2007-01-12 08:03:47.000000000 +0100
> > > > +++ linux-2.6-git/fs/inode.c	2007-01-12 08:53:26.000000000 +0100
> > > > @@ -81,6 +81,7 @@ static struct hlist_head *inode_hashtabl
> > > >   * the i_state of an inode while it is in use..
> > > >   */
> > > >  DEFINE_SPINLOCK(inode_lock);
> > > > +EXPORT_SYMBOL_GPL(inode_lock);
> > > 
> > > Hmmm... Commits to all NFS servers will be globally serialized via the 
> > > inode_lock?
> > 
> > Hmm, right, thats not good indeed, I can pull the call to
> > nfs_commit_list() out of that loop.
> 
> There is no reason to modify any of the commit stuff. Please just drop
> that code.

I though you agreed to flushing commit pages when hitting the dirty page
limit.

Or would you rather see a notifier chain from congestion_wait() calling
into the various NFS mounts?

