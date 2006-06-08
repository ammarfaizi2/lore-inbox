Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWFHK6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWFHK6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWFHK6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:58:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8479 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964818AbWFHK6C (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:58:02 -0400
Date: Thu, 8 Jun 2006 13:00:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Tom Vier <tmv@comcast.net>, Linux-Kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: [PATCH] updated reiser4 - reduced cpu usage for writes by writing  more than 4k at a time (has implications for generic write code and eventually  for the IO layer)
Message-ID: <20060608110044.GA5207@suse.de>
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero> <44749E24.40203@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44749E24.40203@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24 2006, Hans Reiser wrote:
> Tom Vier wrote:
> 
> >On Tue, May 23, 2006 at 01:14:54PM -0700, Hans Reiser wrote:
> >  
> >
> >>underlying FS can be improved.  Performance results show that the new
> >>code consumes  40% less CPU when doing "dd bs=1MB ....." (your hardware,
> >>and whether the data is in cache, may vary this result).  Note that this
> >>has only a small effect on elapsed time for most hardware.
> >>    
> >>
> >
> >Write requests in linux are restricted to one page?
> >
> >  
> >
> It may go to the kernel as a 64MB write, but VFS sends it to the FS as
> 64MB/4k separate 4k writes.

Nonsense, there are ways to get > PAGE_CACHE_SIZE writes in one chunk.
Other file systems have been doing it for years.

-- 
Jens Axboe

