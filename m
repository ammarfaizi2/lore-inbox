Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUBHOiG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 09:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUBHOiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 09:38:06 -0500
Received: from [220.249.10.10] ([220.249.10.10]:56986 "EHLO
	mail.goldenhope.com.cn") by vger.kernel.org with ESMTP
	id S263646AbUBHOhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 09:37:53 -0500
Date: Sun, 8 Feb 2004 22:37:40 +0800
From: lepton <lepton@sina.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG]linux-2.4.24 with k8 numa support panic when init scsi
Message-ID: <20040208143740.GA25010@lepton.goldenhope.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
	I've found if I enable k8-numa support in my dual amd64 boxes.
	It will panic when init scsi.
	Further investigation leads out it panics in

	drivers/scsi/scsi_dma.c

	when it  __get_free_pages(GFP_ATOMIC | GFP_DMA, 0) in two
places.
	Sometimes it will panic before found scsi disk (in scsi_init_minimal_dma_pool)

	Sometimes it will panic after found scsi disk (in scsi_resize_dma_pool)
	

	The following is my output of panic.

	If you'd like any other information,I will provide as you
reguest.

scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Unable to handle kernel NULL pointer dereference<1> at 0000000000000180
RIP: [<ffffffff80145ce0>]PML4 0
Oops: 0000
CPU 1
Pid: 1, comm: swapper Not tainted
RIP: 0010:[<ffffffff80145ce0>]
RSP: 0000:000001007ffe3da8  EFLAGS: 00010012
RAX: 0000000000000000 RBX: 0000010080000000 RCX: 0000000000000021
RDX: 0000010080000548 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00000100fbf2b800 R11: 0000000000000800 R12: 0000000000000021
R13: 0000010080000000 R14: 0000000000000082 R15: 0000000000000021
FS:  0000000000000000(0000) GS:ffffffff803da800(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000180 CR3: 000000007ffed000 CR4: 00000000000006e0
Process swapper (pid: 1, stackpage=1007ffe3000)
Stack: 000001007ffe3da8 0000000000000000 000000000000000f
0000000000000000
       0000010080000548 000001007fffec80 0000010080000000
0000000000000000
       0000000000000021 0000010080000000 0000000000000082
00000100fbf2f618
Call Trace: [<ffffffff801493bd>] [<ffffffff80145f7d>]
       [<ffffffff8024f6ae>] [<ffffffff80244ed0>] [<ffffffff8010c122>]
       [<ffffffff8010f1f0>] [<ffffffff8010c0c0>] [<ffffffff8010f1e8>]


Code: 48 2b 80 80 01 00 00 48 c1 f8 03 41 89 c6 41 89 f4 48 89 d3
RIP [<ffffffff80145ce0>] RSP <000001007ffe3da8>
CR2: 0000000000000180
 <0>Kernel panic: Attempted to kill init!
