Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUL0AJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUL0AJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUL0AJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:09:09 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:12955 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261416AbUL0AI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:08:57 -0500
From: Juergen Krause <Krause.J@gmx.de>
Reply-To: Krause.J@gmx.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: kernel 2.6.10: promise sx6000 not detected by i2o_block
Date: Mon, 27 Dec 2004 01:10:29 +0100
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200412252244.48875.Krause.J@gmx.de> <1104080689.15994.9.camel@localhost.localdomain>
In-Reply-To: <1104080689.15994.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412270110.29657.Krause.J@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

thx for the quick responce.

I added the the PCI indentifier to drivers/message/i2o/pci.c as follows:

--- linux-2.6.10/drivers/message/i2o/pci.c      2004-12-26 23:38:13.801878056 +0100
+++ linux-2.6.10-test/drivers/message/i2o/pci.c 2004-12-27 00:02:25.589172840 +0100
@@ -49,6 +49,7 @@
 static struct pci_device_id __devinitdata i2o_pci_ids[] = {
        {PCI_DEVICE_CLASS(PCI_CLASS_INTELLIGENT_I2O << 8, 0xffff00)},
        {PCI_DEVICE(PCI_VENDOR_ID_DPT, 0xa511)},
+       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x1962)},
        {0}
 };

but now i get a kernel panic when I load the module i2o_core :-(

Dec 27 00:53:22 server kobject i2o_core: registering. parent: <NULL>, set: module
Dec 27 00:53:22 server kobject_hotplug
Dec 27 0----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at pci:517
invalid operand: 0000 [1] PREEMPT SMP
CPU 0
Modules linked in: i2o_core w83627hf eeprom lm75 i2c_sensor i2c_isa i2c_viapro i2c_core st aic7xxx sk98lin
Pid: 0, comm: swapper Not tainted 2.6.10-test
RIP: 0010:[<ffffffffa00893a7>] <ffffffffa00893a7>{:i2o_core:i2o_pci_interrupt+87}
RSP: 0018:ffffffff805c1f08  EFLAGS: 00010287
RAX: ffffff0000300044 RBX: 000001002ca3f500 RCX: 000000000009f600
RDX: 0000000035fb0000 RSI: 000001003d0cbc00 RDI: 00000000000000b9
RBP: 000000000009f600 R08: ffffffff80614000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 000001003d0cbc00
R13: 000001003fc71070 R14: 0000000000000000 R15: ffffffff80615ec8
FS:  00000000005394a0(0000) GS:ffffffff8060d640(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000530038 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff80614000, task ffffffff804d9980)
Stack: ffffffff805c1f08 000001002ca3f500 0000000000000000 ffffffff80615ec8
       00000000000000b9 ffffffff8015365c 0000000000002e40 00000000000000b9
       ffffffff80611200 ffffffff80611224
Call Trace:<IRQ> <ffffffff8015365c>{handle_IRQ_event+44} <ffffffff80153789>{__do_IRQ+249}
       <ffffffff8011042a>{do_IRQ+58} <ffffffff8010da7f>{ret_from_intr+0}
        <EOI> <ffffffff8010b740>{default_idle+0} <ffffffff8010b760>{default_idle+32}
       <ffffffff8010b7fc>{cpu_idle+44} <ffffffff8061775a>{start_kernel+378}
       <ffffffff8061726a>{_sinittext+618}

Code: 0f 0b 97 b5 08 a0 ff ff ff ff 05 02 8b 05 3f e9 53 e0 48 89
RIP <ffffffffa00893a7>{:i2o_core:i2o_pci_interrupt+87} RSP <ffffffff805c1f08>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

Any ideas what I should test now or do you need more infos?
Just let me know.

Regards,
Juergen Krause


Am Sonntag, 26. Dezember 2004 18:04 schrieb Alan Cox:
> On Sad, 2004-12-25 at 21:44, Juergen Krause wrote:
> > 0000:00:0c.0 PCI bridge: Intel Corp. 80960RM [i960RM Bridge] (rev 02)
> > 0000:00:0c.1 Class ff00: Intel Corp. 80960RM [i960RM Microprocessor] (rev
> > 02)
>
> The I2O layer expects the controller to be in I2O mode. You might want
> to try adding the PCI identifier directly to drivers/message/i2o/pci.c
> next to the DPT one.
