Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbTBDIAR>; Tue, 4 Feb 2003 03:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbTBDIAR>; Tue, 4 Feb 2003 03:00:17 -0500
Received: from franka.aracnet.com ([216.99.193.44]:691 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267162AbTBDIAH>; Tue, 4 Feb 2003 03:00:07 -0500
Date: Tue, 04 Feb 2003 00:09:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.59-mm8
Message-ID: <167540000.1044346173@[10.10.2.4]>
In-Reply-To: <20030203233156.39be7770.akpm@digeo.com>
References: <20030203233156.39be7770.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm8/

Booted to login prompt, then immediately oopsed 
(16-way NUMA-Q, mm6 worked fine). At a wild guess, I'd suspect 
irq_balance stuff.

Unable to handle kernel NULL pointer dereference at virtual address 0000013c
 printing eip:
c01ed768
*pde = 2ecb7001
*pte = 00000000
Oops: 0002
CPU:    2
EIP:    0060:[<c01ed768>]    Not tainted
EFLAGS: 00010046
EIP is at isp1020_intr_handler+0x1f8/0x330
eax: 00000000   ebx: ef67f080   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000003   ebp: ef6c589c   esp: f0199efc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f0198000 task=f019cc40)
Stack: ef67f080 c02c7fe0 0360db40 f0199f40 00000003 ef6c5800 00000086
f0199f7c 
       00000013 c01ed556 00000013 ef6c5800 f0199f7c f01ef7e0 24000001
c010b7c5 
       00000013 ef6c5800 f0199f7c c02c3a60 00000260 00000013 f01ef7e0
c010b9bd 
Call Trace:
 [<c01ed556>] do_isp1020_intr_handler+0x36/0x50
 [<c010b7c5>] handle_IRQ_event+0x45/0x70
 [<c010b9bd>] do_IRQ+0x8d/0x100
 [<c0107080>] default_idle+0x0/0x50
 [<c0107080>] default_idle+0x0/0x50
 [<c010a070>] common_interrupt+0x18/0x20
 [<c0107080>] default_idle+0x0/0x50
 [<c0107080>] default_idle+0x0/0x50
 [<c01070aa>] default_idle+0x2a/0x50
 [<c010714a>] cpu_idle+0x3a/0x50
 [<c0120294>] printk+0x164/0x1a0

Code: 89 86 3c 01 00 00 e9 5b ff ff ff c7 44 24 08 40 00 00 00 8d 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

