Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVC1Ka5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVC1Ka5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 05:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVC1Ka4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 05:30:56 -0500
Received: from tornado.reub.net ([60.234.136.108]:58558 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261487AbVC1Ka1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 05:30:27 -0500
Message-ID: <4247DCBE.7020900@reub.net>
Date: Mon, 28 Mar 2005 22:30:22 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050325)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk
Subject: Re: 2.6.12-rc1-mm3
References: <fa.h3qui0k.n6uf30@ifi.uio.no>
In-Reply-To: <fa.h3qui0k.n6uf30@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm3/
> 
> - Mainly a bunch of fixes relative to 2.6.12-rc1-mm2.
> 
> - Again, we'd like people who have had recent DRM and USB resume problems to
>   test and report, please.
> 
> - The bk-ide-dev tree is back after a couple of weeks of difficulties.
> 
> - Jeff asks that anyone who has had problems with the Silicon Image SATA
>   drivers test sata_sil-corruption--lockup-fix.patch, which is included in
>   this kernel.

I'm repeatably getting this crash on shutdown in -mm3, and a few 
releases earlier (but I can't be certain it was the same crash..)

Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS4 at I/O 0xa400 (irq = 16) is a 16550A
ttyS5 at I/O 0xa408 (irq = 16) is a 16550A

This _may_ be the culprit, but I'm not sure:

03:03.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 
16550 UART) (rev 01) (prog-if 02 [16550])
         Subsystem: Timedia Technology Co Ltd: Unknown device 0002
         Flags: stepping, medium devsel, IRQ 16
         I/O ports at a400 [size=32]

The board is an Intel D925XCV.

Shutdown goes like this:   (yes, hyperterminal sucks for the ^M 
characters, sorry)


INIT: Switching^MINIT: Sending processes the TERM signal
Stopping yum:  Disabling nightly yum update: [  OK  ]
[  OK  ]
Stopping cups-config-daemon: [  OK  ]
Stopping HAL daemon: [  OK  ]
Stopping system message bus: [  OK  ]
Stopping atd: [  OK  ]
Stopping cups: [  OK  ]
Shutting down xfs: [  OK  ]
Shutting down console mouse services: [  OK  ]
Unable to handle kernel paging request at virtual address f3a6ce68
  printing eip:
c0244109
*pde = 00000000
Oops: 0000 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in: hidp hci_usb sermouse nfsd exportfs md5 ipv6 lp 
autofs4 eeprom lm85 i2c_sensor rfcomm l2cap bluetooth nfs lock
d sunrpc usb_storage pwc videodev dm_mod video button battery ac 
ohci1394 ieee1394 uhci_hcd ehci_hcd parport_serial parport_pc parp
ort hw_random i2c_i801 i2c_core emu10k1_gp gameport e100 mii floppy ext3 
jbd ata_piix libata sd_mod scsi_mod
CPU:    0
EIP:    0060:[<c0244109>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12-rc1-mm3)
EIP is at serport_ldisc_write_wakeup+0x9/0x20
eax: f3a6cdf8   ebx: f73d7000   ecx: c038e374   edx: c0244100
esi: f73d700c   edi: f73d7000   ebp: c049e900   esp: f7568dc0
ds: 007b   es: 007b   ss: 0068
Process inputattach (pid: 2932, threadinfo=f7568000 task=f6993ac0)
Stack: c021bb08 00000286 f6c31000 c0245e4a f6c31018 f73d7000 f67c1e88 
cbff5c
        00000000 c021ceaa 00000000 00000000 00000000 c1e46000 c1e46000 
00000000
        00000000 c011b739 00000046 c1e46000 00000001 f2c00000 f2c00000 
c011b8b4
Call Trace:
^M [<c021bb08>] tty_wakeup+0x48/0x70
^M [<c0245e4a>] uart_close+0xca/0x1e0
^M [<c021ceaa>] release_dev+0x14a/0x750
^M [<c011b739>] change_page_attr+0x29/0x60
^M [<c011b8b4>] kernel_map_pages+0x84/0xa0
^M [<c014cbca>] store_stackinfo+0x5a/0x90
^M [<c01664c8>] __fput+0x108/0x180
^M [<c018b59b>] inotify_inode_queue_event+0x2b/0x40
^M [<c021d97f>] tty_release+0xf/0x20
^M [<c016644a>] __fput+0x8a/0x180
^M [<c0164d7b>] filp_close+0x4b/0x70
^M [<c0125254>] put_files_struct+0x74/0x100
^M [<c012610c>] do_exit+0x11c/0x420
^M [<c012647d>] do_group_exit+0x2d/0xa0
^M [<c012f74c>] get_signal_to_deliver+0x20c/0x310
^M [<c0103deb>] do_signal+0x5b/0x140
^M [<c011ea89>] __wake_up+0x29/0x40
^M [<c021b60c>] tty_ldisc_deref+0x3c/0x70
^M [<c021c267>] tty_read+0xc7/0x130
^M [<c0243fb0>] serport_ldisc_read+0x0/0x100
^M [<c016ecd3>] sys_fstat64+0x23/0x30
^M [<c021c1a0>] tty_read+0x0/0x130
^M [<c0165547>] vfs_read+0x97/0x140
^M [<c016585c>] sys_read+0x3c/0x70
^M [<c0103efa>] do_notify_resume+0x2a/0x40
^M [<c01040be>] work_notifysig+0x13/0x25
^MCode: e8 0f b6 c5 88 4b 4b 31 d2 c1 e9 10 88 43 4a 88 4b 49 89 d0 5b 
c3 8d b6 00 00 00 00 8d bf 00 00 00 00 8b 80 a8 09 00 00 8b
40 14 <8b> 50 70 85 d2 74 09 8b 52 10 85 d2 74 02 ff d2 c3 90 90 90 90
^M BUG: atomic counter underflow at:
^M [<c0126386>] do_exit+0x396/0x420
^M [<c01059f6>] die+0x166/0x170
^M [<c011a7a3>] do_page_fault+0x1f3/0x6a1
^M [<c0244109>] serport_ldisc_write_wakeup+0x9/0x20
^M [<c011b36c>] __change_page_attr+0x4c/0x3f0
^M [<c011a5b0>] do_page_fault+0x0/0x6a1
^M [<c010522f>] error_code+0x4f/0x60
^M [<c0244100>] serport_ldisc_write_wakeup+0x0/0x20
^M [<c0244109>] serport_ldisc_write_wakeup+0x9/0x20
^M [<c021bb08>] tty_wakeup+0x48/0x70
^M [<c0245e4a>] uart_close+0xca/0x1e0
^M [<c021ceaa>] release_dev+0x14a/0x750
^M [<c011b739>] change_page_attr+0x29/0x60
^M [<c011b8b4>] kernel_map_pages+0x84/0xa0
^M [<c014cbca>] store_stackinfo+0x5a/0x90
^M [<c01664c8>] __fput+0x108/0x180
^M [<c018b59b>] inotify_inode_queue_event+0x2b/0x40
^M [<c021d97f>] tty_release+0xf/0x20
^M [<c016644a>] __fput+0x8a/0x180
^M [<c0164d7b>] filp_close+0x4b/0x70
^M [<c0125254>] put_files_struct+0x74/0x100
^M [<c012610c>] do_exit+0x11c/0x420
^M [<c012647d>] do_group_exit+0x2d/0xa0
^M [<c012f74c>] get_signal_to_deliver+0x20c/0x310
^M [<c0103deb>] do_signal+0x5b/0x140
^M [<c011ea89>] __wake_up+0x29/0x40
^M [<c021b60c>] tty_ldisc_deref+0x3c/0x70
^M [<c021c267>] tty_read+0xc7/0x130
^M [<c0243fb0>] serport_ldisc_read+0x0/0x100
^M [<c016ecd3>] sys_fstat64+0x23/0x30
^M [<c021c1a0>] tty_read+0x0/0x130
^M [<c0165547>] vfs_read+0x97/0x140
^M [<c016585c>] sys_read+0x3c/0x70
^M [<c0103efa>] do_notify_resume+0x2a/0x40
^M [<c01040be>] work_notifysig+0x13/0x25
^MUnable to handle kernel NULL pointer dereference at virtual address 
00000020
^M printing eip:
^Mc0121320
^M*pde = 0041f001
^MOops: 0000 [#2]
^MSMP DEBUG_PAGEALLOC

(there's a bit more, which I can put up online if it's helpful)

Reuben
