Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbSLEKjX>; Thu, 5 Dec 2002 05:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbSLEKjX>; Thu, 5 Dec 2002 05:39:23 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:17865 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267267AbSLEKjW>; Thu, 5 Dec 2002 05:39:22 -0500
Date: Thu, 5 Dec 2002 16:23:29 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
Message-ID: <20021205162329.A12588@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com> <3DEED6FA.B179FAFD@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DEED6FA.B179FAFD@digeo.com>; from akpm@digeo.com on Wed, Dec 04, 2002 at 08:32:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Dec 04, 2002 at 08:32:58PM -0800, Andrew Morton wrote:
> Where in the kernel is such a large number of 4-, 8- or 16-byte
> objects being used?

Well, kernel objects may not be that small, but one would expect
the per-cpu parts of the kernel objects to be sometimes small, often down to
a couple of counters counting statistics.

> 
> The slab allocator will support caches right down to 1024 x 4-byte
> objects per page.  Why is that not appropriate?

Well, if you allocated 4-byte objects directly from the slab allocator,
you aren't guranteed to *not* share a cache line with another object
modified by a different cpu.

> 
> Sorry, but you have what is basically a brand new allocator in
> there, and we need a very good reason for including it.  I'd like
> to know what that reason is, please.

The reason is concern about per-cpu allocation for small per-CPU
parts (typically counters) of objects. If a driver has two counters
counting reads and writes, you don't want to eat up a whole cacheline
for them for each CPU per instance of the device.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
