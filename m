Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUDKJuN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 05:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbUDKJuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 05:50:13 -0400
Received: from mail-06.iinet.net.au ([203.59.3.38]:44233 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262193AbUDKJuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 05:50:07 -0400
Message-ID: <40791475.7040300@cyberone.com.au>
Date: Sun, 11 Apr 2004 19:48:37 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduler problems on shutdown
References: <1516092704.1081534916@[10.10.2.4]> <71390000.1081611090@[10.10.2.4]>
In-Reply-To: <71390000.1081611090@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>I get this on shutdown (after "Power Off" ironically).
>>2.6.5-rc3-mjb2.
>>
>>Badness in find_busiest_group at kernel/sched.c:1425
>>Call Trace:
>> [<c0117c84>] find_busiest_group+0x64/0x22c
>> [<c0118091>] load_balance_newidle+0x21/0x6c
>> [<c0118c77>] schedule+0x273/0x644
>> [<c011e9c5>] exit_notify+0x609/0x64c
>> [<c011ed22>] do_exit+0x31a/0x32c
>> [<c0128c7a>] sys_reboot+0x1f2/0x2f8
>> [<c0116f50>] wake_up_state+0xc/0x10
>> [<c0125c37>] kill_proc_info+0x37/0x4c
>> [<c0125d30>] kill_something_info+0xe4/0xec
>> [<c01279e8>] sys_kill+0x54/0x5c
>> [<c014caa3>] filp_open+0x3b/0x5c
>> [<c014ce79>] sys_open+0x59/0x74
>> [<c01075f9>] error_code+0x2d/0x38
>> [<c0106b8f>] syscall_call+0x7/0xb
>>
>>Look familar?
>>
>
>Dunno why the numbers are different, but it's now 1738 in 2.6.5-mjb1 ... 
>I wouldn't have thought we'd inserted that much since then. anyway, it's
>this:
>
>                /* Tally up the load of all CPUs in the group */
>                cpus_and(tmp, group->cpumask, cpu_online_map);
>                WARN_ON(cpus_empty(tmp));
>
>in find_busiest_group. Which makes sense I guess, but is very ugly.
>
>

I think the WARN_ON can go. You have to make sure the for_each_cpu
loop doesn't get to run it though. It shouldn't be in the latest -mm
kernels, is it?

It is normal to have an entire group offline with CPU hotplug.


