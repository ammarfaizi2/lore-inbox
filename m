Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbSJ2DlW>; Mon, 28 Oct 2002 22:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSJ2DlW>; Mon, 28 Oct 2002 22:41:22 -0500
Received: from dp.samba.org ([66.70.73.150]:62100 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261526AbSJ2DlV>;
	Mon, 28 Oct 2002 22:41:21 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: colpatch@us.ibm.com
Cc: mochel@osdl.org, alan@lxorguk.ukuu.org.uk, davej@suse.de,
       mjbligh@us.ibm.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] DriverFS Topology + per-node (NUMA) meminfo 
In-reply-to: Your message of "Mon, 28 Oct 2002 17:08:00 -0800."
             <3DBDDF70.9050609@us.ibm.com> 
Date: Tue, 29 Oct 2002 14:09:47 +1100
Message-Id: <20021029034743.811402C39F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DBDDF70.9050609@us.ibm.com> you write:
> Rusty Russell wrote:
> > In message <3DBD88EA.7000402@us.ibm.com> you write:
> > 
> >>Rusty Russell wrote:
> >>
> >>>On Mon, 21 Oct 2002 14:50:25 -0700
> >>>Matthew Dobson <colpatch@us.ibm.com> wrote:
> >>>
> >>>This clashes with my "move cpu driverfs to generic code" patch.
> >>
> >>Yes, yes it does.  It does a lot of similar things though.
> > 
> > Hey, great minds think alike 8)
> 
> Indeed!
> 
> 
> >>My patch does not take advantage of the DECLARE_PER_CPU macros, etc.
> > 
> > A minor optimization which can be done later.  The important bit is
> > not creating entries for cpus where !cpu_possible(cpu).
> 
> Very true.  I only instantiate entries for cpus that are online at the 
> time of the initcall.  With the cpu callback stuff that you had in your 
> patch, we can easily instantiate cpus that (magically? ;) come on line 
> at a later point.

I think you really want them there all the time.  Otherwise it's hard
to use the entried to bring them online 8)

It's easy: just don't entry i if "cpu_possible(i)" is false.

> Well, in either (NUMA/non-NUMA) case, there are symlinks to the CPUs 
> under class/cpu/devices:
> [root@elm3b79 devices]# ls -al class/cpu/devices/
> total 0
> drwxr-xr-x    2 root     root            0 Oct 25 07:59 .
> drwxr-xr-x    4 root     root            0 Oct 25 07:59 ..
> lrwxrwxrwx    1 root     root           22 Oct 25 07:59 0 -> 
> ../../../root/sys/cpu0

Cool, I missed that.  As long as they're somewhere, I'm happy.

> > driver/base/cpu.c should probably be moved into kernel/cpu.c anyway.
> 
> What about driver/base/node.c & memblk.c?  My thoughts were to maintain 
> a separation between driverfs-only and other in-core code.

OK, I'll come to the mountain then. 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
