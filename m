Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSCEV5d>; Tue, 5 Mar 2002 16:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288050AbSCEV5Y>; Tue, 5 Mar 2002 16:57:24 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:28848 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288736AbSCEV5P>; Tue, 5 Mar 2002 16:57:15 -0500
Date: Tue, 05 Mar 2002 13:57:09 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Kip Walker <kwalker@broadcom.com>, linux-kernel@vger.kernel.org
cc: linux-mips@sgi.com
Subject: Re: init_idle reaped before final call
Message-ID: <292270000.1015365429@flay>
In-Reply-To: <3C8522EA.2A00E880@broadcom.com>
In-Reply-To: <3C8522EA.2A00E880@broadcom.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm working with a (approximately) 2.4.17 kernel from the mips-linux
> tree (oss.sgi.com).
> 
> I'd like to propose removing the "__init" designation from init_idle in
> kernel/sched.c, since this is called from rest_init via cpu_idle. 
> Notice that rest_init isn't in an init section, and explicitly mentions
> that it's avoiding a race with free_initmem.  In my kernel (an SMP
> kernel running on a system with only 1 available CPU), cpu_idle isn't
> getting called until after free_initmem().
> 
> My CPU is MIPS, but it looks like x86 could experience the same problem.

I fixed something in this area for x86, looks like the same code path
for MIPS unless I'm misreading.

smp_init spins waiting on wait_init_idle until every cpu has done
init_idle. rest_init() isn't called until smp_init returns, so I'm not sure
how you could hit this (possibly there's a minute window after init_idle
clears the bit, but before it returns?).

M.

