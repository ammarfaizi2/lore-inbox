Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUGAHEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUGAHEw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 03:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUGAHEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 03:04:52 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:51177 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264129AbUGAHEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 03:04:43 -0400
From: Duncan Sands <baldrick@free.fr>
To: linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] linux 2.6.6, bttv and usb2 data corruption & lockups & poor performance
Date: Thu, 1 Jul 2004 09:04:39 +0200
User-Agent: KMail/1.6.2
Cc: janne <sniff@xxx.ath.cx>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.40.0407010017360.1548-100000@xxx.xxx>
In-Reply-To: <Pine.LNX.4.40.0407010017360.1548-100000@xxx.xxx>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407010904.39925.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hardware:
>  Athlon XP 1600+
>  Epox 8KHA+ VIA KT266A
>  BT878 TV-card (bttv card=36 tuner=1)
>  Edimax Via6302 4port PCI Usb2 controller (ehci-hcd)
>  Lacie P3 250GB Usb2 hard drive (usb-storage, reiserfs)

I get hard hangs with a Bt878 + disk activity (every time it hangs,
the disk activity LED is on).  But I don't have usb2.  However I have
a similar processor, Athlon XP 2100+, and motherboard, VIA KT333.
I'm also using reiserfs (where an OOPS occurred in your system logs).
I also have a realtek 8139 ethernet card.  We both have VIA usb 1.1
controllers.  My hangs happen with both 2.4 and 2.6 kernels.  I only
get hangs if I'm using the bttv card.

lspci:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
0000:00:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:00:06.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
0000:00:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:00:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:00:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 04)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]

> I recently updated my machine with pci usb2 controller and usb2 hard
> drive. I have been running the same machine on 2.4 kernels for a long
> time and it has never had stability issues.
> 
> I decided to upgrade to kernel version 2.6.6 since realtek gigabit
> ethernet driver in 2.4.26 causes hangs.
> 
> Soon after i updated i noticed problems whenever bttv, usb2 hard drive
> and nfs/GigE were used together at high loads.
> 
> First of all, usb2 throughput was disappointing, i only got about 5-15MB/s
> (usually about 8MB/s) while the manufacturer claims sustained datarate of
> 35MB/s.

Are you sure you plugged your device into a usb 2 port, and not a usb 1.1 port?
Also, some products claim to be usb 2 devices, when they are in fact only usb 1.1.

> I tried to stresstest the drivers by launching TvTime (which uses bttv),
> listening to mp3s, and at the same time transferring data to and from
> usb2 hdd and nfs partitions on another machine.
> 
> Problems while transferring data from usb2 hdd:
> 
> - TV picture has weird artifacts
> - Constant clicks and snaps from mp3 player
> - NFS will hang for about 10sec every now and then
> - And finally after a few minutes the machine either hangs completely
>   or the usb-storage and ehci drivers freeze and the usb2 hdd isn't
>   accessible before the machine is rebooted.
> 
> 
> 
> Here's a clip from syslog:
> 
> Jun 30 04:09:36 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
> Jun 30 04:11:30 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
> Jun 30 04:13:14 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
> Jun 30 04:13:38 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
> Jun 30 04:14:32 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
> Jun 30 04:15:23 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
> Jun 30 04:16:49 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
> Jun 30 04:17:04 ebola kernel: bttv0: SCERR @ 22a1d01c,bits: VSYNC* HSYNC OFLOW FBUS SCERR*
> Jun 30 04:17:05 ebola kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
> Jun 30 04:17:05 ebola kernel: SCSI error : <0 0 0 0> return code = 0x70000
> Jun 30 04:17:05 ebola kernel: end_request: I/O error, dev sda, sector 283278791
> Jun 30 04:17:05 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:05 ebola last message repeated 2 times
> Jun 30 04:17:05 ebola kernel: Buffer I/O error on device sda1, logical block 22417398
> Jun 30 04:17:05 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:05 ebola kernel: Buffer I/O error on device sda1, logical block 2492
> Jun 30 04:17:05 ebola kernel: lost page write due to I/O error on sda1
> Jun 30 04:17:05 ebola kernel: Buffer I/O error on device sda1, logical block 2493
> Jun 30 04:17:05 ebola kernel: lost page write due to I/O error on sda1
> Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 2494
> Jun 30 04:17:06 ebola kernel: lost page write due to I/O error on sda1
> Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 2495
> Jun 30 04:17:06 ebola kernel: lost page write due to I/O error on sda1
> Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 2496
> Jun 30 04:17:06 ebola kernel: lost page write due to I/O error on sda1
> Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 2497
> Jun 30 04:17:06 ebola kernel: lost page write due to I/O error on sda1
> Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 2498
> Jun 30 04:17:06 ebola kernel: lost page write due to I/O error on sda1
> Jun 30 04:17:06 ebola kernel: journal-601, buffer write failed
> Jun 30 04:17:06 ebola kernel: ------------[ cut here ]------------
> Jun 30 04:17:06 ebola kernel: kernel BUG at fs/reiserfs/prints.c:338!
> Jun 30 04:17:06 ebola kernel: invalid operand: 0000 [#1]
> Jun 30 04:17:06 ebola kernel: PREEMPT
> Jun 30 04:17:06 ebola kernel: CPU:    0
> Jun 30 04:17:06 ebola kernel: EIP:    0060:[__crc_poll_freewait+1357058/3378185]    Tainted: P
> Jun 30 04:17:06 ebola kernel: EFLAGS: 00010286   (2.6.6-2-k7)
> Jun 30 04:17:06 ebola kernel: EIP is at reiserfs_panic+0x33/0x70 [reiserfs]
> Jun 30 04:17:06 ebola kernel: eax: 00000024   ebx: f3ef8e00   ecx: 00000001   edx: c02af378
> Jun 30 04:17:06 ebola kernel: esi: f0c8f310   edi: 00000000   ebp: f3ef8e00   esp: c3411d58
> Jun 30 04:17:06 ebola kernel: ds: 007b   es: 007b   ss: 0068
> Jun 30 04:17:06 ebola kernel: Process pdflush (pid: 11287, threadinfo=c3410000 task=ee52fa30)
> Jun 30 04:17:06 ebola kernel: Stack: f8bff124 f8c073a0 f0c8f310 00000000 f8bf2722 f3ef8e00 f8bfd0c0 00000000
> Jun 30 04:17:06 ebola kernel:        00001000 f1ebd000 f8b94068 f0c8f328 dd5e36e8 f3ef8e00 00000000 f0c8f310
> Jun 30 04:17:06 ebola kernel:        f8b940e4 f8bf7359 f3ef8e00 f0c8f310 00000001 00001000 f0c8f310 c3410000
> Jun 30 04:17:06 ebola kernel: Call Trace:
> Jun 30 04:17:06 ebola kernel:  [__crc_poll_freewait+1406817/3378185] flush_commit_list+0x282/0x3f0 [reiserfs]
> Jun 30 04:17:06 ebola kernel:  [__crc_poll_freewait+1426328/3378185] do_journal_end+0x829/0xb70 [reiserfs]
> Jun 30 04:17:06 ebola kernel:  [__crc_poll_freewait+1421724/3378185] journal_end_sync+0x4d/0x90 [reiserfs]
> Jun 30 04:17:06 ebola kernel:  [__crc_poll_freewait+1343963/3378185] reiserfs_sync_fs+0x5c/0xb0 [reiserfs]
> Jun 30 04:17:06 ebola kernel:  [__down_failed_trylock+7/12]__down_failed_trylock+0x7/0xc
> Jun 30 04:17:06 ebola kernel:  [sync_supers+172/192] sync_supers+0xac/0xc0
> Jun 30 04:17:06 ebola kernel:  [wb_kupdate+54/288] wb_kupdate+0x36/0x120
> Jun 30 04:17:06 ebola kernel:  [schedule+812/1440] schedule+0x32c/0x5a0
> Jun 30 04:17:06 ebola kernel:  [__pdflush+202/448] __pdflush+0xca/0x1c0
> Jun 30 04:17:06 ebola kernel:  [pdflush+0/48] pdflush+0x0/0x30
> Jun 30 04:17:06 ebola kernel:  [pdflush+40/48] pdflush+0x28/0x30
> Jun 30 04:17:06 ebola kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
> Jun 30 04:17:06 ebola kernel:  [pdflush+0/48] pdflush+0x0/0x30
> Jun 30 04:17:06 ebola kernel:  [kthread+165/176] kthread+0xa5/0xb0
> Jun 30 04:17:06 ebola kernel:  [kthread+0/176] kthread+0x0/0xb0
> Jun 30 04:17:06 ebola kernel:  [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
> Jun 30 04:17:06 ebola kernel:
> Jun 30 04:17:06 ebola kernel: Code: 0f 0b 52 01 2a f1 bf f8 c7 04 24 00 bb bf f8 c7 44 24 08 a0
> Jun 30 04:17:06 ebola kernel:  <3>scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 22417398
> Jun 30 04:17:06 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:06 ebola kernel: Buffer I/O error on device sda1, logical block 35409841
> Jun 30 04:17:06 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:06 ebola kernel: zam-7001: io error in reiserfs_find_entry
> Jun 30 04:17:10 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:10 ebola kernel: zam-7001: io error in reiserfs_find_entry
> Jun 30 04:17:14 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:14 ebola kernel: zam-7001: io error in reiserfs_find_entry
> Jun 30 04:17:18 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:18 ebola kernel: zam-7001: io error in reiserfs_find_entry
> Jun 30 04:17:23 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:23 ebola kernel: zam-7001: io error in reiserfs_find_entry
> Jun 30 04:17:27 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:27 ebola kernel: zam-7001: io error in reiserfs_find_entry
> Jun 30 04:17:31 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:31 ebola kernel: zam-7001: io error in reiserfs_find_entry
> Jun 30 04:17:36 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:36 ebola kernel: zam-7001: io error in reiserfs_find_entry
> Jun 30 04:17:40 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:40 ebola kernel: zam-7001: io error in reiserfs_find_entry
> Jun 30 04:17:44 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:44 ebola kernel: zam-7001: io error in reiserfs_find_entry
> Jun 30 04:17:53 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:53 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:53 ebola kernel: Buffer I/O error on device sda1, logical block 21740738
> Jun 30 04:17:59 ebola kernel: scsi0 (0:0): rejecting I/O to offline device
> Jun 30 04:17:59 ebola kernel: Buffer I/O error on device sda1, logical block 2500
> Jun 30 04:17:59 ebola kernel: lost page write due to I/O error on sda1
> Jun 30 04:17:59 ebola kernel: Buffer I/O error on device sda1, logical block 2501
> Jun 30 04:17:59 ebola kernel: lost page write due to I/O error on sda1
> Jun 30 04:17:59 ebola kernel: Buffer I/O error on device sda1, logical block 2502
> Jun 30 04:17:59 ebola kernel: lost page write due to I/O error on sda1
> Jun 30 04:17:59 ebola kernel: Buffer I/O error on device sda1, logical block 2503
> Jun 30 04:17:59 ebola kernel: lost page write due to I/O error on sda1
> 
> 
> lspci output:
> 
> 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
> 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
> 0000:00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
> 0000:00:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 04)
> 0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> 0000:00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> 0000:00:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> 0000:00:0d.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50)
> 0000:00:0d.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50)
> 0000:00:0d.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
> 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
> 0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
> 0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
> 0000:00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
> 0000:01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a4)
> 
> 
> 
> Janne Hayrynen
> sniff@xxx.ath.cx

All the best,

Duncan.
