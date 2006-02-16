Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWBPSgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWBPSgn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWBPSgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:36:43 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:52752 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP
	id S1030180AbWBPSgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:36:42 -0500
Date: Thu, 16 Feb 2006 19:36:29 +0100
From: bjd <bjdouma@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: kernel oops: trying to mount a corrupted xfs partition (2.6.16-rc3)
Message-ID: <20060216183629.GA5672@skyscraper.unix9.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Disclaimer: sorry
X-Operating-System: human brain v1.04E11
Organization: A training zoo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to mount a corrupted xfs partition hanging off a Promise
PDC20267 FastTrak100/Ukltra100 controller.

The partition contains a test Linux system that, due to an in-
complete install, had to be halted by brute force (i.e. power off).

After a reboot and xfs_repair the filesystem proved to be mildly
corrupted, but recoverable.

The oops is replicable.

Anyone else I need to CC to?


XFS mounting filesystem hda3
Starting XFS recovery on filesystem: hda3 (logdev: internal)
Unable to handle kernel paging request at virtual address 40000010
 printing eip:
c022d0b9
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: sunkbd serport mousedev usbhid uhci_hcd snd_seq snd_via82xx gameport snd_mpu401_uart snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_seq_device snd_util_mem snd_hwdep nvidia v4l1_compat i2c_viapro i2c_via bttv snd_bt87x snd_pcm snd_timer snd snd_page_alloc msp3400 tuner tda9887 video_buf firmware_class compat_ioctl32 v4l2_common btcx_risc ir_common tveeprom videodev i2c_dev i2c_algo_bit rtc udf ide_cd cdrom video thermal processor fan container button battery ac nls_utf8 nls_iso8859_15 nls_iso8859_1 nfsd 8250_pnp 8250_pci 8250 serial_core sk98lin dummy nfs lockd sunrpc loop floppy evdev pcspkr usbcore
CPU:    0
EIP:    0060:[xlog_recover_do_inode_trans+473/2688]    Tainted: P      VLI
EFLAGS: 00010297   (2.6.16-rc3 #2) 
EIP is at xlog_recover_do_inode_trans+0x1d9/0xa80
eax: 40000010   ebx: e774ed40   ecx: 00000010   edx: 00000000
esi: e92dd1c0   edi: 00000000   ebp: 00000080   esp: e7041aa4
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 2515, threadinfo=e7040000 task=e9a0d550)
Stack: <0>e9f93f08 00000010 00000040 00000000 00004000 c0359515 e9a0d550 c041b160 
       00000001 00010000 0880433e 40c00000 e9a569c0 c03a2a00 00000000 40000010 
       e9f93f08 e91cdc00 00000000 00000040 00000000 00000286 0010bffe e774eda4 
Call Trace:
 [schedule+1205/1664] schedule+0x4b5/0x680
 [xlog_recover_do_trans+288/384] xlog_recover_do_trans+0x120/0x180
 [kmem_zalloc+31/80] kmem_zalloc+0x1f/0x50
 [xlog_recover_commit_trans+57/80] xlog_recover_commit_trans+0x39/0x50
 [xlog_recover_process_data+378/528] xlog_recover_process_data+0x17a/0x210
 [xlog_do_recovery_pass+1744/2864] xlog_do_recovery_pass+0x6d0/0xb30
 [xlog_do_log_recovery+143/208] xlog_do_log_recovery+0x8f/0xd0
 [xlog_do_recover+59/416] xlog_do_recover+0x3b/0x1a0
 [xlog_recover+219/240] xlog_recover+0xdb/0xf0
 [xfs_log_mount+165/320] xfs_log_mount+0xa5/0x140
 [xfs_mountfs+2064/4128] xfs_mountfs+0x810/0x1020
 [__sched_text_start+7/12] __down_failed+0x7/0xc
 [xfs_setsize_buftarg_flags+64/208] xfs_setsize_buftarg_flags+0x40/0xd0
 [xfs_buf_rele+37/224] xfs_buf_rele+0x25/0xe0
 [xfs_readsb+409/560] xfs_readsb+0x199/0x230
 [xfs_ioinit+38/80] xfs_ioinit+0x26/0x50
 [xfs_mount+1001/1744] xfs_mount+0x3e9/0x6d0
 [linvfs_fill_super+161/512] linvfs_fill_super+0xa1/0x200
 [snprintf+39/48] snprintf+0x27/0x30
 [disk_name+98/208] disk_name+0x62/0xd0
 [sb_set_blocksize+46/96] sb_set_blocksize+0x2e/0x60
 [get_sb_bdev+245/336] get_sb_bdev+0xf5/0x150
 [linvfs_get_sb+47/64] linvfs_get_sb+0x2f/0x40
 [linvfs_fill_super+0/512] linvfs_fill_super+0x0/0x200
 [do_kern_mount+174/400] do_kern_mount+0xae/0x190
 [do_new_mount+131/224] do_new_mount+0x83/0xe0
 [do_mount+580/608] do_mount+0x244/0x260
 [exact_copy_from_user+50/112] exact_copy_from_user+0x32/0x70
 [copy_mount_options+96/192] copy_mount_options+0x60/0xc0
 [sys_mount+159/224] sys_mount+0x9f/0xe0
 [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
Code: 24 70 8b 6c 24 74 83 c4 78 c3 0f b7 44 24 5a 8b 4c 24 40 c7 44 24 38 00 00 00 00 89 0c 24 89 44 24 04 e8 2b b1 01 00 89 44 24 3c <0f> b7 00 89 c2 c1 e8 08 c1 e2 08 09 c2 66 81 fa 4e 49 75 67 8b 

