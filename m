Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVCUKZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVCUKZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVCUKZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:25:42 -0500
Received: from viking.sophos.com ([194.203.134.132]:15633 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261471AbVCUKZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:25:14 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 21/03/2005 10:25:00,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 21/03/2005 10:25:00,
	Serialize complete at 21/03/2005 10:25:00,
	S/MIME Sign failed at 21/03/2005 10:25:00: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 21/03/2005 10:25:10,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 21/03/2005 10:25:10,
	Serialize complete at 21/03/2005 10:25:10,
	S/MIME Sign failed at 21/03/2005 10:25:10: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 21/03/2005 10:25:13,
	Serialize complete at 21/03/2005 10:25:13
To: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Something broken on 2.6.11?
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF505229CC.1A6AA6CB-ON80256FCB.00391F2E-80256FCB.00393C75@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Mon, 21 Mar 2005 10:25:10 +0000
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Reposted due to incorrect LKML address, sorry reiserfs-devs]

Machine is a P4 with HT enabled. It was sitting around idle over the 
weekend and below is what I found this morning. More machine info 
available if needed of course.
 
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: usbserial nvram snd_pcm_oss snd_mixer_oss snd_intel8x0 
snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_TOS 
ipt_LOG ipt_limit ipt_pkttype ipt_state ipt_REJECT iptable_mangle 
iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp 
ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 af_packet usbhid 
edd joydev sg st sr_mod ide_cd cdrom ehci_hcd i2c_i801 intel_mch_agp 
agpgart uhci_hcd evdev e1000 usbcore dm_mod ata_piix libata sd_mod 
scsi_mod
CPU:    0
EIP:    0060:[<c014a0cc>]    Not tainted VLI
EFLAGS: 00010007   (2.6.11) 
EIP is at page_address+0x8c/0xd0
eax: fffffff8   ebx: c17269a0   ecx: fffffff8   edx: 00000000
esi: c0470c00   edi: c0470c08   ebp: f360cdb8   esp: f360cda4
ds: 007b   es: 007b   ss: 0068
Process mandb (pid: 10390, threadinfo=f360c000 task=f67ffa80)
Stack: 00000000 00000286 00000000 c17269a0 b7e04008 f360ce0c c014982c 
00000000 
       00000000 00000000 00000000 f360cde0 00000286 f360cde0 c0324f24 
f360cdfc 
       00000246 ff803000 00000286 c1726980 f360cdfc c17269a0 b7e03008 
00000000 
Call Trace:
 [<c0103656>] show_stack+0xa6/0xb0
 [<c01037d6>] show_registers+0x156/0x1d0
 [<c01039f4>] die+0xf4/0x180
 [<c011303d>] do_page_fault+0x4fd/0x685
 [<c01032b7>] error_code+0x2b/0x30
 [<c014982c>] kmap_high+0x1c/0x1e0
 [<c01a39d3>] reiserfs_copy_from_user_to_file_region+0x83/0x100
 [<c01a4d7b>] reiserfs_file_write+0x37b/0x710
 [<c015bd29>] vfs_write+0xc9/0x130
 [<c015be3d>] sys_write+0x3d/0x70
 [<c01027bd>] sysenter_past_esp+0x52/0x75
Code: 74 3d 8d 4a f8 8b 41 08 0f 18 00 90 39 f2 74 2f eb 0d 90 90 90 90 90 
90 90 90 90 90 90 90 90 39 19 74 36 8b 51 08 8d 42 f8 89 c1 <8b> 40 08 0f 
18 00 90 39 f2 75 e9 89 f6 8d bc 27 00 00 00 00 8b 
 <3>Debug: sleeping function called from invalid context at 
include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c0103677>] dump_stack+0x17/0x20
 [<c0118aac>] __might_sleep+0xac/0xc0
 [<c011c1e3>] profile_task_exit+0x23/0x60
 [<c011e1ec>] do_exit+0x1c/0x380
 [<c0103a76>] die+0x176/0x180
 [<c011303d>] do_page_fault+0x4fd/0x685
 [<c01032b7>] error_code+0x2b/0x30
 [<c014982c>] kmap_high+0x1c/0x1e0
 [<c01a39d3>] reiserfs_copy_from_user_to_file_region+0x83/0x100
 [<c01a4d7b>] reiserfs_file_write+0x37b/0x710
 [<c015bd29>] vfs_write+0xc9/0x130
 [<c015be3d>] sys_write+0x3d/0x70
 [<c01027bd>] sysenter_past_esp+0x52/0x75
note: mandb[10390] exited with preempt_count 2
scheduling while atomic: mandb/0x10000002/10390
 [<c0103677>] dump_stack+0x17/0x20
 [<c03236e6>] schedule+0x926/0xbb0
 [<c032410a>] cond_resched+0x2a/0x50
 [<c014b3ad>] unmap_vmas+0x1ad/0x290
 [<c014fdfb>] exit_mmap+0x8b/0x160
 [<c0119096>] mmput+0x36/0xa0
 [<c011e27c>] do_exit+0xac/0x380
 [<c0103a76>] die+0x176/0x180
 [<c011303d>] do_page_fault+0x4fd/0x685
 [<c01032b7>] error_code+0x2b/0x30
 [<c014982c>] kmap_high+0x1c/0x1e0
 [<c01a39d3>] reiserfs_copy_from_user_to_file_region+0x83/0x100
 [<c01a4d7b>] reiserfs_file_write+0x37b/0x710
 [<c015bd29>] vfs_write+0xc9/0x130
 [<c015be3d>] sys_write+0x3d/0x70
 [<c01027bd>] sysenter_past_esp+0x52/0x75
scheduling while atomic: mandb/0x00000002/10390
 [<c0103677>] dump_stack+0x17/0x20
 [<c03236e6>] schedule+0x926/0xbb0
 [<c0322bc5>] __down+0x75/0xe0
 [<c0322d52>] __down_failed+0xa/0x10
 [<c03252bb>] .text.lock.kernel_lock+0x2b/0x3a
 [<c0172dc6>] locks_remove_posix+0x86/0x150
 [<c015b1f8>] filp_close+0x48/0x90
 [<c011d527>] put_files_struct+0x67/0xc0
 [<c011e2aa>] do_exit+0xda/0x380
 [<c0103a76>] die+0x176/0x180
 [<c011303d>] do_page_fault+0x4fd/0x685
 [<c01032b7>] error_code+0x2b/0x30
 [<c014982c>] kmap_high+0x1c/0x1e0
 [<c01a39d3>] reiserfs_copy_from_user_to_file_region+0x83/0x100
 [<c01a4d7b>] reiserfs_file_write+0x37b/0x710
 [<c015bd29>] vfs_write+0xc9/0x130
 [<c015be3d>] sys_write+0x3d/0x70
 [<c01027bd>] sysenter_past_esp+0x52/0x75
scheduling while atomic: mandb/0x00000002/10390
 [<c0103677>] dump_stack+0x17/0x20
 [<c03236e6>] schedule+0x926/0xbb0
 [<c0322bc5>] __down+0x75/0xe0
 [<c0322d52>] __down_failed+0xa/0x10
 [<c03252bb>] .text.lock.kernel_lock+0x2b/0x3a
 [<c0172dc6>] locks_remove_posix+0x86/0x150
 [<c015b1f8>] filp_close+0x48/0x90
 [<c011d527>] put_files_struct+0x67/0xc0
 [<c011e2aa>] do_exit+0xda/0x380
 [<c0103a76>] die+0x176/0x180
 [<c011303d>] do_page_fault+0x4fd/0x685
 [<c01032b7>] error_code+0x2b/0x30
 [<c014982c>] kmap_high+0x1c/0x1e0
 [<c01a39d3>] reiserfs_copy_from_user_to_file_region+0x83/0x100
 [<c01a4d7b>] reiserfs_file_write+0x37b/0x710
 [<c015bd29>] vfs_write+0xc9/0x130
 [<c015be3d>] sys_write+0x3d/0x70
 [<c01027bd>] sysenter_past_esp+0x52/0x75
scheduling while atomic: mandb/0x00000002/10390
 [<c0103677>] dump_stack+0x17/0x20
 [<c03236e6>] schedule+0x926/0xbb0
 [<c0322bc5>] __down+0x75/0xe0
 [<c0322d52>] __down_failed+0xa/0x10
 [<c03252bb>] .text.lock.kernel_lock+0x2b/0x3a
 [<c0172dc6>] locks_remove_posix+0x86/0x150
 [<c015b1f8>] filp_close+0x48/0x90
 [<c011d527>] put_files_struct+0x67/0xc0
 [<c011e2aa>] do_exit+0xda/0x380
 [<c0103a76>] die+0x176/0x180
 [<c011303d>] do_page_fault+0x4fd/0x685
 [<c01032b7>] error_code+0x2b/0x30
 [<c014982c>] kmap_high+0x1c/0x1e0
 [<c01a39d3>] reiserfs_copy_from_user_to_file_region+0x83/0x100
 [<c01a4d7b>] reiserfs_file_write+0x37b/0x710
 [<c015bd29>] vfs_write+0xc9/0x130
 [<c015be3d>] sys_write+0x3d/0x70
 [<c01027bd>] sysenter_past_esp+0x52/0x75
scheduling while atomic: mandb/0x00000002/10390
 [<c0103677>] dump_stack+0x17/0x20
 [<c03236e6>] schedule+0x926/0xbb0
 [<c0322bc5>] __down+0x75/0xe0
 [<c0322d52>] __down_failed+0xa/0x10
 [<c03252bb>] .text.lock.kernel_lock+0x2b/0x3a
 [<c0172dc6>] locks_remove_posix+0x86/0x150
 [<c015b1f8>] filp_close+0x48/0x90
 [<c011d527>] put_files_struct+0x67/0xc0
 [<c011e2aa>] do_exit+0xda/0x380
 [<c0103a76>] die+0x176/0x180
 [<c011303d>] do_page_fault+0x4fd/0x685
 [<c01032b7>] error_code+0x2b/0x30
 [<c014982c>] kmap_high+0x1c/0x1e0
 [<c01a39d3>] reiserfs_copy_from_user_to_file_region+0x83/0x100
 [<c01a4d7b>] reiserfs_file_write+0x37b/0x710
 [<c015bd29>] vfs_write+0xc9/0x130
 [<c015be3d>] sys_write+0x3d/0x70
 [<c01027bd>] sysenter_past_esp+0x52/0x75
Debug: sleeping function called from invalid context at 
fs/file_table.c:125
in_atomic():1, irqs_disabled():0
 [<c0103677>] dump_stack+0x17/0x20
 [<c0118aac>] __might_sleep+0xac/0xc0
 [<c015ca29>] __fput+0x29/0x170
 [<c015b1ff>] filp_close+0x4f/0x90
 [<c011d527>] put_files_struct+0x67/0xc0
 [<c011e2aa>] do_exit+0xda/0x380
 [<c0103a76>] die+0x176/0x180
 [<c011303d>] do_page_fault+0x4fd/0x685
 [<c01032b7>] error_code+0x2b/0x30
 [<c014982c>] kmap_high+0x1c/0x1e0
 [<c01a39d3>] reiserfs_copy_from_user_to_file_region+0x83/0x100
 [<c01a4d7b>] reiserfs_file_write+0x37b/0x710
 [<c015bd29>] vfs_write+0xc9/0x130
 [<c015be3d>] sys_write+0x3d/0x70
 [<c01027bd>] sysenter_past_esp+0x52/0x75



