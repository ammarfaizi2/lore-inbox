Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbWF0PiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWF0PiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWF0PiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:38:08 -0400
Received: from dvhart.com ([64.146.134.43]:36261 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1161110AbWF0PiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:38:07 -0400
Message-ID: <44A150C9.7020809@mbligh.org>
Date: Tue, 27 Jun 2006 08:37:45 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: "Martin J. Bligh" <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>, linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com> <449FF3A2.8010907@mbligh.org>
In-Reply-To: <449FF3A2.8010907@mbligh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Martin J. Bligh wrote:
> 
>> Panic on PPC64. I'm guessing it's the same as the i386 panics I sent
>> you yesterday, just more cryptic ;-) But for the record ...
>>
>> http://test.kernel.org/abat/37737/debug/console.log
>>
>> cpu 0x2: Vector: 300 (Data Access) at [c0000000f99f78c0]
>>     pc: c0000000000c6a34: .s_show+0x178/0x364
>>     lr: c0000000000c696c: .s_show+0xb0/0x364
>>     sp: c0000000f99f7b40
>>    msr: 8000000000001032
>>    dar: fd528000
>>  dsisr: 40000000
>>   current = 0xc0000000f23e0000
>>   paca    = 0xc00000000046e300
>>     pid   = 17653, comm = cp
>> enter ? for help
>>
> 
> Eeek, this is definitely an intermittent thing. I was trawling older
> results, and it shows up (on PPC only) in 2.6.17-git10, so it's not
> just an -mm thing ;-(

OK, still happens in -mm3, though in a different workload now. I also
get a new panic, that's maybe related but more informative



cpu 0x0: Vector: 700 (Program Check) at [c0000000024938b0]
     pc: c0000000000c3218: .free_block+0xe4/0x240
     lr: c0000000000c3514: .drain_array+0xf4/0x170
     sp: c000000002493b30
    msr: 8000000000021032
   current = 0xc0000000025457f0
   paca    = 0xc0000000004f9f00
     pid   = 14, comm = events/0
kernel BUG in list_del at include/linux/list.h:160!

Plus one with an actual backtrace from PPC64 that looks more like the
i386 ones

SMP NR_CPUS=32 NUMA
Modules linked in:
NIP: C0000000000A311C LR: C0000000000A30D4 CTR: C0000000000A3024
REGS: c0000007725b38d0 TRAP: 0300   Not tainted  (2.6.17-mm3-autokern1)
MSR: 8000000000001032 <ME,IR,DR>  CR: 28224424  XER: 00000000
DAR: 000000077BCC6180, DSISR: 0000000040000000
TASK = c00000002fc74670[29812] 'cp' THREAD: c0000007725b0000 CPU: 2
GPR00: 0000000000000000 C0000007725B3B50 C00000000063B828 C00000001E303EC0
GPR04: 0000000000000010 0000000000000000 0000000000000000 FFFFFFFFFFFFFFFD
GPR08: 0000000000000001 0000000000000000 000000077BCC6180 0000000000000000
GPR12: 0000000000000000 C00000000051FF80 0000000000000000 0000000000000001
GPR16: 0000000000000000 0000000000000004 0000000000020000 0000000000000000
GPR20: 0000000000000000 0000000000000000 C0000007759F9D00 0000000000000000
GPR24: 0000000000000E42 0000000000000000 000000000000474A C00000001E30F300
GPR28: 0000000000000000 0000000000000000 C000000000537288 C00000001E303E80
NIP [C0000000000A311C] .s_show+0xf8/0x364
LR [C0000000000A30D4] .s_show+0xb0/0x364
Call Trace:
[C0000007725B3B50] [C0000000000A3334] .s_show+0x310/0x364 (unreliable)
[C0000007725B3C20] [C0000000000D5E84] .seq_read+0x2f4/0x450
[C0000007725B3D00] [C0000000000AADF8] .vfs_read+0xe0/0x1b4
[C0000007725B3D90] [C0000000000AAFD4] .sys_read+0x54/0x98
[C0000007725B3E30] [C00000000000871C] syscall_exit+0x0/0x40
Instruction dump:
3b180001 7c004a78 79290020 7c0bfe70 7f5a4a14 7d600278 7c005850 54000ffe
7c094038 2c090000 41820008 ebbe80b0 <e96a0000> 2fab0000 419e0008 7c005a2c
