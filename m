Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSG3LVw>; Tue, 30 Jul 2002 07:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318228AbSG3LVw>; Tue, 30 Jul 2002 07:21:52 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:27032 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318223AbSG3LVv>; Tue, 30 Jul 2002 07:21:51 -0400
Date: Tue, 30 Jul 2002 16:55:48 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu
Message-ID: <20020730165548.A1992@in.ibm.com>
References: <20020726204033.D18570@in.ibm.com> <3D41990A.EDC1A530@zip.com.au> <20020729162730.A2393@in.ibm.com> <3D45880A.8C87A8E7@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D45880A.8C87A8E7@zip.com.au>; from akpm@zip.com.au on Mon, Jul 29, 2002 at 11:23:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 11:23:06AM -0700, Andrew Morton wrote:
> ...
> Well Rusty's point about just using the percpu API seemed
> reasonable - that's basically equivalent to statically defining
> the data.  In what situation is dynamic allocation needed?
> 

As Dipankar pointed out, counters part of dynamically allocated structures; 
Like:

1. k_atm_dev_stats in atm_dev -- they are all atomic_t types right now.
   we must see a major benefit with statctrs here.  
   I don't have access to  atm infrastructure to test it though :(((
2. Atomic counters like dst->__refcnt; we might be able to hack
   route cache so that the periodic garbage collector can tolerate
   stale reads on the refcnt.  A dst_entry might get gc'd late, nevertheless
   it would boost performance on networking loads. (I still  have to 
   investigate  if we can do it at all...). 

This is what I have in mind for now.  Of course, if these primitives
are available to all, programmers will have more flexibility in 
designing datastructures.  We can then afford to have  non atomic_t
global counters for debugging etc., anywhere in the kernel; modules/dynamic
structures...

Thanks,
Kiran
