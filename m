Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265692AbUGPDEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUGPDEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 23:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUGPDED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 23:04:03 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:45923 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265692AbUGPDEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 23:04:01 -0400
Message-ID: <40F74599.7000606@yahoo.com.au>
Date: Fri, 16 Jul 2004 13:03:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sched domains bringup race?
References: <1089944026.32312.47.camel@nighthawk>
In-Reply-To: <1089944026.32312.47.camel@nighthawk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
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

It shouldn't because sched_init sets up dummy domains for
all runqueues.

Obviously something is going wrong somewhere though.
