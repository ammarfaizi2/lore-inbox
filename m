Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUE0LZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUE0LZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 07:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUE0LZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 07:25:14 -0400
Received: from science.horizon.com ([192.35.100.1]:64298 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261925AbUE0LZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 07:25:09 -0400
Date: 27 May 2004 11:25:08 -0000
Message-ID: <20040527112508.24292.qmail@science.horizon.com>
From: linux@horizon.com
To: neilb@cse.unsw.edu.au
Subject: Re: 2.6.6 is crashing repeatedly
Cc: akpm@osdl.org, kerndev@sc-software.com, linux-kernel@vger.kernel.org,
       linux@horizon.com
In-Reply-To: <20040520060805.1620.qmail@science.horizon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even with neilb's patch, I just got an nfs oops:
Unable to handle kernel paging request at virtual address f2590000
 printing eip:
c01a99a1
*pde = 004b1067
*pte = 32590000
Oops: 0002 [#1]
DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c01a99a1>]    Not tainted
EFLAGS: 00010246   (2.6.6) 
EIP is at encode_entry+0x51/0x530
eax: cc010000   ebx: 00000000   ecx: 000001cc   edx: f32dcdf8
esi: f258fffc   edi: d4ec21cc   ebp: 000001e0   esp: ebfd9b98
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1059, threadinfo=ebfd8000 task=ec000a80)
Stack: 00000006 0000002f e2c63080 00000027 00000000 e2c63080 f32dcdf8 0000000a 
       d4ec21d4 0000001c 02000001 04000900 002bed40 0019a454 00249005 0019a43b 
       00248f88 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:
 [<c016af69>] ext3_bread+0x69/0x90
 [<c0168505>] ext3_readdir+0x305/0x490
 [<c011dba7>] set_current_groups+0x37/0x40
 [<c01a9ed0>] nfs3svc_encode_entry_plus+0x0/0x50
 [<c019d930>] fh_verify+0x280/0x550
 [<c019d5d0>] nfsd_acceptable+0x0/0xe0
 [<c013da8c>] open_private_file+0x1c/0x90
 [<c014ba2d>] vfs_readdir+0x7d/0x90
 [<c01a11f9>] nfsd_readdir+0x79/0xc0
 [<c01a6b8a>] nfsd3_proc_readdirplus+0xda/0x1d0
 [<c01a9ed0>] nfs3svc_encode_entry_plus+0x0/0x50
 [<c01a8e90>] nfs3svc_decode_readdirplusargs+0x0/0x180
 [<c019bce6>] nfsd_dispatch+0xb6/0x1a0
 [<c03139fd>] svc_authenticate+0x4d/0x80
 [<c03112d7>] svc_process+0x487/0x5f0
 [<c019bad9>] nfsd+0x179/0x2d0
 [<c019b960>] nfsd+0x0/0x2d0
 [<c0101fbd>] kernel_thread_helper+0x5/0x18

Code: 89 46 04 81 7c 24 1c 00 01 00 00 b8 ff 00 00 00 8b 94 24 24 

This is causing NFS client hangs.  Bugger; time to reboot.
