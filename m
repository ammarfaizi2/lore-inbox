Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUGRUtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUGRUtS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 16:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGRUtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 16:49:18 -0400
Received: from fmr04.intel.com ([143.183.121.6]:18396 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264501AbUGRUtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 16:49:16 -0400
Date: Sun, 18 Jul 2004 13:45:59 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sched domains bringup race?
Message-ID: <20040718134559.A25488@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <1089944026.32312.47.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1089944026.32312.47.camel@nighthawk>; from haveblue@us.ibm.com on Thu, Jul 15, 2004 at 07:13:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 07:13:46PM -0700, Dave Hansen wrote:
> I keep getting oopses for the non-boot CPU in find_busiest_group(). 
> This occurs the first time that the CPU goes idle.  Those groups are set
> up in sched_init_smp(), which is called after smp_init():
> 
> static int init(void * unused)
> {
> 	...
>         fixup_cpu_present_map();
>         smp_init();
>         sched_init_smp();
> 
> But, the idle threads for the secondary CPUs are initialized in
> smp_init().  So, what happens when a CPU tries to schedule (using sched
> domains) before sched_init_smp() completes?  I think it goes boom! :)
> 
> Anyway, I was thinking that we should just hold the runqueue lock on the
> non-boot CPUs until the sched domain init code is done.  Does that sound
> feasible?

Even on my system which is Intel 865 chipset (P4 with HT enabled system) 
I see a bug check somewhere in the schedular_tick during boot.
However if I move the sched_init_smp() after do_basic_setup() the
kernel boots without any problem. Any clue here?

 static int init(void * unused)
 {
 	...
         fixup_cpu_present_map();
         smp_init();
	 populate_rootfs();
	 do_basic_setup();
 
         sched_init_smp();
-Anil
