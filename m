Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316600AbSGLQDH>; Fri, 12 Jul 2002 12:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSGLQDG>; Fri, 12 Jul 2002 12:03:06 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:57579 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316600AbSGLQDF>; Fri, 12 Jul 2002 12:03:05 -0400
Date: Fri, 12 Jul 2002 21:40:08 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC] dcache scalability patch (2.4.17)
Message-ID: <20020712214008.A22916@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020712193935.B13618@in.ibm.com> <Pine.GSO.4.21.0207121021430.11261-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0207121021430.11261-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Jul 12, 2002 at 10:29:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 10:29:53AM -0400, Alexander Viro wrote:
> On Fri, 12 Jul 2002, Maneesh Soni wrote:
> 
> > Here is the dcache scalability patch (cleaned up) as disscussed in 
> > the previous post to lkml by Dipankar. The patch uses RCU for doing fast
> > dcache lookup. It also does lazy updates to lru list of dentries to
> > avoid doing write operations while doing lookup.
> 
> Where is
> 	* version for 2.5.<current>
> 	* analysis of benefits in real-world situations for 2.5 version?

I know that 2.5 patches are available, but Maneesh will probably
respond to this on Monday.

I am working on getting 2.5 measurements done. BTW, would you consider
specweb99 reasonably real-world ? If not, do you have any suggestions 
for benchmarks ? I suspect that dbench wouldn't cut it ;-).

> 
> Patch adds complexity and unless you can show that it gives significant
> benefits outside of pathological situations, it's not going in.

Fair enough.

> 
> Note: measurements on 2.4 do not make sense; reduction of cacheline
> bouncing between 2.4 and 2.5 will change the results anyway and

Quite possible. Our performance measurements have been far
behind and we are catching up now. You may expect 2.5 numbers soon.

> if any of these patches are going to be applied to 2.4, reduction of
> cacheline bouncing on ->d_count is going to go in before that one.

That is an issue we need to work on. We can do some cache event
profiling to understand the extent of the d_count cacheline bouncing.
At the same time, it seems that the dcache_lock cacheline is also
bouncing around and it is probably more shared than the dentries 
for / or /usr. One thing for sure - RCU based lookup of dcache
makes it difficult to optimize on dget()s. We will have to figure
out a way to do this.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
