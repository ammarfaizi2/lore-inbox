Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269605AbUJFXXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269605AbUJFXXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269564AbUJFXUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:20:18 -0400
Received: from nonada.if.usp.br ([143.107.131.169]:3211 "EHLO nonada.if.usp.br")
	by vger.kernel.org with ESMTP id S269610AbUJFXQu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:16:50 -0400
From: =?utf-8?q?Jo=C3=A3o_Luis_Meloni_Assirati?= 
	<assirati@nonada.if.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Re: hpt366 under hpt372N oops
Date: Wed, 6 Oct 2004 20:16:46 -0300
User-Agent: KMail/1.6.2
References: <200410050638.13426.assirati@nonada.if.usp.br> <1097016504.23924.10.camel@localhost.localdomain>
In-Reply-To: <1097016504.23924.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200410062016.46446.assirati@nonada.if.usp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, it looks that my e-mail didn't find its way... I'm resending it.


Hello,

Bartlomiej Zolnierkiewicz wrote:
> try 2.6.9-rc3

Alan Cox wrote:
> Is this crash fixed by 2.6.9rc3 for you - its my fault I'm afraid I
> slightly screwed up merging 2.4.2x HPT372N into 2.6.x

Unfortunately it is not, but at least the HPT372N chipset gets detected. 
Modprobe still ends with a segmentation fault. Below is the kernel message 
for 2.6.9-rc3.

Regards,
João.

HPT372A: IDE controller at PCI slot 0000:01:08.0
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 18 (level, high) -> IRQ 18
HPT372A: chipset revision 2
hpt: HPT372N detected, using 372N timing.
FREQ: 124 PLL: 45
HPT372A: 100% native mode on irq 18
hpt: no known IDE timings, disabling DMA.
hpt: no known IDE timings, disabling DMA.
Probing IDE interface ide2...
hde: ST380011A, ATA DISK drive
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
de92b719
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: hpt366 binfmt_misc autofs button processor quota_v2 nfsd 
exportfs lockd sunrpc dm_snapshot loop non_fatal w83781d i2c_sensor 
i2c_amd756 i2c_dev i2c_core ohci_hcd usbcore snd_intel8x0 snd_ac97_codec 
snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi 
snd_seq_device snd soundcore rtc evdev psmouse 8250 serial_core 8139too mii 
crc32 forcedeth unix
CPU:    0
EIP:    0060:[<de92b719>]    Not tainted VLI
EFLAGS: 00210282   (2.6.9-rc3)
EIP is at pci_bus_clock_list+0x9/0x30 [hpt366]
eax: 0000000c   ebx: 00000051   ecx: 0000000c   edx: 00000000
esi: 30070000   edi: 00000040   ebp: c14fb000   esp: d2017e1c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 5494, threadinfo=d2016000 task=d8cc0560)
Stack: de92baff 0000000c 00000000 00000051 00000000 0000000c 0c4fb000 00000000
       004fb000 c039ae1c c039aaa4 ddfdfc3e c039a9f8 c0221c97 c039aaa4 0000000c
       00000001 00000012 00000001 d2017eb8 de930214 c02253be 00000012 00200286
Call Trace:
 [<de92baff>] hpt372_tune_chipset+0xdf/0x160 [hpt366]
 [<c0221c97>] probe_hwif+0x267/0x560
 [<c02253be>] do_ide_setup_pci_device+0x9e/0x170
 [<c0221fa7>] probe_hwif_init+0x17/0x60
 [<c02254e7>] ide_setup_pci_device+0x57/0x90
 [<de92d86e>] hpt366_init_one+0x1e/0x30 [hpt366]
 [<c01c8142>] pci_device_probe_static+0x52/0x70
 [<c01c819b>] __pci_device_probe+0x3b/0x50
 [<c01c81dc>] pci_device_probe+0x2c/0x50
 [<c0201c4f>] bus_match+0x3f/0x70
 [<c0201d79>] driver_attach+0x59/0x90
 [<c0202221>] bus_add_driver+0x91/0xb0
 [<c02027df>] driver_register+0x2f/0x40
 [<c01c846c>] pci_register_driver+0x5c/0x90
 [<c022565d>] ide_pci_register_driver+0x3d/0x50
 [<de92d88f>] hpt366_ide_init+0xf/0x14 [hpt366]
 [<c0133cee>] sys_init_module+0x17e/0x230
 [<c010621b>] syscall_call+0x7/0xb
Code: 86 89 e1 ba 01 00 00 00 85 c0 75 d1 8b 75 00 85 f6 75 e1 eb c6 8d b6 00 
00 00 00 8d bc 27 00 00 00 00 8b 54 24 08 0f b6 4c 24 04 <0f> b6 02 84 c0 74 
0e 38 c8 74 0e 83 c2 08 0f b6 02 84 c0 75 f2



Em Ter 05 Out 2004 19:48, você escreveu:
> On Maw, 2004-10-05 at 10:38, João Luis Meloni Assirati wrote:
> > Hello,
> >
> > I have an off board HighPoint RocketRAID 133 pci card. The chip is
> > identified as HPT372N and there is a tag in the board printed V2.35.
>
> Is this crash fixed by 2.6.9rc3 for you - its my fault I'm afraid I
> slightly screwed up merging 2.4.2x HPT372N into 2.6.x
