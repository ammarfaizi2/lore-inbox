Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUBILMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 06:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUBILMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 06:12:35 -0500
Received: from 213-145-178-72.dd.nextgentel.com ([213.145.178.72]:3671 "EHLO
	terminal124.gozu.lan") by vger.kernel.org with ESMTP
	id S264903AbUBILMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 06:12:32 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc1-mm1 - Badness in kobject_get
References: <1ngdf-3Qx-1@gated-at.bofh.it>
From: s864@ii.uib.no (Ronny V. Vindenes)
Date: 09 Feb 2004 12:12:20 +0100
In-Reply-To: <1ngdf-3Qx-1@gated-at.bofh.it>
Message-ID: <m3ptcotskr.fsf@terminal124.gozu.lan>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During boot I get:

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00002c6405]
Badness in kobject_get at lib/kobject.c:431
Call Trace:
 [<c020d15c>] kobject_get+0x4c/0x50
 [<c025ca28>] get_device+0x18/0x30
 [<c025d6a3>] bus_for_each_dev+0x63/0xc0
 [<c02a9fdd>] nodemgr_node_probe+0x4d/0x130
 [<c02a9ea0>] nodemgr_probe_ne_cb+0x0/0x90
 [<c02aa439>] nodemgr_host_thread+0x179/0x1a0
 [<c02aa2c0>] nodemgr_host_thread+0x0/0x1a0
 [<c0109289>] kernel_thread_helper+0x5/0xc
                                                                               
Unable to handle kernel paging request at virtual address b828ec83
 printing eip:
b828ec83
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<b828ec83>]    Not tainted VLI
EFLAGS: 00010282
EIP is at 0xb828ec83
eax: b828ec83   ebx: c03dd7c4   ecx: f019bf9c   edx: 00000000
esi: c02a98a0   edi: 00000000   ebp: c02a8570   esp: f019bf40
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 14, threadinfo=f019a000 task=f01b2670)
Stack: c020d1f8 c03dd7c4 c03dd7a0 c03dd7a8 c03dd700 f0161c44 c025d6c0 c03dd7c4
       f019bf9c c03dd74c 00000000 f0161c3c f019bf9c f01adb58 f019bf9c c02a9fdd
       c03dd700 f0161c3c f019bf9c c02a9ea0 f03a8000 f01adb58 f03a8000 f01adb58
Call Trace:
 [<c020d1f8>] kobject_cleanup+0x98/0xa0
 [<c025d6c0>] bus_for_each_dev+0x80/0xc0
 [<c02a9fdd>] nodemgr_node_probe+0x4d/0x130
 [<c02a9ea0>] nodemgr_probe_ne_cb+0x0/0x90
 [<c02aa439>] nodemgr_host_thread+0x179/0x1a0
 [<c02aa2c0>] nodemgr_host_thread+0x0/0x1a0
 [<c0109289>] kernel_thread_helper+0x5/0xc
                                                                              
Code:  Bad EIP value.
 <7>request_module: failed /sbin/modprobe -- selinuxfs. error = 256
hub 3-0:1.0: new USB device on port 2, assigned address 2

Doesn't happen in 2.6.2-rc2-mm2.

-- 
Ronny V. Vindenes <s864@ii.uib.no>
