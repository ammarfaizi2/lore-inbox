Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132520AbREKBE6>; Thu, 10 May 2001 21:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbREKBEt>; Thu, 10 May 2001 21:04:49 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:25605 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S132520AbREKBEh>; Thu, 10 May 2001 21:04:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Fri, 11 May 2001 03:04:31 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, Albert Cranford <ac9410@bellsouth.net>
In-Reply-To: <200105092122.f49LMAVL019186@webber.adilger.int>
In-Reply-To: <200105092122.f49LMAVL019186@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01051103043101.01587@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 May 2001 23:22, you wrote:
> Daniel writes [re index directories]:
> > This is lightly tested and apparently stable.
>
> I was looking at the new patch, and I saw something that puzzles me.
> Why do you set the EXT2_INDEX_FL on a new (empty) directory, rather
> than only setting it when the dx_root index is created?

This makes it follow the rule: new directories will be created with an 
index.  (Never mind that the index creation is deferred.)  Now, if you 
think it's ok to add an index to any directory that grows past one 
block that's fine with me.  I was looking for a little more predictable 
behavriour.

A couple of lines of code will go away and the is_dx(dir) tests will 
get a little faster if we just use 'dir grew past a block' as the rule.

> Setting the flag earlier than that makes it mostly useless, since it
> will be set on basically every directory.  Not setting it would also
> make your is_dx() check simply a check for the EXT2_INDEX_FL bit (no
> need to also check size).

Yep.

> Also no need to set EXT2_COMPAT_DIR_INDEX until such a time that we
> have a (real) directory with an index, to avoid gratuitous
> incompatibility with e2fsck.
>
> Cheers, Andreas

Again yep,  you decide, I will fix, or I see a few posts down you have 
changed the patch, also fine.

--
Daniel
