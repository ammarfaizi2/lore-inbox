Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262595AbTCPIZl>; Sun, 16 Mar 2003 03:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262598AbTCPIZl>; Sun, 16 Mar 2003 03:25:41 -0500
Received: from holomorphy.com ([66.224.33.161]:17877 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262595AbTCPIZk>;
	Sun, 16 Mar 2003 03:25:40 -0500
Date: Sun, 16 Mar 2003 00:36:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1
Message-ID: <20030316083609.GE20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <20030311042457.GL465@holomorphy.com> <15821.1047800370@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15821.1047800370@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003 20:24:57 -0800, William Lee Irwin III wrote:
>> Enable NUMA-Q's to run with more than 32 cpus by introducing a bitmap
>> ADT and using it for cpu bitmasks on i386. Only good for up to 60 cpus;
>> 64x requires support for node-local cluster ID to physical node routes.
>> diff -urpN linux-2.5.64/arch/i386/kernel/cpu/proc.c cpu-2.5.64-1/arch/i386/kernel/cpu/proc.c
>> -	if (!(cpu_online_map & (1<<n)))
>> +	if (!cpu_isset(n, cpu_online_map))

On Sun, Mar 16, 2003 at 06:39:30PM +1100, Keith Owens wrote:
> 	if (!cpu_online(n))
> Any main line code that explicitly refers to cpu_online_map is an
> ongoing maintenance problem.  Nothing should refer to cpu_online_map
> except the encapsulating macros such as cpu_online().

That was a bit too braindead of a translation, yes. But it is x86 arch
code so it shouldn't be that large of an issue for big MIPS boxen etc.
I'll search & replace for stuff of this kind and wipe it out anyway.

This suggests a "cpumask strategy". Care to share more, like your take
on such things as
	p = req->task;
	cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
	rq_dest = cpu_rq(cpu_dest);
in kernel/sched.c?

-- wli
