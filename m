Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWGARCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWGARCf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWGARCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:02:35 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:56972 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751173AbWGARCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:02:35 -0400
Message-ID: <44A6AB99.8060407@gentoo.org>
Date: Sat, 01 Jul 2006 18:06:33 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Eeek! page_mapcount(page) went negative! (-1)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A user at http://bugs.gentoo.org/138366 reported a one-off crash on x86 
with 2.6.16.19. Here's hoping it might be useful to somebody:

Eeek! page_mapcount(page) went negative! (-1)
   page->flags = 8001003c
   page->count = 1
   page->mapping = f6ad2418
------------[ cut here ]------------
kernel BUG at mm/rmap.c:560!
invalid opcode: 0000 [#1]
PREEMPT
CPU:    0
EIP is at page_remove_rmap+0x93/0xa0
eax: ffffffff   ebx: c1234040   ecx: 0000827e   edx: c0374d01
esi: b2570000   edi: c1234040   ebp: cdf8bf2c   esp: cdf8be84
ds: 007b   es: 007b   ss: 0068
Process X (pid: 27937, threadinfo=cdf8a000 task=dc73da90)
Stack: <0>c0327022 f6ad2418 dc6fd5c0 c014592f c1234040 b2570000
11a0 2067 11a02067
        fffffffc ffffffff d6c562e0 b26ab000 e465fb28 b26ab000
cdf8bf2 c c0145ac5
        c03dbbec f0cd96fc e465fb24 b256c000 b26ab000 cdf8bf2c
0000000 0 b26aafff
Call Trace:
  [zap_pte_range+351/576] zap_pte_range+0x15f/0x240
  [<c014592f>] zap_pte_range+0x15f/0x240
  [unmap_page_range+181/320] unmap_page_range+0xb5/0x140
  [<c0145ac5>] unmap_page_range+0xb5/0x140
  [unmap_vmas+239/496] unmap_vmas+0xef/0x1f0
  [<c0145c3f>] unmap_vmas+0xef/0x1f0
  [unmap_region+149/304] unmap_region+0x95/0x130
  [<c014a255>] unmap_region+0x95/0x130
  [do_munmap+275/384] do_munmap+0x113/0x180
  [<c014a5d3>] do_munmap+0x113/0x180
  [sys_munmap+68/112] sys_munmap+0x44/0x70
  [<c014a684>] sys_munmap+0x44/0x70
  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
  [<c0102ddb>] sysenter_past_esp+0x54/0x75
Code: 53 0c 8b 42 04 c7 04 24 0b 70 32 c0 40 89 44 24 04 e8 c2 b0
fc  ff 8b 43 10 c7 04 24 22 70 32 c0 89 44 24 04 e8 af b0 fc ff eb 86 
<0f> 0b
30 02  e0 6f 32 c0 eb 82 8d 76 00 83 ec 2c 89 5c 24 1c 8b
