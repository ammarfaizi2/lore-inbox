Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264506AbSIVTzl>; Sun, 22 Sep 2002 15:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264508AbSIVTzl>; Sun, 22 Sep 2002 15:55:41 -0400
Received: from thunk.org ([140.239.227.29]:41113 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S264506AbSIVTzl>;
	Sun, 22 Sep 2002 15:55:41 -0400
Date: Sun, 22 Sep 2002 16:00:40 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New version of the ext3 indexed-directory patch
Message-ID: <20020922200039.GA5709@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <E17sQq8-00045P-00@think.thunk.org> <3D8B557C.F9BF34D3@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8B557C.F9BF34D3@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 10:06:04AM -0700, Andrew Morton wrote:
> 
> Thanks; it's good that this is moving ahead.  I'll update to this
> version in the -mm patchkit, so people can test it from there
> too.
> 
> What is the status of e2fsprogs support for htree?  Is everything covered?

Almost.  E2fsck support is fully there.  With e2fsprogs 1.28, you
still need to manually set up the dir_index feature flag to convert a
filesystme to use the directory indexing feature:

debugfs -w -R "features dir_index" /dev/hdXX
debugfs -w -R "ssv def_hash_version tea" /dev/hdXX
debugfs -w -R "ssv hash_seed random" /dev/hdXX

In the 1.29 release, mke2fs will create filesystems with the directory
indexing flag set by default, and tune2fs -O dir_index will do set up
the directory indexing flag and the default hash version
automatically.

There is also a bug in e2fsprogs 1.28 so that the -D option to e2fsck
(which optimizes all directories) has a 1 in 512 chance of corrupting
a directory, due to a fenceport error that escaped my testing.  This
will be fixed in 1.29, which should be released very shortly.

Folks who want to play with the latest e2fsprogs get grab it here:

	bk://thunk.org:5000

							- Ted
