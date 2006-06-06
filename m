Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750802AbWFFAvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWFFAvV (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 20:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWFFAvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 20:51:21 -0400
Received: from smtp-out.google.com ([216.239.45.12]:21241 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750802AbWFFAvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 20:51:20 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=pH8Cs0WYZwhSaIOrjhyUEvZUV4s16OVglixrdHNNYPiLxheGX9J1ymSxBrLp6URQT
	RnRn9LbihTy0/D+NGpW1w==
Message-ID: <4484D174.7080902@google.com>
Date: Mon, 05 Jun 2006 17:51:00 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://test.kernel.org/abat/34264/debug/console.log

Only seems to happen on the sparsemem runs. Possibly a side-effect
of the page migration stuff, manifesting itself differently?
Or maybe not?

Out of Memory: Kill process 1 (idle) score 0 and children.
divide error: 0000 [#1]
SMP
last sysfs file:
CPU:    0
EIP:    0060:[<c013be6a>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc5-mm2-autokern1 #1)
EIP is at shrink_active_list+0x5b/0x382
eax: 00000000   ebx: 00000064   ecx: 00000000   edx: 00000000
esi: c0474500   edi: c03a8e64   ebp: c03a8dbc   esp: c03a8d9c
ds: 007b   es: 007b   ss: 0068
Process idle (pid: 1, threadinfo=c03a8000 task=c0769000)
Stack: 00000000 00000000 00000020 00000004 c03a8dac c03a8dac c03a8db4 
c03a8db4
        c03a8dbc c03a8dbc c03a8dfc c0137a14 00000000 c0137a37 c03a8df8 
c03a8df4
        c0474000 00000000 00000000 c03a8e64 c0137c5a 00000000 00028028 
000dc0e0
Call Trace:
  <c0137a14> get_writeback_state+0x30/0x35  <c0137a37> 
get_dirty_limits+0x1e/0xc4
  <c0137c5a> throttle_vm_writeout+0x18/0x53  <c013c221> 
shrink_zone+0x90/0xc1
  <c013c29f> shrink_zones+0x4d/0x5e  <c013c39d> try_to_free_pages+0xed/0x1a8
  <c0136a91> __alloc_pages+0x16e/0x26a  <c014e6c9> kmem_getpages+0x5b/0xac
  <c014f42c> cache_grow+0xb5/0x147  <c014f655> 
cache_alloc_refill+0x197/0x1d3
  <c014fad0> kmem_cache_alloc+0x4f/0x5e  <c0276dd8> sk_alloc+0x15/0x63
  <c02bb9e0> inet_create+0xfb/0x21a  <c027546d> __sock_create+0xc0/0xea
  <c02754b0> sock_create_kern+0xb/0xe  <c03c413b> icmp_init+0x3a/0xc3
  <c03c445c> inet_init+0x12b/0x174  <c03aa7f6> do_initcalls+0x53/0xe4
  <c01320d8> register_irq_proc+0x6a/0x90  <c0180000> 
xlate_proc_name+0x87/0x90
  <c0100349> init+0x41/0xdc  <c0100308> init+0x0/0xdc
  <c01009d5> kernel_thread_helper+0x5/0xb
Code: 04 24 00 00 00 00 8d 44 24 10 89 44 24 10 89 44 24 14 83 79 10 00 
74 38 8b 8a bc 01 00 00 6b 47 04 64 bb 64 00 00 00 31 d2 d3 fb <f7> 35 
0c 6f 45 c0 ba 02 00 00 00 89 d1 99 f7 f9 01 d8 03 47 18
EIP: [<c013be6a>] shrink_active_list+0x5b/0x382 SS:ESP 0068:c03a8d9c
