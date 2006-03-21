Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWCUTGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWCUTGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWCUTGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:06:34 -0500
Received: from pat.uio.no ([129.240.130.16]:38053 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965039AbWCUTGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:06:33 -0500
Subject: Re: [NFS] [GIT] NFS client update for 2.6.16
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, nfsv4@linux-nfs.org
In-Reply-To: <20060321185734.GB19125@infradead.org>
References: <1142961077.7987.14.camel@lade.trondhjem.org>
	 <20060321174634.GA15827@infradead.org>
	 <1142964532.7987.61.camel@lade.trondhjem.org>
	 <20060321185734.GB19125@infradead.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 14:06:20 -0500
Message-Id: <1142967981.7987.92.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.658, required 12,
	autolearn=disabled, AWL 1.34, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 18:57 +0000, Christoph Hellwig wrote:
> On Tue, Mar 21, 2006 at 01:08:52PM -0500, Trond Myklebust wrote:
> > We never had support for multiple iovecs in O_DIRECT, but were passing
> > around a single iovec entry deep into code that couldn't care less.
> 
> anthing that moves from iovecs back to plain buffers is counterproductive.
> The plan is that every fullblown fs will only deal with iovecs, onlt drivers
> and synthetic filesystems will implement the plain buffers.

You need to do more than just add an iovec argument to
nfs_file_direct_read()/nfs_file_direct_write() if you want to achieve
this. The new call interface actually just clarifies something that was
implicit in the old one.

As I said in my other posting, I believe Chuck's changes are relatively
orthogonal to what you want to do: they neither make the low-level
plumbing better or worse for readv()/writev().

We'd be happy to work with you in the run-up to 2.6.18 to add
multi-segment support for the existing patchsets. It makes more sense to
me to append that functionality to the existing patchsets rather than
trigger a complete rewrite (and thus have a sh_tload more code to
retest).

Cheers,
    Trond

