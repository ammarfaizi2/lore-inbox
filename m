Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSJVTCZ>; Tue, 22 Oct 2002 15:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264879AbSJVTCZ>; Tue, 22 Oct 2002 15:02:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63911 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264878AbSJVTCX>;
	Tue, 22 Oct 2002 15:02:23 -0400
To: Andrew Morton <akpm@digeo.com>
cc: Dave McCracken <dmccr@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch 
In-reply-to: Your message of Tue, 22 Oct 2002 11:49:11 PDT.
             <3DB59DA7.453F89E2@digeo.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8135.1035313589.1@us.ibm.com>
Date: Tue, 22 Oct 2002 12:06:29 -0700
Message-Id: <E1844MH-00027H-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DB59DA7.453F89E2@digeo.com>, > : Andrew Morton writes:
> Dave McCracken wrote:
> > 
> > And
> >   3) The current large page implementation is only for applications
> >      that want anonymous *non-pageable* shared memory.  Shared page
> >      tables reduce resource usage for any shared area that's mapped
> >      at a common address and is large enough to span entire pte pages.
> >      Since all pte pages are shared on a COW basis at fork time, children
> >      will continue to share all large read-only areas with their
> >      parent, eg large executables.
> > 
> 
> How important is that in practice?
> 
> Seems that large pages are the preferred solution to the "Oracle
> and DB2 use gobs of pagetable" problem because large pages also
> reduce tlb reload traffic.
> 
> So once that's out of the picture, what real-world, observed,
> customers-are-hurting problem is solved by pagetable sharing?

If the shared pte patch had mmap support, then all shared libraries
would benefit.  Might need to align them to 4 MB boundaries for best
results, which would also be easy for libraries with unspecified
attach addresses (e.g. most shared libraries).

gerrit
