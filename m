Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUAaCZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 21:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbUAaCZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 21:25:08 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63933 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263695AbUAaCZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 21:25:03 -0500
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
From: john stultz <johnstul@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       andrea <andrea@suse.de>, Joel Becker <Joel.Becker@oracle.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <m1ad45x986.fsf@ebiederm.dsl.xmission.com>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com>
	 <m1ad45x986.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Message-Id: <1075515631.2492.11.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 30 Jan 2004 18:20:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-30 at 16:17, Eric W. Biederman wrote:
> john stultz <johnstul@us.ibm.com> writes:
> 
> > All,
> >         This is my port of the x86-64 vsyscall gettimeofday code to
> > i386. This patch moves gettimeofday into userspace, so it can be called
> > without the syscall overhead, greatly improving performance. This is
> > important for any application, like a database, which heavily uses
> > gettimeofday for timestamping. It supports both the TSC and IBM x44X
> > cyclone time source.
> 
> > 
> > Example performance gain: (vs. int80)
> > Normal gettimeofday 
> > gettimeofday ( 1665576us / 1000000runs ) = 1.665574us
> > vsyscall LD_PRELOAD gettimeofday
> > gettimeofday ( 868378us / 1000000runs ) = 0.868377us
> 
> And what is the performance gain over using the kernel sysenter
> implementation?

Sorry, I hadn't gotten around to upgrading the glibc on my dev box. 

Here's the sysenter comparison:

Normal gettimeofday
gettimeofday ( 1239215us / 1000000runs ) = 1.239214us
vsyscall LD_PRELOAD gettimeofday
gettimeofday ( 805117us / 1000000runs ) = 0.805116us


It should be noted that all the numbers I've posted so far are using the
cyclone timesource. Here's the test running using the TSC timesource
(sysenter as well):

Normal gettimeofday
gettimeofday ( 586046us / 1000000runs ) = 0.586045us
vsyscall LD_PRELOAD gettimeofday
gettimeofday ( 179972us / 1000000runs ) = 0.179972us


thanks
-john

