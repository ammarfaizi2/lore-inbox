Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266160AbUALM2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUALM2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:28:52 -0500
Received: from gizmo09bw.bigpond.com ([144.140.70.19]:12706 "HELO
	gizmo09bw.bigpond.com") by vger.kernel.org with SMTP
	id S266160AbUALM2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:28:49 -0500
From: Srihari Vijayaraghavan <harisri@bigpond.com>
Subject: [PROBLEM] ip_conntrack_ftp module oops under 2.6.1-mm2
Date: Mon, 12 Jan 2004 23:29:38 +1100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401122329.38659.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Executing
"modprobe ip_conntrack_ftp" causes this oops:

ip_conntrack version 2.1 (3968 buckets, 31744 max) - 300 bytes per conntrack
Module len 7233 truncated
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0135e10
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c0135e10>]    Not tainted VLI
EFLAGS: 00010003
EIP is at sys_init_module+0xb0/0x230
eax: 00000004   ebx: 08074958   ecx: c13773c8   edx: df9b7c44
esi: d62c8000   edi: 00000000   ebp: c0300178   esp: d62c9fa4
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1220, threadinfo=d62c8000 task=d7371300)
Stack: 08074958 00001c41 08074088 08074958 00000002 08053670 d62c8000 c02beb96
       08074958 00001c41 08074088 00000002 08053670 bfffe5b0 00000080 0000007b
       0000007b 00000080 ffffd41a 00000073 00000287 bfffe5b0 0000007b
Call Trace:
 [<c02beb96>] sysenter_past_esp+0x43/0x65

Code: ff 89 c7 76 16 89 e9 ff 05 78 01 30 c0 0f 8e 14 07 00 00 89 c2 eb 8e 8d 
74 26 00 fa ff 46 14 8b 15 88 01 30 c0 8d 40 04 89 42 04 <89> 57 04 c7 40 04 
88 01 30 c0 a3 88 01 30 c0 fb 8b 46 08 ff 4e
 <6>note: modprobe[1220] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011c0b5>] schedule+0x5a5/0x5b0
 [<c0145ba3>] unmap_page_range+0x43/0x70
 [<c0145d84>] unmap_vmas+0x1b4/0x210
 [<c0149aeb>] exit_mmap+0x7b/0x190
 [<c011dba9>] mmput+0x79/0xf0
 [<c0121bc2>] do_exit+0x152/0x410
 [<c0119f00>] do_page_fault+0x0/0x50c
 [<c010b7d9>] die+0xf9/0x100
 [<c011a0de>] do_page_fault+0x1de/0x50c
 [<c014f787>] vfree+0x27/0x40
 [<c0135411>] load_module+0xe1/0xa30
 [<c0119f00>] do_page_fault+0x0/0x50c
 [<c02bed97>] error_code+0x2f/0x38
 [<c0135e10>] sys_init_module+0xb0/0x230
 [<c02beb96>] sysenter_past_esp+0x43/0x65

OTOH it loads and works great in 2.6.1. Please feel free to ask for more 
information.

Thanks
Hari
harisri@bigpond.com

