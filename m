Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262006AbSIYPec>; Wed, 25 Sep 2002 11:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262008AbSIYPeb>; Wed, 25 Sep 2002 11:34:31 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34991 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262006AbSIYPeb>; Wed, 25 Sep 2002 11:34:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Mark_H_Johnson@raytheon.com, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] recognize MAP_LOCKED in mmap() call
Date: Wed, 25 Sep 2002 11:36:08 -0400
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, owner-linux-mm@kvack.org
References: <OFC0C42F8D.E1325D58-ON86256C38.00695CD8@hou.us.ray.com>
In-Reply-To: <OFC0C42F8D.E1325D58-ON86256C38.00695CD8@hou.us.ray.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209251136.08559.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 September 2002 03:18 pm, Mark_H_Johnson@raytheon.com wrote:
> Andrew Morton wrote:
> >(SuS really only anticipates that mmap needs to look at prior mlocks
> >in force against the address range.  It also says
> >
> >     Process memory locking does apply to shared memory regions,
> >
> >and we don't do that either.  I think we should; can't see why SuS
> >requires this.)
>
> Let me make sure I read what you said correctly. Does this mean that Linux
> 2.4 (or 2.5) kernels do not lock shared memory regions if a process uses
> mlockall?
>
> If not, that is *really bad* for our real time applications. We don't want
> to take a page fault while running some 80hz task, just because some
> non-real time application tried to use what little physical memory we allow
> for the kernel and all other applications.
>
> I asked a related question about a week ago on linux-mm and didn't get a
> response. Basically, I was concerned that top did not show RSS == Size when
> mlockall(MCL_CURRENT|MCL_FUTURE) was called. Could this explain the
> difference or is there something else that I'm missing here?
>
> Thanks.
> --Mark H Johnson
>   <mailto:Mark_H_Johnson@raytheon.com>


Sorry for the lengthy delay.
mlock() and mlockall() do the right thing..
however, mmap(MAP_LOCKED) should behave like a    mmap | mlock operation 
according to the manpages. This however was not implemented as the 
transformation from the mmap_flags to vm_flags never checked for MAP_LOCKED
but only for mm->def_flags which only covers a previous mlockall() call.

Hope this clarifies it .
-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
