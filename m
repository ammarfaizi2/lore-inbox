Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWC0W6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWC0W6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWC0W6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:58:04 -0500
Received: from ns1.siteground.net ([207.218.208.2]:17601 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750815AbWC0W6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 17:58:03 -0500
Date: Mon, 27 Mar 2006 14:58:47 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: cmm@us.ibm.com, sho@tnes.nec.co.jp, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
       Laurent.Vivier@bull.net
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
Message-ID: <20060327225847.GC3756@localhost.localdomain>
References: <20060325223358sho@rifu.tnes.nec.co.jp> <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com> <20060327131049.2c6a5413.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327131049.2c6a5413.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 01:10:49PM -0800, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > I am wondering if we have (or plan to have) "long long " type of percpu
> >  counters?  Andrew, Kiran, do you know?  
> > 
> >  It seems right now the percpu counters are used mostly by ext2/3 for
> >  filesystem free blocks accounting. Right now the counter is "long" type,
> >  which is not enough if we want to extend the filesystem limit from 2**31
> >  to 2**32 on 32 bit machine.
> > 
> >  The patch from Takashi copies the whole percpu_count.h  and create a new
> >  percpu_llcounter.h to support longlong type percpu counters. I am
> >  wondering is there any better way for this?
> > 
> 
> I can't immediately think of anything smarter.
> 
> One could of course implement a 64-bit percpu counter by simply
> concatenating two 32-bit counters.  That would be a little less efficient,
> but would introduce less source code and would mean that we don't need to
> keep two different implemetations in sync.  But one would need to do a bit
> of implementation, see how bad it looks.

Since long long is 64 bits on both 32bit and 64 bit arches, we can just
change percpu_counter type to long long (or s64) and just have one
implementation of percpu_counter?  
But reads and writes on 64 bit counters may not be atomic on all 32 bit arches.
So the implementation might have to be reviewed for that.

Thanks,
Kiran
