Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTKTViW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 16:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTKTViW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 16:38:22 -0500
Received: from 217-124-44-255.dialup.nuria.telefonica-data.net ([217.124.44.255]:38272
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S262491AbTKTViP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 16:38:15 -0500
Date: Thu, 20 Nov 2003 22:38:10 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Cc: Voicu Liviu <pacman@mscc.huji.ac.il>,
       William Lee Irwin III <wli@holomorphy.com>, kerin@recruit2recruit.net
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031120213810.GA5094@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Voicu Liviu <pacman@mscc.huji.ac.il>,
	William Lee Irwin III <wli@holomorphy.com>, kerin@recruit2recruit.net
References: <20031119234037.GC20840@64m.dyndns.org> <20031120025730.GD22764@holomorphy.com> <3FBC917E.7090506@mscc.huji.ac.il> <20031120101830.GH22764@holomorphy.com> <3FBC9604.1020007@mscc.huji.ac.il> <20031120103117.GI22764@holomorphy.com> <3FBC996F.2060902@mscc.huji.ac.il> <20031120104220.GJ22764@holomorphy.com> <3FBC9C94.4030603@mscc.huji.ac.il> <20031120172059.GA22495@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120172059.GA22495@64m.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 20 November 2003, at 12:20:59 -0500,
Christopher Li wrote:

> Have your try Petr Vandrovec's patch?
> ftp://platan.vc.cvut.cz/pub/vmware
> 
I just tried to "recompile" VMware Workstation 4.0.1 build 5289 applying:
ftp://platan.vc.cvut.cz/pub/vmware/vmware-any-any-update45.tar.gz

And the preblem persists. I get a BUG in the logs, very similar to the
one I reported yesterday (both with 2.6.0-test9-mm4):

kernel BUG at mm/memory.c:793!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<c01425c7>]    Tainted: PF  VLI
EFLAGS: 00013282
EIP is at get_user_pages+0xe7/0x300
eax: c109e391   ebx: 406a0000   ecx: 00000000   edx: ce90d580
esi: ddb89a00   edi: 00000001   ebp: d1af24c0   esp: c17d5d30
ds: 007b   es: 007b   ss: 0068
Process vmware-vmx (pid: 12494, threadinfo=c17d4000 task=dfd9acc0)
Stack: d1af24c0 ddb89a00 406a0000 00000001 00000002 00000000 00000000 c17d4000 
       000406a0 406a0000 00000000 e0b61925 dfd9acc0 d1af24c0 406a0000 00000001 
       00000001 00000000 c17d5da0 00000000 00000000 000406a0 e0b619c0 406a0000 
Call Trace:
 [<e0b61925>] HostIFGetUserPage+0x65/0xa0 [vmmon]
 [<e0b619c0>] HostIF_LockPage+0x60/0x300 [vmmon]
 [<e0b63b6d>] Vmx86_LockPage+0x7d/0xf0 [vmmon]
 [<e0b5ef5d>] __LinuxDriver_Ioctl+0x36d/0xb30 [vmmon]
 [<c013978f>] __alloc_pages+0xaf/0x350
 [<c013bf1e>] do_page_cache_readahead+0xbe/0x110
 [<c013516a>] find_get_page+0x1a/0x30
 [<c0136607>] filemap_nopage+0x267/0x420
 [<c013964f>] buffered_rmqueue+0xaf/0x140
 [<c013978f>] __alloc_pages+0xaf/0x350
 [<c015dda9>] permission+0x49/0x50
 [<c0139a4f>] __get_free_pages+0x1f/0x50
 [<c014494a>] __vma_link+0x3a/0xa0
 [<c0144a06>] vma_link+0x56/0x80
 [<e0b5f7ee>] LinuxDriver_IoctlV4+0x5e/0x100 [vmmon]
 [<e0b60427>] LinuxDriver_Ioctl+0x177/0x210 [vmmon]
 [<c0162b85>] sys_ioctl+0xb5/0x230
 [<c0150770>] sys_close+0x50/0x60
 [<c02ad977>] syscall_call+0x7/0xb

Code: 00 85 c0 74 4b 85 c0 7e 2c 83 f8 01 75 0c 8b 44 24 30 ff 80 d8 01 00 00 eb                                                                 bd 83 f8 02 75 0c 8b 54 24 30 ff 82 dc 01 00 00 eb ac <0f> 0b 19 03 d1 b6 2c c0                                                                 eb a2 40 75 f3 8b 5c 24 18 b8 f4 ff ff 

Greetings.
 
-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test9-mm4)
