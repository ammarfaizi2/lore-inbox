Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVCGIVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVCGIVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVCGIVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:21:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:59051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261684AbVCGIV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:21:27 -0500
Date: Mon, 7 Mar 2005 00:20:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch 2/5] setup_per_zone_lowmem_reserve() oops fix
Message-Id: <20050307002048.51aac96b.akpm@osdl.org>
In-Reply-To: <422C0C5D.3060404@yahoo.com.au>
References: <200503042117.j24LHGrx017967@shell0.pdx.osdl.net>
	<422C0C5D.3060404@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> akpm@osdl.org wrote:
> > If you do 'echo 0 0 > /proc/sys/vm/lowmem_reserve_ratio' the kernel gets a
> > divide-by-zero.
> > 
> > Prevent that, and fiddle with some whitespace too.
> > 
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> Can we instead have a patch that makes the value zero turn off the
> lowmem reserve entirely if it is set to zero?

That would make sense, I guess.

> Just now I was just testing, and found no easy way to do this other
> than to make the value large enough that the reserve is insignificant.

Me too.  I use 1000 to get my 50MB of pagecache back.

I haven't thought about it yet, but there must be some way to avoid leaving
huge amounts of lowmem free.  It should be OK to allow lowmem to be fully
used, as long as there's sufficent reclaimable stuff in there - slab,
blockdev pagecache, etc.  (Assuming nothing sane mmaps blockdevs.  INND
does).  Dunno....

