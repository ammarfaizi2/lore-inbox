Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWHaQEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWHaQEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWHaQEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:04:11 -0400
Received: from pat.uio.no ([129.240.10.4]:54776 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932331AbWHaQEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:04:09 -0400
Subject: Re: bug in nfs in 2.6.18-rc5?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       unionfs@fsl.cs.sunysb.edu
In-Reply-To: <44F6F80F.1000202@cs.columbia.edu>
References: <44F6F80F.1000202@cs.columbia.edu>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 12:03:50 -0400
Message-Id: <1157040230.11347.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.18, required 12,
	autolearn=disabled, AWL 1.82, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 10:54 -0400, Shaya Potter wrote:

> __lookup_hash() ends up calling the underlying fs's lookup op, i.e. 
> nfs_lookup()
> 
> nfs_lookup() calls nfs_reval_fsid(nd->mnt, dir, &fhandle, &fattr);
> 
> see the bug? :)
> 
> This doesn't seem like a unionfs bug, as one should be able to call 
> lookup_one_len() on an NFS fs.

Did someone start handing out these promises when I wasn't looking?

AFAICS, lookup_one_len() should only be used by the filesystem itself,
or by services like nfsd that have intimate knowledge of the
filesystem's inner workings.

The reason why NFS would like to insist on that nameidata is that we
need to be able to create mountpoints on the fly when we cross from one
filesystem on the server to another. Otherwise, we cannot offer the type
of guarantees that POSIX applications expect, such as the ability to
provide unique permanent inode numbers.
If we're to provide the ability for unionfs to use lookup_one_len() on
NFS, then we will have to error out whenever we hit a case where we
should be creating a new mountpoint. Is that acceptable?

Cheers,
  Trond

