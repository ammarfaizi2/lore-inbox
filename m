Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264879AbSJVTDb>; Tue, 22 Oct 2002 15:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbSJVTDa>; Tue, 22 Oct 2002 15:03:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:58553 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264879AbSJVTCh>; Tue, 22 Oct 2002 15:02:37 -0400
Date: Tue, 22 Oct 2002 12:02:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <407130000.1035313347@flay>
In-Reply-To: <Pine.LNX.3.96.1021022135649.7820C-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021022135649.7820C-100000@gatekeeper.tmr.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Actually, per-object reverse mappings are nowhere near as good
>> > a solution as shared page tables.  At least, not from the points
>> > of view of space consumption and the overhead of tearing down
>> > the mappings at pageout time.
>> > 
>> > Per-object reverse mappings are better for fork+exec+exit speed,
>> > though.
>> > 
>> > It's a tradeoff: do we care more for a linear speedup of fork(),
>> > exec() and exit() than we care about a possibly exponential
>> > slowdown of the pageout code ?
> 
> That tradeoff makes the case for spt being a kbuild or /proc/sys option. A
> linear speedup of fork/exec/exit is likely to be more generally useful,
> most people just don't have huge shared areas. On the other hand, those
> who do would get a vast improvement, and that would put Linux a major step
> forward in the server competition.
>  
>> As long as the box doesn't fall flat on it's face in a jibbering
>> heap, that's the first order of priority ... ie I don't care much
>> for now ;-)
> 
> I'm just trying to decide what this might do for a news server with
> hundreds of readers mmap()ing a GB history file. Benchmarks show the 2.5
> has more latency the 2.4, and this is likely to make that more obvious.
> 
> Is there any way to to have this only on processes which really need it?
> define that any way you wish, including hanging a capability on the
> executable to get spt.

Uh, what are you referring to here? Large pages or shared pagetables?
You can't mmap filebacked stuff with larged pages (nixed by Linus).
And yes, large pages have to be specified explicitly by the app.
On the other hand, I don't think shared pagetables have an mmap hook,
though that'd be easy enough to add. And if you're not reading the whole 
history file, presumably the PTEs will only be sparsely instantiated anyway.

M.

