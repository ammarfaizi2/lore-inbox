Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVDEC0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVDEC0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 22:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVDEC0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 22:26:10 -0400
Received: from defout.telus.net ([199.185.220.240]:20953 "EHLO
	priv-edtnes46.telusplanet.net") by vger.kernel.org with ESMTP
	id S261540AbVDECXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 22:23:19 -0400
Subject: ... no drivers for IEEE1394 product 0x/0x/0x in kernel
	2.6.12-rc1-bk6
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 20:22:56 -0600
Message-Id: <1112667776.6675.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I recently built 2.6.12-rc1-bk6.  The kernel seems to be tripping
over sbp2.  The error messages keep right on rolling till I hit the
reboot button (I let it run for more than 90 seconds last time).
2.6.11.6 builds/runs without any problems.
My build scripts includes:
# IEEE 1394 (FireWire) support
CONFIG_IEEE1394=m
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_CMP is not set

#
# I2O device support
#
CONFIG_I2O=m
# CONFIG_I2O_CONFIG is not set
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m
.....and....
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_IMM=m
CONFIG_SCSI_QLA2XXX=m

...The head end of the error message (/var/log/messages) is:
Apr  4 10:04:29 localhost kernel: Freeing unused kernel memory: 248k
freed
Apr  4 10:59:17 localhost kernel: SCSI subsystem initialized
Apr  4 10:59:17 localhost kernel: sbp2: $Rev: 1219 $ Ben Collins
<bcollins@debian.org>
Apr  4 10:59:17 localhost kernel: scsi0 : SCSI emulation for IEEE-1394
SBP-2 Devices
Apr  4 10:59:17 localhost kernel: ieee1394: sbp2: Logged into SBP-2
device
Apr  4 10:59:17 localhost kernel:   Vendor: Maxtor 4  Model: G160J8
Rev:
Apr  4 10:59:17 localhost kernel:   Type:   Direct-Access
ANSI SCSI revision: 06
Apr  4 10:59:17 localhost kernel: scsi1 : SCSI emulation for IEEE-1394
SBP-2 Devices
Apr  4 10:59:17 localhost kernel: SCSI device sda: 268435455 512-byte
hdwr sectors (137439 MB)
Apr  4 10:59:17 localhost kernel: sda: cache data unavailable
Apr  4 10:59:17 localhost kernel: sda: assuming drive cache: write
through
Apr  4 10:59:17 localhost kernel: SCSI device sda: 268435455 512-byte
hdwr sectors (137439 MB)
Apr  4 10:59:17 localhost kernel: sda: cache data unavailable
Apr  4 10:59:17 localhost kernel: sda: assuming drive cache: write
through
Apr  4 10:59:17 localhost kernel:  sda: sda1
Apr  4 10:59:17 localhost kernel: Attached scsi disk sda at scsi0,
channel 0, id 0, lun 0
Apr  4 10:59:17 localhost kernel: ieee1394: sbp2: Logged into SBP-2
device
Apr  4 10:59:17 localhost kernel:   Vendor: Maxtor 4  Model: G160J8
Rev:
Apr  4 10:59:17 localhost kernel:   Type:   Direct-Access
ANSI SCSI revision: 06
Apr  4 10:59:17 localhost kernel: SCSI device sdb: 268435455 512-byte
hdwr sectors (137439 MB)
Apr  4 10:59:17 localhost kernel: sdb: cache data unavailable
Apr  4 10:59:17 localhost kernel: sdb: assuming drive cache: write
through
Apr  4 10:59:17 localhost kernel: SCSI device sdb: 268435455 512-byte
hdwr sectors (137439 MB)
Apr  4 10:59:17 localhost kernel: sdb: cache data unavailable
Apr  4 10:59:17 localhost kernel: sdb: assuming drive cache: write
through
Apr  4 10:59:17 localhost kernel:  sdb: sdb1
Apr  4 10:59:17 localhost kernel: Attached scsi disk sdb at scsi1,
channel 0, id 0, lun 0
Apr  4 10:59:19 localhost smartd[5200]: Device: /dev/hdb, found in
smartd database.
.... please note, I am taking from one /var/log/messages, but the time
seems to get a bit wierd here...I do use ntpd so....
Apr  4 04:58:34 localhost rc.sysinit: -e
Apr  4 04:58:34 localhost start_udev: Starting udev:  succeeded
Apr  4 04:58:35 localhost udevsend[2633]: starting udevd daemon
Apr  4 04:58:39 localhost rc.sysinit: -e
Apr  4 04:58:39 localhost ieee1394.agent[3504]: ... no drivers for
IEEE1394 product 0x/0x/0x
Apr  4 04:58:39 localhost rc.sysinit: Configuring kernel parameters:
succeeded
Apr  4 04:58:40 localhost ieee1394.agent[3683]: ... no drivers for
IEEE1394 product 0x/0x/0x
Apr  4 04:58:40 localhost ieee1394.agent[3701]: ... no drivers for
IEEE1394 product 0x/0x/0x
Apr  4 04:58:40 localhost ieee1394.agent[3693]: ... no drivers for
IEEE1394 product 0x/0x/0x
Apr  4 10:58:40 localhost date: Mon Apr  4 10:58:40 MDT 2005
Apr  4 10:58:40 localhost rc.sysinit: Setting clock  (localtime): Mon
Apr  4 10:58:40 MDT 2005 succeeded
Apr  4 10:58:40 localhost rc.sysinit: Setting hostname
localhost.localdomain:  succeeded
Apr  4 10:59:20 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 000000ad
Apr  4 10:58:40 localhost scsi.agent[3909]: disk
at /devices/pci0000:00/0000:00:0d.0/fw-
host0/0030e000e0000b39/0030e000e0000b39-0/host0/target0:0:0/0:0:0:0
Apr  4 10:59:20 localhost smartd: smartd startup failed
Apr  4 10:59:20 localhost kernel:  printing eip:
Apr  4 10:58:40 localhost ieee1394.agent[3891]: ... no drivers for
IEEE1394 product 0x/0x/0x
Apr  4 10:59:20 localhost kernel: f88c242a
Apr  4 10:58:40 localhost fsck: Filesystem seems mounted read-only.
Skipping journal replay.
Apr  4 10:59:20 localhost kernel: *pde = 00000000
Apr  4 10:58:41 localhost fsck: Checking internal tree..
Apr  4 10:59:20 localhost kernel: Oops: 0000 [#1]
Apr  4 10:58:41 localhost fsck: Reiserfs super block in block 16 on
0x303 of format 3.6 with standard journal
Apr  4 10:59:20 localhost kernel: PREEMPT
Apr  4 10:58:41 localhost fsck: Blocks (total/free): 4859056/2368350 by
4096 bytes
Apr  4 10:59:20 localhost kernel: Modules linked in: ipt_REJECT
ipt_state ip_conntrack iptable_filter ip_tables binfmt_misc sd_mod video
thermal processor fan button battery ac usblp ohci1394 ohci_hcd usbcore
tuner bttv video_buf i2c_algo_bit v4l2_common btcx_risc tveeprom
videodev i2c_sis96x i2c_core snd_emu10k1 snd_rawmidi snd_seq_device
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd soundcore sis900 sbp2 scsi_mod
ieee1394
Apr  4 10:58:41 localhost fsck: Filesystem marked as cleanly umounted
Apr  4 10:59:20 localhost kernel: CPU:    0
Apr  4 10:58:41 localhost fsck: /  3 (of   3)/  1 (of 161)
Apr  4 10:59:20 localhost kernel: EIP:    0060:[<f88c242a>]    Not
tainted VLI
Apr  4 10:58:41 localhost fsck: finished
Apr  4 10:59:20 localhost kernel: EFLAGS: 00010006   (2.6.12-rc1-bk5)
Apr  4 10:58:41 localhost rc.sysinit: Checking root filesystem succeeded
Apr  4 10:59:20 localhost kernel: EIP is at sbp2scsi_queuecommand
+0x1e/0x16c [sbp2]
Apr  4 10:58:41 localhost rc.sysinit: Remounting root filesystem in
read-write mode:  succeeded
Apr  4 10:59:20 localhost kernel: eax: f741de00   ebx: 00000297   ecx:
fffc5b68   edx: f7815000
Apr  4 10:58:41 localhost fsck: Replaying journal..
Apr  4 10:59:20 localhost kernel: esi: f741de00   edi: f7bf4080   ebp:
00000005   esp: f559bc9c
Apr  4 10:58:41 localhost scsi.agent[4025]: disk
at /devices/pci0000:00/0000:00:0d.0/fw-
host0/0030e000e0000ae3/0030e000e0000ae3-0/host1/target1:0:0/1:0:0:0
Apr  4 10:59:20 localhost kernel: ds: 007b   es: 007b   ss: 0068
Apr  4 10:58:41 localhost ieee1394.agent[4017]: ... no drivers for
IEEE1394 product 0x/0x/0x
Apr  4 10:59:20 localhost kernel: Process smartd (pid: 5200,
threadinfo=f559a000 task=f792d590)
Apr  4 10:58:42 localhost fsck: Reiserfs journal '/dev/hdb1' in blocks
[18..8211]: 0 transactions replayed
Apr  4 10:59:20 localhost kernel: Stack: 00000000 f7bf40e8 00000246
c03be4e0 f7bf40e8 00000000 00000297 f741de00
Apr  4 10:58:49 localhost fsck: Checking internal tree..
Apr  4 10:59:20 localhost kernel:        f7bf4080 00000000 f890b5ad
f7bf4080 f890b7c5 f890e404 f7bf4108 f7bf4080
Apr  4 10:58:49 localhost fsck: Reiserfs super block in block 16 on
0x341 of format 3.6 with standard journal
Apr  4 10:59:20 localhost kernel:        f7815000 f741de00 f559a000
f891111c f7bf4080 f7d05618 f7d05618 00000282
Apr  4 10:58:49 localhost fsck: Blocks (total/free): 20008949/7192637 by
4096 bytes
Apr  4 10:59:20 localhost kernel: Call Trace:
Apr  4 10:58:49 localhost fsck: Filesystem marked as cleanly umounted
Apr  4 10:59:20 localhost kernel:  [<f890b5ad>] scsi_dispatch_cmd
+0x160/0x224 [scsi_mod]
Apr  4 10:58:49 localhost fsck: /  1 (of   8)
Apr  4 10:59:20 localhost kernel:  [<f890b7c5>] scsi_done+0x0/0x26
[scsi_mod]
Apr  4 10:58:49 localhost fsck: /  1 (of 113)
Apr  4 10:59:20 localhost kernel:  [<f890e404>] scsi_times_out+0x0/0xa0
[scsi_mod]
Apr  4 10:58:49 localhost fsck: /  2 (of   8)/  1 (of 119)
Apr  4 10:59:20 localhost kernel:  [<f891111c>] scsi_request_fn
+0x1d5/0x40f [scsi_mod]
Apr  4 10:58:49 localhost fsck: /  3 (of   8)
Apr  4 10:59:20 localhost kernel:  [<c0217d9c>] generic_unplug_device
+0x1c/0x36
Apr  4 10:58:49 localhost fsck: /  1 (of 147)
Apr  4 10:59:20 localhost kernel:  [<c02189e2>] blk_execute_rq+0xa1/0xc6
Apr  4 10:58:49 localhost fsck: /  4 (of   8)
Apr  4 10:59:20 localhost kernel:  [<c0219ef2>] blk_rq_bio_prep
+0x73/0x91
Apr  4 10:58:49 localhost fsck: /  1 (of 160)
Apr  4 10:59:20 localhost kernel:  [<c02188a4>] blk_rq_map_user
+0xe6/0x137
Apr  4 10:59:20 localhost acpid: acpid startup succeeded
Apr  4 10:58:49 localhost fsck: /  5 (of   8)
Apr  4 10:59:20 localhost kernel:  [<c021bf79>] sg_io+0x1b9/0x300
Apr  4 10:58:49 localhost fsck: /  1 (of 165)
Apr  4 10:59:20 localhost kernel:  [<c021c6c3>] scsi_cmd_ioctl
+0x30e/0x4ab
Apr  4 10:58:49 localhost fsck: /  6 (of   8)
Apr  4 10:59:20 localhost kernel:  [<c01491d6>] page_add_file_rmap
+0x49/0x57
Apr  4 10:58:49 localhost fsck: /  1 (of 169)
Apr  4 10:59:20 localhost kernel:  [<c014443d>] do_no_page+0x1ca/0x3a6
Apr  4 10:58:49 localhost fsck: /  7 (of   8)
Apr  4 10:59:20 localhost kernel:  [<c0142431>] pte_alloc_map+0x99/0xbe
Apr  4 10:58:49 localhost fsck: /  1 (of 170)
Apr  4 10:59:20 localhost kernel:  [<c014487c>] handle_mm_fault
+0x16e/0x1b4
Apr  4 10:58:49 localhost fsck: /  8 (of   8)
Apr  4 10:59:20 localhost kernel:  [<f8b8e6b8>] sd_ioctl+0xd6/0xdd
[sd_mod]
Apr  4 10:58:49 localhost fsck: /  1 (of 124)
Apr  4 10:59:20 localhost kernel:  [<c0164a47>] do_ioctl+0x57/0x85
Apr  4 10:58:49 localhost fsck: finished
Apr  4 10:59:20 localhost kernel:  [<c0164bd6>] vfs_ioctl+0x5c/0x1c5
Apr  4 10:58:49 localhost fsck: Replaying journal..
Apr  4 10:59:20 localhost kernel:  [<c0164d7b>] sys_ioctl+0x3c/0x59
Apr  4 10:58:51 localhost fsck: Reiserfs journal '/dev/hda1' in blocks
[18..8211]: 0 transactions replayed
Apr  4 10:59:20 localhost kernel:  [<c0102ec3>] sysenter_past_esp
+0x54/0x75
Apr  4 10:58:51 localhost fsck: Checking internal tree..
Apr  4 10:59:20 localhost kernel: Code: 8c f8 eb 8a c7 04 24 98 33 8c f8
eb 81 55 57 56 53 83 ec 18 8b 44 24 2c 8b 50 04 8b 02 8b a8 00 02 00 00
85 ed 0f 84 16 01 00 00 <8b> 85 a8 00 00 00 85 c0 0f 84 1e 01 00 00 8b
5a 40 85 db 75 4a
Apr  4 10:58:51 localhost fsck: Reiserfs super block in block 16 on
0x301 of format 3.6 with standard journal
Apr  4 10:59:20 localhost kernel:  <6>note: smartd[5200] exited with
preempt_count 1
Apr  4 10:58:51 localhost fsck: Blocks (total/free): 18384/1667 by 4096
bytes
Apr  4 10:59:20 localhost kernel: scheduling while atomic:
smartd/0x10000001/5200
Apr  4 10:58:51 localhost fsck: Filesystem marked as cleanly umounted
Apr  4 10:59:20 localhost kernel:  [<c02b2d28>] schedule+0x558/0x606
Apr  4 10:58:51 localhost fsck: /  1 (of  15)
Apr  4 10:59:20 localhost kernel:  [<c0142a02>] unmap_page_range
+0x7f/0xb6
Apr  4 10:58:51 localhost fsck: /  4 (of  15)
Apr  4 10:59:20 localhost kernel:  [<c02b351e>] cond_resched+0x27/0x40
Apr  4 10:58:51 localhost fsck: /  8 (of  15)
Apr  4 10:59:20 localhost kernel:  [<c0142c48>] unmap_vmas+0x20f/0x223
Apr  4 10:58:51 localhost fsck: /  9 (of  15)
Apr  4 10:59:20 localhost kernel:  [<c01475cc>] exit_mmap+0x84/0x164
Apr  4 10:58:51 localhost fsck: / 10 (of  15)
Apr  4 10:59:20 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Apr  4 10:58:51 localhost fsck: / 13 (of  15)
Apr  4 10:59:20 localhost kernel:  [<c0115977>] mmput+0x2b/0x8e
Apr  4 10:58:51 localhost fsck: / 14 (of  15)
Apr  4 10:59:20 localhost kernel:  [<c011a0cf>] do_exit+0xba/0x3a1
Apr  4 10:58:51 localhost fsck: finished
Apr  4 10:59:20 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Apr  4 10:58:51 localhost rc.sysinit: Checking filesystems succeeded
Apr  4 10:59:20 localhost kernel:  [<c010417e>] do_trap+0x0/0xd5
Apr  4 10:58:57 localhost rc.sysinit: Mounting local filesystems:
succeeded
Apr  4 10:59:20 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Apr  4 10:58:57 localhost rc.sysinit: Enabling local filesystem quotas:
succeeded
Apr  4 10:59:20 localhost kernel:  [<c0118031>] printk+0x17/0x1b
Apr  4 10:58:58 localhost rc.sysinit: Enabling swap space:  succeeded
Apr  4 10:59:20 localhost kernel:  [<c0112db8>] do_page_fault
+0x3c4/0x5c7
Apr  4 10:58:58 localhost init: Entering runlevel: 5
Apr  4 10:59:20 localhost kernel:  [<c01398e2>] __alloc_pages
+0x173/0x3e1
Apr  4 10:58:59 localhost readahead_early: Starting background
readahead:
Apr  4 10:59:20 localhost kernel:  [<c01383ba>] mempool_alloc+0x75/0x170
Apr  4 10:58:59 localhost rc: Starting readahead_early:  succeeded
Apr  4 10:59:20 localhost kernel:  [<c012b487>] autoremove_wake_function
+0x0/0x4b
Apr  4 10:59:01 localhost kudzu:  succeeded
Apr  4 10:59:20 localhost kernel:  [<c01442d6>] do_no_page+0x63/0x3a6
Apr  4 10:59:04 localhost iptables:  succeeded
Apr  4 10:59:20 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Apr  4 10:59:05 localhost rc: Starting pcmcia:  succeeded
Apr  4 10:59:20 localhost kernel:  [<c01039c7>] error_code+0x4f/0x54
Apr  4 10:59:05 localhost sysctl: net.ipv4.ip_forward = 0
Apr  4 10:59:20 localhost kernel:  [<c012007b>] mod_timer+0x27/0x58
Apr  4 10:59:05 localhost sysctl: net.ipv4.conf.default.rp_filter = 1
Apr  4 10:59:20 localhost kernel:  [<f88c242a>] sbp2scsi_queuecommand
+0x1e/0x16c [sbp2]
Apr  4 10:59:05 localhost sysctl:
net.ipv4.conf.default.accept_source_route = 0
Apr  4 10:59:20 localhost kernel:  [<f890b5ad>] scsi_dispatch_cmd
+0x160/0x224 [scsi_mod]
Apr  4 10:59:05 localhost sysctl: kernel.core_uses_pid = 1
Apr  4 10:59:20 localhost kernel:  [<f890b7c5>] scsi_done+0x0/0x26
[scsi_mod]
Apr  4 10:59:05 localhost network: Setting network parameters:
succeeded
Apr  4 10:59:20 localhost kernel:  [<f890e404>] scsi_times_out+0x0/0xa0
[scsi_mod]
Apr  4 10:59:05 localhost network: Bringing up loopback interface:
succeeded
Apr  4 10:59:20 localhost kernel:  [<f891111c>] scsi_request_fn
+0x1d5/0x40f [scsi_mod]
Apr  4 10:59:05 localhost ifup:
Apr  4 10:59:20 localhost kernel:  [<c0217d9c>] generic_unplug_device
+0x1c/0x36
Apr  4 10:59:05 localhost ifup: Determining IP information for eth0...
Apr  4 10:59:20 localhost kernel:  [<c02189e2>] blk_execute_rq+0xa1/0xc6
Apr  4 10:59:11 localhost dhclient: DHCPACK from 192.168.1.1
Apr  4 10:59:20 localhost kernel:  [<c0219ef2>] blk_rq_bio_prep
+0x73/0x91
Apr  4 10:59:12 localhost NET: /sbin/dhclient-script :
updated /etc/resolv.conf
Apr  4 10:59:20 localhost kernel:  [<c02188a4>] blk_rq_map_user
+0xe6/0x137
Apr  4 10:59:12 localhost ifup:  done.
Apr  4 10:59:20 localhost kernel:  [<c021bf79>] sg_io+0x1b9/0x300
Apr  4 10:59:17 localhost network: Bringing up interface eth0:
succeeded
Apr  4 10:59:20 localhost kernel:  [<c021c6c3>] scsi_cmd_ioctl
+0x30e/0x4ab
Apr  4 10:59:20 localhost kernel:  [<c01491d6>] page_add_file_rmap
+0x49/0x57
Apr  4 10:59:20 localhost kernel:  [<c014443d>] do_no_page+0x1ca/0x3a6
Apr  4 10:59:20 localhost kernel:  [<c0142431>] pte_alloc_map+0x99/0xbe
Apr  4 10:59:20 localhost kernel:  [<c014487c>] handle_mm_fault
+0x16e/0x1b4
Apr  4 10:59:20 localhost kernel:  [<f8b8e6b8>] sd_ioctl+0xd6/0xdd
[sd_mod]
Apr  4 10:59:20 localhost kernel:  [<c0164a47>] do_ioctl+0x57/0x85
Apr  4 10:59:20 localhost kernel:  [<c0164bd6>] vfs_ioctl+0x5c/0x1c5
Apr  4 10:59:20 localhost kernel:  [<c0164d7b>] sys_ioctl+0x3c/0x59
Apr  4 10:59:20 localhost kernel:  [<c0102ec3>] sysenter_past_esp
+0x54/0x75
Apr  4 10:59:21 localhost rc: Starting hpoj:  succeeded
Apr  4 10:59:30 localhost cups: cupsd startup succeeded
Apr  4 10:59:30 localhost sshd:  succeeded
Apr  4 10:59:31 localhost xinetd: xinetd startup succeeded


I then get another message a bit further on into the boot process...

Apr  4 10:59:49 localhost kernel: scsi2 : Iomega VPI2 (imm) interface
Apr  4 10:59:49 localhost kernel: isa bounce pool size: 16 pages
Apr  4 10:59:49 localhost kernel:   Vendor: IOMEGA    Model: ZIP 250
Rev: H.41
Apr  4 10:59:49 localhost kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Apr  4 10:59:49 localhost kernel: Attached scsi removable disk sdc at
scsi2, channel 0, id 6, lun 0
Apr  4 10:59:49 localhost scsi.agent[5705]: disk
at /devices/platform/host2/target2:0:6/2:0:6:0
Apr  4 10:59:49 localhost fstab-sync[5947]: added mount
point /media/ieee1394disk for /dev/sdb1
Apr  4 10:59:49 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 000000adApr  4 10:59:49 localhost kernel:
printing eip:
Apr  4 10:59:49 localhost kernel: f88c242a
Apr  4 10:59:49 localhost kernel: *pde = 00000000
Apr  4 10:59:49 localhost kernel: Oops: 0000 [#2]
Apr  4 10:59:49 localhost kernel: PREEMPT
Apr  4 10:59:49 localhost kernel: Modules linked in: imm
snd_emu10k1_synth snd_emux_synth snd_seq_oss raw1394 snd_seq_virmidi
snd_seq_midi_emul snd_seq_midi snd_seq_midi_event snd_seq_dummy snd_seq
ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables binfmt_misc
sd_mod video thermal processor fan button battery ac usblp ohci1394
ohci_hcd usbcore tuner bttv video_buf i2c_algo_bit v4l2_common btcx_risc
tveeprom videodev i2c_sis96x i2c_core snd_emu10k1 snd_rawmidi
snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore sis900
sbp2 scsi_mod ieee1394
Apr  4 10:59:49 localhost kernel: CPU:    0
Apr  4 10:59:49 localhost kernel: EIP:    0060:[<f88c242a>]    Not
tainted VLI
Apr  4 10:59:49 localhost kernel: EFLAGS: 00010006   (2.6.12-rc1-bk5)
Apr  4 10:59:49 localhost kernel: EIP is at sbp2scsi_queuecommand
+0x1e/0x16c [sbp2]
Apr  4 10:59:49 localhost kernel: eax: f741de00   ebx: 00000293   ecx:
fffcd067   edx: f7815000
Apr  4 10:59:49 localhost kernel: esi: f741de00   edi: f7bf4b00   ebp:
00000005   esp: f3553cec
Apr  4 10:59:49 localhost kernel: ds: 007b   es: 007b   ss: 0068
Apr  4 10:59:49 localhost kernel: Process hald (pid: 5449,
threadinfo=f3552000 task=f7a510a0)
Apr  4 10:59:49 localhost kernel: Stack: 00000000 f7bf4b68 00000246
c03be4e0 f7bf4b68 00000000 00000293 f741de00
Apr  4 10:59:49 localhost kernel:        f7bf4b00 00000000 f890b5ad
f7bf4b00 f890b7c5 f890e404 f7bf4b88 f7bf4b00
Apr  4 10:59:49 localhost kernel:        f7815000 f741de00 f3552000
f891111c f7bf4b00 f7c603c8 f7c603c8 00000001
Apr  4 10:59:49 localhost kernel: Call Trace:
Apr  4 10:59:49 localhost kernel:  [<f890b5ad>] scsi_dispatch_cmd
+0x160/0x224 [scsi_mod]
Apr  4 10:59:49 localhost kernel:  [<f890b7c5>] scsi_done+0x0/0x26
[scsi_mod]
Apr  4 10:59:49 localhost kernel:  [<f890e404>] scsi_times_out+0x0/0xa0
[scsi_mod]
Apr  4 10:59:49 localhost kernel:  [<f891111c>] scsi_request_fn
+0x1d5/0x40f [scsi_mod]
Apr  4 10:59:49 localhost kernel:  [<c0217d9c>] generic_unplug_device
+0x1c/0x36
Apr  4 10:59:49 localhost kernel:  [<c01575b4>] block_sync_page
+0x3a/0x47
Apr  4 10:59:49 localhost kernel:  [<c013439e>] sync_page+0x3b/0x4f
Apr  4 10:59:49 localhost kernel:  [<c02b386a>] __wait_on_bit_lock
+0x41/0x61
Apr  4 10:59:49 localhost kernel:  [<c0134363>] sync_page+0x0/0x4f
Apr  4 10:59:49 localhost kernel:  [<c0134ba5>] __lock_page+0x91/0x99
Apr  4 10:59:49 localhost kernel:  [<c012b4d2>] wake_bit_function
+0x0/0x34
Apr  4 10:59:49 localhost kernel:  [<c012b4d2>] wake_bit_function
+0x0/0x34
Apr  4 10:59:49 localhost kernel:  [<c0134bd5>] find_get_page+0x28/0x4c
Apr  4 10:59:49 localhost kernel:  [<c0135366>] do_generic_mapping_read
+0x394/0x633
Apr  4 10:59:49 localhost kernel:  [<c01358a3>] __generic_file_aio_read
+0x1b8/0x22d
Apr  4 10:59:49 localhost kernel:  [<c0135605>] file_read_actor+0x0/0xe6
Apr  4 10:59:49 localhost kernel:  [<c0135a34>] generic_file_read
+0xba/0xd8
Apr  4 10:59:49 localhost kernel:  [<c014747c>] do_brk+0x1a8/0x274
Apr  4 10:59:49 localhost kernel:  [<c012b487>] autoremove_wake_function
+0x0/0x4b
Apr  4 10:59:49 localhost kernel:  [<c013597a>] generic_file_read
+0x0/0xd8
Apr  4 10:59:49 localhost kernel:  [<c0152ad6>] vfs_read+0x124/0x129
Apr  4 10:59:49 localhost kernel:  [<c0152d51>] sys_read+0x4b/0x74
Apr  4 10:59:49 localhost kernel:  [<c0102ec3>] sysenter_past_esp
+0x54/0x75
Apr  4 10:59:49 localhost kernel: Code: 8c f8 eb 8a c7 04 24 98 33 8c f8
eb 81 55 57 56 53 83 ec 18 8b 44 24 2c 8b 50 04 8b 02 8b a8 00 02 00 00
85 ed 0f 84 16 01 00 00 <8b> 85 a8 00 00 00 85 c0 0f 84 1e 01 00 00 8b
5a 40 85 db 75 4a
Apr  4 10:59:49 localhost kernel:  <6>note: hald[5449] exited with
preempt_count 1
Apr  4 10:59:49 localhost kernel: scheduling while atomic:
hald/0x10000001/5449
Apr  4 10:59:49 localhost kernel:  [<c02b2d28>] schedule+0x558/0x606
Apr  4 10:59:49 localhost kernel:  [<c0142a02>] unmap_page_range
+0x7f/0xb6
Apr  4 10:59:49 localhost kernel:  [<c02b351e>] cond_resched+0x27/0x40
Apr  4 10:59:49 localhost kernel:  [<c0142c48>] unmap_vmas+0x20f/0x223
Apr  4 10:59:49 localhost kernel:  [<c01475cc>] exit_mmap+0x84/0x164
Apr  4 10:59:49 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Apr  4 10:59:49 localhost kernel:  [<c0115977>] mmput+0x2b/0x8e
Apr  4 10:59:49 localhost kernel:  [<c011a0cf>] do_exit+0xba/0x3a1
Apr  4 10:59:49 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Apr  4 10:59:49 localhost kernel:  [<c010417e>] do_trap+0x0/0xd5
Apr  4 10:59:49 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Apr  4 10:59:50 localhost kernel:  [<c0118031>] printk+0x17/0x1b
Apr  4 10:59:50 localhost kernel:  [<c0112db8>] do_page_fault
+0x3c4/0x5c7
Apr  4 10:59:50 localhost kernel:  [<c012b487>] autoremove_wake_function
+0x0/0x4b
Apr  4 10:59:50 localhost kernel:  [<c014372e>] do_wp_page+0x249/0x391
Apr  4 10:59:50 localhost kernel:  [<c0219860>] submit_bio+0x4d/0xdc
Apr  4 10:59:50 localhost kernel:  [<c01579aa>] bio_alloc_bioset
+0x10f/0x1bf
Apr  4 10:59:50 localhost kernel:  [<c015447e>] end_buffer_async_read
+0x0/0x101
Apr  4 10:59:50 localhost kernel:  [<c01383ba>] mempool_alloc+0x75/0x170
Apr  4 10:59:50 localhost kernel:  [<c012b487>] autoremove_wake_function
+0x0/0x4b
Apr  4 10:59:50 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Apr  4 10:59:50 localhost kernel:  [<c01039c7>] error_code+0x4f/0x54
Apr  4 10:59:50 localhost kernel:  [<c012007b>] mod_timer+0x27/0x58
Apr  4 10:59:50 localhost kernel:  [<f88c242a>] sbp2scsi_queuecommand
+0x1e/0x16c [sbp2]
Apr  4 10:59:50 localhost kernel:  [<f890b5ad>] scsi_dispatch_cmd
+0x160/0x224 [scsi_mod]
Apr  4 10:59:50 localhost kernel:  [<f890b7c5>] scsi_done+0x0/0x26
[scsi_mod]
Apr  4 10:59:50 localhost kernel:  [<f890e404>] scsi_times_out+0x0/0xa0
[scsi_mod]
Apr  4 10:59:50 localhost kernel:  [<f891111c>] scsi_request_fn
+0x1d5/0x40f [scsi_mod]
Apr  4 10:59:50 localhost kernel:  [<c0217d9c>] generic_unplug_device
+0x1c/0x36
Apr  4 10:59:50 localhost kernel:  [<c01575b4>] block_sync_page
+0x3a/0x47
Apr  4 10:59:50 localhost kernel:  [<c013439e>] sync_page+0x3b/0x4f
Apr  4 10:59:50 localhost kernel:  [<c02b386a>] _i_request_fn
+0x1d5/0x40f [scsi_mod]
Apr  4 10:59:50 localhost kernel:  [<c0217d9c>] generic_unplug_device
+0x1c/0x36
Apr  4 10:59:50 localhost kernel:  [<c01575b4>] block_sync_page
+0x3a/0x47
Apr  4 10:59:50 localhost kernel:  [<c013439e>] sync_page+0x3b/0x4f
Apr  4 10:59:50 localhost kernel:  [<c02b386a>] __wait_on_bit_lock
+0x41/0x61
Apr  4 10:59:50 localhost kernel:  [<c0134363>] sync_page+0x0/0x4f
Apr  4 10:59:50 localhost kernel:  [<c0134ba5>] __lock_page+0x91/0x99
Apr  4 10:59:50 localhost kernel:  [<c012b4d2>] wake_bit_function
+0x0/0x34
Apr  4 10:59:50 localhost kernel:  [<c012b4d2>] wake_bit_function
+0x0/0x34
Apr  4 10:59:50 localhost kernel:  [<c0134bd5>] find_get_page+0x28/0x4c
Apr  4 10:59:50 localhost kernel:  [<c0135366>] do_generic_mapping_read
+0x394/0x633
Apr  4 10:59:50 localhost kernel:  [<c01358a3>] __generic_file_aio_read
+0x1b8/0x22d
Apr  4 10:59:50 localhost kernel:  [<c0135605>] file_read_actor+0x0/0xe6
Apr  4 10:59:50 localhost kernel:  [<c0135a34>] generic_file_read
+0xba/0xd8
Apr  4 10:59:50 localhost kernel:  [<c014747c>] do_brk+0x1a8/0x274
Apr  4 10:59:50 localhost kernel:  [<c012b487>] autoremove_wake_function
+0x0/0x4b
Apr  4 10:59:50 localhost kernel:  [<c013597a>] generic_file_read
+0x0/0xd8
Apr  4 10:59:50 localhost kernel:  [<c0152ad6>] vfs_read+0x124/0x129
Apr  4 10:59:50 localhost kernel:  [<c0152d51>] sys_read+0x4b/0x74
Apr  4 10:59:50 localhost kernel:  [<c0102ec3>] sysenter_past_esp
+0x54/0x75
Apr  4 10:59:50 localhost kernel: scheduling while atomic:
hald/0x10000001/5449
Apr  4 10:59:50 localhost kernel:  [<c02b2d28>] schedule+0x558/0x606

... and this error message continues on for (15000+ lines), and seems to
be the
scheduler tripping all over itself.  At the end, my finger hits the
reboot button, and when grub comes up I select another kernel....

....lspci from 2.6.11.6 gives
00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645 Host &
Memory & AGP Controller (rev 02)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI
bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS961 [MuTIOL
Media IO]
00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2 SMBus
Controller
00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI
Fast Ethernet (rev 90)
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 02)
00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 02)

00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 43)

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4200] (rev a3)
(emphasis mine)

.........
While it's true I tend to default to nVidia drivers for graphics/video,
I have not (yet) tainted the kernel with any such drivers (this is the
first boot, no foreign drivers).

As I say, things are working ok with 2.6.11.6 (what I'm using to mail
this).
You will have to mail me back as I'm not on the list.

TIA,
Bob
-- 
Bob Gill <gillb4@telusplanet.net>

