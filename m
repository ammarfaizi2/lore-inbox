Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269506AbUICE44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269506AbUICE44 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 00:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269509AbUICE4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 00:56:55 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:53611 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269506AbUICE4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 00:56:24 -0400
Message-ID: <2c6b3ab0040902215656704680@mail.gmail.com>
Date: Fri, 3 Sep 2004 10:26:23 +0530
From: Amit Gud <amitgud@gmail.com>
Reply-To: Amit Gud <amitgud@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: Using filesystem blocks
Cc: linux-kernel@vger.kernel.org, gud@eth.net
In-Reply-To: <20040902200743.GB6875@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2c6b3ab004090212293b394b41@mail.gmail.com> <20040902200743.GB6875@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Is it wise enough to abstract away the usage of blocks for storing
> > extended attributes?
> 
> No.  Some fs' will store xattr data in the inodes if it fits.
> 

First up, why is mbcache code is written at VFS layer than being
filesystem specific? Neccessarily to take away the coding overheads of
maintaining block cache that any filesystem uses, even though given
that only ext2 and ext3 uses it. It facilitates code reuse.

Now if we are making reuse of the code to manage block cache, why
can't we make use of the code of allocating blocks, storing the stuff
and other intricacies of block boundary management by writing the code
at another layer, which other fs' can use readiliy including ext2
ext3?

This is advantageous for new filesystems or new fs features which may
use disk blocks not assiciated with any inode for some purpose. Right
now if I'm to do, I'II have to rewrite the code of whole block
management. But I can avail the block cache functions of mbcache.

Like I said, forget what fs does what to store its xattr, ext2/3 is
just an example which uses blocks to store them. What I'm pointing to
is generic interface to the block management code. If the block
management code is written with a generic interface, like mbcache, it
would be very helpful for the future filesystems or for new features
in the exiting fs'.

AG
