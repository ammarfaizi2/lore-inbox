Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWGALv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWGALv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 07:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWGALv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 07:51:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36820 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964859AbWGALv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 07:51:28 -0400
Date: Sat, 1 Jul 2006 04:51:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, Brice Goglin <brice@myri.com>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.17-mm5
Message-Id: <20060701045100.88c4eadc.akpm@osdl.org>
In-Reply-To: <44A657B8.7040702@reub.net>
References: <20060701033524.3c478698.akpm@osdl.org>
	<44A657B8.7040702@reub.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jul 2006 23:08:40 +1200
Reuben Farrelly <reuben-lkml@reub.net> wrote:

> 
> 
> On 1/07/2006 10:35 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm5/
> > 
> > 
> > Nothing very exciting here - a few buggy patches were fixed or dropped.
> 
> Ouch:

Well I didn't say that new buggy patches weren't added.

>      ide0: BM-DMA at 0x30b0-0x30b7, BIOS settings: hda:DMA, hdb:pio
> hda: PIONEER DVD-RW DVR-111D, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Unable to handle kernel NULL pointer dereference at 00000000000000ce RIP:
>   [<ffffffff80363a96>] pci_msi_supported+0x37/0x4b
> PGD 0
> Oops: 0000 [1] SMP
> last sysfs file:
> CPU 0
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.17-mm5 #1
> RIP: 0010:[<ffffffff80363a96>]  [<ffffffff80363a96>] pci_msi_supported+0x37/0x4b
> RSP: 0000:ffff81003f601b88  EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff81003ec659c8 RCX: 00000000481a0000
> RDX: 00000000481a03ff RSI: ffff810037f9aa80 RDI: ffff81003ec65800
> RBP: ffff81003f601b88 R08: 0000000000000000 R09: 0000000000000000
> R10: ffff810037f9aa80 R11: 0000000000000040 R12: ffff81003ec65800
> R13: 0000000000000000 R14: ffffffff805a0620 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff80685000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 00000000000000ce CR3: 0000000000201000 CR4: 00000000000006e0
> Process swapper (pid: 1, threadinfo ffff81003f600000, task ffff810001fb8740)
> Stack:  ffff81003f601bf8 ffffffff80364909 ffff81003f601bc8 ffffffff8035dbee
>   0000000000000000 0000000000000005 ffffffff804c8166 ffff81003ec65800
>   ffff81003f601bf8 ffff81003ec659c8 ffff81003ec65800 0000000000000000
> Call Trace:
>   [<ffffffff80364909>] pci_enable_msi+0x19/0x2f2
>   [<ffffffff8035dbee>] pci_request_region+0xce/0x180
>   [<ffffffff803e8867>] ahci_init_one+0x88/0x93a
>   [<ffffffff8026311d>] wait_for_completion+0xb2/0x112
>   [<ffffffff80280b4f>] default_wake_function+0x0/0xf
>   [<ffffffff80290dcc>] call_usermodehelper_keys+0xd4/0xe8
>   [<ffffffff80290de0>] __call_usermodehelper+0x0/0x64
>   [<ffffffff8025affa>] kobject_get+0x1a/0x24
>   [<ffffffff8035ff1c>] pci_device_probe+0x4d/0x78
>   [<ffffffff803aaa8f>] driver_probe_device+0x5c/0xb4
>   [<ffffffff803aabc9>] __driver_attach+0x67/0xb9
>   [<ffffffff803aab62>] __driver_attach+0x0/0xb9
>   [<ffffffff803aa44f>] bus_for_each_dev+0x4f/0x79
>   [<ffffffff803aa9bc>] driver_attach+0x1c/0x1e
>   [<ffffffff803aa01a>] bus_add_driver+0x7a/0x143
>   [<ffffffff803aae63>] driver_register+0x9f/0xa6
>   [<ffffffff80280b6e>] wake_up_process+0x10/0x12
>   [<ffffffff80360107>] __pci_register_driver+0x59/0x7e
>   [<ffffffff806b7799>] ahci_init+0x12/0x14
>   [<ffffffff80267ece>] init+0x14e/0x2c2
>   [<ffffffff80227b67>] schedule_tail+0x37/0x9e
>   [<ffffffff80260972>] child_rip+0x8/0x12
>   [<ffffffff80267d80>] init+0x0/0x2c2
>   [<ffffffff8026096a>] child_rip+0x0/0x12
> 
> 
> Code: f6 80 ce 00 00 00 01 75 04 31 c0 eb 05 b8 ff ff ff ff 5d c3

It oopsed here:

static
int pci_msi_supported(struct pci_dev * dev)
{
	struct pci_dev *pdev;

	if (!pci_msi_enable || !dev || dev->no_msi)
		return -1;

	/* find root complex for our device */
	pdev = dev;
	while (pdev->bus && pdev->bus->self)
		pdev = pdev->bus->self;

	/* check its bus flags */
	if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
		return -1;

	return 0;
}

pdev->subordinate is NULL.

Two patch series touch that file.  The generic-irq wire-up and a couple of new
ones in Greg's tree.  I'd be suspecting
gregkh-pci-msi-stop-inheriting-bus-flags-and-check-root-chipset-bus-flags-instead.patch.


To confirm that, could you please test 2.6.17 plus
http://www.zip.com.au/~akpm/linux/patches/stuff/rf.bz2 with the same
.config?  That's everything up to but not including the genirq changes.


You may find that this gets things going again:

--- a/drivers/pci/msi.c~a
+++ a/drivers/pci/msi.c
@@ -913,6 +913,9 @@ int pci_msi_supported(struct pci_dev * d
 	while (pdev->bus && pdev->bus->self)
 		pdev = pdev->bus->self;
 
+	if (!pdev->subordinate)
+		return -1;
+
 	/* check its bus flags */
 	if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
 		return -1;
_

Or disable CONFIG_PCI_MSI.
