Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTIYSog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTIYSo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:44:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:25321 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261827AbTIYSn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:43:59 -0400
Date: Thu, 25 Sep 2003 11:44:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: ext3 panic on test4 running dbench
Message-Id: <20030925114404.4e30a8d4.akpm@osdl.org>
In-Reply-To: <20610000.1064504990@flay>
References: <20610000.1064504990@flay>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> maybe this is fixed already ... but:

No.

> Sep 24 02:26:14 elm3b67 kernel: invalid operand: 0000 [#1]
> Sep 24 02:26:14 elm3b67 kernel: CPU:    11
> Sep 24 02:26:14 elm3b67 kernel: EIP:    0060:[_end+404081921/1069412752]    Not tainted
> Sep 24 02:26:14 elm3b67 kernel: EFLAGS: 00010206
> Sep 24 02:26:14 elm3b67 kernel: EIP is at 0xd857bb71

Your EIP looks like it is in modules space.

> Sep 24 02:26:14 elm3b67 kernel: eax: 00038815   ebx: 00000002   ecx: cbe4ab20   edx: 00000011
> Sep 24 02:26:14 elm3b67 kernel: esi: 00000000   edi: d82c6690   ebp: d4ecd1b0   esp: d857bb80
> Sep 24 02:26:14 elm3b67 kernel: ds: 007b   es: 007b   ss: 0068
> Sep 24 02:26:14 elm3b67 kernel: Process dbench (pid: 20747, threadinfo=d857a000 task=d4015900)
> Sep 24 02:26:14 elm3b67 kernel: Stack: cf768ea4 00000000 d82c6690 d857bc1c d8841400 d5f0a180 00000000 00000000 
> Sep 24 02:26:14 elm3b67 kernel:        00818006 d8841400 00000000 d5489310 cf768ea4 c017f65f cc218280 c01892b9 
> Sep 24 02:26:14 elm3b67 kernel:        cf768ea4 d82c6690 00000000 00000000 d4ecd1b0 00000000 d4ecd1b0 cf768ea4 
> Sep 24 02:26:14 elm3b67 kernel: Call Trace:
> Sep 24 02:26:14 elm3b67 kernel:  [ext3_get_inode_loc+87/572] ext3_get_inode_loc+0x57/0x23c
> Sep 24 02:26:14 elm3b67 kernel:  [journal_get_write_access+33/52] journal_get_write_access+0x21/0x34
> Sep 24 02:26:14 elm3b67 kernel:  [ext3_reserve_inode_write+52/152] ext3_reserve_inode_write+0x34/0x98
> Sep 24 02:26:14 elm3b67 kernel:  [ext3_mark_inode_dirty+26/52] ext3_mark_inode_dirty+0x1a/0x34
> Sep 24 02:26:14 elm3b67 kernel:  [ext3_splice_branch+209/388] ext3_splice_branch+0xd1/0x184

But syslogd has conveniently gone and futzed with the oops trace so I
cannot tell what address your ext3 driver was loaded at.  Sigh.  Please add
`-x' to your syslogd invokation and shoot whoever first thought of this.


If, as I suspect, your ext3 is not loaded as a module then weird.  There
are no indirect jumps around there which I can think of, so how did EIP get
that value?  Maybe an overwritten return address?

