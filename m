Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263349AbVGORzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbVGORzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbVGORzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:55:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:41106 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263349AbVGORyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:54:51 -0400
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Daniel McNeil <daniel@osdl.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42D77293.3050900@gmail.com>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net>
	 <42D70318.1000304@gmail.com> <42D74724.8000703@us.ibm.com>
	 <42D77293.3050900@gmail.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 10:54:39 -0700
Message-Id: <1121450079.6755.96.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 17:23 +0900, Tejun Heo wrote:
> Badari Pulavarty wrote:
...
> >>  I don't know why you wanna relax the alignment requirement, but 
> >> wouldn't it be easier to just write/use block-aligned allocator for 
> >> such buffers?  It will even make the program more portable.
> >>
> > 
> > I can imagine a reason for relaxing the alignment. I keep getting asked
> > whether we can do "O_DIRECT mount option".  Database folks wants to
> > make sure all the access to files in a given filesystem are O_DIRECT
> > (whether they are accessing or some random program like ftp, scp, cp
> > are acessing them). This was mainly to ensure that buffered accesses to
> > the file doesn't polute the pagecache (while database is using O_DIRECT
> > access). Seems like a logical request, but not easy to do :(
> > 
> > Thanks,
> > Badari
> 
>   I don't know much about VM, but, if that's necessary, I think that 
> limiting pagecache size per mounted fs (or by some other applicable 
> category) is easier/more complete approach.  After all, you cannot mmap 
> w/ O_DIRECT and many programs (gcc, ld come to mind) mmap large part of 
> their memory usage.

I agree. I guess for mmap()ed access we can kick it back to buffered
mode.

I don't think limiting pagecache use per filesystem is an acceptable
option. In fact, database folks exactly want this -  to limit the
pagecache use by filesystems - but I don't think its right thing to do,
so I am trying to propose mount O_DIRECT as an alternative (if its
feasible).

Thanks,
Badari

