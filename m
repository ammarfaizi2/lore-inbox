Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262098AbSIYUHh>; Wed, 25 Sep 2002 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262101AbSIYUHh>; Wed, 25 Sep 2002 16:07:37 -0400
Received: from thunk.org ([140.239.227.29]:2463 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262098AbSIYUHg>;
	Wed, 25 Sep 2002 16:07:36 -0400
Date: Wed, 25 Sep 2002 16:12:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop device broken in 2.5.38
Message-ID: <20020925201220.GA9557@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E17uG42-0002gm-00@think.thunk.org> <20020925180355.GD22795@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020925180355.GD22795@clusterfs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 12:03:55PM -0600, Andreas Dilger wrote:
> Is there a historic reason why we pre-compute and store the loop device
> size instead of re-calculating it each time we do a BLKGETSZ ioctl?
> Re-calculating it each time allows you to increase the size of the
> backing file if needed while it is in use, and I don't think we actually
> get the size of the loop device very often, so it is not a big deal,
> especially given the simple calculation needed.

We need to pre-compute the size because the block device layer wants
to know how big devices were so it can do sanity checking on the
incoming requests.  This was done in the historically by setting
blk_size[MAJOR_NR] to point to an array which contained the size of
the minor devices in kilobytes, and in the new world order, via the
set_capacity() call.

						- Ted
