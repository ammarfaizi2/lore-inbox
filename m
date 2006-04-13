Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWDMFVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWDMFVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 01:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWDMFVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 01:21:49 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:59795 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964795AbWDMFVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 01:21:49 -0400
Date: Thu, 13 Apr 2006 07:21:45 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com
Subject: 2.6.17-rc1 did break XFS 
Message-ID: <20060413052145.GA31435@MAIL.13thfloor.at>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
	linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# grep XFS .config
CONFIG_XFS_FS=y
CONFIG_XFS_EXPORT=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set

if you need more information, please let me know ...

best,
Herbert


[   39.585041] BUG: unable to handle kernel paging request at virtual address 7856c380
[   39.586688]  printing eip:
[   39.587040] 78129430
[   39.587354] *pde = 005bf027
[   39.587709] *pte = 0056c000
[   39.588201] Oops: 0000 [#1]
[   39.588536] SMP DEBUG_PAGEALLOC
[   39.589057] Modules linked in:
[   39.589639] CPU:    0
[   39.589670] EIP:    0060:[<78129430>]    Not tainted VLI
[   39.589710] EFLAGS: 00000206   (2.6.17-rc1 #1) 
[   39.591291] EIP is at notifier_chain_register+0x20/0x50
[   39.591890] eax: 7856c378   ebx: 878db3f8   ecx: 00000000   edx: 784bf9bc
[   39.592601] esi: 878db3f8   edi: 878e7c00   ebp: 878db800   esp: 878cad5c
[   39.593399] ds: 007b   es: 007b   ss: 0068
[   39.593896] Process mount (pid: 50, threadinfo=878ca000 task=87f7e570)
[   39.594530] Stack: <0>784bf9a0 781295f4 784bf9bc 878db3f8 878db000 878db000 78136997 784bf9a0 
[   39.595839]        878db3f8 782d43e6 878db3f8 00000404 878db000 87d1e6a0 878e7c00 782d1813 
[   39.597002]        878db000 00000001 782e5eaf 00000424 00000001 878e7c00 87d1e6a0 782f2150 
[   39.598164] Call Trace:
[   39.598592]  <781295f4> blocking_notifier_chain_register+0x54/0x90   <78136997> register_cpu_notifier+0x17/0x20
[   39.600024]  <782d43e6> xfs_icsb_init_counters+0x46/0xb0   <782d1813> xfs_mount_init+0x23/0x160
[   39.601199]  <782e5eaf> kmem_zalloc+0x1f/0x50   <782f2150> bhv_insert_all_vfsops+0x10/0x50
[   39.602315]  <782f1835> xfs_fs_fill_super+0x35/0x1f0   <78313607> snprintf+0x27/0x30
[   39.603437]  <781a2134> disk_name+0x64/0xc0   <78168fbf> sb_set_blocksize+0x1f/0x50
[   39.604524]  <78168909> get_sb_bdev+0x109/0x160   <781445ef> __alloc_pages+0x5f/0x370
[   39.605612]  <782f1a20> xfs_fs_get_sb+0x30/0x40   <782f1800> xfs_fs_fill_super+0x0/0x1f0
[   39.606698]  <78168bb0> do_kern_mount+0xa0/0x160   <78181467> do_new_mount+0x77/0xc0
[   39.607764]  <78181b2f> do_mount+0x1bf/0x220   <783f4178> iret_exc+0x3d4/0x6ab
[   39.608790]  <78181913> copy_mount_options+0x63/0xc0   <783f398f> lock_kernel+0x2f/0x50
[   39.609867]  <78181f2f> sys_mount+0x9f/0xe0   <78102b27> syscall_call+0x7/0xb
[   39.610923] Code: 90 90 90 90 90 90 90 90 90 90 90 53 8b 54 24 08 8b 5c 24 0c 8b 02 85 c0 74 31 8b 4b 08 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 <3b> 48 08 7f 1b 8d 50 04 8b 40 04 85 c0 75 f1 31 c0 eb 0d 90 90 
[   39.615306]  <3>BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
[   39.616413] in_atomic():0, irqs_disabled():1
[   39.616918]  <781189f4> __might_sleep+0xa4/0xb0   <7811de7a> exit_mm+0x3a/0x170
[   39.617953]  <7811e74c> do_exit+0xfc/0x420   <7811c217> printk+0x17/0x20
[   39.618902]  <78103ef7> die+0x1e7/0x1f0   <78112b34> do_page_fault+0x334/0x690
[   39.619988]  <7815c407> cache_grow+0x157/0x1a0   <78112800> do_page_fault+0x0/0x690
[   39.621106]  <78103627> error_code+0x4f/0x54   <78129430> notifier_chain_register+0x20/0x50
[   39.622317]  <781295f4> blocking_notifier_chain_register+0x54/0x90   <78136997> register_cpu_notifier+0x17/0x20
[   39.623764]  <782d43e6> xfs_icsb_init_counters+0x46/0xb0   <782d1813> xfs_mount_init+0x23/0x160
[   39.625010]  <782e5eaf> kmem_zalloc+0x1f/0x50   <782f2150> bhv_insert_all_vfsops+0x10/0x50
[   39.626207]  <782f1835> xfs_fs_fill_super+0x35/0x1f0   <78313607> snprintf+0x27/0x30
[   39.627354]  <781a2134> disk_name+0x64/0xc0   <78168fbf> sb_set_blocksize+0x1f/0x50
[   39.628486]  <78168909> get_sb_bdev+0x109/0x160   <781445ef> __alloc_pages+0x5f/0x370
[   39.629634]  <782f1a20> xfs_fs_get_sb+0x30/0x40   <782f1800> xfs_fs_fill_super+0x0/0x1f0
[   39.630799]  <78168bb0> do_kern_mount+0xa0/0x160   <78181467> do_new_mount+0x77/0xc0
[   39.631939]  <78181b2f> do_mount+0x1bf/0x220   <783f4178> iret_exc+0x3d4/0x6ab
[   39.633023]  <78181913> copy_mount_options+0x63/0xc0   <783f398f> lock_kernel+0x2f/0x50
[   39.634154]  <78181f2f> sys_mount+0x9f/0xe0   <78102b27> syscall_call+0x7/0xb


