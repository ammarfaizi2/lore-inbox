Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030575AbWBHUH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbWBHUH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbWBHUH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:07:59 -0500
Received: from mout.perfora.net ([217.160.230.40]:6370 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S1030575AbWBHUH6 (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:07:58 -0500
Message-ID: <43EA4F95.3090501@rajgad.com>
Date: Wed, 08 Feb 2006 12:07:49 -0800
From: "Amit D. Chaudhary" <amit_ml@rajgad.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: fedora-devel-list@redhat.com, Linux-Kernel@vger.kernel.org
Subject: Kernel BUG at "mm/page_alloc.c":413 due to invalid operand: 0000
 on AMD 64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:49a32e510da81d164d776cf3f249f025
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While using a program that does lot of file manipulation on a dual 
processor AMD Opteron system, the system reboots. During one of the two 
times it happened, the following ended up in the /var/log/messages. The 
problem is not reproducible, it just happens in a few days.
The kernel is from Fedora Core 3, but not the latest. There are no other 
kernel modules.

I have searched on the mailing lists, but nothing specific to this.
Any ideas on what might be wrong?

Thanks
Amit

PS: Cross-posting to linux-kernel and fedora-devel just incase the issue 
is not of core kernel.

Kernel version:
Feb  6 10:45:54 GEN kernel: Linux version 2.6.12-1.1372_FC3smp 
(bhcompile@crowe.devel.redhat.com) (gcc version 3.4.3 20050227 (Red Hat 
3.4.3-22)) #1 SMP Fri Jul 15 01:08:54 EDT 2005


Feb  2 18:55:47 nc-analyzer kernel: ----------- [cut here ] --------- 
[please bite here ] ---------
Feb  2 18:55:47 nc-analyzer kernel: Kernel BUG at "mm/page_alloc.c":413
Feb  2 18:55:47 nc-analyzer kernel: invalid operand: 0000 [1] SMP
Feb  2 18:55:47 nc-analyzer kernel: CPU 0
Feb  2 18:55:47 nc-analyzer kernel: Modules linked in: md5 ipv6 
ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod video 
button battery ac ohci_hcd i2c_amd8111 i2c_core hw_random tg3 floppy 
ext3 jbd 3w_9xxx sd_mod scsi_mod
Feb  2 18:55:47 nc-analyzer kernel: Pid: 3161, comm: AgentEventRecor Not 
tainted 2.6.12-1.1372_FC3smp
Feb  2 18:55:47 nc-analyzer kernel: RIP: 0010:[<ffffffff80166454>] 
<ffffffff80166454>{__rmqueue+196}
Feb  2 18:55:47 nc-analyzer kernel: RSP: 0018:ffff81024a149a18  EFLAGS: 
00010002
Feb  2 18:55:47 nc-analyzer kernel: RAX: 0000000000000001 RBX: 
ffff810000017418 RCX: ffff810000015000
Feb  2 18:55:47 nc-analyzer kernel: RDX: 000000000012d340 RSI: 
0000000000001000 RDI: ffff810000016300
Feb  2 18:55:47 nc-analyzer kernel: RBP: ffff8100051e3600 R08: 
0000000000000001 R09: 0000000000000001
Feb  2 18:55:47 nc-analyzer kernel: R10: 0000000000000001 R11: 
0000000000000000 R12: 0000000000000040
Feb  2 18:55:47 nc-analyzer kernel: R13: 0000000000000006 R14: 
ffff810000016300 R15: ffff8100051e2800
Feb  2 18:55:47 nc-analyzer kernel: FS:  00002aaaaba8b3a0(0000) 
GS:ffffffff80502200(0000) knlGS:0000000000000000
Feb  2 18:55:47 nc-analyzer kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Feb  2 18:55:47 nc-analyzer kernel: CR2: 000000000069d000 CR3: 
000000012d23f000 CR4: 00000000000006e0
Feb  2 18:55:47 nc-analyzer kernel: Process AgentEventRecor (pid: 3161, 
threadinfo ffff81024a148000, task ffff8102fbd99840)
Feb  2 18:55:47 nc-analyzer kernel: Stack: 0000000000000286 
ffff810000016380 ffff810000016300 0000000000000000
Feb  2 18:55:47 nc-analyzer kernel:        ffff810000016390 
0000000000000002 0000000000000000 ffffffff8016692c
Feb  2 18:55:47 nc-analyzer kernel:        0000000000000292 
ffff810000017380
Feb  2 18:55:47 nc-analyzer kernel: Call 
Trace:<ffffffff8016692c>{buffered_rmqueue+172} 
<ffffffff80166d17>{__alloc_pages+231}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80163e11>{generic_file_buffered_write+417}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff8013da95>{current_fs_time+85} 
<ffffffff80209e72>{copy_user_generic_c+8}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff801a18ee>{inode_update_time+62} 
<ffffffff8016484a>{__generic_file_aio_write_nolock+970}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80162eb0>{file_read_actor+0} 
<ffffffff80164a2e>{__generic_file_write_nolock+158}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80164f5f>{__generic_file_aio_read+431} 
<ffffffff8017366f>{do_no_page+879}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff8014f020>{autoremove_wake_function+0} 
<ffffffff80185d8d>{do_sync_read+173}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80164ac5>{generic_file_writev+117} 
<ffffffff8018658f>{do_readv_writev+399}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80185f20>{do_sync_write+0} <ffffffff8034e782>{thread_return+155}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff8014f020>{autoremove_wake_function+0} 
<ffffffff801bdaee>{dnotify_parent+46}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80186823>{sys_writev+83} <ffffffff8010eaa6>{system_call+126}
Feb  2 18:55:47 nc-analyzer kernel:        
Feb  2 18:55:47 nc-analyzer kernel:
Feb  2 18:55:47 nc-analyzer kernel: Code: 0f 0b 77 01 37 80 ff ff ff ff 
9d 01 48 8b 13 48 8d 45 28 48
Feb  2 18:55:47 nc-analyzer kernel: RIP 
<ffffffff80166454>{__rmqueue+196} RSP <ffff81024a149a18>
Feb  2 18:55:47 nc-analyzer kernel:  <3>Debug: sleeping function called 
from invalid context at include/linux/rwsem.h:43
Feb  2 18:55:47 nc-analyzer kernel: in_atomic():0, irqs_disabled():1
Feb  2 18:55:47 nc-analyzer kernel:
Feb  2 18:55:47 nc-analyzer kernel: Call 
Trace:<ffffffff80132435>{__might_sleep+197} 
<ffffffff801394c9>{profile_task_exit+41}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff8013ae12>{do_exit+34} <ffffffff8025ea75>{do_unblank_screen+53}
Feb  2 18:55:47 nc-analyzer kernel:        <ffffffff8011047d>{die+77} 
<ffffffff801108c1>{do_invalid_op+145}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80166454>{__rmqueue+196} 
<ffffffff8803f926>{:jbd:do_get_write_access+1446}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff8010f5c9>{error_exit+0} <ffffffff80166454>{__rmqueue+196}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80166450>{__rmqueue+192} <ffffffff8016692c>{buffered_rmqueue+172}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80166d17>{__alloc_pages+231} 
<ffffffff80163e11>{generic_file_buffered_write+417}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff8013da95>{current_fs_time+85} 
<ffffffff80209e72>{copy_user_generic_c+8}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff801a18ee>{inode_update_time+62} 
<ffffffff8016484a>{__generic_file_aio_write_nolock+970}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80162eb0>{file_read_actor+0} 
<ffffffff80164a2e>{__generic_file_write_nolock+158}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80164f5f>{__generic_file_aio_read+431} 
<ffffffff8017366f>{do_no_page+879}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff8014f020>{autoremove_wake_function+0} 
<ffffffff80185d8d>{do_sync_read+173}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80164ac5>{generic_file_writev+117} 
<ffffffff8018658f>{do_readv_writev+399}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80185f20>{do_sync_write+0} <ffffffff8034e782>{thread_return+155}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff8014f020>{autoremove_wake_function+0} 
<ffffffff801bdaee>{dnotify_parent+46}
Feb  2 18:55:47 nc-analyzer kernel:        
<ffffffff80186823>{sys_writev+83} <ffffffff8010eaa6>{system_call+126}
Feb  2 18:55:47 nc-analyzer kernel:        


