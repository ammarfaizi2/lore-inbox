Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbUAaAYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUAaAYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:24:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21576 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263522AbUAaAY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:24:28 -0500
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       andrea <andrea@suse.de>, Joel Becker <Joel.Becker@oracle.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Jan 2004 17:17:13 -0700
In-Reply-To: <1075344395.1592.87.camel@cog.beaverton.ibm.com>
Message-ID: <m1ad45x986.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> writes:

> All,
>         This is my port of the x86-64 vsyscall gettimeofday code to
> i386. This patch moves gettimeofday into userspace, so it can be called
> without the syscall overhead, greatly improving performance. This is
> important for any application, like a database, which heavily uses
> gettimeofday for timestamping. It supports both the TSC and IBM x44X
> cyclone time source.

> 
> Example performance gain: (vs. int80)
> Normal gettimeofday 
> gettimeofday ( 1665576us / 1000000runs ) = 1.665574us
> vsyscall LD_PRELOAD gettimeofday
> gettimeofday ( 868378us / 1000000runs ) = 0.868377us

And what is the performance gain over using the kernel sysenter
implementation?

> This patch becomes especially important with the introduction of the
> 4G/4G split, as there the syscall overhead is greatly increased. 
> 
> Example gain w/ 4/4g split: (vs. int80)
> Normal gettimeofday 
> gettimeofday ( 7210630us / 1000000runs ) = 7.210623us
> vsyscall LD_PRELOAD gettimeofday
> gettimeofday ( 844855us / 1000000runs ) = 0.844854us

This is clear evidence that the 4g/4g kernel has significant overhead,
suggesting that a 64bit kernel should be used if you care about
syscall performance with gobs of RAM.

Eric
