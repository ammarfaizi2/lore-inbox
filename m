Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbTGGMjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 08:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTGGMjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 08:39:40 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:38784 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S266987AbTGGMjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 08:39:01 -0400
Date: Mon, 7 Jul 2003 14:53:34 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: kfree_debugcheck: out of range ptr 100h in 2.5.74 (c1384 from last thursday)
Message-ID: <20030707125334.GA6893@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   sorry if this is duplicate, but LK traffic somehow grew over my capabilities.

   I just typed 'netstat' after 3 hours of uptime, and in reward I received
few connections followed by kernel complaining about invalid kfree.

   Oopses are triggered by reading /proc/net/raw, as 'cat /proc/net/raw' reveals.

   'PF' tainting is caused by VMware's vmmon/vmnet, but I do not think that it is
extremenly relevant to this oops, as nothing from VMware creates raw sockets.
   						Thanks,
   							Petr Vandrovec

vana:~# netstat
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 vana:32901              mailgw.cvut.cz:ssh      ESTABLISHED
tcp        0      0 vana:32796              petr.vc.cvut.cz:ssh     ESTABLISHED
tcp        0      0 vana:32773              olc.cvut.cz:ssh         ESTABLISHED
tcp        0      0 vana:32774              buk.vc.cvut.cz:ssh      ESTABLISHED
tcp        0      0 vana:32772              cdrom.vc.cvut.cz:524    ESTABLISHED
tcp        0      0 vana:32769              cdrom.vc.cvut.cz:524    ESTABLISHED
kfree_debugcheck: out of range ptr 100h.
------------[ cut here ]------------
kernel BUG at mm/slab.c:1610!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c014d1f8>]    Tainted: PF
EFLAGS: 00010086
EIP is at kfree+0x2c9/0x2d6
eax: 0000002c   ebx: c9626104   ecx: c047ef54   edx: c03c0f58
esi: d2214738   edi: 00040000   ebp: c8ea47d8   esp: ce1a1f1c
ds: 007b   es: 007b   ss: 0068
Process netstat (pid: 6890, threadinfo=ce1a0000 task=da576100)
Stack: c0381780 00000100 d2214758 c0335a09 c9626104 00000003 00000206 c9626104
       d2214738 c2307b8c c8ea47d8 c0191833 00000100 d2214738 d2214738 dffb6224
       c2307b8c c0169cbe c2307b8c d2214738 d2214738 da644504 00000000 ce1a0000
Call Trace:
       [<c0335a09>] raw_seq_start+0x39/0x3d
       [<c0191833>] seq_release_private+0x25/0x48
       [<c0169cbe>] __fput+0xd9/0xde
       [<c01681e6>] filp_close+0x4d/0x79
       [<c01682fd>] sys_close+0xeb/0x1ed
       [<c0168cf2>] sys_read+0x42/0x63
       [<c0109aaf>] syscall_call+0x7/0xb
Code: 0f 0b 4a 06 af 0b 38 c0 e9 5c fd ff ff 53 31 d2 b8 08 00 00
Segmentation fault
vana:~# cat /proc/net/raw
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode
1: 00000000:0001 00000000:0000 07 00000000:00000000 00:00000000 00000000     0        0 2121 2 dc9f44b4
1: 00000000:0001 00000000:0000 07 00000000:00000000 00:00000000 00000000     0        0 1325 2 dfcb0084
<3>kfree_debugcheck: out of range ptr 100h.
------------[ cut here ]------------
kernel BUG at mm/slab.c:1610!
invalid operand: 0000 [#3]
CPU:    0
EIP:    0060:[<c014d1f8>]    Tainted: PF
EFLAGS: 00010086
EIP is at kfree+0x2c9/0x2d6
eax: 0000002c   ebx: d9756334   ecx: c047eadc   edx: c03c0f58
esi: d8e1adec   edi: 00040000   ebp: c8ea47d8   esp: c7305f1c
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 6913, threadinfo=c7304000 task=db8b8400)
Stack: c0381780 00000100 d8e1ae0c c0335a09 d9756334 00000003 00000206 d9756334
       d8e1adec c2307b8c c8ea47d8 c0191833 00000100 d8e1adec d8e1adec dffb6224
       c2307b8c c0169cbe c2307b8c d8e1adec d8e1adec db93e184 00000000 c7304000
Call Trace:
       [<c0335a09>] raw_seq_start+0x39/0x3d
       [<c0191833>] seq_release_private+0x25/0x48
       [<c0169cbe>] __fput+0xd9/0xde
       [<c01681e6>] filp_close+0x4d/0x79
       [<c01682fd>] sys_close+0xeb/0x1ed
       [<c0168cf2>] sys_read+0x42/0x63
       [<c0109aaf>] syscall_call+0x7/0xb
Code: 0f 0b 4a 06 af 0b 38 c0 e9 5c fd ff ff 53 31 d2 b8 08 00 00
Segmentation fault

