Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268105AbUJDMrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268105AbUJDMrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268126AbUJDMrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:47:35 -0400
Received: from [217.222.53.238] ([217.222.53.238]:17572 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S268105AbUJDMr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:47:29 -0400
Message-ID: <4161462A.5040806@gts.it>
Date: Mon, 04 Oct 2004 14:46:34 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
References: <20041004020207.4f168876.akpm@osdl.org>
In-Reply-To: <20041004020207.4f168876.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/
> 
> 
> - Hopefully those x86 compile errors are fixed up.
> 
> - Various fairly minor updates

(#ifdef around is_irq_stack_ptr already applied)

Kernel BUGs at boot time, here is what I see (copied by hand, I hope 
Stack and Code hex values are not that important :)):

[...]
IP: routing cache hash table of 4096 buckets, 32KBytes
kmem_cache_create: Early error in slab ip_fib_hash
-----[ cut here ] -----
kernel BUG at mm/slab.c:1185!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in:
CPU:	0
EIP:	0060:[<c01348f6>]	Not tainted VLI
EFLAGS: 00010282 (2.6.9-rc3-mm2)
EIP is at kmem_cache_create+0x51d/0x53e
eax: 00000036  ebx: 00000000  ecx: c02b7f04  edx: 00001d9f
esi: 00000000  edi: 000000ff  ebp: c15fe3c0  esp: dff83f30
ds: 007b    es: 007b    ss: 0068
Process swapper: (pid: 1, threadinfo=dff82000 task=dff815f0)
Stack: (stripped, hope you don't need this :)
Call trace:
  [<>] fib_hash_init+0xd8/0xe2
  [<>] ip_fib_init+0xa/0x32
  [<>] ip_rt_init+0x1cc/0x2e3
  [<>] ip_init+0xf/0x14
  [<>] inet_init+0xd0/0x1b3
  [<>] do_initcalls+0x27/0xad
  [<>] init+0x0/0xf8
  [<>] init+0x0/0xf8
  [<>] init+0x2a/0xf8
  [<>] kernel_thread_helper+0x0/0xb
  [<>] kernel_thread_helper+0x5/0xb

Bye.

-- 
Stefano RIVOIR

