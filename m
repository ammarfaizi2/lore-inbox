Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbSJVSnc>; Tue, 22 Oct 2002 14:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264917AbSJVSnc>; Tue, 22 Oct 2002 14:43:32 -0400
Received: from packet.digeo.com ([12.110.80.53]:60351 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264910AbSJVSnJ>;
	Tue, 22 Oct 2002 14:43:09 -0400
Message-ID: <3DB59DA7.453F89E2@digeo.com>
Date: Tue, 22 Oct 2002 11:49:11 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
CC: Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
References: <Pine.LNX.4.44L.0210221514430.1648-100000@duckman.distro.conectiva> <145460000.1035311809@baldur.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2002 18:49:11.0228 (UTC) FILETIME=[B5B7F7C0:01C279FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote:
> 
> --On Tuesday, October 22, 2002 15:15:29 -0200 Rik van Riel
> <riel@conectiva.com.br> wrote:
> 
> >> Or large pages.  I confess to being a little perplexed as to
> >> why we're pursuing both.
> >
> > I guess that's due to two things.
> >
> > 1) shared pagetables can speed up fork()+exec() somewhat
> >
> > 2) if we have two options that fix the Oracle problem,
> >    there's a better chance of getting at least one of
> >    the two merged ;)
> 
> And
>   3) The current large page implementation is only for applications
>      that want anonymous *non-pageable* shared memory.  Shared page
>      tables reduce resource usage for any shared area that's mapped
>      at a common address and is large enough to span entire pte pages.
>      Since all pte pages are shared on a COW basis at fork time, children
>      will continue to share all large read-only areas with their
>      parent, eg large executables.
> 

How important is that in practice?

Seems that large pages are the preferred solution to the "Oracle
and DB2 use gobs of pagetable" problem because large pages also
reduce tlb reload traffic.

So once that's out of the picture, what real-world, observed,
customers-are-hurting problem is solved by pagetable sharing?
