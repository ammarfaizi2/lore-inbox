Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282936AbRK1O5p>; Wed, 28 Nov 2001 09:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279950AbRK1O5f>; Wed, 28 Nov 2001 09:57:35 -0500
Received: from node10450.a2000.nl ([24.132.4.80]:60288 "EHLO awacs.dhs.org")
	by vger.kernel.org with ESMTP id <S282936AbRK1O5R>;
	Wed, 28 Nov 2001 09:57:17 -0500
Date: Wed, 28 Nov 2001 15:57:16 +0100
From: Pascal Haakmat <a.haakmat@chello.nl>
To: linux-kernel@vger.kernel.org
Subject: XFS Oopses with 2.4.5 and 2.4.14?
Message-ID: <20011128155716.A7302@awacs.dhs.org>
In-Reply-To: <000701c177e6$7317af40$ea9133d5@groni1.gr.nl.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000701c177e6$7317af40$ea9133d5@groni1.gr.nl.home.com>; from l.a.van.der.duim.st@ppsw.rug.nl on Wed, Nov 28, 2001 at 09:26:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the following Oopses, is it wise to continue running the XFS
filesystem, or might there be some other underlying problem that is causing
these Oopses?

Kernel 2.4.5 + XFS 1.0.1:

Nov 25 07:28:23 awacs kernel: Unable to handle kernel paging request at virtual address 0cb73058
Nov 25 07:28:23 awacs kernel:  printing eip:
Nov 25 07:28:23 awacs kernel: c01d6493
Nov 25 07:28:23 awacs kernel: *pde = 00000000
Nov 25 07:28:23 awacs kernel: Oops: 0000
Nov 25 07:28:23 awacs kernel: CPU:    0
Nov 25 07:28:23 awacs kernel: EIP: 0010:[xfs_inactive_free_eofblocks+615/720]
Nov 25 07:28:23 awacs kernel: EFLAGS: 00010206
Nov 25 07:28:23 awacs kernel: eax: 0cb73000   ebx: dfecf400   ecx: dfecf400 edx: ce19b830
Nov 25 07:28:23 awacs kernel: esi: c0042bd8   edi: da742f20   ebp: 00000000 esp: dffe7f2c
Nov 25 07:28:23 awacs kernel: ds: 0018   es: 0018   ss: 0018
Nov 25 07:28:23 awacs kernel: Process kupdated (pid: 6, stackpage=dffe7000)
Nov 25 07:28:23 awacs kernel: Stack: dfec6c00 00000000 dfec6c44 dffe6650 00000001 dfecf514 00000010 00000001 
Nov 25 07:28:23 awacs kernel:        dfecf514 00000000 00000010 00000001 00000000 00000008 00000008 00000040 
Nov 25 07:28:23 awacs kernel:        00000000 00000000 00000000 de64d500 df196f20 00000026 dfaeaa00 00000000 
Nov 25 07:28:23 awacs kernel: Call Trace: [xfs_inactive_free_eofblocks+17/720] [load_msg+176/240] [block_write+1347/1376] [do_remount+122/172] [do_mount+537/740] [kernel_thread+35/48] 
Nov 25 07:28:23 awacs kernel: 
Nov 25 07:28:23 awacs kernel: Code: f7 40 58 ff 01 00 00 75 14 66 83 be 52 01 00 00 00 75 0a 8b 

Kernel 2.4.14 + XFS 1.0.2:

Nov 26 04:16:23 awacs kernel: Unable to handle kernel paging request at virtual address ff689108
Nov 26 04:16:23 awacs kernel:  printing eip:
Nov 26 04:16:23 awacs kernel: c01c5955
Nov 26 04:16:23 awacs kernel: *pde = 00000000
Nov 26 04:16:23 awacs kernel: Oops: 0000
Nov 26 04:16:23 awacs kernel: CPU:    1
Nov 26 04:16:23 awacs kernel: EIP:    0010:[xfs_syncsub+2309/3056]    Not tainted
Nov 26 04:16:23 awacs kernel: EFLAGS: 00010246
Nov 26 04:16:23 awacs kernel: eax: 00000000   ebx: 00000000   ecx: dffbe914 edx: c490bbd8
Nov 26 04:16:23 awacs kernel: esi: ff689100   edi: c84ab740   ebp: c03c4760 esp: c1955f24
Nov 26 04:16:23 awacs kernel: ds: 0018   es: 0018   ss: 0018
Nov 26 04:16:23 awacs kernel: Process kupdated (pid: 7, stackpage=c1955000)
Nov 26 04:16:23 awacs kernel: Stack: dffbe914 00000001 00000001 00000000 00000001 00000008 00000008 00000040 
Nov 26 04:16:23 awacs kernel:        00000000 00000000 00000000 dd2bda00 c79a91a0 c197bfac c0114539 c1955f9c 
Nov 26 04:16:23 awacs kernel:        de302f40 dbde0000 0000001a 00000046 00000286 00000001 00000286 00000003 
Nov 26 04:16:23 awacs kernel: Call Trace: [schedule+969/1504] [xfs_sync+21/32] [linvfs_write_super+42/48] [sync_supers+199/256] [sync_old_buffers+44/128]
Nov 26 04:16:23 awacs kernel:    [kupdate+317/336] [_stext+0/64] [kernel_thread+38/48] [kupdate+0/336] 
Nov 26 04:16:23 awacs kernel: 
Nov 26 04:16:23 awacs kernel: Code: 39 56 08 0f 85 22 f8 ff ff 8b 44 24 78 05 14 01 00 00 50 e8 
