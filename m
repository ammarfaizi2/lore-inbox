Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319446AbSIMAnU>; Thu, 12 Sep 2002 20:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319471AbSIMAnU>; Thu, 12 Sep 2002 20:43:20 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:29381 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S319446AbSIMAnT>;
	Thu, 12 Sep 2002 20:43:19 -0400
Subject: Re: 2.4.20pre5aa2
From: Stephen Lord <lord@sgi.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Samuel Flory <sflory@rackable.com>, Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
In-Reply-To: <20020913002316.GG11605@dualathlon.random>
References: <20020911201602.A13655@pc9391.uni-regensburg.de>
	<1031768655.24629.23.camel@UberGeek.coremetrics.com>
	<20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> 
	<20020913002316.GG11605@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 12 Sep 2002 19:47:48 -0500
Message-Id: <1031878070.1236.29.camel@snafu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 19:23, Andrea Arcangeli wrote:
> 
> that seems a bug in xfs, it BUG() if vmap fails, it must not BUG(), it
> must return -ENOMEM to userspace instead, or it can try to recollect and
> release some of the other vmalloced entries. Most probably you run into
> an address space shortage, not a real ram shortage, so to workaround it
> you can recompile with CONFIG_2G and it'll probably work, also dropping
> the gap page in vmalloc may help workaround it (there's no config option
> for it though). It could be also a vmap leak, maybe a missing vfree,
> just some idea.
> 

We hold vmalloced space for very short periods of time, in fact
filesystem recovery and large extended attributes are the only
cases. In this case we should be attempting to remap 2 pages
together. The only way out of this would be to fail the whole
mount at this point. I suspect a leak elsewhere.

Samuel, when you mounted xfs and it oopsed, was it shortly after bootup?
Also, how far did your dbench run get before it hung? I tried the
kernel, but I paniced during startup - then I realized I did not 
apply the patch to fix the xfs/scheduler interactions first.

How much memory is in the machine by the way? And Andrea, is the
vmalloc space size reduced in the 3G user space configuration?

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com

