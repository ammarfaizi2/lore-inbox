Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268919AbUJEJiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268919AbUJEJiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 05:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUJEJiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 05:38:22 -0400
Received: from nonada.if.usp.br ([143.107.131.169]:21889 "EHLO
	nonada.if.usp.br") by vger.kernel.org with ESMTP id S268919AbUJEJiQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 05:38:16 -0400
From: =?iso-8859-1?q?Jo=E3o_Luis_Meloni_Assirati?= 
	<assirati@nonada.if.usp.br>
To: linux-kernel@vger.kernel.org
Subject: hpt366 under hpt372N oops
Date: Tue, 5 Oct 2004 06:38:13 -0300
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410050638.13426.assirati@nonada.if.usp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an off board HighPoint RocketRAID 133 pci card. The chip is identified 
as HPT372N and there is a tag in the board printed V2.35.

I'm using the kernel 2.6.8.1 with no patches. I compiled the driver hpt366 as 
a module, and when I modprobe it, I get a segmentation fault. The kernel 
outputs the message at the end of this e-mail.

Strange things:
* lspci reports
0000:01:08.0 RAID bus controller: Triones Technologies, Inc. HPT372A (rev 02)
The oops message below also identifies it as an HPT372A
* I have just one hard disk at the first controller (it makes no difference if 
I use the second). I didn't test with two hard disks, but with NO hard disks  
the driver doesn't oops.

General information:
Mother board: Asus A7N266-VM (I'm not using nvidia's proprietary driver)
Processor: AMD Athlon(TM) XP 2000+
Gcc version: 3.3.4

I will be glad to send any other necessary information and do some testing.

Please CC to me as I'm not subscribed to the list.

Thank you,
Joao Luis.

Kernel oops:

HPT372A: IDE controller at PCI slot 0000:01:08.0
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 18 (level, high) -> IRQ 18
HPT372A: chipset revision 2
hpt: HPT372N detected, using 372N timing.
FREQ: 125 PLL: 45
HPT372A: 100% native mode on irq 18
hpt: no known IDE timings, disabling DMA.
hpt: no known IDE timings, disabling DMA.
hde: ST380011A, ATA DISK drive
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
de96c719
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: hpt366 binfmt_misc autofs button processor quota_v2 nfsd 
exportfs lockd sunrpc dm_snapshot loop non_fatal w83781d i2c_sensor 
i2c_amd756 i2c_dev i2c_core ohci_hcd usbcore snd_intel8x0 snd_ac97_codec 
snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi 
snd_seq_device snd evdev soundcore rtc psmouse 8250 serial_core 8139too mii 
crc32 forcedeth unix
CPU:    0
EIP:    0060:[<de96c719>]    Not tainted
EFLAGS: 00210286   (2.6.8.1-test)
EIP is at pci_bus_clock_list+0x9/0x30 [hpt366]
eax: 0000000c   ebx: 00000051   ecx: 0000000c   edx: 00000000
esi: 30070000   edi: 00000040   ebp: c14fec00   esp: d057de28
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 5622, threadinfo=d057c000 task=d92ce6a0)
Stack: de96caff 0000000c 00000000 00000051 00000000 0000000c 0c4fec00 00000000
       004fec00 c038a84c c02b3d4f c159563e c038a7a0 c02186f7 c038a84c 0000000c
       d057deb8 de971334 c021bebe 00000012 00200286 00000000 00000012 c038a7a0
Call Trace:
 [<de96caff>] hpt372_tune_chipset+0xdf/0x160 [hpt366]
 [<c02186f7>] probe_hwif+0x237/0x440
 [<c021bebe>] do_ide_setup_pci_device+0x9e/0x170
 [<c0218917>] probe_hwif_init+0x17/0x60
 [<c021bfe6>] ide_setup_pci_device+0x56/0x90
 [<de96e8ae>] hpt366_init_one+0x1e/0x30 [hpt366]
 [<c01c4342>] pci_device_probe_static+0x52/0x70
 [<c01c439b>] __pci_device_probe+0x3b/0x50
 [<c01c43dc>] pci_device_probe+0x2c/0x50
 [<c01f8f8f>] bus_match+0x3f/0x70
 [<c01f90b9>] driver_attach+0x59/0x90
 [<c01f9561>] bus_add_driver+0x91/0xb0
 [<c01f9b1f>] driver_register+0x2f/0x40
 [<c01c465c>] pci_register_driver+0x5c/0x90
 [<c021c15d>] ide_pci_register_driver+0x3d/0x50
 [<de96e8cf>] hpt366_ide_init+0xf/0x14 [hpt366]
 [<c0132054>] sys_init_module+0x114/0x230
 [<c0106107>] syscall_call+0x7/0xb
Code: 0f b6 02 84 c0 74 0e 38 c8 74 0e 83 c2 08 0f b6 02 84 c0 75
