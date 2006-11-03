Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753550AbWKCVWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbWKCVWc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 16:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbWKCVWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 16:22:32 -0500
Received: from pat.uio.no ([129.240.10.4]:18051 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1753543AbWKCVWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 16:22:31 -0500
Subject: Re: [PATCH 2/3] fsstack: Generic get/set lower object functions
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20061103204743.GC16506@filer.fsl.cs.sunysb.edu>
References: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu>
	 <20061102035928.679.5819.stgit@thor.fsl.cs.sunysb.edu>
	 <1162483565.6299.98.camel@lade.trondhjem.org>
	 <20061103204743.GC16506@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 16:22:22 -0500
Message-Id: <1162588942.5629.101.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.67, required 12,
	autolearn=disabled, AWL 1.33, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 15:47 -0500, Josef Sipek wrote: 
> I was thinking about this a bit, and it would seem that not having get/set
> function pretty much kills the reson to have generic pointer structures at
> all.
> 
> Would it make sense to change filesystems like ecryptfs to open-code all
> these things instead of using _their own_ get/set functions (e.g.,
> ecryptfs_inode_to_lower)?
>
> Other posibility is to move the lower pointers into generic VFS objects in
> some clever way (not to waste memory on regular filesystems) - this way, the
> stackable filesystems can still share some parts.

In order for this to be useful, you and the ecryptfs folks need to sit
down and figure out what functionality all these stackable filesystems
want to share.

For instance, there is nothing wrong with moving ecryptfs_d_revalidate()
into a common libstackfs.c if it turns out that several filesystems want
to do the same thing. This is particularly true if you find common
locking needs (as is the case with ecryptfs_do_create(), for instance)
since locks are a good example of something you never want to debug more
than once.

Given all the fun things that can happen with intents in the lower_level
filesystem lookup() code, then that is probably a prime candidate for
some nice helper functions to make everyone's lives easy too...

Cheers,
  Trond

