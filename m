Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161293AbWBUClZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161293AbWBUClZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 21:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161292AbWBUClZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 21:41:25 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:63969 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161289AbWBUClY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 21:41:24 -0500
Date: Mon, 20 Feb 2006 18:41:08 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, christoph <hch@lst.de>,
       mcao@us.ibm.com, akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and mpage_readpages()
Message-ID: <20060221024108.GA251337@sgi.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com> <20060221085953.H9484650@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221085953.H9484650@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 08:59:53AM +1100, Nathan Scott wrote:
> On Mon, Feb 20, 2006 at 01:21:27PM -0800, Badari Pulavarty wrote:
> 
> I've been running these patches in my development tree for awhile
> and have not seen any problems.  My one (possibly minor) concern
> is that we pass get_block a size in units of bytes, e.g....
> 
> 	bh->b_size = 1 << inode->i_blkbits;
> 	err = get_block(inode, block, bh, 1);
> 
> And b_size is a u32.  We have had the situation in the past where
> people (I'm looking at you, Jeremy ;) have been issuing multiple-
> gigabyte direct reads/writes through XFS.  The syscall interface
> takes an (s)size_t in bytes, which on 64 bit platforms is a 64 bit
> byte count.
> 
> I wonder if this change will end up ruining things for the lunatic
> fringe issuing these kinds of IOs?  Maybe the get_block call could

Hey!  Lunatic fringe indeed.  Harumph!  :-)

Yes, there are a few people out there who will need to issue really
large I/O reads or writes to get maximum I/O bandwidth on large
stripes.  The largest I've done so far is 4GiB, but I expect that
number will likely increase this year, and more likely next year,
if not.

jeremy
