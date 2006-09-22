Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWIVCVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWIVCVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWIVCVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:21:17 -0400
Received: from mxsf30.cluster1.charter.net ([209.225.28.230]:5026 "EHLO
	mxsf30.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932208AbWIVCVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:21:16 -0400
Message-ID: <451347EB.9090101@cybsft.com>
Date: Thu, 21 Sep 2006 21:18:19 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
References: <20060920141907.GA30765@elte.hu> <45118EEC.2080700@cybsft.com>	 <20060920194958.GA24691@elte.hu>  <4511A57D.9070500@cybsft.com>	 <1158784863.5724.1027.camel@localhost.localdomain>	 <4511A98A.4080908@cybsft.com> <1158866166.12028.9.camel@localhost.localdomain>
In-Reply-To: <1158866166.12028.9.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2006-09-20 at 15:50 -0500, K.R. Foley wrote:
>> Thomas Gleixner wrote:
>>> On Wed, 2006-09-20 at 15:33 -0500, K.R. Foley wrote:
>>>> DOH! The log had two different boots in it. :( Let's try this again. By
>>>> the way, you may notice from my screw up that this is pretty much the
>>>> same oops that I got with 2.6.17-rt*. I have been getting this on all of
>>>> my SMP systems since we went past 2.6.16.
>>> Which module is modprobed ?
>>>
>>> 	tglx
>>>
>>>
>>>
>> How can I tell which particular module is being loaded? The last thing I
>> see on the console before the oops is that it is starting udev. I am
>> including the rest of the boot log below in hopes that will help.
>> Suggestions? Something else I can provide?
>>
> [snip]
>> kjournald starting.  Commit interval 5 seconds
>> EXT3-fs: mounted filesystem with ordered data mode.
>> BUG: unable to handle kernel paging request at virtual address f3010000
>>  printing eip:
>> *pde = 00000000
>> Oops: 0000 [#1]
>> PREEMPT SMP
>> Modules linked in:
>> CPU:    1
>> EIP:    0060:[<c0131e02>]    Not tainted VLI
>> EFLAGS: 00010283   (2.6.18-rt2 #4)
>> EIP is at lookup_symbol+0x11/0x35
>> eax: 00000001   ebx: e0830e08   ecx: c036ff60   edx: c036dd94
>> esi: f3010000   edi: e0830e08   ebp: df657e74   esp: df657e68
>> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
>> Process modprobe (pid: 1366, ti=df656000 task=dfc68e90 task.ti=df656000)
>> Stack: e083c780 00000c00 e0830e08 df657e90 c0131e6f df657ea8 df657ea4
>> e083c780
>>        00000c00 e0830e08 df657eb8 c0132c21 00000001 00000012 e082d074
>> 00000000
>>        df657ecc e083a434 00000c00 e082d074 df657edc c0133188 e083c780
>> 00000000
>> Call Trace:
>>  [<c01037a1>] show_stack_log_lvl+0x87/0x8f
>>  [<c010391b>] show_registers+0x12f/0x198
>>  [<c0103b0c>] die+0x114/0x1c6
>>  [<c0111196>] do_page_fault+0x3f2/0x4c8
>>  [<c0103481>] error_code+0x39/0x40
>>  [<c0131e6f>] __find_symbol+0x25/0x2a5
>>  [<c0132c21>] resolve_symbol+0x27/0x5f
>>  [<c0133188>] simplify_symbols+0x83/0xf3
>>  [<c0133e65>] load_module+0x720/0xbb8
>>  [<c013435f>] sys_init_module+0x3f/0x1b5
>>  [<c0102969>] sysenter_past_esp+0x56/0x79
>> Code: eb 11 8b 75 f0 41 83 c2 28 0f b7 46 30 39 c1 72 c9 31 c0 5a 59 5b
>> 5e 5f 5d c3 55 89 e5 57 56 53 89 c3 39 ca 73 22 8b 72 04 89 df <ac> ae
>> 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 04 89
>> EIP: [<c0131e02>] lookup_symbol+0x11/0x35 SS:ESP 0068:df657e68
>>
> 
> 
> I'm seeing a similar issue. Although the log is a bit futzed. Maybe its
> the sd_mod?
> 
>  at virtual address 75010000le kernel paging requestproc filesystem
> 
>  printing eip:
> 
> Creating /dev
> c01372d5
> Starting udev
> L*pde = cccccccc
> oading sd_mod.kostopped custom tracer.
>  module
> Oops: 0000 [#1]
> PREEMPT SMP
> Modules linked in:
> CPU:    3
> EIP:    0060:[<c01372d5>]    Not tainted VLI
> EFLAGS: 00010293   (2.6.18-rt3johnsmp #1)
> EIP is at lookup_symbol+0x15/0x37
> eax: ffffffff   ebx: f88209a0   ecx: c03916fc   edx: c038eba0
> esi: 75010000   edi: f881a405   ebp: c7d01ea4   esp: c7d01e64
> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
> Process insmod (pid: 462, ti=c7d00000 task=f7d6c1f0 task.ti=c7d00000)
> Stack: f8821e00 f881a405 c0137345 f881a405 c038c658 c03916fc f88209a0 f8821e00
>        f881a405 00000000 c0138145 f881a405 c7d01ea0 c7d01ea4 00000001 00000000
>        f881a405 f88209a0 00000500 0000003c c01386d2 f88193d0 0000000b f881a405
> Call Trace:
>  [<c0137345>] __find_symbol+0x26/0x2e0
>  [<c0138145>] resolve_symbol+0x23/0x5f
>  [<c01386d2>] simplify_symbols+0x7e/0xf0
>  [<c013942d>] load_module+0x7c4/0xc14
>  [<c01398dd>] sys_init_module+0x3d/0x1ae
>  [<c01029d9>] sysenter_past_esp+0x56/0x79
> Code: c8 eb 0e 0f b7 45 30 41 83 c2 28 39 c1 72 ca 31 c0 5b 5e 5f 5d c3 57 56 8b 4c 24 14 8b 54 24 10 39 ca 73 24 8b 72 04 8b 7c 24 0c <ac> ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 04 89
> EIP: [<c01372d5>] lookup_symbol+0x15/0x37 SS:ESP 0068:c7d01e64
>  ERROR: /bin/insmod exited abnormally! (pid 462)
> Loading jbd.ko module
> 
> 
> thanks
> -john
> 

Yes. This looks very much like the problem I am having. However, on the
system that this log came from I have no SCSI.

-- 
	kr
