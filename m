Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267201AbSLED2d>; Wed, 4 Dec 2002 22:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267202AbSLED2d>; Wed, 4 Dec 2002 22:28:33 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:53197 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267201AbSLED2c>;
	Wed, 4 Dec 2002 22:28:32 -0500
Date: Thu, 5 Dec 2002 09:12:17 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
Message-ID: <20021205091217.A11438@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DEE58CB.737259DB@digeo.com>; from akpm@digeo.com on Wed, Dec 04, 2002 at 11:34:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 11:34:35AM -0800, Andrew Morton wrote:
> > +/* Use these with kmalloc_percpu */
> > +#define get_cpu_ptr(ptr) per_cpu_ptr(ptr, get_cpu())
> > +#define put_cpu_ptr(ptr) put_cpu()
> 
> These names sound very much like get_cpu_var() and put_cpu_var(),
> yet they are using a quite different subsystem.  It would be good
> to choose something more distinct.  Not that I can think of anything
> at present ;)

Well, they are similar, aren't they ? get_cpu_ptr() can just be thought
of as the dynamic twin of get_cpu_var(). So, in that sense it seems ok
to me.

> 
> If we were to remove the percpu_interlaced_alloc() leg here, we'd
> have a nice, simple per-cpu kmalloc implementation.
> 
> Could you please explain what all the other code is there for?

The interlaced allocator allows you to save space when kmalloc_percpu()
is used to allocate small objects. That is done by interlacing each
CPU's copy of the objects just like the static per-cpu data area.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
