Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbUCYR4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbUCYR4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:56:17 -0500
Received: from vvv.conterra.de ([212.124.44.162]:22968 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S263464AbUCYR4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:56:15 -0500
Message-ID: <40631D3A.6040708@conterra.de>
Date: Thu, 25 Mar 2004 18:56:10 +0100
From: Dieter Stueken <stueken@conterra.de>
Organization: con terra GmbH
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.4 Oops in nfs3svc_encode_readdirres
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a problem if the nfsd (v3) tries to export large directories
of some 1000 files. This oops is easily reproduceable. I did not verify by now,
if the v2 or v4 code is affected, too.

Dieter.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c02b6445
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[do_tcp_sendpages+405/2912]    Not tainted
EIP:    0060:[<c02b6445>]    Not tainted
EFLAGS: 00010287
EIP is at do_tcp_sendpages+0x195/0xb60
eax: c08a5d88   ebx: 00000008   ecx: c0e27780   edx: 00000000
esi: 00000001   edi: c08a5d80   ebp: c0cc6400   esp: c0cd3e68
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1004, threadinfo=c0cd2000 task=c0cd5700)
Stack: c01c4720 c08a5d90 c0cc6454 00000008 00000000 00000000 00000000 000005b4
        c0cc65cc 00007530 00000000 c0cc6400 00000008 00000000 c02b6e5e c0cc6400
        c0cd3ed0 00000000 00000008 00000000 00000008 00000008 00000000 00000008
Call Trace:
  [selinux_inode_getattr+64/80] selinux_inode_getattr+0x40/0x50
  [<c01c4720>] selinux_inode_getattr+0x40/0x50
  [tcp_sendpage+78/112] tcp_sendpage+0x4e/0x70
  [<c02b6e5e>] tcp_sendpage+0x4e/0x70
  [svc_sendto+231/608] svc_sendto+0xe7/0x260
  [<c02ef177>] svc_sendto+0xe7/0x260
  [__crc_mb_cache_entry_release+419455/528300] nfs3svc_encode_readdirres+0x52/0xa0 [nfsd]
  [<c4cfc6a2>] nfs3svc_encode_readdirres+0x52/0xa0 [nfsd]
  [svc_tcp_sendto+69/144] svc_tcp_sendto+0x45/0x90
  [<c02ef365>] svc_tcp_sendto+0x45/0x90
  [svc_send+187/256] svc_send+0xbb/0x100
  [<c02f0c6b>] svc_send+0xbb/0x100
  [svc_process+853/1632] svc_process+0x355/0x660
  [<c02ee4f5>] svc_process+0x355/0x660
  [__crc_mb_cache_entry_release+369960/528300] nfsd+0x17b/0x300 [nfsd]
  [<c4cf054b>] nfsd+0x17b/0x300 [nfsd]
  [__crc_mb_cache_entry_release+369581/528300] nfsd+0x0/0x300 [nfsd]
  [<c4cf03d0>] nfsd+0x0/0x300 [nfsd]
  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
  [<c0107005>] kernel_thread_helper+0x5/0x10

Code: 8b 02 a9 00 00 08 00 74 03 8b 52 18 ff 42 04 8b 7c 24 14 8b
