Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbTEVKAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 06:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbTEVKAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 06:00:38 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:42685 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262270AbTEVKAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 06:00:34 -0400
Subject: use-after-free in smbfs on 2.5.69-mm5
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: urban@teststation.com
Cc: linux-kernel@vger.kernel.org, samba@samba.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053598415.15182.23.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 May 2003 12:13:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Urban

smbfs modifies some memory after free...

smb_get_length: Invalid NBT packet, code=4a
smb_add_request: request [d828617c, mid=1802201963] timed out!
Slab corruption: start=d828617c, expend=d8286287, problemat=d8286184
Last user: [<ec992e35>](smb_free_request+0x45/0x4c [smbfs])
Data: ********6A ***********************************************************************************************************************************************************************************************************************************************************02 00 58 00 FB FF FF FF 
Next: 71 F0 2C .35 2E 99 EC 71 F0 2C .********************
slab error in check_poison_obj(): cache `smb_request': object was modified after freeing
Call Trace:
 [<c013d61d>] __slab_error+0x21/0x28
 [<ec9966b5>] +0x2b95/0x30e0 [smbfs]
 [<c013d8cc>] check_poison_obj+0x174/0x180
 [<c013f287>] kmem_cache_alloc+0xaf/0x150
 [<ec992d2e>] smb_do_alloc_request+0x1e/0xb4 [smbfs]
 [<ec992d2e>] smb_do_alloc_request+0x1e/0xb4 [smbfs]
 [<ec992de4>] smb_alloc_request+0x20/0x2c [smbfs]
 [<ec98c439>] smb_proc_open+0x3d/0xfc [smbfs]
 [<ec98cae1>] smb_proc_readX+0xe5/0xf4 [smbfs]
 [<ec98c54e>] smb_open+0x56/0xcc [smbfs]
 [<ec991889>] smb_readpage_sync+0x85/0x158 [smbfs]
 [<ec991974>] smb_readpage+0x18/0x50 [smbfs]
 [<c013cfa6>] read_pages+0xa6/0x120
 [<c013d2f7>] do_page_cache_readahead+0x2d7/0x324
 [<c013d43b>] page_cache_readahead+0xf7/0x12c
 [<c0137938>] do_generic_mapping_read+0x64/0x328
 [<c0137e90>] __generic_file_aio_read+0x184/0x1a0
 [<c0137bfc>] file_read_actor+0x0/0x110
 [<c0137f77>] generic_file_read+0x7f/0x9c
 [<c015763f>] do_sync_write+0x7f/0xb0
 [<ec8f0f18>] rtc_wait+0x18/0x20 [rtc]
 [<c0117383>] default_wake_function+0x17/0x1c
 [<c01173c2>] __wake_up_common+0x3a/0x54
 [<ec8f0f00>] rtc_wait+0x0/0x20 [rtc]
 [<ec8f0f30>] rtc_task_lock+0x0/0x18 [rtc]
 [<c016b61a>] kill_fasync+0x16/0x1c
 [<ec991c32>] smb_file_read+0x4e/0x5c [smbfs]
 [<c015758e>] vfs_read+0xa2/0xd4
 [<c0157770>] sys_read+0x30/0x50
 [<c0109853>] syscall_call+0x7/0xb


-- 
/Martin
