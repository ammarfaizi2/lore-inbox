Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbVF3QeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVF3QeG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVF3QeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:34:06 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:37657 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S263001AbVF3QdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:33:07 -0400
From: SA <n0td1scl0s3d@ntlworld.com>
Subject: Fwd: dvd ram / ext2 / oops / massive logfile
Date: Thu, 30 Jun 2005 17:33:03 +0100
User-Agent: KMail/1.7.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506301733.03178.n0td1scl0s3d@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Supplementary:

I could not halt the machine since it shutdown and halt both hung without
messages, as did sync.

telinit 6 produced the following messages:
PID 4246:
umount2: Device busy
umount: /dev/pts device is busy

so I hit the power button...

Dear List,

When writing to a DVD RAM on my system I got >48000 lines of compliant in
my system logs (sample below) and the file was corrupt.  The final error
 keeps occurring and the logfile is growing at 40kb/minute which isn't good.

There is a kernel oops bug down done messages a way in the ext2 module.

After rescuing my data I tried to eject the disk (eject /media/cdrecoder) -
 it removed it from the mtab but the eject never completed so the disk is
 currently stuck in the driver and the system is still throwing messages.


Anyway I must go a reboot now before my logs fill up.

SA

uname -a
Linux valium 2.6.11-1.14_FC3 #1 Thu Apr 7 19:25:50 EDT 2005 x86_64 x86_64
 x86_64 GNU/Linux





** early on
Jun 30 15:08:36 valium kernel: cdrom: open failed.
Jun 30 15:08:36 valium kernel: cdrom: open failed.
Jun 30 15:08:44 valium kernel: hdb: packet command error: status=0x51 {
 DriveReady SeekComplete Error } Jun 30 15:08:44 valium kernel: hdb: packet
 command error: error=0x54 { AbortedCommand LastFailedSense=0x05 } Jun 30
 15:08:44 valium kernel: ide: failed opcode was: unknown
Jun 30 15:08:44 valium kernel: ATAPI device hdb:
Jun 30 15:08:44 valium kernel:   Error: Illegal request -- (Sense key=0x05)
Jun 30 15:08:44 valium kernel:   Cannot read medium - incompatible format --
 (asc=0x30, ascq=0x02) Jun 30 15:08:44 valium kernel:   The failed "Read
 Subchannel" packet command was: Jun 30 15:08:44 valium kernel:   "42 02 40
 01 00 00 00 00 10 00 00 00 00 00 00 00 " Jun 30 15:08:45 valium kernel: hdb:
 packet command error: status=0x51 { DriveReady SeekComplete Error } Jun 30
 15:08:45 valium kernel: hdb: packet command error: error=0x54 {
 AbortedCommand LastFailedSense=0x05 } Jun 30 15:08:45 valium kernel: ide:
 failed opcode was: unknown
Jun 30 15:08:45 valium kernel: ATAPI device hdb:
Jun 30 15:08:45 valium kernel:   Error: Illegal request -- (Sense key=0x05)
Jun 30 15:08:45 valium kernel:   Cannot read medium - incompatible format --
 (asc=0x30, ascq=0x02) Jun 30 15:08:45 valium kernel:   The failed "Read
 Subchannel" packet command was: Jun 30 15:08:45 valium kernel:   "42 02 40
 01 00 00 00 00 10 00 00 00 00 00 00 00 " Jun 30 15:08:46 valium kernel:
 SELinux: initialized (dev hdb, type ext2), uses xattr Jun 30 15:08:46 valium
 kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete
 Error } Jun 30 15:08:46 valium kernel: hdb: packet command error: error=0x54
 { AbortedCommand LastFailedSense=0x05 } Jun 30 15:08:46 valium kernel: ide:
 failed opcode was: unknown
Jun 30 15:08:46 valium kernel: ATAPI device hdb:
...


** then later when writing a large file:
Jun 30 15:56:47 valium kernel: hdb: packet command error: status=0x51 {
 DriveReady SeekComplete Error } Jun 30 15:56:47 valium kernel: hdb: packet
 command error: error=0x54 { AbortedCommand LastFailedSense=0x05 } Jun 30
 15:56:47 valium kernel: ide: failed opcode was: unknown
Jun 30 15:56:47 valium kernel: ATAPI device hdb:
Jun 30 15:56:47 valium kernel:   Error: Illegal request -- (Sense key=0x05)
Jun 30 15:56:47 valium kernel:   Cannot read medium - incompatible format --
 (asc=0x30, ascq=0x02) Jun 30 15:56:47 valium kernel:   The failed "Read
 Subchannel" packet command was: Jun 30 15:56:47 valium kernel:   "42 02 40
 01 00 00 00 00 10 00 00 00 00 00 00 00 " Jun 30 15:56:47 valium kernel:
 attempt to access beyond end of device Jun 30 15:56:47 valium kernel: hdb:
 rw=0, want=1312928, limit=1279588 Jun 30 15:56:54 valium kernel: attempt to
 access beyond end of device Jun 30 15:56:54 valium kernel: hdb: rw=1,
 want=1279768, limit=1279588 Jun 30 15:56:54 valium kernel: attempt to access
 beyond end of device Jun 30 15:56:54 valium kernel: hdb: rw=1, want=1280024,
 limit=1279588 Jun 30 15:56:54 valium kernel: attempt to access beyond end of
 device Jun 30 15:56:54 valium kernel: hdb: rw=1, want=1280280, limit=1279588
 Jun 30 15:56:54 valium kernel: attempt to access beyond end of device Jun 30
 15:56:54 valium kernel: hdb: rw=1, want=1280536, limit=1279588 Jun 30
 15:56:54 valium kernel: attempt to access beyond end of device Jun 30
 15:56:54 valium kernel: hdb: rw=1, want=1280664, limit=1279588 ...

** then nasty messages:

Jun 30 15:56:54 valium kernel: hdb: rw=1, want=1304912, limit=1279588
Jun 30 15:56:54 valium kernel: attempt to access beyond end of device
Jun 30 15:56:54 valium kernel: hdb: rw=1, want=1305168, limit=1279588
Jun 30 15:56:54 valium kernel: attempt to access beyond end of device
Jun 30 15:56:54 valium kernel: hdb: rw=1, want=1305264, limit=1279588
Jun 30 15:56:54 valium kernel: ----------- [cut here ] --------- [please bite
 here ] --------- Jun 30 15:56:54 valium kernel: Kernel BUG at buffer:2706
Jun 30 15:56:54 valium kernel: invalid operand: 0000 [1]
Jun 30 15:56:54 valium kernel: CPU 0
Jun 30 15:56:54 valium kernel: Modules linked in: vfat fat sch_tbf nvidia(U)
 pcspkr ipt_MASQUERADE ipt_LOG ipt_state iptable_nat ip_conntrack
 iptable_filter ip_tables md5 ipv6 parport_pc l p parport w83627hf eeprom
 lm75 i2c_sensor i2c_isa dm_mod video button battery ac usb_storage uhci_hcd
 ehci_hcd i2c_viapro i2c_core snd_via82xx snd_ac97_codec snd_pcm_oss
 snd_mixer_oss snd_ pcm snd_timer snd_page_alloc gameport snd_mpu401_uart
 snd_rawmidi snd_seq_device snd soundcore r8169 sk98lin ext3 jbd sata_via
 libata sd_mod scsi_mod Jun 30 15:56:54 valium kernel: Pid: 149, comm:
 pdflush Tainted: P      2.6.11-1.14_FC3 Jun 30 15:56:54 valium kernel: RIP:
 0010:[<ffffffff8019b4ea>] <ffffffff8019b4ea>{submit_bh+58} Jun 30 15:56:54
 valium kernel: RSP: 0018:ffff81007fdbba28  EFLAGS: 00010246 Jun 30 15:56:55
 valium kernel: RAX: 0000000000000005 RBX: ffff8100249442f0 RCX:
 0000000000000000 Jun 30 15:56:55 valium kernel: RDX: ffff81007fdbba88 RSI:
 ffff8100249442f0 RDI: 0000000000000001 Jun 30 15:56:55 valium kernel: RBP:
 ffff8100249442f0 R08: 0000000000000000 R09: 0000000000000007 Jun 30 15:56:55
 valium kernel: R10: ffffffff805187e0 R11: ffffffff8016f320 R12:
 0000000000000001 Jun 30 15:56:55 valium kernel: R13: 0000000000000000 R14:
 0000000000000001 R15: 0000000000000001 Jun 30 15:56:55 valium kernel: FS:
 00002aaaaaad6360(0000) GS:ffffffff80550700(0000) knlGS:00000000556c0b20 Jun
 30 15:56:55 valium kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
 Jun 30 15:56:55 valium kernel: CR2: 00002aaaaaaac000 CR3: 000000007ee59000
 CR4: 00000000000006e0 Jun 30 15:56:55 valium kernel: Process pdflush (pid:
 149, threadinfo ffff81007fdba000, task ffff81007fd1e030) Jun 30 15:56:55
 valium kernel: Stack: ffff81006461c608 ffff8100249442f0 0000000000000001
 ffff81007fdbba88 Jun 30 15:56:55 valium kernel:        0000000000000001
 ffffffff8019b669 ffff81007fdbbbf8 0000000000000001 Jun 30 15:56:55 valium
 kernel:        ffff810001d2c9e8 0000000000000000 Jun 30 15:56:55 valium
 kernel: Call Trace:<ffffffff8019b669>{ll_rw_block+105}
 <ffffffff8019b6d0>{write_boundary_block+48} Jun 30 15:56:55 valium kernel:
      <ffffffff801cc86b>{mpage_writepages+1819}
 <ffffffff801f42a0>{ext2_get_block+0} Jun 30 15:56:55 valium kernel:
 <ffffffff8019dc49>{__getblk+57}
 <ffffffff801ca2fa>{__writeback_single_inode+874} Jun 30 15:56:55 valium
 kernel:        <ffffffff801cb18c>{sync_sb_inodes+508}
 <ffffffff803a3f38>{__down_failed_trylock+53} Jun 30 15:56:55 valium kernel:
       <ffffffff801cb861>{writeback_inodes+577}
 <ffffffff801a03cc>{sync_supers+476} Jun 30 15:56:55 valium kernel:
 <ffffffff80172427>{wb_kupdate+167} <ffffffff803a2049>{thread_return+41} Jun
 30 15:56:55 valium kernel:        <ffffffff801739a8>{pdflush+952}
 <ffffffff80172380>{wb_kupdate+0} Jun 30 15:56:55 valium kernel:
 <ffffffff801735f0>{pdflush+0} <ffffffff8015921d>{kthread+205} Jun 30
 15:56:55 valium kernel:        <ffffffff8010f743>{child_rip+8}
 <ffffffff80159260>{keventd_create_kthread+0} Jun 30 15:56:55 valium kernel:
       <ffffffff80159150>{kthread+0} <ffffffff8010f73b>{child_rip+0} Jun 30
 15:56:55 valium kernel:
Jun 30 15:56:55 valium kernel:
Jun 30 15:56:55 valium kernel: Code: 0f 0b f3 6b 3d 80 ff ff ff ff 92 0a 48
 83 7d 38 00 75 13 0f Jun 30 15:56:55 valium kernel: RIP
 <ffffffff8019b4ea>{submit_bh+58} RSP <ffff81007fdbba28> Jun 30 15:56:55
 valium kernel:  <2>EXT2-fs error (device hdb): read_block_bitmap: Cannot
 read block bitmap - block_group = 5, block_bitmap = 164115 Jun 30 15:56:55
 valium kernel: attempt to access beyond end of device Jun 30 15:56:55 valium
 kernel: hdb: rw=0, want=1312928, limit=1279588 Jun 30 15:57:01 valium
 kernel: EXT2-fs error (device hdb): read_block_bitmap: Cannot read block
 bitmap - block_group = 5, block_bitmap = 164115 Jun 30 15:57:01 valium
 kernel: attempt to access beyond end of device Jun 30 15:57:01 valium
 kernel: hdb: rw=0, want=1312928, limit=1279588 Jun 30 15:57:01 valium
 kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete
 Error } Jun 30 15:57:01 valium kernel: hdb: packet command error: error=0x54
 { AbortedCommand LastFailedSense=0x05 } Jun 30 15:57:01 valium kernel: ide:
 failed opcode was: unknown
Jun 30 15:57:01 valium kernel: ATAPI device hdb:
Jun 30 15:57:01 valium kernel:   Error: Illegal request -- (Sense key=0x05)
Jun 30 15:57:01 valium kernel:   Cannot read medium - incompatible format --
 (asc=0x30, ascq=0x02) Jun 30 15:57:01 valium kernel:   The failed "Read
 Subchannel" packet command was: Jun 30 15:57:01 valium kernel:   "42 02 40
 01 00 00 00 00 10 00 00 00 00 00 00 00 " Jun 30 15:57:01 valium kernel:
 EXT2-fs error (device hdb): read_block_bitmap: Cannot read block bitmap -
 block_group = 5, block_bitmap = 164115 Jun 30 15:57:01 valium kernel:
 attempt to access beyond end of device Jun 30 15:57:01 valium kernel: hdb:
 rw=0, want=1312928, limit=1279588 Jun 30 15:57:01 valium kernel: EXT2-fs
 error (device hdb): read_block_bitmap: Cannot read block bitmap -
 block_group = 5, block_bitmap = 164115 Jun 30 15:57:01 valium kernel:
 attempt to access beyond end of device Jun 30 15:57:01 valium kernel: hdb:
 rw=0, want=1312928, limit=1279588 Jun 30 15:57:01 valium kernel: EXT2-fs
 error (device hdb): read_block_bitmap: Cannot read block bitmap -
 block_group = 5, block_bitmap = 164115 Jun 30 15:57:01 valium kernel:
 attempt to access beyond end of device Jun 30 15:57:01 valium kernel: hdb:
 rw=0, want=1312928, limit=1279588 Jun 30 15:57:01 valium kernel: EXT2-fs
 error (device hdb): read_block_bitmap: Cannot read block bitmap -
 block_group = 5, block_bitmap = 164115 Jun 30 15:57:01 valium kernel:
 attempt to access beyond end of device Jun 30 15:57:01 valium kernel: hdb:
 rw=0, want=1312928, limit=1279588 Jun 30 15:57:01 valium kernel: EXT2-fs
 error (device hdb): read_block_bitmap: Cannot read block bitmap -
 block_group = 5, block_bitmap = 164115 Jun 30 15:57:02 valium kernel:
 attempt to access beyond end of device Jun 30 15:57:02 valium kernel: hdb:
 rw=0, want=1312928, limit=1279588 Jun 30 15:57:02 valium kernel: EXT2-fs
 error (device hdb): read_block_bitmap: Cannot read block bitmap -
 block_group = 5, block_bitmap = 164115 ...

** then (get this a few times)
Jun 30 15:57:02 valium kernel: attempt to access beyond end of device
Jun 30 15:57:02 valium kernel: hdb: rw=0, want=1312928, limit=1279588
Jun 30 15:57:02 valium kernel: EXT2-fs error (device hdb): read_block_bitmap:
 Cannot read block bitmap - block_group = 5, block_bitmap = 164115 Jun 30
 15:57:02 valium kernel: attempt to access beyond end of device Jun 30
 15:57:02 valium kernel: hdb: rw=0, want=1312928, limit=1279588 Jun 30
 15:57:02 valium kernel: EXT2-fs error (device hdb): read_block_bitmap:
 Cannot read block bitmap - block_group = 5, block_bitmap = 164115 Jun 30
 15:57:02 valium kernel: hdb: packet command error: status=0x51 { DriveReady
 SeekComplete Error } Jun 30 15:57:02 valium kernel: hdb: packet command
 error: error=0x54 { AbortedCommand LastFailedSense=0x05 } Jun 30 15:57:02
 valium kernel: ide: failed opcode was: unknown
Jun 30 15:57:02 valium kernel: ATAPI device hdb:
Jun 30 15:57:02 valium kernel:   Error: Illegal request -- (Sense key=0x05)
Jun 30 15:57:02 valium kernel:   Cannot read medium - incompatible format --
 (asc=0x30, ascq=0x02) Jun 30 15:57:02 valium kernel:   The failed "Read
 Subchannel" packet command was: Jun 30 15:57:02 valium kernel:   "42 02 40
 01 00 00 00 00 10 00 00 00 00 00 00 00 " Jun 30 15:57:02 valium kernel:
 attempt to access beyond end of device Jun 30 15:57:02 valium kernel: hdb:
 rw=0, want=1312928, limit=1279588 Jun 30 15:57:02 valium kernel: EXT2-fs
 error (device hdb): read_block_bitmap: Cannot read block bitmap -
 block_group = 5, block_bitmap = 164115 Jun 30 15:57:02 valium kernel:
 attempt to access beyond end of device Jun 30 15:57:02 valium kernel: hdb:
 rw=0, want=1312928, limit=1279588 Jun 30 15:57:02 valium kernel: EXT2-fs
 error (device hdb): read_block_bitmap: Cannot read block bitmap -
 block_group = 5, block_bitmap = 164115 Jun 30 15:57:02 valium kernel:
 attempt to access beyond end of device Jun 30 15:57:02 valium kernel: hdb:
 rw=0, want=1312928, limit=1279588 ...
** then



Jun 30 15:57:10 valium kernel: attempt to access beyond end of device
Jun 30 15:57:10 valium kernel: hdb: rw=0, want=1312928, limit=1279588
Jun 30 15:57:10 valium kernel: EXT2-fs error (device hdb): read_block_bitmap:
 Cannot read block bitmap - block_group = 5, block_bitmap = 164115 Jun 30
 15:57:10 valium kernel: attempt to access beyond end of device Jun 30
 15:57:10 valium kernel: hdb: rw=0, want=1312928, limit=1279588 Jun 30
 15:57:10 valium kernel: EXT2-fs error (device hdb): read_block_bitmap:
 Cannot read block bitmap - block_group = 5, block_bitmap = 164115 Jun 30
 15:57:10 valium kernel: attempt to access beyond end of device Jun 30
 15:57:10 valium kernel: hdb: rw=0, want=1312928, limit=1279588 Jun 30
 15:57:10 valium kernel: EXT2-fs error (device hdb): read_block_bitmap:
 Cannot read block bitmap - block_group = 5, block_bitmap = 164115 Jun 30
 15:57:10 valium kernel: attempt to access beyond end of device Jun 30
 15:57:10 valium kernel: hdb: rw=0, want=1312928, limit=1279588 Jun 30
 15:57:10 valium kernel: EXT2-fs error (device hdb): read_block_bitmap:
 Cannot read block bitmap - block_group = 5, block_bitmap = 164115 Jun 30
 15:57:10 valium kernel: attempt to access beyond end of device Jun 30
 15:57:10 valium kernel: hdb: rw=0, want=1312928, limit=1279588 Jun 30
 15:57:10 valium kernel: EXT2-fs error (device hdb): read_block_bitmap:
 Cannot read block bitmap - block_group = 5, block_bitmap = 164115 Jun 30
 15:57:10 valium kernel: hdb: packet command error: status=0x51 { DriveReady
 SeekComplete Error } Jun 30 15:57:10 valium kernel: hdb: packet command
 error: error=0x54 { AbortedCommand LastFailedSense=0x05 } Jun 30 15:57:10
 valium kernel: ide: failed opcode was: unknown
Jun 30 15:57:10 valium kernel: ATAPI device hdb:
Jun 30 15:57:10 valium kernel:   Error: Illegal request -- (Sense key=0x05)
Jun 30 15:57:10 valium kernel:   Cannot read medium - incompatible format --
 (asc=0x30, ascq=0x02) Jun 30 15:57:10 valium kernel:   The failed "Read
 Subchannel" packet command was: Jun 30 15:57:10 valium kernel:   "42 02 40
 01 00 00 00 00 10 00 00 00 00 00 00 00 " Jun 30 15:57:11 valium kernel: hdb:
 packet command error: status=0x51 { DriveReady SeekComplete Error } Jun 30
 15:57:11 valium kernel: hdb: packet command error: error=0x54 {
 AbortedCommand LastFailedSense=0x05 } Jun 30 15:57:11 valium kernel: ide:
 failed opcode was: unknown
Jun 30 15:57:11 valium kernel: ATAPI device hdb:
Jun 30 15:57:11 valium kernel:   Error: Illegal request -- (Sense key=0x05)
Jun 30 15:57:11 valium kernel:   Cannot read medium - incompatible format --
 (asc=0x30, ascq=0x02) Jun 30 15:57:11 valium kernel:   The failed "Read
 Subchannel" packet command was: Jun 30 15:57:11 valium kernel:   "42 02 40
 01 00 00 00 00 10 00 00 00 00 00 00 00 " Jun 30 15:57:12 valium kernel: hdb:
 packet command error: status=0x51 { DriveReady SeekComplete Error } Jun 30
 15:57:12 valium kernel: hdb: packet command error: error=0x54 {
 AbortedCommand LastFailedSense=0x05 } ** This continues for ever...

-------------------------------------------------------

-------------------------------------------------------
