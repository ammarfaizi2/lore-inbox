Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318263AbSIEV7Y>; Thu, 5 Sep 2002 17:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318253AbSIEV7I>; Thu, 5 Sep 2002 17:59:08 -0400
Received: from citi.umich.edu ([141.211.92.141]:3864 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S318242AbSIEV5L>;
	Thu, 5 Sep 2002 17:57:11 -0400
Message-ID: <3D77D44C.8060109@citi.umich.edu>
Date: Thu, 05 Sep 2002 18:01:48 -0400
From: Chuck Lever <cel@citi.umich.edu>
Organization: Center for Info Tech Integration, U-Michigan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77C0A7.F74A89D0@zip.com.au> <15735.50124.304510.10612@charged.uio.no> <3D77C8B7.1534A2DB@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Trond, there are very good reasons why it broke.  Those pages are
> visible to the whole world via global data structures - both the 
> page LRUs and via the superblocks->inodes walk.  Those things exist
> for legitimate purposes, and it is legitimate for async threads
> of control to take a reference on those pages while playing with them.
> 
> It just "happened to work" in earlier kernels.
> 
> I suspect we can just remove the page_count() test from invalidate
> and that will fix everything up.  That will give stronger invalidate
> and anything which doesn't like that is probably buggy wrt truncate anyway.
> 
> Could you test that?


removing that test from invalidate_inode_pages allows test6 to run to

completion.

however, i don't see why the reference counts should be higher in

2.5.32 than they were in 2.5.31.  is there a good way to test that
these pages do not become orphaned?

-- 

corporate: 
<cel at netapp dot com>
personal: 
<chucklever at bigfoot dot com>

