Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273295AbRIRKC0>; Tue, 18 Sep 2001 06:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273293AbRIRKCG>; Tue, 18 Sep 2001 06:02:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21460 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273290AbRIRKCE>;
	Tue, 18 Sep 2001 06:02:04 -0400
Date: Tue, 18 Sep 2001 06:02:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918115713.C2723@athlon.random>
Message-ID: <Pine.GSO.4.21.0109180558150.25323-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andrea Arcangeli wrote:

> On Tue, Sep 18, 2001 at 05:44:18AM -0400, Alexander Viro wrote:
> > Bumping ->i_count on inode is _not_ an option - think what it does if
> > you umount the first fs.
> 
> what it does? Unless I'm missing something the fs never cares and never
> sees the bd_inode. the fs just does a bdget and then it works only on
> the bdev. What should I run to get the oops exactly?

It sees an active inode for superblock we are destroying.  _Not_ a good
thing, for very obvious reasons.  There is a reason for "Self-destruct in
5 seconds" printk...
 
> If we need to avoid the bumping of i_count and to allocate something
> dynamically that will be the bd_mapping address space, we don't need a
> new fake_inode there too, we just need to share the new physical
> pagecahce address space. Such physical i_mapping address space is the

What are you going to use as mapping->host for it?

