Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbTEBPlJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTEBPlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:41:09 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:38551 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S262953AbTEBPlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:41:07 -0400
Message-ID: <3EB29478.2020308@blue-labs.org>
Date: Fri, 02 May 2003 11:53:28 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030429
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: more OOPSes and things, 2.5.67
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

buffer layer error at fs/buffer.c:127
Call Trace:
 [<c0176a10>] __wait_on_buffer+0xe0/0xf0
 [<c0126b50>] autoremove_wake_function+0x0/0x50
 [<c0126b50>] autoremove_wake_function+0x0/0x50
 [<c023d548>] reiserfs_unmap_buffer+0x68/0xb0
 [<c023d5f0>] unmap_buffers+0x60/0x70
 [<c023d7fc>] indirect2direct+0x1fc/0x2f0
 [<c023b315>] reiserfs_cut_from_item+0x3d5/0x500
 [<c023b71e>] reiserfs_do_truncate+0x27e/0x560
 [<c0228eb2>] reiserfs_truncate_file+0x162/0x3c0
 [<c0241ec7>] journal_end+0x27/0x30
 [<c022a9d6>] reiserfs_file_release+0x396/0x600
 [<c03939d0>] ip_rcv+0x3d0/0x480
 [<c0393c40>] ip_rcv_finish+0x0/0x250
 [<c017610b>] __fput+0x9b/0x100
 [<c017615b>] __fput+0xeb/0x100
 [<c017429d>] filp_close+0x15d/0x230
 [<c010db75>] do_IRQ+0x225/0x340
 [<c01743d2>] sys_close+0x62/0xa0
 [<c010b0bb>] syscall_call+0x7/0xb

[repeated]

Slab corruption: start=c321e638, expend=c321e6f7, problemat=c321e660
Last user: [<c0193917>](d_callback+0x27/0x40)
Data: ****************************************4B 
***********************************************4B 
*******************************4B 
**********************************************************************A5
Next: 71 F0 2C .17 39 19 C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `dentry_cache': object was 
modified after freeing
Call Trace:
 [<c0156258>] check_poison_obj+0x158/0x1b0
 [<c0158060>] kmem_cache_alloc+0x120/0x150
 [<c0195d80>] d_alloc+0x20/0x390
 [<c0195d80>] d_alloc+0x20/0x390
 [<c0196a2e>] d_lookup+0x2e/0x50
 [<c0187a06>] real_lookup+0xb6/0x100
 [<c01882ca>] do_lookup+0xaa/0xc0
 [<c01889e1>] link_path_walk+0x701/0xd90
 [<c015613b>] check_poison_obj+0x3b/0x1b0
 [<c0158060>] kmem_cache_alloc+0x120/0x150
 [<c0123d90>] default_wake_function+0x0/0x20
 [<c01871f1>] getname+0x31/0xd0
 [<c0189519>] __user_walk+0x49/0x60
 [<c01823af>] vfs_stat+0x1f/0x60
 [<c0182a8b>] sys_stat64+0x1b/0x40
 [<c0139431>] sys_rt_sigprocmask+0x91/0x2f0
 [<c010db75>] do_IRQ+0x225/0x340
 [<c010b0bb>] syscall_call+0x7/0xb

Slab corruption: start=c321e704, expend=c321e7c3, problemat=c321e718
Last user: [<c0193917>](d_callback+0x27/0x40)
Data: ********************4B *******************************63 *******63 
**********************************************************************************************************************************A5
Next: 71 F0 2C .17 39 19 C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `dentry_cache': object was 
modified after freeing
Call Trace:
 [<c0156258>] check_poison_obj+0x158/0x1b0
 [<c0158060>] kmem_cache_alloc+0x120/0x150
 [<c0195d80>] d_alloc+0x20/0x390
 [<c0195d80>] d_alloc+0x20/0x390
 [<c0261a37>] vsprintf+0x27/0x30
 [<c0186f9f>] do_pipe+0xbf/0x1f0
 [<c0113c03>] sys_pipe+0x23/0x80
 [<c010b0bb>] syscall_call+0x7/0xb

[repeats with different values and different functions]



