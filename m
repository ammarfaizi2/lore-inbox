Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVFIROx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVFIROx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 13:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVFIROq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 13:14:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262418AbVFIROD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 13:14:03 -0400
Subject: Re: PROBLEM: Adaptec RAID 2010S hang-up under heavy load
From: Mark Haverkamp <markh@osdl.org>
To: Jan Marek <linux@hazard.jcu.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Mark Salyzyn <mark_salyzyn@adaptec.com>
In-Reply-To: <20050609161747.GB21111@hazard.jcu.cz>
References: <20050609161747.GB21111@hazard.jcu.cz>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 10:13:54 -0700
Message-Id: <1118337234.12001.12.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-09 at 18:17 +0200, Jan Marek wrote:
> Hello lkml's,
> 
> I have server on Supermicro board with Xenon processor and Adaptec RAID
> controller 2010S.
> 
> I'm using for this controller aacraid driver.
> 
> Version of kernel is 2.6.11.7, but problem can be reproducted on
> 2.6.11.11 too.
> 
> lspci:
> 0000:00:00.0 Host bridge: Intel Corp. E7500 Memory Controller Hub (rev 02)
> 0000:00:00.1 ff00: Intel Corp. E7500/E7501 Host RASUM Controller (rev 02)
> 0000:00:02.0 PCI bridge: Intel Corp. E7500/E7501 Hub Interface B PCI-to-PCI Bridge (rev 02)
> 0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
> 0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
> 0000:00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 42)
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev 02)
> 0000:00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controller (rev 02)
> 0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
> 0000:01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
> 0000:01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
> 0000:01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
> 0000:01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
> 0000:02:03.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet Controller (LOM) (rev 02)
> 0000:03:01.0 RAID bus controller: Adaptec AAC-RAID (rev 01)
> 0000:04:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 0000:04:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
> 
> Part of dmesg:
> Red Hat/Adaptec aacraid driver (1.1.2-lk2 Jun  7 2005)
> AAC0: kernel 4.0.4 build 6011
> AAC0: monitor 4.0.4 build 6011
> AAC0: bios 4.0.0 build 6011
> AAC0: serial b81168fafaf001
> AAC0: Non-DASD support enabled.
> scsi0 : aacraid
>   Vendor: ADAPTEC   Model: Adaptec Volume    Rev: V1.0
>   Type:   Direct-Access                      ANSI SCSI revision: 02
>   Vendor: ADAPTEC   Model: Volume0           Rev: V1.0
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> SCSI device sda: 71677440 512-byte hdwr sectors (36699 MB)
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 00
> SCSI device sda: drive cache: write through
> SCSI device sda: 71677440 512-byte hdwr sectors (36699 MB)
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 00
> SCSI device sda: drive cache: write through
>  sda: sda1 sda2 < sda5 >
> Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> SCSI device sdb: 716785920 512-byte hdwr sectors (366994 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 03 00 00 00
> SCSI device sdb: drive cache: write through
> SCSI device sdb: 716785920 512-byte hdwr sectors (366994 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 03 00 00 00
> SCSI device sdb: drive cache: write through
>  sdb: sdb1 sdb2
> Attached scsi removable disk sdb at scsi0, channel 0, id 1, lun 0
> 
> sda: one disk
> sdb: RAID5 volume
> 
> In the adapter is (probably) newest firmware, I had updated firmware on
> the disks in the RAID5 volume too to the newest version (they are
> Seagate drives).
> 
> Description of the problem:
> 
> If I have not very loaded this server, everythink goes OK. I want do
> some backups to the sdb2 device.
> 
> But if I have on this server CPU under load (I can reproducted it by
> distributed.net client) and I want to intensively access RAID volume (I
> make on sdb2 backups from another machine via rdiff-backup tool), sdb
> hung-up and is innacessible. aaccli tool didn't report any problem with
> this volume. To repair this problem, I must restart server.
> 
> When I stop distributed.net client, backup goes OK and volume is
> operational without any problems.
> 
> This problem is reproductible.
> 
> Part of kern.log, when this problem occurs:
> Jun  7 01:31:30 afs1 kernel: aacraid: Host adapter reset request. SCSI hang ?
> Jun  7 01:32:30 afs1 kernel: aacraid: SCSI bus appears hung
> Jun  7 01:32:31 afs1 kernel: scsi: Device offlined - not ready after error recovery: host0 channel 0 id 1 lun 0
> Jun  7 01:32:31 afs1 kernel: SCSI error : <0 0 1 0> return code = 0x6000000
> Jun  7 01:32:31 afs1 kernel: end_request: I/O error, dev sdb, sector 324337614
> Jun  7 01:32:31 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
> Jun  7 01:32:31 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
> Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3899
> Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
> Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3900
> Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
> Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3901
> Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
> Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3902
> Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
> Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3903
> Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
> Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3904
> Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
> Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3905
> Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
> Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3906
> Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
> Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3907
> Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
> Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3908
> Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
> Jun  7 01:32:31 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
> Jun  7 01:32:31 afs1 kernel: REISERFS: abort (device sdb2): Journal write error in flush_commit_list
> Jun  7 01:32:31 afs1 kernel: REISERFS: Aborting journal for filesystem on sdb2
> Jun  7 01:32:31 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
> Jun  7 01:32:31 afs1 last message repeated 53 times
> Jun  7 01:32:31 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
> Jun  7 01:32:31 afs1 last message repeated 1295 times
> Jun  7 01:32:31 afs1 kernel: ------------[ cut here ]------------
> Jun  7 01:32:31 afs1 kernel: kernel BUG at fs/buffer.c:2891!
> Jun  7 01:32:31 afs1 kernel: invalid operand: 0000 [#1]
> Jun  7 01:32:31 afs1 kernel: PREEMPT SMP
> Jun  7 01:32:31 afs1 kernel: Modules linked in: evdev piix e100 e1000 ide_cd ide_core cdrom unix
> Jun  7 01:32:31 afs1 kernel: CPU:    0
> Jun  7 01:32:31 afs1 kernel: EIP:    0060:[try_to_free_buffers+156/176]
> Not tainted VLI
> Jun  7 01:32:31 afs1 kernel: EFLAGS: 00010246   (2.6.11.7)
> Jun  7 01:32:31 afs1 kernel: EIP is at try_to_free_buffers+0x9c/0xb0
> Jun  7 01:32:31 afs1 kernel: eax: 20000000   ebx: c14b3fe0   ecx: cec37cec   edx: f4c52530
> Jun  7 01:32:31 afs1 kernel: esi: 00000000   edi: e2097ee4   ebp: 00000001   esp: e2097e0c
> Jun  7 01:32:31 afs1 kernel: ds: 007b   es: 007b   ss: 0068
> Jun  7 01:32:31 afs1 kernel: Process rdiff-backup (pid: 20207, threadinfo=e2096000 task=f4c52530)
> Jun  7 01:32:31 afs1 kernel: Stack: 000019c2 000019c3 00000000 c14b3fe0 00000000 e2097ee4c019aa5b c14b3fe0
> Jun  7 01:32:31 afs1 kernel:        0000005a 00000001 fffffffb cec37c34 c019c1a6 e2097ee400000001 0000312e
> Jun  7 01:32:31 afs1 kernel:        00000000 00000001 0000005a e2097ee4 fffffffb 00000000f3c1b680 00000001
> Jun  7 01:32:31 afs1 kernel: Call Trace:
> Jun  7 01:32:31 afs1 kernel:  [reiserfs_unprepare_pages+43/112] reiserfs_unprepare_pages+0x2b/0x70
> Jun  7 01:32:31 afs1 kernel:  [reiserfs_file_write+1638/1744] reiserfs_file_write+0x666/0x6d0
> Jun  7 01:32:31 afs1 kernel:  [ip_rcv+859/1264] ip_rcv+0x35b/0x4f0
> Jun  7 01:32:31 afs1 kernel:  [pg0+946460271/1070216192] e1000_clean_rx_irq+0x1bf/0x4c0 [e1000]
> Jun  7 01:32:31 afs1 kernel:  [handle_IRQ_event+91/112] handle_IRQ_event+0x5b/0x70
> Jun  7 01:32:31 afs1 kernel:  [mark_offset_tsc+473/720] mark_offset_tsc+0x1d9/0x2d0
> Jun  7 01:32:31 afs1 kernel:  [update_wall_time+21/64] update_wall_time+0x15/0x40
> Jun  7 01:32:31 afs1 kernel:  [do_timer+192/208] do_timer+0xc0/0xd0
> Jun  7 01:32:31 afs1 kernel:  [timer_interrupt+192/304] timer_interrupt+0xc0/0x130
> Jun  7 01:32:31 afs1 kernel:  [vfs_write+174/304] vfs_write+0xae/0x130
> Jun  7 01:32:31 afs1 kernel:  [sys_write+81/128] sys_write+0x51/0x80
> Jun  7 01:32:31 afs1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Jun  7 01:32:31 afs1 kernel: Code: 75 ed 89 f2 83 c4 0c 89 d0 5b 5e 5f
> c3 89 1c 24 e8 5a 29 fe ff eb c2 89 1c 24 8d 44 24 08 89 44 24 04 e8 c8
> fe ff ff 89 c6 eb b5 <0f> 0b 4b 0b e6 18 28 c0 e9 74 ff ff ff 8d b4 26
> 00 00 00 00 83
> Jun  7 04:12:01 afs1 kernel:  <3>scsi0 (1:0): rejecting I/O to offline device
> Jun  7 04:12:01 afs1 kernel: ReiserFS: sdb1: warning: zam-7001: io error in reiserfs_find_entry
> Jun  7 06:25:04 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
> Jun  7 06:25:04 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
> 
> Kernel .config is attached.
> 
> Have you any suggestions?

I have had some problems like this with a 2200S that have been solved by
updating the firmware on the card.  I have copied Mark Salyzyn from
Adaptec.  Maybe he can comment on your version of the card and its
firmware version.

Mark.

> 
> If you will need any additional information, please send me an e-mail.
> 
> Sincerely
> Jan Marek
-- 
Mark Haverkamp <markh@osdl.org>

