Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUDOA3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 20:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUDOA3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 20:29:17 -0400
Received: from ns.suse.de ([195.135.220.2]:47261 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261221AbUDOA3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 20:29:10 -0400
Subject: Re: [PATCH] reiserfs v3 fixes and features
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <1081274618.30828.30.camel@watt.suse.com>
References: <1081274618.30828.30.camel@watt.suse.com>
Content-Type: text/plain
Message-Id: <1081989006.27614.110.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Apr 2004 20:30:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I've uploaded some new code to:

ftp.suse.com/pub/people/mason/patches/reiserfs/2.6.5-mm5

series.linus tells you which patches are needed for 2.6.5.  If you're
working off a recent pull of bitkeeper, or the mm trees, use series.mm,
since data=ordered patches were recently applied.

(note, I haven't tested 2.6.5 with this patch set yet, -mm is my target
right now)

reiserfs-group-alloc-8 and reiserfs-search_reada-5 are still
experimental, and are only for the brave.

Most of the changes were to reiserfs-group-alloc-8, which tries to
improve the reiserfs allocator to reduce fragmentation.  The mount
options to enable the new code haven't changed, but I switched to using
the existing in-core bitmap book keeping to decide if a given packing
locality is full.  This is much more accurate, I'm not sure why I didn't
think of it before.

Also mount -o alloc=dirid_groups:skip_busy now tries to get metadata
into the same bitmap as the data blocks.  This really cuts down on
fragmentation among the leaf nodes.  More details are in the docs at the
top of the patch.

My goal is to make -o alloc=dirid_groups:skip_busy,packing_groups the
new default, it is working nicely here.  Testers and benchmarkers would
be appreciated.

Other new patches:
reiserfs-search_reada-5 -  it should make deletes and directory reads
faster by doing some metadata readahead.

reiserfs-delayed-work - a huge performance boost to synchronous
workloads that trigger transaction commits.

reiserfs-no-sleep-on - removes the last sleep_on user in reiserfs.

I'll submit these last two to Andrew after the whole thing passes some
more tests.

-chris


