Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTDUSnc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTDUSmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:42:54 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:32208 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261970AbTDUSlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:41:51 -0400
Date: Mon, 21 Apr 2003 14:53:54 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
In-Reply-To: <20030421195847.A28684@lst.de>
Message-ID: <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
 <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, Christoph Hellwig wrote:

> On Mon, Apr 21, 2003 at 07:55:55PM +0200, Christoph Hellwig wrote:
> > Could you please try this patch?
>
> Better this one :)  Sorry.

No, it doesn't help, although the stack trace is different this time:

Unable to handle kernel NULL pointer dereference at virtual address
0000001c
 printing eip:
c019599a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c019599a>]    Not tainted
EFLAGS: 00010286
EIP is at devfs_remove+0x5a/0x80
eax: 00000000   ebx: 00000000   ecx: 00000002   edx: 00000000
esi: c139e568   edi: 00000000   ebp: c6c69ecc   esp: c6c69e78
ds: 007b   es: 007b   ss: 0068
Process sshd (pid: 660, threadinfo=c6c68000 task=c691a100)
Stack: 00000000 c6c69e88 00000000 c6c69ed8 00737470 c68f41e8 c68f41e8 c6c69ea4
       c015d016 c68f41e8 00000246 c6c69ebc c015aa53 c6503f4c c6470000 c6503f4c
       c139e568 c6c69ecc c0172c6f c6503f4c c6470000 c6c69ee0 c01e8999 c02cec81
Call Trace:
 [<c015d016>] iput+0x56/0x80
 [<c015aa53>] dput+0xc3/0x150
 [<c0172c6f>] devpts_pty_kill+0x3f/0x56
 [<c01e8999>] pty_close+0xe9/0x150
 [<c01e3b40>] release_dev+0x750/0x790
 [<c0152e55>] __user_walk+0x55/0x60
 [<c014e74e>] vfs_stat+0x1e/0x60
 [<c01e3f51>] tty_release+0x11/0x20
 [<c01474ca>] __fput+0xca/0xe0
 [<c0145d9b>] filp_close+0x4b/0x80
 [<c0145e21>] sys_close+0x51/0x60
 [<c01092ff>] syscall_call+0x7/0xb

Code: 8b 40 1c 89 5c 24 04 89 04 24 e8 07 fc ff ff 89 1c 24 e8 3f


I understand from "virtual address 0000001c" that devfs is still called,
and de is still NULL.

-- 
Regards,
Pavel Roskin
