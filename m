Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbUDFVK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264014AbUDFVHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:07:43 -0400
Received: from ns.suse.de ([195.135.220.2]:5053 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264009AbUDFVEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:04:34 -0400
Subject: Re: [PATCH] reiserfs v3 fixes and features
From: Chris Mason <mason@suse.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200404062214.40259@WOLK>
References: <1081274618.30828.30.camel@watt.suse.com>
	 <200404062214.40259@WOLK>
Content-Type: text/plain
Message-Id: <1081285587.30811.258.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Apr 2004 17:06:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 16:14, Marc-Christian Petersen wrote:
> On Tuesday 06 April 2004 20:03, Chris Mason wrote:
> 
> Hi Chris,
> 
> > If anyone is interested in experimenting with the block allocator stuff,
> > please let me know.
> 
> I am :)

There are a few different sides to the block allocator work. 

1) don't ruin what the current allocator is good at (desktop esp).  A
sequential tree read of freshly copied data is really fast right now. 
It could be a little better with some metadata readahead, I'm still
trying to safely revive that code.

The patch tries to keep performance for a full tree read by with the -o
packing_groups option.  The basic idea is to reuse bitmap groups for new
subdirectories until the bitmap group is full.  This is done by checking
to see how full a given part of the btree is.
 
2) Improve the fragmentation under multiple writers.   With 20 writers,
the default allocator breaks down, fragmenting badly (20% or so).  The
patch with -o alloc=skip_busy:dirid_groups on makes things sane (3%).

So, to help test, you need some way of measuring fragmentation and a
whole bunch of benchmarks.  I like fibmap:
(http://www.informatik.uni-frankfurt.de/~loizides/reiserfs/fibmap.html)

But Andrew has a fragmentation tool in the ext2 cvs I think.

-chris


