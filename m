Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264810AbSJVSDd>; Tue, 22 Oct 2002 14:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264816AbSJVSC5>; Tue, 22 Oct 2002 14:02:57 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24072 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264800AbSJVSCH>; Tue, 22 Oct 2002 14:02:07 -0400
Date: Tue, 22 Oct 2002 14:06:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
In-Reply-To: <2666588581.1035278080@[10.10.2.3]>
Message-ID: <Pine.LNX.3.96.1021022135649.7820C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Martin J. Bligh wrote:

> > Actually, per-object reverse mappings are nowhere near as good
> > a solution as shared page tables.  At least, not from the points
> > of view of space consumption and the overhead of tearing down
> > the mappings at pageout time.
> > 
> > Per-object reverse mappings are better for fork+exec+exit speed,
> > though.
> > 
> > It's a tradeoff: do we care more for a linear speedup of fork(),
> > exec() and exit() than we care about a possibly exponential
> > slowdown of the pageout code ?

That tradeoff makes the case for spt being a kbuild or /proc/sys option. A
linear speedup of fork/exec/exit is likely to be more generally useful,
most people just don't have huge shared areas. On the other hand, those
who do would get a vast improvement, and that would put Linux a major step
forward in the server competition.
 
> As long as the box doesn't fall flat on it's face in a jibbering
> heap, that's the first order of priority ... ie I don't care much
> for now ;-)

I'm just trying to decide what this might do for a news server with
hundreds of readers mmap()ing a GB history file. Benchmarks show the 2.5
has more latency the 2.4, and this is likely to make that more obvious.

Is there any way to to have this only on processes which really need it?
define that any way you wish, including hanging a capability on the
executable to get spt.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

