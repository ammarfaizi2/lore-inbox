Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWJFAC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWJFAC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 20:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWJFAC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 20:02:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:24239 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932472AbWJFAC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 20:02:56 -0400
Message-ID: <45259D2E.3000002@us.ibm.com>
Date: Thu, 05 Oct 2006 17:02:54 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: kmannth@us.ibm.com
CC: Andi Kleen <ak@suse.de>, mel gorman <mel@csn.ul.ie>,
       Vivek goyal <vgoyal@in.ibm.com>, Steve Fox <drfickle@us.ibm.com>,
       Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-mm2 boot failure on x86-64 II
References: <20060928014623.ccc9b885.akpm@osdl.org>	 <200610060114.03466.ak@suse.de> <1160091179.5664.17.camel@keithlap>	 <200610060135.56134.ak@suse.de> <1160092711.5664.19.camel@keithlap>
In-Reply-To: <1160092711.5664.19.camel@keithlap>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

keith mannthey wrote:
> On Fri, 2006-10-06 at 01:35 +0200, Andi Kleen wrote:
>   
>>> As of yet I haven't been able to recreate the hang.  I am running
>>> similar HW to Steve. 
>>>       
>
> I ran into this with -mm3
>
> Memory: 24150368k/26738688k available (1933k kernel code, 490260k
> reserved, 978k data, 308k init)
> ------------[ cut here ]------------
> kernel BUG in init_list at mm/slab.c:1334!
> invalid opcode: 0000 [1] SMP
> last sysfs file:
> CPU 0
> Modules linked in:
> Pid: 0, comm: swapper Not tainted 2.6.18-mm3-smp #1
> RIP: 0010:[<ffffffff8027f8fa>]  [<ffffffff8027f8fa>] init_list+0x1d/0xfd
> RSP: 0018:ffffffff80577f48  EFLAGS: 00010212
> RAX: 0000000000000040 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffff805ba848 RDI: ffff810460700040
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000003
> R10: 0000000000000000 R11: ffffffff805bc268 R12: ffff810460700040
> R13: ffffffff805ba848 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff804d8000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006a0
> Process swapper (pid: 0, threadinfo ffffffff80576000, task
> ffffffff80455840)
> Stack:  0000000000000000 0000000000000000 0000000100000000
> 0000000000000001
>  ffffffff805ba848 0000000000000000 0000000000000000 ffffffff80593aa8
>  00000000000002c0 0000000100000001 000000000008ef00 000000000008c000
> Call Trace:
>  [<ffffffff80593aa8>] kmem_cache_init+0x344/0x406
>  [<ffffffff805805ef>] start_kernel+0x180/0x21b
>  [<ffffffff8058016a>] _sinittext+0x16a/0x16e
>
>
> Code: 0f 0b 48 8b 3d 15 ab 1e 00 be d0 00 00 00 e8 c0 f5 ff ff 48
> RIP  [<ffffffff8027f8fa>] init_list+0x1d/0xfd
>  RSP <ffffffff80577f48>
>  <0>Kernel panic - not syncing: Attempted to kill the idle task!
>
>
> I am going to revert the patch and see if it works.  I ran -git22 just
> fine. 
>
> Thanks,
>   Keith 
>
>   
Keith,

I fixed this already. Can you look for it on lkml (look for 2.6.18-mm3 
in the subject line).
one typo in mm/slab.c

Thanks,
Badari

