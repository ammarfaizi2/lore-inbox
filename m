Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUDJPbl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 11:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUDJPbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 11:31:41 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:34256 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262050AbUDJPbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 11:31:39 -0400
Date: Sat, 10 Apr 2004 08:31:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduler problems on shutdown
Message-ID: <71390000.1081611090@[10.10.2.4]>
In-Reply-To: <1516092704.1081534916@[10.10.2.4]>
References: <1516092704.1081534916@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get this on shutdown (after "Power Off" ironically).
> 2.6.5-rc3-mjb2.
> 
> Badness in find_busiest_group at kernel/sched.c:1425
> Call Trace:
>  [<c0117c84>] find_busiest_group+0x64/0x22c
>  [<c0118091>] load_balance_newidle+0x21/0x6c
>  [<c0118c77>] schedule+0x273/0x644
>  [<c011e9c5>] exit_notify+0x609/0x64c
>  [<c011ed22>] do_exit+0x31a/0x32c
>  [<c0128c7a>] sys_reboot+0x1f2/0x2f8
>  [<c0116f50>] wake_up_state+0xc/0x10
>  [<c0125c37>] kill_proc_info+0x37/0x4c
>  [<c0125d30>] kill_something_info+0xe4/0xec
>  [<c01279e8>] sys_kill+0x54/0x5c
>  [<c014caa3>] filp_open+0x3b/0x5c
>  [<c014ce79>] sys_open+0x59/0x74
>  [<c01075f9>] error_code+0x2d/0x38
>  [<c0106b8f>] syscall_call+0x7/0xb
> 
> Look familar?

Dunno why the numbers are different, but it's now 1738 in 2.6.5-mjb1 ... 
I wouldn't have thought we'd inserted that much since then. anyway, it's
this:

                /* Tally up the load of all CPUs in the group */
                cpus_and(tmp, group->cpumask, cpu_online_map);
                WARN_ON(cpus_empty(tmp));

in find_busiest_group. Which makes sense I guess, but is very ugly.

M.

