Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270184AbTGMI6P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 04:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270185AbTGMI6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 04:58:15 -0400
Received: from bay2-f100.bay2.hotmail.com ([65.54.247.100]:57617 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270184AbTGMI6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 04:58:02 -0400
X-Originating-IP: [212.143.73.102]
X-Originating-Email: [yuval_yeret@hotmail.com]
From: "yuval yeret" <yuval_yeret@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: yuval@exanet.com
Subject: 2.4.18-24 SMP Machine stuck in zombie state after kernel Oops in devfs_d_iput
Date: Sun, 13 Jul 2003 12:12:42 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F10090EVrQQehr00006765@hotmail.com>
X-OriginalArrivalTime: 13 Jul 2003 09:12:43.0280 (UTC) FILETIME=[EABFF100:01C3491E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tried to find information about a kernel OOPS I've seen twice already on two 
different machines - but nothing seems to be said about this in the list 
archives or anywhere else for that matter (except someone saw this a while 
ago on a 2.5.X kernel - 
http://groups.google.com/groups?q=devfs_d_iput&hl=en&lr=lang_en|lang_iw&ie=UTF-8&oe=UTF-8&safe=off&selm=20030424211014%242fa9%40gated-at.bofh.it&rnum=1 
)

We are running 2.4.18-24 and doing heavy IO to disk and networking. (Qlogic 
HBAs and Intel e1000 NICs are used)

At some point the machine oopses (no scenario except heavy nfs-server like 
load):

Jul  9 09:49:02 node0 kernel: devfs_d_iput(generic): de: f5a99600 dentry: 
f558f500 de->dentry: f558f900
Jul  9 09:49:02 node0 kernel: Forcing Oops
Jul  9 09:49:02 node0 kernel: ------------[ cut here ]------------
Jul  9 09:49:02 node0 kernel: kernel BUG at base.c:2852!
Jul  9 09:49:02 node0 kernel: invalid operand: 0000
Jul  9 09:49:02 node0 kernel: CPU:    0
Jul  9 09:49:02 node0 kernel: EIP:    0010:[devfs_d_iput+63/112]    Not 
tainted
Jul  9 09:49:02 node0 kernel: EIP:    0010:[<c0186dcf>]    Not tainted
Jul  9 09:49:02 node0 kernel: EFLAGS: 00010286
Jul  9 09:49:02 node0 kernel:
Jul  9 09:49:02 node0 kernel: EIP is at  (2.4.18-24exa)
Jul  9 09:49:02 node0 kernel: eax: 0000000d   ebx: f5a99600   ecx: 00000001  
  edx: f5c8c000
Jul  9 09:49:02 node0 kernel: esi: f558f500   edi: f1250180   ebp: 00000055  
  esp: c992df3c
Jul  9 09:49:02 node0 kernel: ds: 0018   es: 0018   ss: 0018
Jul  9 09:49:02 node0 kernel: Process kswapd (pid: 12, stackpage=c992d000)
Jul  9 09:49:02 node0 kernel: Stack: c02be2c5 c02c7f60 c02be45b f5a99649 
f5a99600 f558f500 f558f900 f558f518
Jul  9 09:49:02 node0 kernel:        f558f500 f1250180 c01562c0 f558f500 
f1250180 c0303f50 000f4240 00000000
Jul  9 09:49:02 node0 kernel:        00000000 c0302f20 00000216 00000151 
00000000 000001d0 00000000 00000000
Jul  9 09:49:02 node0 kernel: Call Trace: [prune_dcache+208/432]  
(0xc992df64))
Jul  9 09:49:02 node0 kernel: Call Trace: [<c01562c0>]  (0xc992df64))
Jul  9 09:49:02 node0 kernel: [shrink_dcache_memory+32/48]  (0xc992dfa0))
Jul  9 09:49:02 node0 kernel: [<c01566f0>]  (0xc992dfa0))
Jul  9 09:49:02 node0 kernel: [do_try_to_free_pages+28/416]  (0xc992dfa8))
Jul  9 09:49:02 node0 kernel: [<c013961c>]  (0xc992dfa8))
Jul  9 09:49:02 node0 kernel: [kswapd+321/896]  (0xc992dfd4))
Jul  9 09:49:02 node0 kernel: [<c0139971>]  (0xc992dfd4))
Jul  9 09:49:02 node0 kernel: [_stext+0/80]  (0xc992dfe8))
Jul  9 09:49:02 node0 kernel: [<c0105000>]  (0xc992dfe8))
Jul  9 09:49:02 node0 kernel: [kernel_thread+38/48]  (0xc992dff0))
Jul  9 09:49:02 node0 kernel: [<c01072d6>]  (0xc992dff0))
Jul  9 09:49:02 node0 kernel: [kswapd+0/896]  (0xc992dff8))
Jul  9 09:49:02 node0 kernel: [<c0139830>]  (0xc992dff8))

After the oops networking stack continues to function, some running daemons 
continue to work (I'm seeing network traffic from the machine which 
indicates that clearly), but login into the node is not possible via 
console, ssh, rsh, and the majority of the application processes are dead.

Any information / pointers will be appreciated.


Thanks,

--
Yuval Yeret
Exanet
yuval@exanet.com
http://www.exanet.com
Tel.  972-9-9717782
Fax. 972-9-9717778

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

