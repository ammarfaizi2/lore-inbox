Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261325AbSJYKaZ>; Fri, 25 Oct 2002 06:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbSJYKaZ>; Fri, 25 Oct 2002 06:30:25 -0400
Received: from dsl-62-3-75-185.zen.co.uk ([62.3.75.185]:5760 "EHLO
	giantx.co.uk") by vger.kernel.org with ESMTP id <S261325AbSJYKaY>;
	Fri, 25 Oct 2002 06:30:24 -0400
Date: Fri, 25 Oct 2002 11:36:31 +0100
To: linux-kernel@vger.kernel.org
Subject: [Bug] 2.5.44-ac2 cdrom eject panic
Message-ID: <20021025103631.GA588@giantx.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Nyk Tarr <nyk@giantx.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I got this nice error after doing an 'eject /cdrom'


Oct 25 11:28:29 natsu kernel: Kernel panic: Unable to find device associated with request
Oct 25 11:28:29 natsu kernel: Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Oct 25 11:28:29 natsu kernel: Call Trace:
Oct 25 11:28:29 natsu kernel:  [get_super_to_sync+127/176] get_super_to_sync+0x7f/0xb0
Oct 25 11:28:29 natsu kernel:  [sync_inodes+21/160] sync_inodes+0x15/0xa0
Oct 25 11:28:29 natsu kernel:  [sys_sync+27/64] sys_sync+0x1b/0x40
Oct 25 11:28:29 natsu kernel:  [panic+255/272] panic+0xff/0x110
Oct 25 11:28:29 natsu kernel:  [scsi_request_fn+637/1200] scsi_request_fn+0x27d/0x4b0
Oct 25 11:28:29 natsu kernel:  [generic_unplug_device+102/112] generic_unplug_device+0x66/0x70
Oct 25 11:28:29 natsu kernel:  [blk_do_rq+93/144] blk_do_rq+0x5d/0x90
Oct 25 11:28:29 natsu kernel:  [scsi_cmd_ioctl+471/656] scsi_cmd_ioctl+0x1d7/0x460
Oct 25 11:28:29 natsu kernel:  [cdrom_ioctl+69/3376] cdrom_ioctl+0x45/0xd30
Oct 25 11:28:29 natsu kernel:  [blkdev_open+56/80] blkdev_open+0x38/0x50
Oct 25 11:28:29 natsu kernel:  [dentry_open+366/432] dentry_open+0x16e/0x1b0
Oct 25 11:28:29 natsu kernel:  [filp_open+104/112] filp_open+0x68/0x70
Oct 25 11:28:29 natsu kernel:  [blkdev_ioctl+176/1104] blkdev_ioctl+0xb0/0x4eb
Oct 25 11:28:29 natsu kernel:  [sys_ioctl+234/592] sys_ioctl+0xea/0x340
Oct 25 11:28:29 natsu kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 25 11:28:29 natsu kernel: 
Oct 25 11:28:29 natsu kernel: ------------[ cut here ]------------
Oct 25 11:28:29 natsu kernel: kernel BUG at fs/buffer.c:1248!
Oct 25 11:28:29 natsu kernel: invalid operand: 0000
Oct 25 11:28:29 natsu kernel: nls_cp437 vfat fat nls_iso8859-1 isofs sg ppp_generic slhc cls_u32 sch_sfq sch_cbq snd-seq-midi snd-emu10k1-synth snd-emux-synth snd-seq-midi-emul snd-seq-virmidi snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-ens1371 snd-emu10k1 snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd-util-mem snd-hwdep snd soundcore ipt_LOG ipt_unclean ipt_REJECT ipt_state iptable_filter iptable_nat ip_conntrack_ftp ipt_helper ip_tables ip_conntrack uhci-hcd usbcore 8139too mii crc32 joydev analog emu10k1-gp gameport rtc  
Oct 25 11:28:29 natsu kernel: CPU:    0
Oct 25 11:28:29 natsu kernel: EIP:    0060:[lookup_bh+173/186]    Not tainted
Oct 25 11:28:29 natsu kernel: EFLAGS: 00010002
Oct 25 11:28:29 natsu kernel: EIP is at lookup_bh+0xad/0xba
Oct 25 11:28:29 natsu kernel: eax: 00000001   ebx: c6a86000   ecx: 00000000   edx: c94f0000
Oct 25 11:28:29 natsu kernel: esi: 012c402f   edi: 012c402f   ebp: 00000000   esp: c6a87c68
Oct 25 11:28:29 natsu kernel: ds: 0068   es: 0068   ss: 0068
Oct 25 11:28:29 natsu kernel: Process eject (pid: 21077, threadinfo=c6a86000 task=caceadc0)
Oct 25 11:28:29 natsu kernel: Stack: 00000000 c6a86000 012c402f 00000000 c133d640 c0146f27 c133d640 012c402f 
Oct 25 11:28:29 natsu kernel:        00000000 00000200 c6a86000 012c402f 00000000 c133d640 c0146fa7 c133d640 
Oct 25 11:28:29 natsu kernel:        012c402f 00000000 00000200 c6a86000 012c402f 00000000 c133d640 c0147027 
Oct 25 11:28:29 natsu kernel: Call Trace:
Oct 25 11:28:29 natsu kernel:  [__find_get_block+55/128] __find_get_block+0x37/0x80
Oct 25 11:28:29 natsu kernel:  [__getblk+55/128] __getblk+0x37/0x80
Oct 25 11:28:29 natsu kernel:  [__bread+55/144] __bread+0x37/0x90
Oct 25 11:28:29 natsu kernel:  [<d33ae20d>] default_fat_bread+0x2d/0x40 [fat]
Oct 25 11:28:29 natsu kernel:  [<d33ae09e>] fat_bread+0x1e/0x30 [fat]
Oct 25 11:28:29 natsu kernel:  [<d33b3e4d>] fat_write_inode_R0ba59c09+0x6d/0x1f0 [fat]
Oct 25 11:28:29 natsu kernel:  [write_inode+68/80] write_inode+0x44/0x50
Oct 25 11:28:29 natsu kernel:  [__sync_single_inode+373/416] __sync_single_inode+0x175/0x1a0
Oct 25 11:28:29 natsu kernel:  [sync_sb_inodes+396/576] sync_sb_inodes+0x18c/0x240
Oct 25 11:28:29 natsu kernel:  [sync_inodes_sb+125/160] sync_inodes_sb+0x7d/0xa0
Oct 25 11:28:29 natsu kernel:  [sync_inodes+43/160] sync_inodes+0x2b/0xa0
Oct 25 11:28:29 natsu kernel:  [sys_sync+27/64] sys_sync+0x1b/0x40
Oct 25 11:28:29 natsu kernel:  [panic+255/272] panic+0xff/0x110
Oct 25 11:28:29 natsu kernel:  [scsi_request_fn+637/1200] scsi_request_fn+0x27d/0x4b0
Oct 25 11:28:29 natsu kernel:  [generic_unplug_device+102/112] generic_unplug_device+0x66/0x70
Oct 25 11:28:29 natsu kernel:  [blk_do_rq+93/144] blk_do_rq+0x5d/0x90
Oct 25 11:28:29 natsu kernel:  [scsi_cmd_ioctl+471/656] scsi_cmd_ioctl+0x1d7/0x460
Oct 25 11:28:29 natsu kernel:  [cdrom_ioctl+69/3376] cdrom_ioctl+0x45/0xd30
Oct 25 11:28:29 natsu kernel:  [blkdev_open+56/80] blkdev_open+0x38/0x50
Oct 25 11:28:29 natsu kernel:  [dentry_open+366/432] dentry_open+0x16e/0x1b0
Oct 25 11:28:29 natsu kernel:  [filp_open+104/112] filp_open+0x68/0x70
Oct 25 11:28:29 natsu kernel:  [blkdev_ioctl+176/1104] blkdev_ioctl+0xb0/0x4eb
Oct 25 11:28:29 natsu kernel:  [sys_ioctl+234/592] sys_ioctl+0xea/0x340
Oct 25 11:28:29 natsu kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 25 11:28:29 natsu kernel: 
Oct 25 11:28:29 natsu kernel: Code: 0f 0b e0 04 12 6d 2b c0 e9 6d ff ff ff e8 d5 d5 fb ff e9 7d 
Oct 25 11:28:29 natsu kernel:  <6>note: eject[21077] exited with preempt_count 2
Oct 25 11:30:18 natsu kernel: SysRq : SAK
Oct 25 11:30:18 natsu kernel: SAK: killed process 479 (XFree86): fd#4 opened to the tty
Oct 25 11:30:18 natsu kernel: MTRR: setting reg 1
Oct 25 11:30:19 natsu modprobe: modprobe: Can't locate module char-major-10-134
Oct 25 11:30:20 natsu kernel: MTRR: setting reg 1
Oct 25 11:30:20 natsu last message repeated 4 times
Oct 25 11:30:32 natsu kernel: SysRq : Emergency Sync
Oct 25 11:30:32 natsu kernel: Syncing device sd(8,22) ... OK
Oct 25 11:30:32 natsu kernel: Syncing device sd(8,17) ... OK
Oct 25 11:30:32 natsu kernel: Syncing device sd(8,23) ... OK
Oct 25 11:30:32 natsu kernel: Syncing device sd(8,24) ... OK
Oct 25 11:30:32 natsu kernel: Syncing device sd(8,1) ... OK
Oct 25 11:30:32 natsu kernel: Syncing device ide0(3,1) ... OK
Oct 25 11:30:32 natsu kernel: Syncing device ide0(3,69) ... OK
Oct 25 11:30:32 natsu kernel: Done.
Oct 25 11:30:34 natsu kernel: SysRq : Emergency Remount R/O
Oct 25 11:30:34 natsu kernel: Remounting device sd(8,22) ... OK

-- 
/__
\_|\/
   /\
