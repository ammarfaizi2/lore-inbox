Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbULBInI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbULBInI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbULBInI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:43:08 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:6532 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261510AbULBImE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:42:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=g4fSWTpZ6srq34RautgwUEdchQdX+KwaLPpEKJdrxg3TMtSeJKoLjCwk1LhOIs3+misMB/rzGrXQ/lgd4/nZb1RdbMmF14gTnMAWa4XV5RR3l7wfPv+TXoH4R16HnewsTG+aQH9fLrSvzc6VfvBdT3o3zwlc2cGdiFv7uuVoA3w=
Message-ID: <3063e5041202004269334a25@mail.gmail.com>
Date: Thu, 2 Dec 2004 10:42:02 +0200
From: George Alexandru Dragoi <waruiinu@gmail.com>
Reply-To: George Alexandru Dragoi <waruiinu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic after ip_conntrack loaded on a kernel with mm patch.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


       This is my first post to this list. I got that serious problem
from the subj. The kernel os 2.6.10-rc2-mm3. I will paste in here the
logs from messages with the oops (there were some oops and in the last
there was a panic too):

Dec  2 09:38:51 cyclops kernel: ip_conntrack version 2.1 (4096
buckets, 32768 max) - 336 bytes per conntrack
Dec  2 09:40:01 cyclops kernel: e08d3670
Dec  2 09:40:01 cyclops kernel: Modules linked in: cls_u32 ipt_mac
cls_fw sch_sfq sch_htb iptable_filter ipt_MARK ipt_mark ipt_ttl
 iptable_mangle ip_tables e100
Dec  2 09:40:01 cyclops kernel: CPU:    0
Dec  2 09:40:01 cyclops kernel: EIP:    0060:[<e08d3670>]    Not tainted VLI
Dec  2 09:40:01 cyclops kernel: EFLAGS: 00010282   (2.6.10-rc2-mm3) 
Dec  2 09:40:01 cyclops kernel: EIP is at 0xe08d3670
Dec  2 09:40:01 cyclops kernel: eax: e08d3670   ebx: 00000000   ecx:
00000000   edx: 0000000c
Dec  2 09:40:01 cyclops kernel: esi: dd7be000   edi: c0305bb0   ebp:
00000000   esp: dc575bfc
Dec  2 09:40:01 cyclops kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 09:40:01 cyclops kernel: Process ip (pid: 3058,
threadinfo=dc574000 task=dc4c2020)
Dec  2 09:40:01 cyclops kernel: Stack: c025ec36 dd7be000 00000006
00000008 c0305ba8 c0305ba8 c0130ed8 000009a4
Dec  2 09:40:01 cyclops kernel:        d94a2560 00000001 00000000
000005c4 00000000 00000000 00000000 00000000
Dec  2 09:40:01 cyclops kernel:        00000000 00000000 00000000
00000000 00000000 ffffffff 00000000 00000000
Dec  2 09:40:01 cyclops kernel: Call Trace:
Dec  2 09:40:01 cyclops kernel:  [<c025ec36>] rtnetlink_fill_ifinfo+0x54e/0x66c
Dec  2 09:40:01 cyclops kernel:  [<c0130ed8>] cache_grow+0xde/0x122
Dec  2 09:40:01 cyclops kernel:  [<c025edc2>] rtnetlink_dump_ifinfo+0x6e/0x74
Dec  2 09:40:01 cyclops kernel:  [<c02674b3>] netlink_dump+0x59/0x1e1
Dec  2 09:40:01 cyclops kernel:  [<e08ccfac>]
htb_dequeue_tree+0xe0/0x2f6 [sch_htb]
Dec  2 09:40:01 cyclops kernel:  [<c02676f4>] netlink_dump_start+0xb9/0x114
Dec  2 09:40:01 cyclops kernel:  [<c025f56a>] rtnetlink_rcv+0x38c/0x3c8
Dec  2 09:40:01 cyclops kernel:  [<c025ed54>] rtnetlink_dump_ifinfo+0x0/0x74
Dec  2 09:40:01 cyclops kernel:  [<c025f1db>] rtnetlink_done+0x0/0x3
Dec  2 09:40:01 cyclops kernel:  [<c0267324>] netlink_data_ready+0x61/0x69
Dec  2 09:40:01 cyclops kernel:  [<c0266774>] netlink_sendskb+0x32/0x6e
Dec  2 09:40:01 cyclops kernel:  [<c0266f9a>] netlink_sendmsg+0x1f9/0x319
Dec  2 09:40:01 cyclops kernel:  [<c027211c>] ip_finish_output2+0x0/0x1e4
Dec  2 09:40:01 cyclops kernel:  [<c024e6e6>] sock_sendmsg+0xe5/0x100
Dec  2 09:40:01 cyclops kernel:  [<c012ddb3>] __alloc_pages+0x254/0x409
Dec  2 09:40:01 cyclops kernel:  [<c012a966>] filemap_nopage+0x0/0x31c
Dec  2 09:40:01 cyclops kernel:  [<c0123bf4>] autoremove_wake_function+0x0/0x57
Dec  2 09:40:01 cyclops kernel:  [<c024fa60>] sys_sendto+0xe3/0xfe
Dec  2 09:40:01 cyclops kernel:  [<c024f23e>] __sock_create+0xa7/0x18f
Dec  2 09:40:01 cyclops kernel:  [<c01f0260>] copy_from_user+0x42/0x6e
Dec  2 09:40:01 cyclops kernel:  [<c0250317>] sys_socketcall+0x189/0x254
Dec  2 09:40:01 cyclops kernel:  [<c01021c7>] syscall_call+0x7/0xb
Dec  2 09:40:01 cyclops kernel: Code:  Bad EIP value.
Dec  2 09:40:02 cyclops kernel:  <1>Unable to handle kernel paging
request at virtual address e08d3670
Dec  2 09:40:02 cyclops kernel: e08d3670
Dec  2 09:40:02 cyclops kernel: Modules linked in: cls_u32 ipt_mac
cls_fw sch_sfq sch_htb iptable_filter ipt_MARK ipt_mark ipt_ttl
 iptable_mangle ip_tables e100
Dec  2 09:40:02 cyclops kernel: CPU:    0
Dec  2 09:40:02 cyclops kernel: EIP:    0060:[<e08d3670>]    Not tainted VLI
Dec  2 09:40:02 cyclops kernel: EFLAGS: 00010282   (2.6.10-rc2-mm3) 
Dec  2 09:40:02 cyclops kernel: EIP is at 0xe08d3670
Dec  2 09:40:02 cyclops kernel: eax: e08d3670   ebx: dd7be000   ecx:
cf293f4c   edx: dd08f780
Dec  2 09:40:02 cyclops kernel: esi: dd08f780   edi: dd7be000   ebp:
000003ce   esp: cf293ed4
Dec  2 09:40:02 cyclops kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 09:40:02 cyclops kernel: Process ifconfig (pid: 3060,
threadinfo=cf292000 task=ca2d0530)
Dec  2 09:40:02 cyclops kernel: Stack: c0257fd5 dd7be000 c02da400
dfbcf000 18135902 0013579a 00000000 00000000
Dec  2 09:40:02 cyclops kernel:        00000000 00000000 00000000
00000000 97596285 0035a75c 0000034c 00000000
Dec  2 09:40:02 cyclops kernel:        00000000 00000000 0000034c
00000000 00000000 dd08f780 c02580ab dd08f780
Dec  2 09:40:02 cyclops kernel: Call Trace:
Dec  2 09:40:02 cyclops kernel:  [<c0257fd5>] dev_seq_printf_stats+0x23/0xdd
Dec  2 09:40:02 cyclops kernel:  [<c02580ab>] dev_seq_show+0x1c/0x34
Dec  2 09:40:02 cyclops kernel:  [<c0161c62>] seq_read+0x19e/0x289
Dec  2 09:40:02 cyclops kernel:  [<c0144bc1>] vfs_read+0xd4/0x16a
Dec  2 09:40:02 cyclops kernel:  [<c0144efd>] sys_read+0x51/0x80
Dec  2 09:40:02 cyclops kernel:  [<c01021c7>] syscall_call+0x7/0xb
Dec  2 09:40:02 cyclops kernel: Code:  Bad EIP value.
Dec  2 09:40:12 cyclops kernel:  <1>Unable to handle kernel paging
request at virtual address e08d3670
Dec  2 09:40:12 cyclops kernel: e08d3670
Dec  2 09:40:12 cyclops kernel: Modules linked in: cls_u32 ipt_mac
cls_fw sch_sfq sch_htb iptable_filter ipt_MARK ipt_mark ipt_ttl
 iptable_mangle ip_tables e100
Dec  2 09:40:12 cyclops kernel: CPU:    0
Dec  2 09:40:12 cyclops kernel: EIP:    0060:[<e08d3670>]    Not tainted VLI
Dec  2 09:40:12 cyclops kernel: EFLAGS: 00010282   (2.6.10-rc2-mm3) 
Dec  2 09:40:12 cyclops kernel: EIP is at 0xe08d3670
Dec  2 09:40:12 cyclops kernel: eax: e08d3670   ebx: dd7be000   ecx:
dc575f4c   edx: cf318800
Dec  2 09:40:12 cyclops kernel: esi: cf318800   edi: dd7be000   ebp:
000003ce   esp: dc575ed4
Dec  2 09:40:12 cyclops kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 09:40:12 cyclops kernel: Process ifconfig (pid: 3062,
threadinfo=dc574000 task=ca2d0530)
Dec  2 09:40:12 cyclops kernel: Stack: c0257fd5 dd7be000 c02da400
dfbcf000 18136c57 001357dd 00000000 00000000
Dec  2 09:40:12 cyclops kernel:        00000000 00000000 00000000
00000000 97596285 0035a75c 0000034c 00000000
Dec  2 09:40:12 cyclops kernel:        00000000 00000000 0000034c
00000000 00000000 cf318800 c02580ab cf318800
Dec  2 09:40:12 cyclops kernel: Call Trace:
Dec  2 09:40:12 cyclops kernel:  [<c0257fd5>] dev_seq_printf_stats+0x23/0xdd
Dec  2 09:40:12 cyclops kernel:  [<c02580ab>] dev_seq_show+0x1c/0x34
Dec  2 09:40:12 cyclops kernel:  [<c0161c62>] seq_read+0x19e/0x289
Dec  2 09:40:12 cyclops kernel:  [<c0144bc1>] vfs_read+0xd4/0x16a
Dec  2 09:40:12 cyclops kernel:  [<c0144efd>] sys_read+0x51/0x80
Dec  2 09:40:12 cyclops kernel:  [<c01021c7>] syscall_call+0x7/0xb
Dec  2 09:40:12 cyclops kernel: Code:  Bad EIP value.
Dec  2 09:40:17 cyclops kernel:  <1>Unable to handle kernel paging
request at virtual address e08d3670
Dec  2 09:40:17 cyclops kernel: e08d3670
Dec  2 09:40:17 cyclops kernel: Modules linked in: cls_u32 ipt_mac
cls_fw sch_sfq sch_htb iptable_filter ipt_MARK ipt_mark ipt_ttl
 iptable_mangle ip_tables e100
Dec  2 09:40:17 cyclops kernel: CPU:    0
Dec  2 09:40:17 cyclops kernel: EIP:    0060:[<e08d3670>]    Not tainted VLI
Dec  2 09:40:17 cyclops kernel: EFLAGS: 00010282   (2.6.10-rc2-mm3) 
Dec  2 09:40:17 cyclops kernel: EIP is at 0xe08d3670
Dec  2 09:40:17 cyclops kernel: eax: e08d3670   ebx: dd7be000   ecx:
d4a55f4c   edx: cf318900
Dec  2 09:40:17 cyclops kernel: esi: cf318900   edi: dd7be000   ebp:
000003ce   esp: d4a55ed4
Dec  2 09:40:17 cyclops kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 09:40:17 cyclops kernel: Process ifconfig (pid: 3063,
threadinfo=d4a54000 task=ca2d0a40)
Dec  2 09:40:17 cyclops kernel: Stack: c0257fd5 dd7be000 c02da400
dfbcf000 1814d239 00135898 00000000 00000000
Dec  2 09:40:17 cyclops kernel:        00000000 00000000 00000000
00000000 97596285 0035a75c 0000034c 00000000
Dec  2 09:40:17 cyclops kernel:        00000000 00000000 0000034c
00000000 00000000 cf318900 c02580ab cf318900
Dec  2 09:40:17 cyclops kernel: Call Trace:
Dec  2 09:40:17 cyclops kernel:  [<c0257fd5>] dev_seq_printf_stats+0x23/0xdd
Dec  2 09:40:17 cyclops kernel:  [<c02580ab>] dev_seq_show+0x1c/0x34
Dec  2 09:40:17 cyclops kernel:  [<c0161c62>] seq_read+0x19e/0x289
Dec  2 09:40:17 cyclops kernel:  [<c0144bc1>] vfs_read+0xd4/0x16a
Dec  2 09:40:17 cyclops kernel:  [<c0144efd>] sys_read+0x51/0x80
Dec  2 09:40:17 cyclops kernel:  [<c01021c7>] syscall_call+0x7/0xb
Dec  2 09:40:17 cyclops kernel: Code:  Bad EIP value.
Dec  2 09:44:42 cyclops kernel:  <1>Unable to handle kernel paging
request at virtual address e08d3670
Dec  2 09:44:42 cyclops kernel: e08d3670
Dec  2 09:44:42 cyclops kernel: Modules linked in: cls_u32 ipt_mac
cls_fw sch_sfq sch_htb iptable_filter ipt_MARK ipt_mark ipt_ttl
 iptable_mangle ip_tables e100
Dec  2 09:44:42 cyclops kernel: CPU:    0
Dec  2 09:44:42 cyclops kernel: EIP:    0060:[<e08d3670>]    Not tainted VLI
Dec  2 09:44:42 cyclops kernel: EFLAGS: 00010282   (2.6.10-rc2-mm3) 
Dec  2 09:44:42 cyclops kernel: EIP is at 0xe08d3670
Dec  2 09:44:42 cyclops kernel: eax: e08d3670   ebx: dd7be000   ecx:
dc575f4c   edx: c1feec00
Dec  2 09:44:42 cyclops kernel: esi: c1feec00   edi: dd7be000   ebp:
000003ce   esp: dc575ed4
Dec  2 09:44:42 cyclops kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 09:44:42 cyclops kernel: Process ifconfig (pid: 3081,
threadinfo=dc574000 task=ca2d0530)
Dec  2 09:44:42 cyclops kernel: Stack: c0257fd5 dd7be000 c02da400
dfbcf000 182edb63 00137266 00000000 00000000
Dec  2 09:44:42 cyclops kernel:        00000000 00000000 00000000
00000000 9759651f 0035a765 0000034c 00000000
Dec  2 09:44:42 cyclops kernel:        00000000 00000000 0000034c
00000000 00000000 c1feec00 c02580ab c1feec00
Dec  2 09:44:42 cyclops kernel: Call Trace:
Dec  2 09:44:42 cyclops kernel:  [<c0257fd5>] dev_seq_printf_stats+0x23/0xdd
Dec  2 09:44:42 cyclops kernel:  [<c02580ab>] dev_seq_show+0x1c/0x34
Dec  2 09:44:42 cyclops kernel:  [<c0161c62>] seq_read+0x19e/0x289
Dec  2 09:44:42 cyclops kernel:  [<c0144bc1>] vfs_read+0xd4/0x16a
Dec  2 09:44:42 cyclops kernel:  [<c0144efd>] sys_read+0x51/0x80
Dec  2 09:44:42 cyclops kernel:  [<c01021c7>] syscall_call+0x7/0xb
Dec  2 09:44:42 cyclops kernel: Code:  Bad EIP value.
Dec  2 09:44:53 cyclops kernel:  <1>Unable to handle kernel paging
request at virtual address e08d3670
Dec  2 09:44:53 cyclops kernel: e08d3670
Dec  2 09:44:53 cyclops kernel: Modules linked in: cls_u32 ipt_mac
cls_fw sch_sfq sch_htb iptable_filter ipt_MARK ipt_mark ipt_ttl
 iptable_mangle ip_tables e100
Dec  2 09:44:53 cyclops kernel: CPU:    0
Dec  2 09:44:53 cyclops kernel: EIP:    0060:[<e08d3670>]    Not tainted VLI
Dec  2 09:44:53 cyclops kernel: EFLAGS: 00010282   (2.6.10-rc2-mm3) 
Dec  2 09:44:53 cyclops kernel: EIP is at 0xe08d3670
Dec  2 09:44:53 cyclops kernel: eax: e08d3670   ebx: dd7be000   ecx:
d3a33f4c   edx: dd8e3340
Dec  2 09:44:53 cyclops kernel: esi: dd8e3340   edi: dd7be000   ebp:
000003ce   esp: d3a33ed4
Dec  2 09:44:53 cyclops kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 09:44:53 cyclops kernel: Process ifconfig (pid: 3083,
threadinfo=d3a32000 task=cfd2f020)
Dec  2 09:44:53 cyclops kernel: Stack: c0257fd5 dd7be000 c02da400
dfbcf000 18305822 00137364 00000000 00000000
Dec  2 09:44:53 cyclops kernel:        00000000 00000000 00000000
00000000 9759651f 0035a765 0000034c 00000000
Dec  2 09:44:53 cyclops kernel:        00000000 00000000 0000034c
00000000 00000000 dd8e3340 c02580ab dd8e3340
Dec  2 09:44:53 cyclops kernel: Call Trace:
Dec  2 09:44:53 cyclops kernel:  [<c0257fd5>] dev_seq_printf_stats+0x23/0xdd
Dec  2 09:44:53 cyclops kernel:  [<c02580ab>] dev_seq_show+0x1c/0x34
Dec  2 09:44:53 cyclops kernel:  [<c0161c62>] seq_read+0x19e/0x289
Dec  2 09:44:53 cyclops kernel:  [<c0144bc1>] vfs_read+0xd4/0x16a
Dec  2 09:44:53 cyclops kernel:  [<c0144efd>] sys_read+0x51/0x80
Dec  2 09:44:53 cyclops kernel:  [<c01021c7>] syscall_call+0x7/0xb
Dec  2 09:44:53 cyclops kernel: Code:  Bad EIP value.
Dec  2 09:45:06 cyclops kernel:  <1>Unable to handle kernel paging
request at virtual address e08d3670
Dec  2 09:45:06 cyclops kernel: e08d3670
Dec  2 09:45:06 cyclops kernel: Modules linked in: cls_u32 ipt_mac
cls_fw sch_sfq sch_htb iptable_filter ipt_MARK ipt_mark ipt_ttl
 iptable_mangle ip_tables e100
Dec  2 09:45:06 cyclops kernel: CPU:    0
Dec  2 09:45:06 cyclops kernel: EIP:    0060:[<e08d3670>]    Not tainted VLI
Dec  2 09:45:06 cyclops kernel: EFLAGS: 00010282   (2.6.10-rc2-mm3) 
Dec  2 09:45:06 cyclops kernel: EIP is at 0xe08d3670
Dec  2 09:45:06 cyclops kernel: eax: e08d3670   ebx: dd7be000   ecx:
d7469f4c   edx: dd08f280
Dec  2 09:45:06 cyclops kernel: esi: dd08f280   edi: dd7be000   ebp:
000003ce   esp: d7469ed4
Dec  2 09:45:06 cyclops kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 09:45:06 cyclops kernel: Process cat (pid: 3088,
threadinfo=d7468000 task=d1a3d530)
Dec  2 09:45:06 cyclops kernel: Stack: c0257fd5 dd7be000 c02da400
dfbcf000 18308436 001373e8 00000000 00000000
Dec  2 09:45:06 cyclops kernel:        00000000 00000000 00000000
00000000 9759651f 0035a765 0000034c 00000000
Dec  2 09:45:06 cyclops kernel:        00000000 00000000 0000034c
00000000 00000000 dd08f280 c02580ab dd08f280
Dec  2 09:45:06 cyclops kernel: Call Trace:
Dec  2 09:45:06 cyclops kernel:  [<c0257fd5>] dev_seq_printf_stats+0x23/0xdd
Dec  2 09:45:06 cyclops kernel:  [<c02580ab>] dev_seq_show+0x1c/0x34
Dec  2 09:45:06 cyclops kernel:  [<c0161c62>] seq_read+0x19e/0x289
Dec  2 09:45:06 cyclops kernel:  [<c0144bc1>] vfs_read+0xd4/0x16a
Dec  2 09:45:06 cyclops kernel:  [<c0144efd>] sys_read+0x51/0x80
Dec  2 09:45:06 cyclops kernel:  [<c01021c7>] syscall_call+0x7/0xb
Dec  2 09:45:06 cyclops kernel: Code:  Bad EIP value.
Dec  2 09:45:09 cyclops kernel:  <1>Unable to handle kernel paging
request at virtual address e08d3670
Dec  2 09:45:09 cyclops kernel: e08d3670
Dec  2 09:45:09 cyclops kernel: Modules linked in: cls_u32 ipt_mac
cls_fw sch_sfq sch_htb iptable_filter ipt_MARK ipt_mark ipt_ttl
 iptable_mangle ip_tables e100
Dec  2 09:45:09 cyclops kernel: CPU:    0
Dec  2 09:45:09 cyclops kernel: EIP:    0060:[<e08d3670>]    Not tainted VLI
Dec  2 09:45:09 cyclops kernel: EFLAGS: 00010282   (2.6.10-rc2-mm3) 
Dec  2 09:45:09 cyclops kernel: EIP is at 0xe08d3670
Dec  2 09:45:09 cyclops kernel: eax: e08d3670   ebx: dd7be000   ecx:
d7469f4c   edx: dd08f280
Dec  2 09:45:09 cyclops kernel: esi: dd08f280   edi: dd7be000   ebp:
000003ce   esp: d7469ed4
Dec  2 09:45:09 cyclops kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 09:45:09 cyclops kernel: Process cat (pid: 3089,
threadinfo=d7468000 task=d1a3d530)
Dec  2 09:45:09 cyclops kernel: Stack: c0257fd5 dd7be000 c02da400
dfbcf000 18318dae 00137436 00000000 00000000
Dec  2 09:45:09 cyclops kernel:        00000000 00000000 00000000
00000000 9759651f 0035a765 0000034c 00000000
Dec  2 09:45:09 cyclops kernel:        00000000 00000000 0000034c
00000000 00000000 dd08f280 c02580ab dd08f280
Dec  2 09:45:09 cyclops kernel: Call Trace:
Dec  2 09:45:09 cyclops kernel:  [<c0257fd5>] dev_seq_printf_stats+0x23/0xdd
Dec  2 09:45:09 cyclops kernel:  [<c02580ab>] dev_seq_show+0x1c/0x34
Dec  2 09:45:09 cyclops kernel:  [<c0161c62>] seq_read+0x19e/0x289
Dec  2 09:45:09 cyclops kernel:  [<c0144bc1>] vfs_read+0xd4/0x16a
Dec  2 09:45:09 cyclops kernel:  [<c0144efd>] sys_read+0x51/0x80
Dec  2 09:45:09 cyclops kernel:  [<c01021c7>] syscall_call+0x7/0xb
Dec  2 09:45:09 cyclops kernel: Code:  Bad EIP value.
Dec  2 09:45:15 cyclops kernel:  <1>Unable to handle kernel paging
request at virtual address e08d3670
Dec  2 09:45:15 cyclops kernel: e08d3670
Dec  2 09:45:15 cyclops kernel: Modules linked in: cls_u32 ipt_mac
cls_fw sch_sfq sch_htb iptable_filter ipt_MARK ipt_mark ipt_ttl
 iptable_mangle ip_tables e100
Dec  2 09:45:15 cyclops kernel: CPU:    0
Dec  2 09:45:15 cyclops kernel: EIP:    0060:[<e08d3670>]    Not tainted VLI
Dec  2 09:45:15 cyclops kernel: EFLAGS: 00010282   (2.6.10-rc2-mm3) 
Dec  2 09:45:15 cyclops kernel: EIP is at 0xe08d3670
Dec  2 09:45:15 cyclops kernel: eax: e08d3670   ebx: dd7be000   ecx:
d7469f4c   edx: dd08f280
Dec  2 09:45:15 cyclops kernel: esi: dd08f280   edi: dd7be000   ebp:
000003ce   esp: d7469ed4
Dec  2 09:45:15 cyclops kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 09:45:15 cyclops kernel: Process ifconfig (pid: 3090,
threadinfo=d7468000 task=d1a3d530)
Dec  2 09:45:15 cyclops kernel: Stack: c0257fd5 dd7be000 c02da400
dfbcf000 1831d61c 00137468 00000000 00000000
Dec  2 09:45:15 cyclops kernel:        00000000 00000000 00000000
00000000 9759651f 0035a765 0000034c 00000000
Dec  2 09:45:15 cyclops kernel:        00000000 00000000 0000034c
00000000 00000000 dd08f280 c02580ab dd08f280
Dec  2 09:45:15 cyclops kernel: Call Trace:
Dec  2 09:45:15 cyclops kernel:  [<c0257fd5>] dev_seq_printf_stats+0x23/0xdd
Dec  2 09:45:15 cyclops kernel:  [<c02580ab>] dev_seq_show+0x1c/0x34
Dec  2 09:45:15 cyclops kernel:  [<c0161c62>] seq_read+0x19e/0x289
Dec  2 09:45:15 cyclops kernel:  [<c0144bc1>] vfs_read+0xd4/0x16a
Dec  2 09:45:15 cyclops kernel:  [<c0144efd>] sys_read+0x51/0x80
Dec  2 09:45:15 cyclops kernel:  [<c01021c7>] syscall_call+0x7/0xb
Dec  2 09:45:15 cyclops kernel: Code:  Bad EIP value.
Dec  2 09:52:47 cyclops kernel:  <1>Unable to handle kernel paging
request at virtual address e08d3670
Dec  2 09:52:47 cyclops kernel: e08d3670
Dec  2 09:52:47 cyclops kernel: Modules linked in: cls_u32 ipt_mac
cls_fw sch_sfq sch_htb iptable_filter ipt_MARK ipt_mark ipt_ttl
 iptable_mangle ip_tables e100
Dec  2 09:52:47 cyclops kernel: CPU:    0
Dec  2 09:52:47 cyclops kernel: EIP:    0060:[<e08d3670>]    Not tainted VLI
Dec  2 09:52:47 cyclops kernel: EFLAGS: 00010282   (2.6.10-rc2-mm3) 
Dec  2 09:52:47 cyclops kernel: EIP is at 0xe08d3670
Dec  2 09:52:47 cyclops kernel: eax: e08d3670   ebx: dd7be000   ecx:
c429df4c   edx: d79bc9c0
Dec  2 09:52:47 cyclops kernel: esi: d79bc9c0   edi: dd7be000   ebp:
000003ce   esp: c429ded4
Dec  2 09:52:47 cyclops kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 09:52:47 cyclops kernel: Process ifconfig (pid: 3113,
threadinfo=c429c000 task=c2227020)
Dec  2 09:52:47 cyclops kernel: Stack: c0257fd5 dd7be000 c02da400
dfbcf000 1862128f 0013986a 00000000 00000000
Dec  2 09:52:47 cyclops kernel:        00000000 00000000 00000000
00000000 97596b8b 0035a77d 0000034c 00000000
Dec  2 09:52:47 cyclops kernel:        00000000 00000000 0000034c
00000000 00000000 d79bc9c0 c02580ab d79bc9c0
Dec  2 09:52:47 cyclops kernel: Call Trace:
Dec  2 09:52:47 cyclops kernel:  [<c0257fd5>] dev_seq_printf_stats+0x23/0xdd
Dec  2 09:52:47 cyclops kernel:  [<c02580ab>] dev_seq_show+0x1c/0x34
Dec  2 09:52:47 cyclops kernel:  [<c0161c62>] seq_read+0x19e/0x289
Dec  2 09:52:47 cyclops kernel:  [<c0144bc1>] vfs_read+0xd4/0x16a
Dec  2 09:52:47 cyclops kernel:  [<c0144efd>] sys_read+0x51/0x80
Dec  2 09:52:47 cyclops kernel:  [<c01021c7>] syscall_call+0x7/0xb
Dec  2 09:52:47 cyclops kernel: Code:  Bad EIP value.
