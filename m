Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVLXUDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVLXUDt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 15:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVLXUDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 15:03:49 -0500
Received: from kenga.kmv.ru ([217.13.212.5]:33200 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id S1750705AbVLXUDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 15:03:48 -0500
Date: Sat, 24 Dec 2005 23:03:36 +0300
From: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc6 OOPS 
Message-ID: <20051224200336.GF12561@kmv.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Data-Status: msg.XXMzN6hQ:11134@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
Please, CC me, i'm not subscribed.

Kernel 2.6.15-rc6 OOPS:

kernel: general protection fault: 0000 [#1]
kernel: SMP
kernel: Modules linked in: ipt_REDIRECT ipt_LOG ipt_TOS ipt_TCPMSS ipt_tos
ip_nat_ftp ipt_tcpmss iptable_nat ip_nat iptable_mangle iptable_filter
ipt_multiport ipt_mac ipt_state ipt_limit ipt_conntrack ip_conntrack_ftp 
ip_conntrack ip_tables af_packet ipv6 pcspkr floppy i2c_piix4 i2c_core 
ohci_hcd usbcore aic7xxx scsi_transport_spi psmouse ide_disk ide_cd 
cdrom genrtc
kernel: CPU:    0
kernel: EIP:    0060:[<c019d70f>]    Not tainted VLI
kernel: EFLAGS: 00010286   (2.6.15-rc6)
kernel: EIP is at ext3_find_entry+0x18f/0x3e0
kernel: eax: ffffffff   ebx: 00010001   ecx: 00000002   edx: 00000000
kernel: esi: 00000000   edi: ffffffff   ebp: 00000000   esp: f71b9d60
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process smbd (pid: 2999, threadinfo=f71b8000 task=f7aee530)
kernel: Stack: 00000000 f71b9db8 00000000 00000027 000005b4 ffffffff f71a62e8 00000000
kernel:        f71b9ea8 00001000 f71a636c 00000001 00000001 00010001 00000001 00000000
kernel:        00000000 00000000 f7caf400 f71b9df0 f71503d4 ffffffff 00000000 f7159c68
kernel: Call Trace:
kernel:  [<c025eb29>] memcpy_toiovec+0x29/0x50
kernel:  [<c019dbda>] ext3_lookup+0x3a/0xc0
kernel:  [<c0167c8e>] real_lookup+0xae/0xd0
kernel:  [<c0167f35>] do_lookup+0x85/0x90
kernel:  [<c016872f>] __link_path_walk+0x7ef/0xdd0
kernel:  [<c0168d5e>] link_path_walk+0x4e/0xd0
kernel:  [<c016907f>] path_lookup+0x9f/0x170
kernel:  [<c01693cf>] __user_walk+0x2f/0x60
kernel:  [<c0163b5d>] vfs_stat+0x1d/0x60
kernel:  [<c01641df>] sys_stat64+0xf/0x30
kernel:  [<c0121271>] sys_gettimeofday+0x21/0x60
kernel:  [<c0102e59>] syscall_call+0x7/0xb
kernel: Code: 07 7e 88 89 f6 8d bc 27 00 00 00 00 8b 5c 24 34 8b 44 9c 5c 43 89
5c 24 34 85 c0 89 44 24 14 89 44 24 54 0f 84 b7 00 00 00 89 c7 <8b> 00 a8 04 75
07 8b 47 0c 85 c0 75 11 8b 44 24 14 e8 fb e1 fb

After OOPS system work, but smbd process in 'D' state:

kernel: smbd          D 00000000     0  3000   2871          3001  2872 (NOTLB)
kernel: f71b9dbc 000005b4 000005b4 00000000 00000000 f71b9ea8 c1b70dc0 00000000
kernel:        7fffffff c031d940 c1807400 00000000 998db100 003d099f c0300b20 f7aee530
kernel:        f7aee658 f71a63e0 f71a63e8 00000292 f7aee530 c02ba525 00000001 f7aee530
kernel: Call Trace:
kernel:  [<c02ba525>] __down+0x75/0xe0
kernel:  [<c0118d70>] default_wake_function+0x0/0x10
kernel:  [<c0172804>] __d_lookup+0xa4/0x110
kernel:  [<c02b8e8f>] __down_failed+0x7/0xc
kernel:  [<c016bb42>] .text.lock.namei+0x8/0x1e6
kernel:  [<c0167f35>] do_lookup+0x85/0x90
kernel:  [<c016872f>] __link_path_walk+0x7ef/0xdd0
kernel:  [<c0168d5e>] link_path_walk+0x4e/0xd0
kernel:  [<c017ce14>] __mark_inode_dirty+0x104/0x1b0
kernel:  [<c016907f>] path_lookup+0x9f/0x170
kernel:  [<c01693cf>] __user_walk+0x2f/0x60
kernel:  [<c0163b5d>] vfs_stat+0x1d/0x60
kernel:  [<c017ce14>] __mark_inode_dirty+0x104/0x1b0
kernel:  [<c0121a0f>] current_fs_time+0x5f/0x70
kernel:  [<c01641df>] sys_stat64+0xf/0x30
kernel:  [<c0174832>] update_atime+0x52/0x90
kernel:  [<c016cdc5>] vfs_readdir+0x85/0x90
kernel:  [<c0171891>] dput+0x71/0x1b0
kernel:  [<c01763bb>] mntput_no_expire+0x1b/0x70
kernel:  [<c0159d8c>] filp_close+0x3c/0x80
kernel:  [<c0102e59>] syscall_call+0x7/0xb

kernel: smbd          D 00000000     0  3001   2871          3008  3000 (NOTLB)
kernel: f71fbdbc 000005b4 000005b4 00000000 00000000 f71fbea8 c1b70e60 00000000
kernel:        7fffffff c031d940 c1807400 00000000 0dfc9800 003d09ad c0300b20 f7aeea30
kernel:        f7aeeb58 f71a63e0 f71a63e8 00000292 f7aeea30 c02ba525 00000001 f7aeea30
kernel: Call Trace:
kernel:  [<c02ba525>] __down+0x75/0xe0
kernel:  [<c0118d70>] default_wake_function+0x0/0x10
kernel:  [<c0172804>] __d_lookup+0xa4/0x110
kernel:  [<c02b8e8f>] __down_failed+0x7/0xc
kernel:  [<c016bb42>] .text.lock.namei+0x8/0x1e6
kernel:  [<c0167f35>] do_lookup+0x85/0x90
kernel:  [<c016872f>] __link_path_walk+0x7ef/0xdd0
kernel:  [<c0168d5e>] link_path_walk+0x4e/0xd0
kernel:  [<c017cd72>] __mark_inode_dirty+0x62/0x1b0
kernel:  [<c016907f>] path_lookup+0x9f/0x170
kernel:  [<c01693cf>] __user_walk+0x2f/0x60
kernel:  [<c0163b5d>] vfs_stat+0x1d/0x60
kernel:  [<c017cd72>] __mark_inode_dirty+0x62/0x1b0
kernel:  [<c0121a0f>] current_fs_time+0x5f/0x70
kernel:  [<c01641df>] sys_stat64+0xf/0x30
kernel:  [<c0174832>] update_atime+0x52/0x90
kernel:  [<c016cdc5>] vfs_readdir+0x85/0x90
kernel:  [<c0171891>] dput+0x71/0x1b0
kernel:  [<c01763bb>] mntput_no_expire+0x1b/0x70
kernel:  [<c0159d8c>] filp_close+0x3c/0x80
kernel:  [<c0102e59>] syscall_call+0x7/0xb

kernel: smbd          D 00000000     0  3008   2871          3015  3001 (NOTLB)
kernel: f736bdbc 000005b4 000005b4 00000000 00000000 f736bea8 f79e4e00 00000000
kernel:        7fffffff c031d940 c1807400 00000000 66f2b100 003d09bd c0300b20 f7b3b0b0
kernel:        f7b3b1d8 f71a63e0 f71a63e8 00000292 f7b3b0b0 c02ba525 00000001 f7b3b0b0
kernel: Call Trace:
kernel:  [<c02ba525>] __down+0x75/0xe0
kernel:  [<c0118d70>] default_wake_function+0x0/0x10
kernel:  [<c0172804>] __d_lookup+0xa4/0x110
kernel:  [<c02b8e8f>] __down_failed+0x7/0xc
kernel:  [<c016bb42>] .text.lock.namei+0x8/0x1e6
kernel:  [<c0167f35>] do_lookup+0x85/0x90
kernel:  [<c016872f>] __link_path_walk+0x7ef/0xdd0
kernel:  [<c0168d5e>] link_path_walk+0x4e/0xd0
kernel:  [<c017cd72>] __mark_inode_dirty+0x62/0x1b0
kernel:  [<c016907f>] path_lookup+0x9f/0x170
kernel:  [<c01693cf>] __user_walk+0x2f/0x60
kernel:  [<c0163b5d>] vfs_stat+0x1d/0x60
kernel:  [<c017cd72>] __mark_inode_dirty+0x62/0x1b0
kernel:  [<c0121a0f>] current_fs_time+0x5f/0x70
kernel:  [<c01641df>] sys_stat64+0xf/0x30
kernel:  [<c0174832>] update_atime+0x52/0x90
kernel:  [<c016cdc5>] vfs_readdir+0x85/0x90
kernel:  [<c0171891>] dput+0x71/0x1b0
kernel:  [<c01763bb>] mntput_no_expire+0x1b/0x70
kernel:  [<c0159d8c>] filp_close+0x3c/0x80
kernel:  [<c0102e59>] syscall_call+0x7/0xb

kernel: smbd          D C01641BA     0  3015   2871          3036  3008 (NOTLB)
kernel: f7273f30 bfe3253c 00000000 c01641ba 00000804 00000000 00000000 0048815f
kernel:        000041c0 00000008 c1807400 00000000 66224500 003d09e6 c0300b20 f7b3bab0
kernel:        f7b3bbd8 f71a63e0 f71a63e8 00000286 f7b3bab0 c02ba525 00000001 f7b3bab0
kernel: Call Trace:
kernel:  [<c01641ba>] cp_new_stat64+0xea/0x100
kernel:  [<c02ba525>] __down+0x75/0xe0
kernel:  [<c0118d70>] default_wake_function+0x0/0x10
kernel:  [<c02b8e8f>] __down_failed+0x7/0xc
kernel:  [<c016d070>] filldir64+0x0/0xf0
kernel:  [<c016d23f>] .text.lock.readdir+0x8/0x29
kernel:  [<c016d1d7>] sys_getdents64+0x77/0xd7
kernel:  [<c016c36e>] do_fcntl+0x16e/0x1e0
kernel:  [<c0102e59>] syscall_call+0x7/0xb


Hardware: IBM eServer xSeries 330, 1Gb memory, ServeRaid 4Mx.

Config, other data - on request.

-- 
 Best regards, TEMHOTA-RIPN aka MJA13-RIPE
 System Administrator. mailto:temnota@kmv.ru

