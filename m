Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318165AbSIEVgw>; Thu, 5 Sep 2002 17:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318170AbSIEVgv>; Thu, 5 Sep 2002 17:36:51 -0400
Received: from citi.umich.edu ([141.211.92.141]:1440 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S318165AbSIEVgv>;
	Thu, 5 Sep 2002 17:36:51 -0400
Message-ID: <3D77CF83.1020606@citi.umich.edu>
Date: Thu, 05 Sep 2002 17:41:23 -0400
From: Chuck Lever <cel@citi.umich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77A22A.DC3F4D1@zip.com.au>		<Pine.BSO.4.33.0209051439540.12826-100000@citi.umich.edu>		<3D77ADC3.938C09F8@zip.com.au> <shsvg5k9pg3.fsf@charged.uio.no> <3D77BB7C.5F20939F@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Trond Myklebust wrote:
> 
>>>>>>>" " == Andrew Morton <akpm@zip.com.au> writes:
>>>>>>>
>>     > You may have more success using the stronger
>>     > invalidate_inode_pages2().
>>
>>Shouldn't make any difference. Chuck is seeing this on readdir() pages
>>which, of course, don't suffer from problems of dirtiness etc on NFS.
>>
> 
> Well the VM will take a ref on the page during reclaim even if it
> is clean.
> 
> With what sort of frequency does this happen?  If it's easily reproducible
> then dunno. If it's once-an-hour then it may be page reclaim, conceivably.
> The PageLRU debug test in there will tell us.


this happens every time i run test6 on 2.5.32 or 2.5.33.  the pages
are not on the LRU, and are not locked, when the NFS client calls
invalidate_inode_pages.

how do these pages get into the page cache?  answer:

nfs_readdir_filler is invoked by read_cache_page to fill a page.
when nfs_readdir_filler is invoked in 2.5.31, the page count on the
page to be filled is always 2.  when nfs_readdir_filler is invoked
in 2.5.32+, the page count is very often 3, but occasionally it is 2.

         - Chuck Lever

-- 
corporate: 
<cel at netapp dot com>
personal: 
<chucklever at bigfoot dot com>

