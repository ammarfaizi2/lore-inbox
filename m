Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWALE3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWALE3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWALE3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:29:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30167 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965013AbWALE3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:29:35 -0500
Date: Wed, 11 Jan 2006 20:29:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [GIT PATCH] PCI patches for 2.6.15 - retry
Message-Id: <20060111202903.77ff9938.akpm@osdl.org>
In-Reply-To: <43C5D34B.1090903@reub.net>
References: <20060109203711.GA25023@kroah.com>
	<Pine.LNX.4.64.0601091557480.5588@g5.osdl.org>
	<20060109164410.3304a0f6.akpm@osdl.org>
	<1136857742.14532.0.camel@localhost.localdomain>
	<20060109174941.41b617f6.akpm@osdl.org>
	<43C5D34B.1090903@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> 
> 
> On 10/01/2006 2:49 p.m., Andrew Morton wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >> On Llu, 2006-01-09 at 16:44 -0800, Andrew Morton wrote:
> >>> - Reuben Farrelly's oops in make_class_name().  Could be libata, or scsi
> >>>   or driver core.
> >> libata I think. I reproduced it on 2.6.14-mm2 by accident with a buggy
> >> pata driver.
> > 
> > Well that's all merged up now.  Reuben, could you please test 2.6.15git6
> > tomorrow?
> 
> Seemingly not fixed afterall.  I've been doing many reboots lately getting to 
> the bottom of the barrier/md bug and just before I hit this with -mm3 
> (linus.patch -git7) which I believe is the same bug (the call trace looks very 
> similar).
> 
> ...

I'm getting my bugs confused now - there are so many.  Were you the person
who reported this before?

> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 18 (level, low) -> IRQ 185
> 0000:06:02.0: ttyS1 at I/O 0xbc00 (irq = 185) is a 16550A
> 0000:06:02.0: ttyS2 at I/O 0xbc08 (irq = 185) is a 16550A
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ahci: probe of 0000:00:1f.2 failed with error -12
> ata1: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x0 irq 0
> ata2: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x8 irq 0
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   printing eip:
> c023c873
> *pde = 00000000
> Oops: 0000 [#1]
> SMP
> last sysfs file:
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c023c873>]    Not tainted VLI
> EFLAGS: 00010206   (2.6.15-mm3)
> EIP is at make_class_name+0x28/0x8d
> eax: 00000000   ebx: ffffffff   ecx: ffffffff   edx: c1a12224
> esi: 00000009   edi: 00000000   ebp: c1921d2c   esp: c1921d1c
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=c1921000 task=c1920a90)
> Stack: <0>c1a12224 c03913f8 c1a12224 c03913f8 c1921d54 c023cabd c1921d58 c0391380
>         00000000 c1af39c0 c0391400 c1a12224 c1a12000 c1a12030 c1921d60 c023cb7b
>         c1a120e4 c1921d74 c0255dbf c1a122c0 c1a43a40 00000000 c1921d80 c025e393
> Call Trace:
>   [<c0103c5d>] show_stack+0x9b/0xc0
>   [<c0103de4>] show_registers+0x162/0x1e7
>   [<c0103f8f>] die+0x126/0x231
>   [<c01140db>] do_page_fault+0x271/0x5b9
>   [<c01037df>] error_code+0x4f/0x54
>   [<c023cabd>] class_device_del+0xa3/0x156
>   [<c023cb7b>] class_device_unregister+0xb/0x15
>   [<c0255dbf>] scsi_remove_host+0xb4/0xef
>   [<c025e393>] ata_host_remove+0x11/0x1c
>   [<c0260ec6>] ata_device_add+0x2e4/0xb7b
>   [<c0261cd6>] ata_pci_init_one+0x322/0x387
>   [<c0265b34>] piix_init_one+0x18c/0x338
>   [<c01f4f4f>] pci_device_probe+0x44/0x5f
>   [<c023bf62>] driver_probe_device+0x3e/0xb0
>   [<c023c0df>] __driver_attach+0x8e/0x90
>   [<c023b9f3>] bus_for_each_dev+0x44/0x62
>   [<c023bece>] driver_attach+0x19/0x1b
>   [<c023b687>] bus_add_driver+0x6d/0x126
>   [<c023c350>] driver_register+0x6b/0x9b
>   [<c01f50fb>] __pci_register_driver+0x6a/0x95
>   [<c03e8ea8>] piix_init+0xf/0x22
>   [<c01003cc>] init+0xff/0x325
>   [<c0100d25>] kernel_thread_helper+0x5/0xb
> Code: c8 5d c3 55 89 e5 57 56 53 83 ec 04 89 45 f0 89 c2 8b 40 48 8b 38 bb ff ff 
> ff ff 89 d9 31 c0 f2 ae f7 d1 49 89 ce 8b 7a 08 89 d9 <f2> ae f7 d1 49 89 ca 8d 
> 4e 02 8d 04 0a ba d0 00 00 00 e8 3b 72

Jeff, I beleive this is a sata bug.  ata_device_add() called
ata_host_remove() and something under there isnot yet sufficiently
initialised.

