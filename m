Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWHNVrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWHNVrR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWHNVrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:47:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964996AbWHNVrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:47:16 -0400
Date: Mon, 14 Aug 2006 14:46:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Ben Buxton <kernel@bb.cactii.net>,
       Maciej Rutecki <maciej.rutecki@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060814144652.f91997aa.akpm@osdl.org>
In-Reply-To: <20060814202004.GE16280@redhat.com>
References: <20060813012454.f1d52189.akpm@osdl.org>
	<44DF10DF.5070307@gmail.com>
	<20060813121126.b1dc22ee.akpm@osdl.org>
	<20060813224413.GA21959@cactii.net>
	<20060813232549.GG28540@redhat.com>
	<20060814115556.GA13159@cactii.net>
	<20060814202004.GE16280@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 16:20:04 -0400
Dave Jones <davej@redhat.com> wrote:

> On Mon, Aug 14, 2006 at 01:55:56PM +0200, Ben Buxton wrote:
>  
>  > > > Also, whenever I echo anything to "scaling_governor", I get the
>  > > > following kernel message:
>  > > > 
>  > > > [  734.156000] BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
>  > > > [  734.156000]  [<c013c3ec>] lock_cpu_hotplug+0x7c/0x90
>  > > > [  734.156000]  [<c01327f4>] __create_workqueue+0x44/0x140
>  > > > [  734.156000]  [<c02dcf7b>] mutex_lock+0xb/0x20
>  > > > [  734.156000]  [<e01f2665>] cpufreq_governor_dbs+0x2b5/0x310 [cpufreq_ondemand]
>  > > 
>  > > This makes no sense at all, because in -mm __create_workqueue doesn't
>  > > call lock_cpu_hotplug().
>  > > 
>  > > Are you sure this was from a tree with -mm1 applied ?
>  > 
>  > Definitely 2.6.18-rc4-mm1, and I've done a clean rebuild + removal of
>  > all modules under /lib/modules beforehand.
> 
> It's a real mystery.  Andrew ?
> 

I'm suspecting it's just stack gunk.  If Ben could send some more such
traces that'd clear things up.  Also, turning on CONFIG_UNWIND_INFO,
CONFIG_STACK_UNWIND and perhaps CONFIG_FRAME_POINTER might give us a
cleaner backtrace.

