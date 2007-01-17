Return-Path: <linux-kernel-owner+w=401wt.eu-S1751657AbXAQVzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbXAQVzM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbXAQVzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:55:11 -0500
Received: from pat.uio.no ([129.240.10.15]:57054 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657AbXAQVzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:55:10 -0500
Subject: Re: [PATCH] nfs: fix congestion control
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1169070763.5975.70.camel@lappy>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org> <1168985323.5975.53.camel@lappy>
	 <Pine.LNX.4.64.0701171158290.7397@schroedinger.engr.sgi.com>
	 <1169070763.5975.70.camel@lappy>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 16:54:46 -0500
Message-Id: <1169070886.6523.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Resend: resent
X-UiO-Spam-info: not spam, SpamAssassin (score=0.0, required=12.0, autolearn=disabled, none)
X-UiO-Scanned: CF11D01D9BBDC7EC7B0EB6B3B7226FE6A0736072
X-UiO-SPAM-Test: remote_host: 129.240.10.9 spam_score: 0 maxlevel 200 minaction 2 bait 0 mail/h: 171 total 9318 max/h 9318 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-17 at 22:52 +0100, Peter Zijlstra wrote:

> > 
> > > Index: linux-2.6-git/fs/inode.c
> > > ===================================================================
> > > --- linux-2.6-git.orig/fs/inode.c	2007-01-12 08:03:47.000000000 +0100
> > > +++ linux-2.6-git/fs/inode.c	2007-01-12 08:53:26.000000000 +0100
> > > @@ -81,6 +81,7 @@ static struct hlist_head *inode_hashtabl
> > >   * the i_state of an inode while it is in use..
> > >   */
> > >  DEFINE_SPINLOCK(inode_lock);
> > > +EXPORT_SYMBOL_GPL(inode_lock);
> > 
> > Hmmm... Commits to all NFS servers will be globally serialized via the 
> > inode_lock?
> 
> Hmm, right, thats not good indeed, I can pull the call to
> nfs_commit_list() out of that loop.

There is no reason to modify any of the commit stuff. Please just drop
that code.

Trond

