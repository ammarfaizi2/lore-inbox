Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754734AbWKIFLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbWKIFLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 00:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754735AbWKIFLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 00:11:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55783 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1754734AbWKIFLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 00:11:14 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: tim.c.chen@linux.intel.com
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc5: known regressions
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
	<m1y7qm425l.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0611080745150.3667@g5.osdl.org>
	<20061108162202.GA4729@stusta.de>
	<1163027494.10806.229.camel@localhost.localdomain>
	<1163040581.10806.266.camel@localhost.localdomain>
Date: Wed, 08 Nov 2006 22:10:33 -0700
In-Reply-To: <1163040581.10806.266.camel@localhost.localdomain> (Tim Chen's
	message of "Wed, 08 Nov 2006 18:49:41 -0800")
Message-ID: <m1u01919yu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Chen <tim.c.chen@linux.intel.com> writes:

> On Wed, 2006-11-08 at 15:11 -0800, Tim Chen wrote:
>> On Wed, 2006-11-08 at 17:22 +0100, Adrian Bunk wrote:
>> 
>> With CONFIG_NR_CPUS increased from 8 to 64:
>> 2.6.18     see no change in fork time measured.
CONFIG_NR_CPUS has no affect on NR_IRQS in 2.6.18.
So this test unfortunately told us nothing.

>> 2.6.19-rc5 see a 138% increase in fork time.
>> 
>
> Lmbench is broken in its fork time measurement.
> It includes overhead time when it is pinning processes onto
> specific cpu. The actual fork time is not affected by NR_IRQS.
>
> Lmbench calls the following C library function to determine the 
> number of processors online before it pin the processes: 
> 	sysconf(_SC_NPROCESSORS_ONLN);
>
> This function takes the same order of time to run as
> fork itself.  In addition, runtime of this function 
> increases with NR_IRQS.  This resulted in the change in
> time measured.
>
> After hardcoding the number of online processors in lmbench,
> the fork time measured now does not change with CONFIG_NR_CPUS
> for both 2.6.18 and 2.6.19-rc5.  So we can now conclude that
> NR_IRQS does not affect fork.  We can remove this particular
> issue from the known regression.

Cool.  I'm glad to know it was simply a buggy lmbench.

What is sysconf(_SN_NPROCESSORS_ONLN) doing that it slows down as the
number of irqs increase?  It is a slow path certainly but possibly
something we should fix.  My hunch is cat /proc/cpuinfo...

Eric
