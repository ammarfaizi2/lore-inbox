Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268907AbUIMWTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268907AbUIMWTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269003AbUIMWTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:19:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:14060 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268907AbUIMWTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:19:09 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: aio (maybe XFS) bug?
Date: Mon, 13 Sep 2004 15:19:02 -0700
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409131519.03065.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got this panic running aim7 on 2.6.9-rc2, is it a known problem and/or 
likely to be a generic aio problem?

Thanks,
Jesse

Unable to handle kernel paging request at virtual address 2000000002484000
ls[29576]: Oops 11046655885316 [1]
Modules linked in:

Pid: 29576, CPU 7, comm:                   ls
psr : 0000121008026038 ifs : 800000000000cc18 ip  : [<a0000001003f68d1>]    
Not tainted
ip is at __copy_user+0xb1/0x940
unat: 0000000000000000 pfs : 000000000000058e rsc : 0000000000000003
rnat: a00000010076fe05 bsps: 0000000000000000 pr  : 00000000056a1495
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c0270033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a000000100113b10 b6  : a000000100113980 b7  : a000000100002cd0
f6  : 0ffff8000000000000000 f7  : 000000000000000000000
f8  : 000000000000000000000 f9  : 1003e000000006ec01d0a
f10 : 1003e000000030740cb46 f11 : 1003e6db6db6db6db6db7
r1  : a000000100b8eb00 r2  : e0001bb007428000 r3  : 0000000000000000
r8  : 0000000000000000 r9  : 0000000000000005 r10 : 0000000000000000
r11 : 00000000056a15d5 r12 : e00019bc7b55fca0 r13 : e00019bc7b558000
r14 : 2000000002484000 r15 : e0001bb007428000 r16 : 0000000000000317
r17 : 2000000002484000 r18 : 2000000002484001 r19 : e0001bb007428080
r20 : 2000000002484000 r21 : 6db6db6db6db6db7 r22 : 000000030740cb46
r23 : 000000183a065a30 r24 : a0007fe43b138000 r25 : 0000000000000000
r26 : e00019bc7b558e40 r27 : 000000000000006c r28 : 0000000000000000
r29 : 0000000000000000 r30 : 0000000000000008 r31 : 000000000000058e

Call Trace:
 [<a000000100017380>] show_stack+0x80/0xa0
                                sp=e00019bc7b55f830 bsp=e00019bc7b5595a8
 [<a00000010003d810>] die+0x150/0x200
                                sp=e00019bc7b55fa00 bsp=e00019bc7b559568
 [<a00000010005db20>] ia64_do_page_fault+0x8c0/0xbc0
                                sp=e00019bc7b55fa00 bsp=e00019bc7b559500
 [<a00000010000f660>] ia64_leave_kernel+0x0/0x270
                                sp=e00019bc7b55fad0 bsp=e00019bc7b559500
 [<a0000001003f68d0>] __copy_user+0xb0/0x940
                                sp=e00019bc7b55fca0 bsp=e00019bc7b559440
 [<a000000100113b10>] file_read_actor+0x190/0x340
                                sp=e00019bc7b55fca0 bsp=e00019bc7b5593e0
 [<a000000100113460>] do_generic_mapping_read+0x2e0/0x800
                                sp=e00019bc7b55fca0 bsp=e00019bc7b559338
 [<a000000100117b60>] __generic_file_aio_read+0x360/0x460
                                sp=e00019bc7b55fd00 bsp=e00019bc7b5592d0
 [<a0000001003c86f0>] xfs_read+0x250/0x4c0
                                sp=e00019bc7b55fd20 bsp=e00019bc7b559258
 [<a0000001003c01e0>] linvfs_read+0x100/0x160
                                sp=e00019bc7b55fd30 bsp=e00019bc7b559220
 [<a000000100160640>] do_sync_read+0x140/0x1a0
                                sp=e00019bc7b55fd40 bsp=e00019bc7b5591d8
 [<a000000100160860>] vfs_read+0x1c0/0x2e0
                                sp=e00019bc7b55fe20 bsp=e00019bc7b559188
 [<a000000100160e70>] sys_read+0x70/0xe0
                                sp=e00019bc7b55fe20 bsp=e00019bc7b559110
 [<a00000010000f4c0>] ia64_ret_from_syscall+0x0/0x20
                                sp=e00019bc7b55fe30 bsp=e00019bc7b559110
Kernel panic - not syncing: Aiee, killing interrupt handler!
Rebooting in 5 seconds..
