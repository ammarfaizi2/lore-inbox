Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVHHW7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVHHW7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVHHW7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:59:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:9375 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932341AbVHHW7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:59:02 -0400
Date: Mon, 8 Aug 2005 23:33:41 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: Fw: two 2.6.13-rc3-mm3 oddities
Message-ID: <20050808180341.GB6153@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050803095644.78b58cb4.akpm@osdl.org> <20050808140536.GC4558@in.ibm.com> <42F788F8.1000001@colorfullife.com> <20050808164636.GA6153@in.ibm.com> <20050808102559.131bf839.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808102559.131bf839.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 10:25:59AM -0700, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> >
> > > But: IIRC the counters were moved to the ctor/dtor for performance 
> > > reasons, I'd guess mbligh ran into cache line trashing on the 
> > > filp_count_lock spinlock with reaim or something like that.
> > 
> > Ah, so the whole idea was to inc/dec nr_files less often so
> > that we reduce contention on filp_count_lock, right ? This however
> > causes skews nr_files by the size of the slab array, AFAICS.
> > Since we check nr_files before we allocate files from slab, the
> > check seems inaccurate.
> > 
> > Anyway, I guess, I need to look at scaling the file counting
> > first.
> 
> Something like vm_acct_memory() or percpu_counter would suit.

Yes, that is what I am doing, except that because of the sysctl 
stuff, I now have to wallow myself in /proc code.

Thanks
Dipankar
