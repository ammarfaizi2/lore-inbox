Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbTK0ClT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 21:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTK0ClT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 21:41:19 -0500
Received: from mgr1.xmission.com ([198.60.22.201]:15304 "EHLO
	mgr1.xmission.com") by vger.kernel.org with ESMTP id S264428AbTK0ClQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 21:41:16 -0500
Date: Wed, 26 Nov 2003 19:41:39 -0700
From: Eric Jensen <ej@xmission.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.0-test10 BUG/panic in mpage_end_io_read
Message-ID: <20031126194139.C22441@xmission.xmission.com>
References: <20031126174726.B22441@xmission.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031126174726.B22441@xmission.xmission.com>; from ej@xmission.com on Wed, Nov 26, 2003 at 05:47:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It just happened again in 2.6.0-test11.  :(

The trace has a slightly different code path:

---------------------------------- BUG ------------------------------------
kernel BUG at mm/filemap.c:332!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0130f4a>]    Not tainted
EFLAGS: 00010246
EIP is at unlock_page+0x1a/0x40
eax: 00000000   ebx: c1298060   ecx: 00000017   edx: c1500400
esi: c1501204   edi: 00000001   ebp: 00000003   esp: dfcc1f0c
ds: 007b   es: 007b   ss: 0068
Process md0_raid5 (pid: 17, threadinfo=dfcc0000 task=dfcdd2d0)
Stack: dffd2784 dffd49c0 c016201e dffd49c0 c16d0ba8 ffffffff c16d0ba8 c02a3195
       dffd49c0 00000000 00000000 c16d0ba8 dfd20b00 dff7ae00 dfd20b08 dfdee6b0
       dfcc1f70 c0119247 dff7ae74 00000000 00000002 00000001 00000004 ffffffff
Call Trace:
 [<c016201e>] mpage_end_io_read+0x5e/0x80
 [<c02a3195>] handle_stripe+0x9e5/0xb30
 [<c0119247>] recalc_task_prio+0x147/0x160
 [<c02a363c>] raid5d+0xec/0x110
 [<c02a9d19>] md_thread+0xf9/0x140
 [<c02a9c20>] md_thread+0x0/0x140
 [<c0119ea0>] default_wake_function+0x0/0x20
 [<c010725d>] kernel_thread_helper+0x5/0x18

Code: 0f 0b 4c 01 79 87 30 c0 8d 46 04 39 46 04 74 0e 31 c9 ba 03
-------------------------------- END BUG ----------------------------------

