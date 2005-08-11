Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVHKAvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVHKAvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbVHKAvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:51:03 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35297 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030194AbVHKAvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:51:02 -0400
Date: Thu, 11 Aug 2005 02:51:00 +0200
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Mike Waychison <mikew@google.com>,
       YhLu <YhLu@tyan.com>, Peter Buckingham <peter@pantasys.com>,
       linux-kernel@vger.kernel.org, "discuss@x86-64.org" <discuss@x86-64.org>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Message-ID: <20050811005100.GF8974@wotan.suse.de>
References: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB> <42FA8A4B.4090408@google.com> <20050810232614.GC27628@wotan.suse.de> <86802c4405081016421db9baa5@mail.gmail.com> <20050811000430.GD8974@wotan.suse.de> <86802c4405081017174c22dcd5@mail.gmail.com> <86802c440508101723d4aadef@mail.gmail.com> <20050811002841.GE8974@wotan.suse.de> <86802c440508101743783588df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440508101743783588df@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 05:43:23PM -0700, yhlu wrote:
> Yes, I mean more aggressive
> 
> static void __init smp_init(void)
> {
>         unsigned int i;
> 
>         /* FIXME: This should be done in userspace --RR */
>         for_each_present_cpu(i) {
>                 if (num_online_cpus() >= max_cpus)
>                         break;
>                 if (!cpu_online(i))
>                         cpu_up(i);
>         }
> 
> 
> let cpu_up take one array instead of one int.

It can be done already by just not starting the CPUs and
then do it multithreaded from user space using sysfs with
the CPU hotplug infrastructure. Unfortunately cpu_up
right now has a global semaphore, so it won't save you any
time. However it could be done in parallel with other 
startup jobs.

-Andi
