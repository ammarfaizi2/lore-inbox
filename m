Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbULRSkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbULRSkc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 13:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbULRSkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 13:40:32 -0500
Received: from mail4.worldserver.net ([217.13.200.24]:33431 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S261215AbULRSkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 13:40:22 -0500
X-Speedbone-MailScanner-Mail-From: christian@leber.de via mail4.worldserver.net
X-Speedbone-MailScanner: 1.23st (Clear:RC:1(80.140.59.159):. Processed in 0.160375 secs Process 29195)
Date: Sat, 18 Dec 2004 19:40:21 +0100
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [bugreport] Problem when trying to mount CD/DVD (2.6.10-rc{1 to 3-bk12}); most likely it's ide-scsi
Message-ID: <20041218184021.GA6795@core.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when i try to mount (mount /dev/hdc /cdrom) a CD or DVD i get the
following error:

Dec 18 19:27:50 igor3 kernel: ide-scsi: unsup command: dev hdc: flags = REQ_CMD REQ_STARTED 
Dec 18 19:27:50 igor3 kernel: sector 0, nr/cnr 1/1
Dec 18 19:27:50 igor3 kernel: bio c15ee740, biotail c15ee740, buffer dd1a4000, data 00000000, len 0
Dec 18 19:27:50 igor3 kernel: end_request: I/O error, dev hdc, sector 0
Dec 18 19:27:50 igor3 kernel: FAT: unable to read boot sector
(i also tried it with -t iso9660, this way the error is only slightly different)
Dec 18 19:27:50 igor3 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Dec 18 19:27:50 igor3 kernel:  printing eip:
Dec 18 19:27:50 igor3 kernel: c01b817e
Dec 18 19:27:50 igor3 kernel: *pde = 00000000
Dec 18 19:27:50 igor3 kernel: Oops: 0000 [#1]
Dec 18 19:27:50 igor3 kernel: PREEMPT SMP 
Dec 18 19:27:50 igor3 kernel: Modules linked in: md5 ipv6 lp ehci_hcd eepro100 snd_bt87x btaudio bt878 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_sis96x i2c_sis630 shpchp pciehp pci_hotplug analog gameport 8250_pnp pcspkr tsdev evdev ext3 jbd via_agp sworks_agp sis_agp nvidia_agp intel_mch_agp intel_agp efficeon_agp ati_agp amd_k7_agp amd64_agp ali_agp autofs4 af_packet agpgart i810_audio soundcore ac97_codec e100 mii sis900 tuner tvaudio msp3400 bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc i2c_core videodev parport_pc parport 8250 serial_core thermal processor fan button battery ac rtc sbp2 ohci1394 ieee1394 ub usb_storage ohci_hcd uhci_hcd usbcore tmscsim ide_scsi
Dec 18 19:27:50 igor3 kernel: CPU:    0
Dec 18 19:27:50 igor3 kernel: EIP:    0060:[<c01b817e>]    Not tainted VLI
Dec 18 19:27:50 igor3 kernel: EFLAGS: 00010246   (2.6.10-rc1) 
Dec 18 19:27:50 igor3 kernel: EIP is at get_kobj_path_length+0x1a/0x34
Dec 18 19:27:50 igor3 kernel: eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: dfd88df0
Dec 18 19:27:50 igor3 kernel: esi: 00000001   edi: 00000000   ebp: ffffffff   esp: de367de4
Dec 18 19:27:50 igor3 kernel: ds: 007b   es: 007b   ss: 0068
Dec 18 19:27:50 igor3 kernel: Process mount (pid: 3468, threadinfo=de366000 task=dfde65c0)
Dec 18 19:27:50 igor3 kernel: Stack: deaab400 c15d3900 c15d3900 dfd88df0 c01b81f7 dfd88df0 00000000 deaab400 
Dec 18 19:27:50 igor3 kernel:        c15d3900 c15d3900 00000000 c01b88c5 dfd88df0 000000d0 fffffff4 deaab400 
Dec 18 19:27:50 igor3 kernel:        c15d3900 c15d3900 00000000 c01b898e dfd88df0 00000005 00000000 000000d0 
Dec 18 19:27:50 igor3 kernel: Call Trace:
Dec 18 19:27:50 igor3 kernel:  [<c01b81f7>] kobject_get_path+0xf/0x54
Dec 18 19:27:50 igor3 kernel:  [<c01b88c5>] do_kobject_uevent+0x1d/0xd0
Dec 18 19:27:50 igor3 kernel:  [<c01b898e>] kobject_uevent+0x16/0x1c
Dec 18 19:27:50 igor3 kernel:  [<c015a8c2>] bdev_uevent+0x36/0x3c
Dec 18 19:27:50 igor3 kernel:  [<c015a9e8>] kill_block_super+0x14/0x34
Dec 18 19:27:50 igor3 kernel:  [<c0159ebd>] deactivate_super+0x3d/0x50
Dec 18 19:27:50 igor3 kernel:  [<c015a9b6>] get_sb_bdev+0xee/0x10c
Dec 18 19:27:50 igor3 kernel:  [<c019b2aa>] vfat_get_sb+0x1a/0x20
Dec 18 19:27:50 igor3 kernel:  [<c019b248>] vfat_fill_super+0x0/0x48
Dec 18 19:27:50 igor3 kernel:  [<c015ab76>] do_kern_mount+0x86/0x128
Dec 18 19:27:50 igor3 kernel:  [<c016e806>] do_new_mount+0x62/0xac
Dec 18 19:27:50 igor3 kernel:  [<c016ee52>] do_mount+0x146/0x198
Dec 18 19:27:50 igor3 kernel:  [<c016ecbc>] copy_mount_options+0x4c/0x9c
Dec 18 19:27:50 igor3 kernel:  [<c016f1cb>] sys_mount+0x97/0x114
Dec 18 19:27:50 igor3 kernel:  [<c01063a7>] syscall_call+0x7/0xb
Dec 18 19:27:50 igor3 kernel: Code: c3 85 db 58 74 ee 56 e8 d5 1b fd ff 5e eb e5 89 f6 55 57 56 53 be 01 00 00 00 8b 54 24 14 31 db bd ff ff ff ff 8b 3a 89 e9 89 d8 <f2> ae f7 d1 49 8b 52 24 85 d2 8d 74 31 01 75 ea 5b 89 f0 5e 5f 


Full kernel log is here:
http://debian.christian-leber.de/bugreport/kern.log
config is here:
http://debian.christian-leber.de/bugreport/config

Christian Leber

-- 
http://www.nosoftwarepatents.com

