Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTEQDTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 23:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbTEQDTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 23:19:39 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:46865 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id S261180AbTEQDTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 23:19:38 -0400
Message-ID: <3EC5AD4A.B6C18A1C@compuserve.com>
Date: Fri, 16 May 2003 23:32:26 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.69 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>, akpm@digeo.com
CC: kernel <linux-kernel@vger.kernel.org>
Subject: DAC960 breakage, 2.5 bk current
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The change that went into 2.5.69 for DAC960 seems to break it here.

(http://marc.theaimsgroup.com/?l=linux-kernel&m=105209603501299&w=2)

I backed out the last two changesets in DAC960.c, and the driver runs
again.  Backing out only:
 ChangeSet 1.1132 2003/05/15 09:01:05 akpm@digeo.com
  [PATCH] DAC960 typedef cleanup patch

Did not resolve the panic, however backing out:
ChangeSet 1.1042.94.9 2003/04/30 07:31:56 akpm@digeo.com
  [PATCH] DAC960 patch to entry points with a new fix

Seems to resolve the problem.

The problem was, (copied by hand, please let me know if I've omitted a
critical field.):

kernel NULL pointer deref - virt 00000019
Oops: 0000 [#1]
CPU: 0
EIP: 0060:[<c02774d3>]  Not tainted
EFLAGS: 00010286
EIP is at DAC960_ioctl+0x33/0x190

Process swapper (pid: 1, ...)

Call Trace:
] blkdev_ioctl+0xa5/0x466
] ioctl_by_dev+0x41/0x50
] isofs_get_last_session+0xb4/0xe0
] set_blocksize+
] sb_set_blocksize+
] isofs_fill_super+
] sb_set_blocksize+
] get_sb_bdev+
] isofs_get_sb+
] isofs_fill_super+
] do_kern_mount+
] do_add_mount+
] do_mount+
] copy_mount_options+
] sys_mount+
] do_mount_root+
] mount_block_root+
] mount_root+
] prepare_namespace+
] init_workqueues+
] init+0x5f/0x200
] init+0x0/0x200
] kernel_thread_helper+0x5/0x10

Code: f6 43 19 08 0f 85 33 01 00 00 81 ff 01 03 00 00 74 12 ba ea
 <0>kernel panic: Attempted to kill init!


This is on a SuSE 8.1, dual Athlon MP system, gcc 3.2, binutils
2.12.90.0.15-40.  Please let me know if additional detail is helpful.

-- 
Kevin
