Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279556AbRLGMsE>; Fri, 7 Dec 2001 07:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278428AbRLGMry>; Fri, 7 Dec 2001 07:47:54 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:38904 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S279556AbRLGMrq>; Fri, 7 Dec 2001 07:47:46 -0500
Date: Fri, 7 Dec 2001 18:22:14 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@zip.com.au>, riel@conectiva.com.br, kiran@in.ibm.com,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011207182214.D15810@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20011205163153.E16315@in.ibm.com> <Pine.LNX.4.33L.0112051109340.4079-100000@imladris.surriel.com> <3C0E7ED9.1F0BD44E@zip.com.au> <20011206141826.16833acc.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206141826.16833acc.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Thu, Dec 06, 2001 at 02:18:26PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 02:18:26PM +1100, Rusty Russell wrote:
> On Wed, 05 Dec 2001 12:08:57 -0800
> Andrew Morton <akpm@zip.com.au> wrote:
> 
> > http://www.zipworld.com.au/~akpm/linux/2.4/2.4.7/
> 
> Oops, guess I should have read this thread first (still catching up on mail).
> 
> Please see my per-cpu patch (just posted under [PATCH] 2.5.1-pre5: per-cpu
> areas), and my previous /proc patch.  Combining the two into convenient form
> is left as an exercise for the reader...

Hi Rusty,

Your per-cpu area patch looks like a good solution with a very simple
implementation. BTW, some OSes map the per-cpu data areas
to the same virtual address for each CPU avoiding the per-cpu data
array lookup. I am not sure if this really saves much, we are ourselves
trying to understand the overhead of such array lookup with 
statctrs. 

IIUC, we can declare statically allocated per-cpu data using 
this allocator (kstat, apic_timer_irqs etc.). For things that
are a part of dynamically allocated structure, we would still
need to use a dynamic per-cpu allocator, right ?

Another interesting question is how we can load different
per-cpu sections to different areas in memory. I would suspect
that for NUMA, we would want to locate the per-cpu sections closest
to the corresponding CPUs.

I couldn't find the /proc patch. Any pointers ?

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
