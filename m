Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbTIQI0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 04:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTIQI0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 04:26:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:24207 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262708AbTIQI0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 04:26:35 -0400
Date: Wed, 17 Sep 2003 10:26:34 +0200 (MEST)
From: "Daniel Engelschalt" <daniel.engelschalt@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: 2.6.0-test5: mm/page_alloc.c failure
X-Priority: 3 (Normal)
X-Authenticated: #1538274
Message-ID: <10709.1063787194@www40.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with vanilla 2.6.0-test5 i get the following:

Sep 16 19:23:41 A405a kernel: Debug: sleeping function called from invalid
context at mm/page_alloc.c:546
Sep 16 19:23:41 A405a kernel: Call Trace:
Sep 16 19:23:41 A405a kernel:  [__might_sleep+99/108]
__might_sleep+0x63/0x6c
Sep 16 19:23:41 A405a kernel:  [<c011b967>] __might_sleep+0x63/0x6c
Sep 16 19:23:41 A405a kernel:  [__alloc_pages+42/676]
__alloc_pages+0x2a/0x2a4
Sep 16 19:23:41 A405a kernel:  [<c0141bfa>] __alloc_pages+0x2a/0x2a4
Sep 16 19:23:41 A405a kernel:  [try_to_wake_up+640/656]
try_to_wake_up+0x280/0x290
Sep 16 19:23:41 A405a kernel:  [<c01188b4>] try_to_wake_up+0x280/0x290
Sep 16 19:23:41 A405a kernel:  [pte_alloc_one+25/96] pte_alloc_one+0x19/0x60
Sep 16 19:23:41 A405a kernel:  [<c0116f3d>] pte_alloc_one+0x19/0x60
Sep 16 19:23:41 A405a kernel:  [pte_alloc_map+162/472]
pte_alloc_map+0xa2/0x1d8
Sep 16 19:23:41 A405a kernel:  [<c014cc5a>] pte_alloc_map+0xa2/0x1d8
Sep 16 19:23:41 A405a kernel:  [remap_page_range+275/688]
remap_page_range+0x113/0x2b0
Sep 16 19:23:41 A405a kernel:  [<c014e717>] remap_page_range+0x113/0x2b0
Sep 16 19:23:41 A405a kernel:  [_end+546523023/1069938592]
os_map_io_space+0x37/0x4c [nvidia]
Sep 16 19:23:41 A405a kernel:  [<e0cd2fef>] os_map_io_space+0x37/0x4c
[nvidia]
Sep 16 19:23:41 A405a kernel:  [map_vm_area+200/372] map_vm_area+0xc8/0x174
Sep 16 19:23:41 A405a kernel:  [<c015a468>] map_vm_area+0xc8/0x174
Sep 16 19:23:41 A405a kernel:  [_end+546598282/1069938592]
__nvsym00625+0x1e/0x28 [nvidia]
Sep 16 19:23:41 A405a kernel:  [<e0ce55ea>] __nvsym00625+0x1e/0x28 [nvidia]
Sep 16 19:23:41 A405a kernel:  [_end+546590913/1069938592]
__nvsym00602+0x91/0xc4 [nvidia]
Sep 16 19:23:41 A405a kernel:  [<e0ce3921>] __nvsym00602+0x91/0xc4 [nvidia]
Sep 16 19:23:41 A405a kernel:  [_end+546591346/1069938592]
__nvsym00611+0x26/0x5c [nvidia]
Sep 16 19:23:41 A405a kernel:  [<e0ce3ad2>] __nvsym00611+0x26/0x5c [nvidia]
Sep 16 19:23:41 A405a kernel:  [_end+546613939/1069938592]
rm_map_agp_pages+0x1b/0x24 [nvidia]
Sep 16 19:23:41 A405a kernel:  [<e0ce9313>] rm_map_agp_pages+0x1b/0x24
[nvidia]
Sep 16 19:23:41 A405a kernel:  [_end+546508354/1069938592]
nv_kern_mmap+0x3d6/0x7c4 [nvidia]
Sep 16 19:23:41 A405a kernel:  [<e0ccf6a2>] nv_kern_mmap+0x3d6/0x7c4
[nvidia]
Sep 16 19:23:41 A405a kernel:  [do_mmap_pgoff+1031/1484]
do_mmap_pgoff+0x407/0x5cc
Sep 16 19:23:41 A405a kernel:  [<c0151c93>] do_mmap_pgoff+0x407/0x5cc
Sep 16 19:23:41 A405a kernel:  [old_mmap+275/340] old_mmap+0x113/0x154
Sep 16 19:23:41 A405a kernel:  [<c011197b>] old_mmap+0x113/0x154
Sep 16 19:23:41 A405a kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 16 19:23:41 A405a kernel:  [<c0109d77>] syscall_call+0x7/0xb
Sep 16 19:23:41 A405a kernel:  [tcp_twcal_tick+395/592]
tcp_twcal_tick+0x18b/0x250
Sep 16 19:23:41 A405a kernel:  [<c0284627>] tcp_twcal_tick+0x18b/0x250

