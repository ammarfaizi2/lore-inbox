Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266107AbTIKAP0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTIKAP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:15:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:40631 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266107AbTIKAPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:15:14 -0400
Message-Id: <200309110014.h8B0EsC22469@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Nick Piggin <piggin@cyberone.com.au>
cc: Cliff White <cliffw@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Steven Pratt <slpratt@austin.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms 
In-Reply-To: Message from Nick Piggin <piggin@cyberone.com.au> 
   of "Wed, 10 Sep 2003 12:12:39 +1000." <3F5E8897.7040302@cyberone.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Sep 2003 17:14:54 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> Cliff White wrote:
> 
> >> Nick Piggin wrote:
> >>
> >
> >>Con Kolivas wrote:
> >>
> >>
> >
> >>Hi Con,
> >>Any chance you could give this
> >>http://www.kerneltrap.org/~npiggin/v14/sched-rollup-nopolicy-v14.gz
> >>a try? It should apply against test5.
> >>
> >>
> >>
> >I have some STP tests scheduled against this also (PLM 2117) 
> >Please let me know if you want other combinations tested - am just catching up 
> >on
> >this thread.
> >cliffw
> >
> 
> Thanks Cliff that would be cool. If you could test  this: 
> http://www.kerneltrap.org/~npiggin/v14/sched-rollup-v14.gz
> as well would be good. The previous one is more important though.
> 
sched-rollup-v14 runs good on 2-cpu w/reaim (more in next email):
example:
http://khack.osdl.org/stp/279657/

Has oops on 4-cpu when running the dbt2-1tier database test(below):
Two runs, different oops.
Let me know how much more detail you need. 
Both machines are Intel PIII x ~800mhz w/ 1GB RAM/cpu
Diffs between the 2 and 4 way would include. :
- different SCSI controllers 
- database uses raw IO
kernel .config files should be the same for both, other
than SCSI.
cliffw

 
----------------------------
Sep 10 15:44:30 stp4-000 kernel:  sdo: sdo1
Unable to handle kernel paging request at virtual address 4d7a7153
 printing eip:
c011c1f9
*pde = 0e81a067
*pte = 00000000
Oops: 0002 [#1]
CPU:    3
EIP:    0060:[<c011c1f9>]    Not tainted
EFLAGS: 00010003
EIP is at load_balance+0x2a9/0x4d0
eax: de9c4998   ebx: c366a518   ecx: 4d7a7153   edx: c3672100
esi: c366a518   edi: c366a4f8   ebp: c3e8df64   esp: c3e8df30
ds: 007b   es: 007b   ss: 0068
Process kernel (pid: 4246, threadinfo=c3e8c000 task=f7b9b300)
Stack: c3669bc0 c366a104 c3669bc0 c366a518 c366a100 00000000 00000003 00000080
       0000000f 00000002 c3e8c000 c3671bc0 0000000f c3e8df88 c011c486 c3671bc0
       00000000 0000000f 00000000 00000001 00000000 c0412084 c3e8dfc4 c012a6a5
Call Trace:
 [<c011c486>] rebalance_tick+0x66/0xa0
 [<c012a6a5>] update_process_times+0x45/0x60
 [<c0117961>] smp_apic_timer_interrupt+0x141/0x150
 [<c010a0ca>] apic_timer_interrupt+0x1a/0x20

Code: 89 19 89 4b 04 8b 47 18 0f ab 42 04 ff 02 89 57 28 8b 5d 08
----------
second 4-cpu run, same test
--------
nable to handle kernel paging request at virtual address 20190078
 printing eip:
c011c9c4
*pde = 00000000
Oops: 0002 [#1]
CPU:    1
EIP:    0060:[<c011c9c4>]    Not tainted
EFLAGS: 00010002
EIP is at schedule+0x224/0x5d0
eax: 00000001   ebx: cacfd940   ecx: 00000001   edx: 20190000
esi: de984460   edi: f73a8e00   ebp: caed3c28   esp: caed3be8
ds: 007b   es: 007b   ss: 0068
Process awk (pid: 9673, threadinfo=caed2000 task=cacfd940)
Stack: de984460 840e6b72 00000003 d1bf3120 c3661bc0 c3661020 00000001 bfffa000
       c11c03e0 00000007 f73a8e00 c3661590 003fe5d0 caed2000 0324ef80 f7983dc0
       caed3c34 c011cda6 e8912660 00000001 c0150ed4 c3661034 00000000 00000000
Call Trace:
 [<c011cda6>] preempt_schedule+0x36/0x50
 [<c0150ed4>] exit_mmap+0x1e4/0x240
 [<c011f6a0>] mmput+0x70/0xc0
 [<c0169bad>] exec_mmap+0x11d/0x210
 [<c0169e03>] flush_old_exec+0x163/0xa10
 [<c0169a80>] kernel_read+0x50/0x60
 [<c018c2cc>] load_elf_binary+0x2dc/0xbc0
 [<c011a148>] pgd_alloc+0x18/0x20
 [<c011f59d>] mm_init+0xbd/0x100
 [<c0169533>] copy_strings+0x213/0x290
 [<c018bff0>] load_elf_binary+0x0/0xbc0
 [<c016aa41>] search_binary_handler+0xa1/0x210
 [<c016adc4>] do_execve+0x214/0x250
 [<c0107c80>] sys_execve+0x50/0x80
 [<c0109689>] sysenter_past_esp+0x52/0x71

Code: f0 0f ab 42 78 8b 42 10 05 00 00 00 40 0f 22 d8 8b 8a 9c 00

_______________________________________________

cliffw
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


