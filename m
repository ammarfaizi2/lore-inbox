Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbULMMLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbULMMLe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbULMML3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:11:29 -0500
Received: from wylie.me.uk ([82.68.155.89]:45976 "EHLO mail.wylie.me.uk")
	by vger.kernel.org with ESMTP id S262238AbULMMLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:11:04 -0500
From: "Alan J. Wylie" <alan@wylie.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16829.34517.689764.245416@devnull.wylie.me.uk>
Date: Mon, 13 Dec 2004 12:11:01 +0000
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       EC <wingman@waika9.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
In-Reply-To: <41BD7866.4010009@pobox.com>
References: <16824.8109.697757.673632@devnull.wylie.me.uk>
	<41BB41DC.6020808@pobox.com>
	<16829.29661.747368.799519@devnull.wylie.me.uk>
	<41BD7866.4010009@pobox.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004 06:09:26 -0500, Jeff Garzik <jgarzik@pobox.com> said:

> Is it possible for you to enable the following two #ifdefs in
> include/linux/libata.h, and send me the output?

> #define ATA_DEBUG                /* debugging output */
> #define ATA_VERBOSE_DEBUG        /* yet more debugging output */

(Hand transcribed - E&OE)

ksymoops output below.

...
piix_init: pci_module_init
ata_pci_init_one: ENTER
PCI: found IRQ 10 for device 00:1f.2
PCI: Sharing IRQ 10 with 00:1d.2
PCI: Sharing IRQ 10 with 04:02.0
piix_init: scsi_register_host
ata_scsi_detect: ENTER
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt f7e5a000, dma 37e5a000
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18E0 irq 14
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata_bus_reset: ENTER, host 1, port 0
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_dev_identify: do ATA identify
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_exec_command_pio: ata1: cmd 0xEC
ata_pio_sector: data read
ata_qc_complete: EXIT
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  75==0x0000
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7f09  84==0x4003
ata_dump_id: 88==0x207f  93==0x0000
ata1: dev 0 ATA, max UDMA/133, 39827088 sectors: lba48
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
ata_dev_set_xfermode: set features - xfer mode
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_pio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xA0
ata_command_exec_pio: ata1: cmd 0xEF
ata_host_intr: ata1: protocol 1 (dev_stat 0x50)
ata_qc_complete: EXIT
ata_dev_set_xfermode: EXIT
ata_dev_set_mode: idx=6 xfer_shift=0, xfer_mode=0x46, base=0x40, offset=6
ata1: dev 0 configured for UDMA/133
ata_device_add: ata1: probe end
ata_device_add: EXIT, returning 1
ata_device_add: ENTER
ata_host_add: ENTER
Unable to handle kernel NULL pointer dereference at virtual address 00000050
 printing eip:
c01b028b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b028b>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: f7e6b878   ecx: 00000000   edx: 00000002
esi: f7e6b800   edi: f7e6ba20   ebp: f7e6ba20   esp: c19b7f10
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c19b7000)
Stack: f7e6b878 f7e6b800 c19bfa00 f7e6ba20 00000000 f7e6ba20 c19bfa00 00000000
       c01b04c0 f7e6ba20 c19bfa00 00000000 c0209ae8 00000286 000003f6 000018e0
       0000000e c19b0800 00000000 f7e6ba20 00000001 c0105000 c02282e0 c01b05d0
Call Trace:    [<c01a04c0>] [<c0105000>] [<c01b05d0>] [<c01a0ab5>] [<c01161b1>]
  [<c01b5efc>] [<c0105000>] [<c010507b>] [<c0105000>] [<c010569e>] [<c0105070>]

Code: ff 50 50 89 da 85 c0 75 12 8b 5c 24 14 89 d0 8b 74 24 18 8b
  <0>Kernel panic: Attempted to kill init!


ksymoops 2.4.9 on i686 2.4.29-pre1-bk5.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000050
c01b028b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b028b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: f7e6b878   ecx: 00000000   edx: 00000002
esi: f7e6b800   edi: f7e6ba20   ebp: f7e6ba20   esp: c19b7f10
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c19b7000)
Stack: f7e6b878 f7e6b800 c19bfa00 f7e6ba20 00000000 f7e6ba20 c19bfa00 00000000
       c01b04c0 f7e6ba20 c19bfa00 00000000 c0209ae8 00000286 000003f6 000018e0
       0000000e c19b0800 00000000 f7e6ba20 00000001 c0105000 c02282e0 c01b05d0
Call Trace:    [<c01a04c0>] [<c0105000>] [<c01b05d0>] [<c01a0ab5>] [<c01161b1>]
  [<c01b5efc>] [<c0105000>] [<c010507b>] [<c0105000>] [<c010569e>] [<c0105070>]
Code: ff 50 50 89 da 85 c0 75 12 8b 5c 24 14 89 d0 8b 74 24 18 8b


>>EIP; c01b028b <ata_host_add+6b/a0>   <=====

Trace; c01a04c0 <proc_scsi_gen_write+160/470>
Trace; c0105000 <_stext+0/0>
Trace; c01b05d0 <ata_scsi_detect+70/90>
Trace; c01a0ab5 <scsi_register_host+2e5/2f0>
Trace; c01161b1 <printk+111/150>
Trace; c01b5efc <pci_register_driver+5c/60>
Trace; c0105000 <_stext+0/0>
Trace; c010507b <init+b/100>
Trace; c0105000 <_stext+0/0>
Trace; c010569e <arch_kernel_thread+2e/40>
Trace; c0105070 <init+0/100>

Code;  c01b028b <ata_host_add+6b/a0>
00000000 <_EIP>:
Code;  c01b028b <ata_host_add+6b/a0>   <=====
   0:   ff 50 50                  call   *0x50(%eax)   <=====
Code;  c01b028e <ata_host_add+6e/a0>
   3:   89 da                     mov    %ebx,%edx
Code;  c01b0290 <ata_host_add+70/a0>
   5:   85 c0                     test   %eax,%eax
Code;  c01b0292 <ata_host_add+72/a0>
   7:   75 12                     jne    1b <_EIP+0x1b>
Code;  c01b0294 <ata_host_add+74/a0>
   9:   8b 5c 24 14               mov    0x14(%esp),%ebx
Code;  c01b0298 <ata_host_add+78/a0>
   d:   89 d0                     mov    %edx,%eax
Code;  c01b029a <ata_host_add+7a/a0>
   f:   8b 74 24 18               mov    0x18(%esp),%esi
Code;  c01b029e <ata_host_add+7e/a0>
  13:   8b 00                     mov    (%eax),%eax

  <0>Kernel panic: Attempted to kill init!


-- 
Alan J. Wylie                                          http://www.wylie.me.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  -- Antoine de Saint-Exupery
