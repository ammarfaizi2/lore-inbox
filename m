Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSEaIg7>; Fri, 31 May 2002 04:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315227AbSEaIg6>; Fri, 31 May 2002 04:36:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32756 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315218AbSEaIg6>;
	Fri, 31 May 2002 04:36:58 -0400
Date: Fri, 31 May 2002 14:10:30 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: "'Mala Anand'" <manand@us.ibm.com>, linux-kernel@vger.kernel.org,
        "'Paul McKenney'" <Paul.McKenney@us.ibm.com>,
        "'Rusty Russell'" <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: [RFC] Dynamic percpu data allocator
Message-ID: <20020531141030.A6933@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020530232513.C3575@in.ibm.com> <00eb01c20878$d952b890$290806c0@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 01:27:44PM +0530, BALBIR SINGH wrote:
> |
> |
> |   CPU #0          CPU#1
> |
> | ---------       ---------         Start of cache line
> |   *ctrp1         *ctrp1
> |   *ctrp2         *ctrp2
> |
> |   .               .
> |   .               .
> |   .               .
> |   .               .
> |   .               .
> |
> | ---------       ----------        End of cache line
> 
> 
> Won't this result in a lot of false sharing, if any of the CPUs
> tried to access any of the counters, the entire cache line would be
> moved from the current CPU to that CPU. Isn't this a very bad thing or
> am I missing something? Do all your counters fit into one cache line.

Yes it could result in false sharing. You could probably avoid
that by imposing classes of allocation - say STRICLY_LOCAL and
ALMOST_LOCAL, so that strictly local objects are not penalized
by occasionally non-local objects. If your code frequently accesses 
other CPU's copy of the object than you should not be using this 
per-cpu allocator in the first place, it would be meaningless.

> 
> For sometime now, I have been thinking of implementing/supporting
> PME's (Peformance Monitoring Events and Counters), so that we can
> get real values (atleast on x86) as compared to our guesses about
> cacheline bouncing, etc. Do you know if somebody is already doing
> this?

You can use SGI kernprof to measure PMCs. See the SGI oss
website for details. You can count L2_LINES_IN event to
get a measure of cache line bouncing.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
