Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262021AbSIYQad>; Wed, 25 Sep 2002 12:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262022AbSIYQad>; Wed, 25 Sep 2002 12:30:33 -0400
Received: from packet.digeo.com ([12.110.80.53]:3526 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262021AbSIYQac>;
	Wed, 25 Sep 2002 12:30:32 -0400
Message-ID: <3D91E5DC.665EB3AC@digeo.com>
Date: Wed, 25 Sep 2002 09:35:40 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: frankeh@watson.ibm.com
CC: Mark_H_Johnson@raytheon.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] recognize MAP_LOCKED in mmap() call
References: <OFC0C42F8D.E1325D58-ON86256C38.00695CD8@hou.us.ray.com> <3D88D9DE.2FB9A23D@digeo.com> <200209251142.29341.frankeh@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Sep 2002 16:35:41.0236 (UTC) FILETIME=[963CEF40:01C264B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> ...
> This is what the manpage says...
> 
>        mlockall  disables  paging  for  all pages mapped into the
>        address space of the calling process.  This  includes  the
>        pages  of  the  code,  data  and stack segment, as well as
>        shared libraries, user space kernel  data,  shared  memory
>        and  memory  mapped files. All mapped pages are guaranteed
>        to be resident  in  RAM  when  the  mlockall  system  call
>        returns  successfully  and  they are guaranteed to stay in
>        RAM until the pages  are  unlocked  again  by  munlock  or
>        munlockall  or  until  the  process  terminates  or starts
>        another program with exec.  Child processes do not inherit
>        page locks across a fork.
> 
> Do you read that all pages must be faulted in apriori ?

For MCL_FUTURE.

> Or is it sufficient to to make sure non of the currently mapped
> pages are swapped out and future swapout is prohibited.

I'd say that we should try to make all the pages present.  But
if it's a problem for (say) a hugepage implementation then it's
unlikely that the world would end if these things were still
demand paged in.
