Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVJ2PEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVJ2PEY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 11:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVJ2PEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 11:04:24 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:46236 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751182AbVJ2PEY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 11:04:24 -0400
Date: Sat, 29 Oct 2005 11:04:22 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: oops with USB Storage on 2.6.14
In-reply-to: <38bdcd1f0510290511t65bb16cfkfd1e84fb301424f9@mail.gmail.com>
To: linux-kernel@vger.kernel.org
Message-id: <200510291104.22414.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <38bdcd1f0510290511t65bb16cfkfd1e84fb301424f9@mail.gmail.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 October 2005 08:11, Masanari Iida wrote:
>Hello,
>I updated my system's kernel from 2.6.13.2 to 2.6.14,
>then it oops when I connect my Digital Camera via USB connection
>as USB storage device.
>I went back to 2.6.14-rc1, still the same panic happen.
>2.6.13.2 and before, the kernel has been worked as expected.
>
>CPU Intel P4(2.4Ghz)
>USB Device   Pentax Optio S40.

I have an Olympus C-3020 which uses the usbstorage module, and looks
like a vfat filesystem with fat bugs.  I just checked it and it worked
as expected with no errors or oops's.  Its worked all along anytime I
wanted to grab the pix from it and unload the ram card for further use.
Athlon XP-2800, currently running 2.6.14.

>From dmesg:
usb 3-2.3: new full speed USB device using ohci_hcd and address 6
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 6
usb-storage: waiting for device to settle before scanning
  Vendor: OLYMPUS   Model: C-3020ZOOM(U)     Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: device scan complete
SCSI device sda: 128000 512-byte hdwr sectors (66 MB)
sda: Write Protect is off
sda: Mode Sense: 18 00 00 08
sda: assuming drive cache: write through
SCSI device sda: 128000 512-byte hdwr sectors (66 MB)
sda: Write Protect is off
sda: Mode Sense: 18 00 00 08
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
usb 3-2.3: USB disconnect, address 6

You may want to re-check your .config & rebuild.

>Unable to handle kernel paging request at virtual address dc9d1f4c
> printing eip:
>c02b44cc
>*pde = 00073067
>*pte = 1c9d1000
>Oops: 0000 [#1]
>SMP DEBUG_PAGEALLOC
>Modules linked in: autofs e100 ipt_LOG ipt_state ip_conntrack
>ipt_recent iptable
>_filter ip_tables video rtc
>CPU:    1
>EIP:    0060:[<c02b44cc>]    Not tainted VLI
>EFLAGS: 00010286   (2.6.14)
>EIP is at scsi_run_queue+0xc/0xd0
>eax: 00000001   ebx: dc9d1e3c   ecx: d6b67910   edx: dc9d1e3c
>esi: d5048eb0   edi: dc9d1e3c   ebp: c1507e98   esp: c1507e84
>ds: 007b   es: 007b   ss: 0068
>Process ksoftirqd/1 (pid: 6, threadinfo=c1506000 task=dfe2dad0)
>Stack: 00000292 de3a7bf8 dc9d1e3c d5048eb0 dc9d1e3c c1507ea8 c02b4612
> dc9d1e3c da51bf60 c1507ecc c02b473f d5048eb0 00000000 00000024 00000286
> 00000001 d5048eb0 00000000 c1507f10 c02b4b2e d5048eb0 00000000 00000024
> 00000001
>
>Call Trace:
> [<c0103abf>] show_stack+0x7f/0xa0
> [<c0103c72>] show_registers+0x162/0x1d0
> [<c0103e90>] die+0x100/0x1a0
> [<c039d7ae>] do_page_fault+0x31e/0x640
> [<c0103763>] error_code+0x4f/0x54
> [<c02b4612>] scsi_next_command+0x22/0x30
> [<c02b473f>] scsi_end_request+0xcf/0xf0
> [<c02b4b2e>] scsi_io_completion+0x26e/0x470
> [<c02b4fc7>] scsi_generic_done+0x37/0x50
> [<c02af9e5>] scsi_finish_command+0x85/0xa0
> [<c02af89c>] scsi_softirq+0xcc/0x140
> [<c0122085>] __do_softirq+0xd5/0xf0
> [<c01220d8>] do_softirq+0x38/0x40
> [<c0122685>] ksoftirqd+0x95/0xe0
> [<c0131cfa>] kthread+0xba/0xc0
> [<c0100ecd>] kernel_thread_helper+0x5/0x18
>Code: f0 8b 42 44 e8 16 7f 0e 00 89 45 ec 89 1c 24 e8 6b b7 ff ff eb aa
> 89 f6 8d bc 27 00 00 00 00 55 89 e5 57 56 53 83 ec 08 8b 55 08 <8b> 82
> 10 01 00 00 8b 38 f6 80 85 01 00 00 80 0f 85 9e 00 00 00
>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>
>Masanari

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Free OpenDocument reader/writer/converter download:
http://www.openoffice.org
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

