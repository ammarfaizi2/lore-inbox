Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261540AbSJUWNP>; Mon, 21 Oct 2002 18:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbSJUWNP>; Mon, 21 Oct 2002 18:13:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:42461 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261540AbSJUWNO>;
	Mon, 21 Oct 2002 18:13:14 -0400
Subject: 2.5.44 crash on reboot
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 15:19:20 -0700
Message-Id: <1035238760.1186.22.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following happens on 2-way SMP box every time I reboot using
serial console. Not sure if it is a socket or inode problem but it looks
like a close race.
--------------------------------------------------------------------

Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c01b1a38
*pde = 00000000
Oops: 0000
ide-cd cdrom soundcore mga agpgart autofs nfs lockd sunrpc eepro100 mii
mousede
CPU:    0
EIP:    0060:[<c01b1a38>]    Not tainted
EFLAGS: 00010246
EIP is at device_shutdown+0x78/0x9e
eax: ffffffff   ebx: 00000000   ecx: c0392650   edx: 00000000
esi: 00000001   edi: ec3ee000   ebp: bffffdb8   esp: ec3efe8c
ds: 0068   es: 0068   ss: 0068
Process reboot (pid: 19350, threadinfo=ec3ee000 task=f01a6cc0)
Stack: c0299ffc 00000077 00000000 01234567 c0130ae2 c03f5bac 00000001
00000000
       c01372f8 c19fd0d0 00000007 f0270d10 00001000 00000002 fffee334
f0270d10
       f0270ce0 ec57b420 c01394f9 f0270ce0 eed08b40 420cdaf0 00000000
fffee334
Call Trace:
 [<c0130ae2>] sys_reboot+0x182/0x380
 [<c01372f8>] pte_alloc_map+0x128/0x140
 [<c01394f9>] handle_mm_fault+0xb9/0x1c0
 [<c0156f23>] invalidate_inode_buffers+0x13/0xc0
 [<c022e65b>] sock_destroy_inode+0x1b/0xa0
 [<c016f41a>] destroy_inode+0x6a/0x70
 [<c01704fc>] generic_forget_inode+0x14c/0x180
 [<c0276906>] inet_release+0x56/0x70
 [<c01705ac>] iput+0x5c/0x80
 [<c016cff0>] dput+0x30/0x200
 [<c0155958>] __fput+0x108/0x140
 [<c0152fd8>] filp_close+0xf8/0x130
 [<c0153089>] sys_close+0x79/0x90
 [<c0109a0f>] syscall_call+0x7/0xb


