Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWFXSqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWFXSqF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 14:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWFXSqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 14:46:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28844 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751037AbWFXSqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 14:46:04 -0400
Date: Sat, 24 Jun 2006 11:45:52 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Stephen Cameron <smcameron@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with Sandisk USB CF reader on 2.6.16.20
Message-Id: <20060624114552.90dd9332.zaitcev@redhat.com>
In-Reply-To: <mailman.1150903750.17592.linux-kernel2news@redhat.com>
References: <mailman.1150903750.17592.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 19:54:31 -0700 (PDT), Stephen Cameron <smcameron@yahoo.com> wrote:

> Here's the dmesg diff:

Well, kinda...

> [scameron@zuul ~]$ cat dmesg_diffs.txt
> --- dmesg.11.txt        2006-06-20 16:21:05.000000000 -0500
> +++ dmesg.20.txt        2006-06-20 16:16:03.000000000 -0500
> @@ -1,4 +1,24 @@
> -ivers/usb/core/inode.c: creating file '001'
> +pports S0 S1 S3 S4 S5)
> +Freeing unused kernel memory: 168k freed
> +input: ImPS/2 Generic Wheel Mouse as /class/input/input1
> +ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800004d8682]
> +ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> +PCI: setting IRQ 11 as level-triggered
> +ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
> +ALSA /home/scameron/software/alsa-driver-1.0.11/pci/emu10k1/../../alsa-kernel/pci/emu10k1/emu10k1_main.c:186: Audigy2 value: Special config.
> +ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
> +PCI: setting IRQ 10 as level-triggered
> +ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
> +usbcore: registered new driver usbfs
> +usbcore: registered new driver hub
> +ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
> +ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
> +ehci_hcd 0000:00:10.4: EHCI Host Controller
> +ehci_hcd 0000:00:10.4: reset hcs_params 0x4208 dbg=0 cc=4 pcc=2 ordered !ppc ports=8
> +ehci_hcd 0000:00:10.4: reset hcc_params 6872 thresh 7 uframes 256/512/1024
> +ehci_hcd 0000:00:10.4: MWI active
> +drivers/usb/core/inode.c: creating file 'devices'
> +drivers/usb/core/inode.c: creating file '001'
>  ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
>  ehci_hcd 0000:00:10.4: irq 11, io mem 0xeb001000

This is truncated on top, and so less useful than it otherwise would.
And it's truncated because of this:

> -usb 1-5:1.0: uevent
> -libusual 1-5:1.0: usb_probe_interface
> -libusual 1-5:1.0: usb_probe_interface - got id
> -usb-storage 1-5:1.0: usb_probe_interface
> -usb-storage 1-5:1.0: usb_probe_interface - got id

You built a kernel with some silly debugging, which made the dmesg
to explode.

> +usb 1-5: device not accepting address 3, error -110

This tells us enough (without any debugging options), your interrupt
routing is busted.

We know that this is not the Wedgewood's "VIA cleanup", because
in your case the quirk was applied. But since the diff was truncated,
there's no telling. Observe that that ALSA stuff you load out-of-tree
shares IRQ 11 with the failing EHCI, for example.

-- Pete
