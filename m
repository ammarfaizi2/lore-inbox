Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVCWXVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVCWXVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVCWXVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:21:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262089AbVCWXU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:20:57 -0500
Date: Wed, 23 Mar 2005 15:20:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: cmm@us.ibm.com, andrea@suse.de, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-Id: <20050323152055.6fc8c198.akpm@osdl.org>
In-Reply-To: <17250000.1111619602@flay>
References: <20050315204413.GF20253@csail.mit.edu>
	<20050316003134.GY7699@opteron.random>
	<20050316040435.39533675.akpm@osdl.org>
	<20050316183701.GB21597@opteron.random>
	<1111607584.5786.55.camel@localhost.localdomain>
	<20050323144953.288a5baf.akpm@osdl.org>
	<17250000.1111619602@flay>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > It would be interesting if you could run the same test on 2.6.11.  
> 
> One thing I'm finding is that it's hard to backtrace who has each page
> in this sort of situation. My plan is to write a debug patch to walk
> mem_map and dump out some info on each page. I would appreciate ideas
> on what info would be useful here. Some things are fairly obvious, like
> we want to know if it's anon / mapped into address space (& which),
> whether it's slab / buffers / pagecache etc ... any other suggestions
> you have would be much appreciated.

You could use

	page-owner-tracking-leak-detector.patch
	make-page_owner-handle-non-contiguous-page-ranges.patch
	add-gfp_mask-to-page-owner.patch

which sticks an 8-slot stack backtrace into each page, recording who
allocated it.

But that's probably not very interesting info for pagecache pages.

Nothing beats poking around in a dead machine's guts with kgdb though.
