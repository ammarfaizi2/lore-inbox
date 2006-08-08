Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWHHVh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWHHVh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWHHVh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:37:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30877 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965039AbWHHVh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:37:58 -0400
Date: Tue, 8 Aug 2006 14:37:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Andi Kleen" <ak@muc.de>,
       "Jan Beulich" <jbeulich@novell.com>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Message-Id: <20060808143751.42f8d87c.akpm@osdl.org>
In-Reply-To: <6bffcb0e0608081419p4430b5cei7b4aa990cd0d4422@mail.gmail.com>
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
	<6bffcb0e0608081329r732e191dsec0f391ea70f7d28@mail.gmail.com>
	<20060808140511.def9b13c.akpm@osdl.org>
	<6bffcb0e0608081419p4430b5cei7b4aa990cd0d4422@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 23:19:09 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> >  You
> > can look these things up in gdb or using addr2line, provided you have
> > CONFIG_DEBUG_INFO=y.
> >
> >
> 
> (gdb) list *0xc047d609
> 0xc047d609 is in start_kernel (/usr/src/linux-work1/init/main.c:577).
> 572             cpuset_init_early();
> 573             mem_init();
> 574             kmem_cache_init();
> 575             setup_per_cpu_pageset();
> 576             numa_policy_init();
> 577             if (late_time_init)
> 578                     late_time_init();
> 579             calibrate_delay();
> 580             pidmap_init();
> 581             pgtable_cache_init();

hm.

- Try to get the full oops record, find out what the faulting address is
  ("unable to handle kernel paging request at virtual address xxxx") and
  see if that lines up with any symbol in .vmlinux.

- Might be something bad in numa_policy_init().  I assume you don't have
  CONFIG_NUMA=y ;)


This'll be hard to diagnose without a full oops trace.
