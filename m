Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269373AbTGJPbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269376AbTGJPbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:31:32 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:11136 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S269373AbTGJPbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:31:25 -0400
From: Nicolas <linux@1g6.biz>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: slab oops 2.5.74
Date: Thu, 10 Jul 2003 17:46:42 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307101746.42207.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, here is another slab oops with 2.5.74,
they always occurs at 4:00 AM, when crontab launches
cron.daily,
"msec" launches a "netstat -pvlA inet" (mandrake)
and then the oops occurs.
It is repeatable.

Regards.

Nicolas.


Jul  9 04:03:27 hal9003 kernel: ------------[ cut here ]------------                                                        
Jul  9 04:03:27 hal9003 kernel: kernel BUG at mm/slab.c:1537!
Jul  9 04:03:27 hal9003 kernel: invalid operand: 0000 [#1]                                                                  
Jul  9 04:03:27 hal9003 kernel: CPU:    0
Jul  9 04:03:27 hal9003 kernel: EIP:    0060:[kfree+784/797]    Not tainted                                                 
Jul  9 04:03:27 hal9003 kernel: EIP:    0060:[<c0135d36>]    Not tainted
Jul  9 04:03:27 hal9003 kernel: EFLAGS: 00010082                                                                            
Jul  9 04:03:27 hal9003 kernel: EIP is at kfree+0x310/0x31d
Jul  9 04:03:27 hal9003 kernel: eax: 0000002c   ebx: 00040000   ecx: 00000001   
edx: c02de558                               Jul  9 04:03:27 hal9003 kernel: 
esi: f61e7188   edi: f6e79b74   ebp: ee5c3f50   esp: ee5c3f24
Jul  9 04:03:27 hal9003 kernel: ds: 007b   es: 007b   ss: 0068                                                              
Jul  9 04:03:27 hal9003 kernel: Process netstat (pid: 2976, 
threadinfo=ee5c2000 task=f1645380)
Jul  9 04:03:27 hal9003 kernel: Stack: c02ad200 00000100 00000100 e517c000 
ee5c3f8c c013cd94 00000100 00000206              Jul  9 04:03:27 hal9003 
kernel:        edff89ec f61e7188 f6e79b74 ee5c3f6c c01610b8 00000100 f61e7188 
f61e7188
Jul  9 04:03:27 hal9003 kernel:        f7ff68e4 f6e79b74 ee5c3f8c c0148494 
f6e79b74 f61e7188 e0552e20 f61e7188              Jul  9 04:03:27 hal9003 
kernel: Call Trace:
Jul  9 04:03:27 hal9003 kernel:  [do_mmap_pgoff+1388/1665] 
do_mmap_pgoff+0x56c/0x681                                        Jul  9 
04:03:27 hal9003 kernel:  [<c013cd94>] do_mmap_pgoff+0x56c/0x681
Jul  9 04:03:27 hal9003 kernel:  [seq_release_private+35/65] 
seq_release_private+0x23/0x41                                  Jul  9 
04:03:27 hal9003 kernel:  [<c01610b8>] seq_release_private+0x23/0x41
Jul  9 04:03:27 hal9003 kernel:  [__fput+231/236] __fput+0xe7/0xec                                                          
Jul  9 04:03:27 hal9003 kernel:  [<c0148494>] __fput+0xe7/0xec
Jul  9 04:03:27 hal9003 kernel:  [filp_close+75/116] filp_close+0x4b/0x74                                                   
Jul  9 04:03:27 hal9003 kernel:  [<c0146e3f>] filp_close+0x4b/0x74
Jul  9 04:03:27 hal9003 kernel:  [sys_close+81/95] sys_close+0x51/0x5f                                                      
Jul  9 04:03:27 hal9003 kernel:  [<c0146eb9>] sys_close+0x51/0x5f
Jul  9 04:03:27 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb                                                   
Jul  9 04:03:27 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Jul  9 04:03:27 hal9003 kernel:                                                                                             
Jul  9 04:03:27 hal9003 kernel: Code: 0f 0b 01 06 05 c7 2a c0 e9 14 fd ff ff 
55 89 e5 8b 55 08 5d

