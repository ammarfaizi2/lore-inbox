Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266670AbTGFNwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 09:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266671AbTGFNwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 09:52:15 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:5314 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S266670AbTGFNwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 09:52:12 -0400
Message-ID: <3F082DC8.1000900@free.fr>
Date: Sun, 06 Jul 2003 16:10:16 +0200
From: shal <shal@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG] Oops in dst_output  function
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I run a linux-2.5.73-bk5.

I have a  lot of oops but all finish by call the dst_output function  
and system freeze after.
I don't find anythink about this Oops......

The Oops :

Jul  4 18:07:20 shal kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000003
Jul  4 18:07:20 shal kernel:  printing eip:
Jul  4 18:07:20 shal kernel: c0310110
Jul  4 18:07:20 shal kernel: *pde = 00000000
Jul  4 18:07:20 shal kernel: Oops: 0002 [#10]
Jul  4 18:07:20 shal kernel: CPU:    0
Jul  4 18:07:20 shal kernel: EIP:    0060:[<c0310110>]    Not tainted
Jul  4 18:07:20 shal kernel: EFLAGS: 00010246
Jul  4 18:07:20 shal kernel: EIP is at ip_finish_output+0x0/0x250
Jul  4 18:07:20 shal kernel: eax: cfde6e80   ebx: c7bf6240   ecx: 
c7bf6240   edx: 00000000
Jul  4 18:07:20 shal kernel: esi: 00000003   edi: cf9e5c00   ebp: 
c6c29bd4   esp: c6c29bc8
Jul  4 18:07:20 shal kernel: ds: 007b   es: 007b   ss: 0068
Jul  4 18:07:20 shal kernel: Process mozilla-bin (pid: 2009, 
threadinfo=c6c28000 task=ceecccc0)
Jul  4 18:07:20 shal kernel: Stack: c03126e5 c7bf6240 00000000 c6c29c10 
c0304da8 c7bf6240 c6c29c20 00000003
Jul  4 18:07:20 shal kernel:        00000000 cf9e5c00 c6c29c00 c03126d0 
80000000 00000000 c050bdb8 c4ee4780
Jul  4 18:07:20 shal kernel:        00000040 c7bf6240 c6c29c54 c031229f 
00000002 00000003 c7bf6240 00000000
Jul  4 18:07:20 shal kernel: Call Trace:
Jul  4 18:07:20 shal kernel:  [<c03126e5>] dst_output+0x15/0x30
Jul  4 18:07:20 shal kernel:  [<c0304da8>] nf_hook_slow+0xc8/0x120
Jul  4 18:07:20 shal kernel:  [<c03126d0>] dst_output+0x0/0x30
Jul  4 18:07:20 shal kernel:  [<c031229f>] 
ip_push_pending_frames+0x3af/0x410
Jul  4 18:07:20 shal kernel:  [<c03126d0>] dst_output+0x0/0x30
Jul  4 18:07:20 shal kernel:  [<c033037b>] 
udp_push_pending_frames+0x12b/0x240
Jul  4 18:07:20 shal kernel:  [<c0330943>] udp_sendmsg+0x473/0x890
Jul  4 18:07:20 shal kernel:  [<c0197f49>] 
journal_dirty_metadata+0x159/0x2b0
Jul  4 18:07:20 shal kernel:  [<c018be77>] ext3_do_update_inode+0x167/0x350
Jul  4 18:07:20 shal kernel:  [<c0198572>] journal_stop+0x1b2/0x250
Jul  4 18:07:20 shal kernel:  [<c03393fb>] inet_sendmsg+0x4b/0x60
Jul  4 18:07:20 shal kernel:  [<c02f4c12>] sock_sendmsg+0x92/0xb0
Jul  4 18:07:20 shal kernel:  [<c030b69e>] __ip_route_output_key+0x2e/0xe0
Jul  4 18:07:20 shal kernel:  [<c030b7ca>] ip_route_output_flow+0x2a/0x60
Jul  4 18:07:20 shal kernel:  [<c02f4a3a>] sockfd_lookup+0x1a/0x70
Jul  4 18:07:20 shal kernel:  [<c02f5f25>] sys_sendto+0xe5/0x110
Jul  4 18:07:20 shal kernel:  [<c02f5cc6>] sys_connect+0x86/0xa0
Jul  4 18:07:20 shal kernel:  [<c02f5f86>] sys_send+0x36/0x40
Jul  4 18:07:20 shal kernel:  [<c02f6909>] sys_socketcall+0x159/0x280
Jul  4 18:07:20 shal kernel:  [<c01093bf>] syscall_call+0x7/0xb
Jul  4 18:07:20 shal kernel:
Jul  4 18:07:20 shal kernel: Code: 88 2c a6 3d 7b 1e ae 20 71 1b a6 18 
77 15 9c 12 7e 18 8d 17

