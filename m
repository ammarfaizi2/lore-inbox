Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSG2SnO>; Mon, 29 Jul 2002 14:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSG2SnO>; Mon, 29 Jul 2002 14:43:14 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:55982 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317624AbSG2SnN>; Mon, 29 Jul 2002 14:43:13 -0400
Date: Tue, 30 Jul 2002 00:20:31 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>, riel@conectiva.com.br,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: [RFC] Scalable statistics counters using kmalloc_percpu
Message-ID: <20020730002031.A14892@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020726204033.D18570@in.ibm.com> <3D41990A.EDC1A530@zip.com.au> <20020729162730.A2393@in.ibm.com> <3D45880A.8C87A8E7@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D45880A.8C87A8E7@zip.com.au>; from akpm@zip.com.au on Mon, Jul 29, 2002 at 11:23:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 11:23:06AM -0700, Andrew Morton wrote:
> Ravikiran G Thirumalai wrote:
> > 
> > ...
> > 
> > > General comment:  we need to clean up the kernel_stat stuff.  We
> > > cannot just make it per-cpu because it is 32k in size already.  I
> > > would suggest that we should break out the disk accounting and
> > > make the rest of kernel_stat per CPU.
> > >
> > > That would be a great application of your interface, and a good
> > > way to get your interface merged ;)  Is that something which you
> > > have time to do?
> > 
> > Sure,... anything to get these interfaces merged :)
> 
> Well Rusty's point about just using the percpu API seemed
> reasonable - that's basically equivalent to statically defining
> the data.  In what situation is dynamic allocation needed?
> 
> Well, in modules for one.  Unless we work out a way to make the
> percpu API work with storage which is defined within modules.

Apart from modules, I can see two advantages -

1. static per_cpu data has to be allocated based on NR_CPUS because
of the current offset calculations. kmalloc_percpu() needs to allocate only
for cpu_possible() cpus.

2. If the statistics is a part of a dynamically allocated structure.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
