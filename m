Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVG1PDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVG1PDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVG1PBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:01:40 -0400
Received: from dvhart.com ([64.146.134.43]:698 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261494AbVG1PBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:01:19 -0400
Date: Thu, 28 Jul 2005 08:01:17 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2
Message-ID: <93600000.1122562877@[10.10.2.4]>
In-Reply-To: <20050727024330.78ee32c2.akpm@osdl.org>
References: <20050727024330.78ee32c2.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Seems to have some odd problem on PPC64 - crashes on boot.
Seems to affect power 4 boxes, both LPAR and bare metal.

raid5: using function: 32regs (4524.000 MB/sec)
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
oprofile: using ppc64/power4 performance monitoring.
NET: Registered protocol family 2
IP route cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Badness in nr_blockdev_pages at fs/block_dev.c:399
Call Trace:
[c0000003fffafbd0] [000000000000000a] -- 0:

that's all I get. full log is here:
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/9278/debug/console.log

Oooh, this one has more info:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/9276/debug/console.log

Something networky? Tail end is here:


raid5: using function: 32regs (5452.000 MB/sec)
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
oprofile: using ppc64/power4 performance monitoring.
NET: Registered protocol family 2
IP route cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Badness in nr_blockdev_pages at fs/block_dev.c:399
Call Trace:
[c00000003ffd3bd0] [000000000000000a] 0xa (unreliable)
[c00000003ffd3c50] [c000000000079ec8] .si_meminfo+0x40/0x7c
[c00000003ffd3ce0] [c0000000004fc0e8] .inet_initpeers+0x24/0x114
[c00000003ffd3de0] [c0000000004fc1f0] .ip_init+0x18/0x34
[c00000003ffd3e60] [c0000000004fcba4] .inet_init+0x14c/0x4a8
[c00000003ffd3f00] [c00000000000c378] .init+0x1e4/0x408
[c00000003ffd3f90] [c000000000013210] .kernel_thread+0x4c/0x68
kmem_cache_create: Early error in slab inet_peer_cache
kernel BUG in kmem_cache_create at mm/slab.c:1516!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=32 NUMA PSERIES LPAR 
Modules linked in:
NIP: C000000000081E80 XER: 00000000 LR: C000000000081E7C CTR: 00000000000D0274
REGS: c00000003ffd3970 TRAP: 0700   Not tainted  (2.6.13-rc3-mm2-autokern1)
MSR: 8000000000029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 CR: 24004022
DAR: 0000000000000280 DSISR: c00000003ffd3b40
TASK: c00000000418d7e0[1] 'swapper' THREAD: c00000003ffd0000 CPU: 1
GPR00: C000000000081E7C C00000003FFD3BF0 C000000000647D10 000000000000003D 
GPR04: 8000000000009032 FFFFFFFFFFFFFFFF 5F63616368650D0A C000000000567E28 
GPR08: 0000000000000000 C00000000056A590 C000000000650C30 C000000000650B50 
GPR12: 00000000000D0274 C000000000551800 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000230000 0000000000000000 0000000003A10000 C0000000004A4D58 
GPR24: 0000000000002000 C000000000646208 C00000000052AC18 0000000000008000 
GPR28: 0000000000000020 0000000000000000 C000000000576C88 0000000000000040 
NIP [c000000000081e80] .kmem_cache_create+0xd4/0x8a8
LR [c000000000081e7c] .kmem_cache_create+0xd0/0x8a8
Call Trace:
[c00000003ffd3bf0] [c000000000081e7c] .kmem_cache_create+0xd0/0x8a8 (unreliable)
[c00000003ffd3ce0] [c0000000004fc154] .inet_initpeers+0x90/0x114
[c00000003ffd3de0] [c0000000004fc1f0] .ip_init+0x18/0x34
[c00000003ffd3e60] [c0000000004fcba4] .inet_init+0x14c/0x4a8
[c00000003ffd3f00] [c00000000000c378] .init+0x1e4/0x408
[c00000003ffd3f90] [c000000000013210] .kernel_thread+0x4c/0x68
Instruction dump:
3128ffff 7c094110 21670000 7d2b3914 7c0b4838 2c0b0000 4182001c e87e8168 
e89e8170 7ee5bb78 4bfc7461 60000000 <0fe00000> 7b006fe3 41820008 0b150000 
 <0>Kernel panic - not syncing: Fatal exception in interrupt
