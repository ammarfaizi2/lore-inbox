Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161778AbWKIGt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161778AbWKIGt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 01:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161819AbWKIGt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 01:49:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:772 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161818AbWKIGty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 01:49:54 -0500
Date: Thu, 9 Nov 2006 07:49:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Olivier Nicolas <olivn@trollprod.org>,
       Stephen Hemminger <shemminger@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc5 x86_64  irq 22: nobody cared
Message-ID: <20061109064956.GG4729@stusta.de>
References: <4551D12D.4010304@trollprod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4551D12D.4010304@trollprod.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 01:44:29PM +0100, Olivier Nicolas wrote:

> Hi,

Hi Olivier,

> 2.6.19-rc5 does not boot properly, I have tried pci=routeirq, irpoll 
> without success.
> 
> Full details (.config, dmesg, /proc/interrupts) are in 
> http://olivn.trollprod.org/2.6.19-rc5-irq.tar.gz

thanks for your report!

I might be wrong, but looking at the dmesg:
- irq 22 is the hda_intel IRQ
- the "irq 22: nobody cared" is immediately before the
  "hda_intel: No response from codec, disabling MSI..."
- in the routeirq case, the hda_intel IRQ as well as the
  IRQ in the error message change to 21

So it might be related to the hda_intel MSI check.

If this was a wrong guess, other interesting messages in the dmesg are:

<--  snip  -->

...
PCI: Using MMCONFIG at f0000000
PCI: No mmconfig possible on device 00:18
...
PCI: Setting latency timer of device 0000:00:03.0 to 64
pcie_portdrv_probe->Dev[02fd:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie03]
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[02fb:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie03]
PCI: Setting latency timer of device 0000:00:12.0 to 64
pcie_portdrv_probe->Dev[0376:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:12.0:pcie00]
Allocate Port Service[0000:00:12.0:pcie03]
PCI: Setting latency timer of device 0000:00:14.0 to 64
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:14.0:pcie00]
Allocate Port Service[0000:00:14.0:pcie03]
PCI: Setting latency timer of device 0000:00:16.0 to 64
pcie_portdrv_probe->Dev[0375:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:16.0:pcie00]
Allocate Port Service[0000:00:16.0:pcie03]
PCI: Setting latency timer of device 0000:00:17.0 to 64
pcie_portdrv_probe->Dev[0377:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:17.0:pcie00]
Allocate Port Service[0000:00:17.0:pcie03]
...

<--  snip  -->

> Olivier
> 
> System: ASUS M2N32-SLI, AMD64 X2 Dual Core 4600
> 
> 
> kernel 2.6.9-rc5
> 
> irq 22: nobody cared (try booting with the "irqpoll" option)
> 
> Call Trace:
>  <IRQ>  [<ffffffff80259055>] __report_bad_irq+0x35/0x90
>  [<ffffffff802592d3>] note_interrupt+0x223/0x280
>  [<ffffffff80259d41>] handle_fasteoi_irq+0xb1/0xf0
>  [<ffffffff8020b17c>] call_softirq+0x1c/0x30
>  [<ffffffff8020d1ba>] do_IRQ+0x8a/0xe0
>  [<ffffffff8020a571>] ret_from_intr+0x0/0xa
>  <EOI>
> handlers:
> [<ffffffff8807f150>] (nv_generic_interrupt+0x0/0xc0 [sata_nv])
> Disabling IRQ #22
> 
> 
>            CPU0       CPU1
>   0:        223      45540   IO-APIC-edge      timer
>   1:          1        402   IO-APIC-edge      i8042
>   6:          1          4   IO-APIC-edge      floppy
>   8:          0          0   IO-APIC-edge      rtc
>   9:          0          0   IO-APIC-fasteoi   acpi
>  12:          0        103   IO-APIC-edge      i8042
>  14:          7        140   IO-APIC-edge      ide0
>  16:          0          0   IO-APIC-fasteoi   libata
>  17:          0         10   IO-APIC-fasteoi   bttv0
>  20:          0         20   IO-APIC-fasteoi   ehci_hcd:usb1
>  21:          0          0   IO-APIC-fasteoi   libata
>  22:        214      99786   IO-APIC-fasteoi   libata, HDA Intel
>  23:         76       6230   IO-APIC-fasteoi   libata, ohci_hcd:usb2
> 308:          5       3169   PCI-MSI-edge      eth1
> 309:          0         10   PCI-MSI-edge      eth1
> 310:          0         44   PCI-MSI-edge      eth1
> 311:          1       3193   PCI-MSI-edge      eth0
> 312:          0          0   PCI-MSI-edge      eth0
> 313:          0          1   PCI-MSI-edge      eth0
> NMI:         64         68
> LOC:      45716      45691
> ERR:          0
> 
> 
> 
> kernel 2.6.19-rc5 with pci=routeirq
> 
> irq 21: nobody cared (try booting with the "irqpoll" option)
> 
> Call Trace:
>  <IRQ>  [<ffffffff80259055>] __report_bad_irq+0x35/0x90
>  [<ffffffff802592d3>] note_interrupt+0x223/0x280
>  [<ffffffff80259d41>] handle_fasteoi_irq+0xb1/0xf0
>  [<ffffffff8020b17c>] call_softirq+0x1c/0x30
>  [<ffffffff8020d1ba>] do_IRQ+0x8a/0xe0
>  [<ffffffff802092f0>] default_idle+0x0/0x50
>  [<ffffffff8020a571>] ret_from_intr+0x0/0xa
>  <EOI>  [<ffffffff80209319>] default_idle+0x29/0x50
>  [<ffffffff8020939b>] cpu_idle+0x5b/0x80
>  [<ffffffff8050039c>] start_secondary+0x50c/0x520
> 
> handlers:
> [<ffffffff880e6fd0>] (usb_hcd_irq+0x0/0x60 [usbcore])
> Disabling IRQ #21
> 
>            CPU0       CPU1
>   0:        214      24856   IO-APIC-edge      timer
>   1:          0        359   IO-APIC-edge      i8042
>   6:          0          5   IO-APIC-edge      floppy
>   8:          0          0   IO-APIC-edge      rtc
>   9:          0          0   IO-APIC-fasteoi   acpi
>  12:          0        103   IO-APIC-edge      i8042
>  14:          0        128   IO-APIC-edge      ide0
>  16:          0          0   IO-APIC-fasteoi   libata
>  17:          1          2   IO-APIC-fasteoi   bttv0
>  20:         22       6469   IO-APIC-fasteoi   libata
>  21:         11      99989   IO-APIC-fasteoi   ehci_hcd:usb2, HDA Intel
>  22:          0          1   IO-APIC-fasteoi   libata, ohci_hcd:usb1
>  23:          0          0   IO-APIC-fasteoi   libata
> 308:          8       2378   PCI-MSI-edge      eth1
> 309:          0          9   PCI-MSI-edge      eth1
> 310:          0          9   PCI-MSI-edge      eth1
> 311:          4       2401   PCI-MSI-edge      eth0
> 312:          0          0   PCI-MSI-edge      eth0
> 313:          0          1   PCI-MSI-edge      eth0
> NMI:         74         47
> LOC:      25024      24991
> ERR:          0
> 
> 
> 
> kernel 2.6.19-rc5 with irqpoll
> 
> Hang during boot
> (See screenshot in http://olivn.trollprod.org/2.6.19-rc5-irq.tar.gz)
> 
> 
> 
> kernel 2.6.18 (works without any problem)
> 
>            CPU0       CPU1
>   0:       1590     998089    IO-APIC-edge  timer
>   1:          2        657    IO-APIC-edge  i8042
>   6:          0          5    IO-APIC-edge  floppy
>   8:          0          0    IO-APIC-edge  rtc
>   9:          0          0   IO-APIC-level  acpi
>  12:        194      59353    IO-APIC-edge  i8042
>  14:         13       6381    IO-APIC-edge  ide0
>  50:          0          0   IO-APIC-level  libata
>  58:          0          0   IO-APIC-level  libata
>  66:        109     181425   IO-APIC-level  libata, nvidia
>  74:         41        963   IO-APIC-level  ehci_hcd:usb1, HDA Intel
>  82:          4          6   IO-APIC-level  bttv0
>  90:          0          0       PCI-MSI-X  eth0
>  98:          3          0       PCI-MSI-X  eth0
> 106:     212234          0       PCI-MSI-X  eth0
> 114:        532          0       PCI-MSI-X  eth1
> 122:        445          0       PCI-MSI-X  eth1
> 130:     212217          0       PCI-MSI-X  eth1
> 233:         73      23009   IO-APIC-level  libata, ohci_hcd:usb2
> NMI:         99        104
> LOC:     999684     999664
> ERR:          0
> MIS:          0
