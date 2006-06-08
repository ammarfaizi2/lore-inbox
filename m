Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWFHMKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWFHMKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 08:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWFHMKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 08:10:41 -0400
Received: from tzec.mtu.ru ([195.34.34.228]:44556 "EHLO tzec.mtu.ru")
	by vger.kernel.org with ESMTP id S964814AbWFHMKl (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Thu, 8 Jun 2006 08:10:41 -0400
Subject: Re: [PATCH] updated reiser4 - reduced cpu usage for writes by 
	writing  more than 4k at a time (has implications for generic write code 
	and eventually  for the IO layer)
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Jens Axboe <axboe@suse.de>
Cc: Hans Reiser <reiser@namesys.com>, Tom Vier <tmv@comcast.net>,
       Linux-Kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
In-Reply-To: <20060608113517.GC5207@suse.de>
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero>
	 <44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de>
	 <1149766000.6336.29.camel@tribesman.namesys.com>
	 <20060608113517.GC5207@suse.de>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 16:08:57 +0400
Message-Id: <1149768537.6336.36.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, 2006-06-08 at 13:35 +0200, Jens Axboe wrote:
> On Thu, Jun 08 2006, Vladimir V. Saveliev wrote:
> > Hello
> > 
> > On Thu, 2006-06-08 at 13:00 +0200, Jens Axboe wrote:
> > > On Wed, May 24 2006, Hans Reiser wrote:
> > > > Tom Vier wrote:
> > > > 
> > > > >On Tue, May 23, 2006 at 01:14:54PM -0700, Hans Reiser wrote:
> > > > >  
> > > > >
> > > > >>underlying FS can be improved.  Performance results show that the new
> > > > >>code consumes  40% less CPU when doing "dd bs=1MB ....." (your hardware,
> > > > >>and whether the data is in cache, may vary this result).  Note that this
> > > > >>has only a small effect on elapsed time for most hardware.
> > > > >>    
> > > > >>
> > > > >
> > > > >Write requests in linux are restricted to one page?
> > > > >
> > > > >  
> > > > >
> > > > It may go to the kernel as a 64MB write, but VFS sends it to the FS as
> > > > 64MB/4k separate 4k writes.
> > > 
> > > Nonsense, 
> > 
> > Hans refers to generic_file_write which does
> > prepare_write
> > copy_from_user
> > commit_write
> > for each page.
> 
> Provide your own f_op->write() ?
> 
Yes, a filesystem can do that. But it is more welcomed to kernel if it
writes/reads using generic functions.

> > > there are ways to get > PAGE_CACHE_SIZE writes in one chunk.
> > > Other file systems have been doing it for years.
> > > 
> > 
> > Would you, please, say more about it.
> 
> Use writepages?
> 
This is about flushing, not sys_write.


