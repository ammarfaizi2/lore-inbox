Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSJ1X27>; Mon, 28 Oct 2002 18:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSJ1X27>; Mon, 28 Oct 2002 18:28:59 -0500
Received: from dp.samba.org ([66.70.73.150]:3811 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261859AbSJ1X24>;
	Mon, 28 Oct 2002 18:28:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: colpatch@us.ibm.com
Cc: mochel@osdl.org, alan@lxorguk.ukuu.org.uk, davej@suse.de,
       mjbligh@us.ibm.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] DriverFS Topology + per-node (NUMA) meminfo 
In-reply-to: Your message of "Mon, 28 Oct 2002 10:58:50 -0800."
             <3DBD88EA.7000402@us.ibm.com> 
Date: Tue, 29 Oct 2002 10:24:52 +1100
Message-Id: <20021028233518.53C5E2C105@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DBD88EA.7000402@us.ibm.com> you write:
> Rusty Russell wrote:
> > On Mon, 21 Oct 2002 14:50:25 -0700
> > Matthew Dobson <colpatch@us.ibm.com> wrote:
> > 
> > 
> >>[ patch ]
> > 
> > 
> > This clashes with my "move cpu driverfs to generic code" patch.
> 
> Yes, yes it does.  It does a lot of similar things though.

Hey, great minds think alike 8)

> My patch does not take advantage of the DECLARE_PER_CPU macros, etc.

A minor optimization which can be done later.  The important bit is
not creating entries for cpus where !cpu_possible(cpu).

> But it also 
> offers node-topology info and per-node meminfo.  I'd like to see them 
> work together.  Most of the conflict is simply in where we put the 
> driverfs CPU code.  Your patch moves it (w/ additions) to kernel/cpu.c, 
> whereas mine moves it (also w/ different additions) to 
> drivers/base/cpu.c.  I think that the drivers/base is a bit more 
> appropriate for the driverfs specific code (struct device_driver 
> cpu_driver, the array of cpu_devices...).  Also, I made the registration 
> routines arch-specific, because I figured that different architectures 
> may want to add arch-specific info, and register devices at different 
> times, in different orders, etc.  I also didn't incorporate the 
> cpu_notifier stuff, which I should have.
> 
> What do you think of my patch (other than the obvious that it conflicts 
> with yours)?

If I'm reading correctly, you move the cpus under "node" dirs when
it's a NUMA system.  I can see the cute appeal, but it makes it harder
to answer "how many cpus do I have?": a program would need to do a
"find" which is kinda icky (also hard to write HOWTOs).  So I'd prefer
symlinks to the node, and no hierarchy.

driver/base/cpu.c should probably be moved into kernel/cpu.c anyway.

I think exposing the struct cpu array is a good idea, so archs can add
properties if they want (ie. node information).

But Patrick is the architect, I'm just a grunt, so it's his call 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
