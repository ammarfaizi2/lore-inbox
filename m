Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVBSPS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVBSPS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 10:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVBSPS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 10:18:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33540 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261727AbVBSPSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 10:18:23 -0500
Date: Sat, 19 Feb 2005 16:18:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: urban@teststation.com
Cc: samba@samba.org, linux-kernel@vger.kernel.org
Subject: 2.6.11-rc3-mm2: SMB: BUG: atomic counter underflow
Message-ID: <20050219151820.GE4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the following in my logs:

<--  snip  -->

Feb 19 15:46:05 r063144 kernel: smb_get_length: Invalid NBT packet, code=86
Feb 19 15:46:35 r063144 kernel: smb_add_request: request [d5242d40, mid=50934] timed out!
Feb 19 15:46:35 r063144 kernel: BUG: atomic counter underflow at:
Feb 19 15:46:35 r063144 kernel:  [<c0194201>] smb_rput+0x51/0x60
Feb 19 15:46:35 r063144 kernel:  [<c018dbf8>] smb_proc_readX+0xe8/0x100
Feb 19 15:46:35 r063144 kernel:  [<c01931b2>] smb_readpage_sync+0x92/0x110
Feb 19 15:46:35 r063144 kernel:  [<c0193247>] smb_readpage+0x17/0x60
Feb 19 15:46:35 r063144 kernel:  [<c01338ec>] read_pages+0xec/0x170
Feb 19 15:46:35 r063144 kernel:  [<c0133a5e>] __do_page_cache_readahead+0xee/0x100
Feb 19 15:46:35 r063144 kernel:  [<c0133bf0>] blockable_page_cache_readahead+0x40/0x60
Feb 19 15:46:35 r063144 kernel:  [<c0133e1b>] page_cache_readahead+0x20b/0x280
Feb 19 15:46:35 r063144 kernel:  [<c012d4de>] do_generic_mapping_read+0x3fe/0x720
Feb 19 15:46:35 r063144 kernel:  [<c012da75>] __generic_file_aio_read+0x185/0x200
Feb 19 15:46:35 r063144 kernel:  [<c012d800>] file_read_actor+0x0/0xf0
Feb 19 15:46:35 r063144 kernel:  [<c012dbfc>] generic_file_read+0x9c/0xc0
Feb 19 15:46:35 r063144 kernel:  [<c01230b0>] autoremove_wake_function+0x0/0x50
Feb 19 15:46:35 r063144 kernel:  [<c011c201>] do_sigaction+0x131/0x1b0
Feb 19 15:46:35 r063144 kernel:  [<c019350f>] smb_file_read+0x3f/0xa0
Feb 19 15:46:35 r063144 kernel:  [<c011c548>] sys_rt_sigaction+0x78/0xb0
Feb 19 15:46:35 r063144 kernel:  [<c015a4ad>] sys_select+0x36d/0x480
Feb 19 15:46:35 r063144 kernel:  [<c0149006>] vfs_read+0x126/0x130
Feb 19 15:46:35 r063144 kernel:  [<c0149291>] sys_read+0x41/0x70
Feb 19 15:46:35 r063144 kernel:  [<c010238d>] sysenter_past_esp+0x52/0x75

<--  snip  -->

This was during a time with multiple active smb connections with heavy 
read traffic (approx. 0,8 MByte/s altogether).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

