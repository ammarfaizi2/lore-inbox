Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbSIRTtL>; Wed, 18 Sep 2002 15:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbSIRTtL>; Wed, 18 Sep 2002 15:49:11 -0400
Received: from packet.digeo.com ([12.110.80.53]:37623 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267613AbSIRTtK>;
	Wed, 18 Sep 2002 15:49:10 -0400
Message-ID: <3D88D9DE.2FB9A23D@digeo.com>
Date: Wed, 18 Sep 2002 12:54:06 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark_H_Johnson@raytheon.com
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, owner-linux-mm@kvack.org
Subject: Re: [PATCH] recognize MAP_LOCKED in mmap() call
References: <OFC0C42F8D.E1325D58-ON86256C38.00695CD8@hou.us.ray.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Sep 2002 19:54:05.0979 (UTC) FILETIME=[25204EB0:01C25F4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark_H_Johnson@raytheon.com wrote:
> 
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

Linux does lock these regions.  SuS seems to imply that we shouldn't.
But we should.

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

That mlockall should have faulted everything in.  It could be an
accounting bug, or it could be a bug.  That's not an aspect which
gets tested a lot.  I'll take a look.
