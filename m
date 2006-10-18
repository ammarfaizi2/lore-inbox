Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWJRN4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWJRN4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWJRN4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:56:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:41096 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751482AbWJRN4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:56:19 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,324,1157353200"; 
   d="scan'208"; a="148342144:sNHT19456346"
Message-ID: <4536327E.5030206@intel.com>
Date: Wed, 18 Oct 2006 21:56:14 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: MSI messages in 2.6.19-rc2
References: <20061016133005.08d20b18@freekitty>
In-Reply-To: <20061016133005.08d20b18@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

msi_init function is called by multithreads at the same time,
there should be mutex lock against status variable access, or
adding this function with __initcall prefix?

thanks
bibo,mao

Stephen Hemminger wrote:
> Got this on boot up, doesn't seem to be reliably reproducible.
> System ran okay. My guess is it is a mulithread probe issue
> 
> [    2.773198] assign_interrupt_mode Found MSI capability
> [    2.773227] assign_interrupt_mode Found MSI capability
> [    2.773291] kmem_cache_create: duplicate cache msi_cache
> [    2.773408] assign_interrupt_mode Found MSI capability
> [    2.773485]  [dump_trace+100/461] dump_trace+0x64/0x1cd
> [    2.773573] assign_interrupt_mode Found MSI capability
> [    2.773644]  [show_trace_log_lvl+18/37] <7>PCI: Setting latency timer of device 0000:00:1c.3 to 64
> [    2.773707] assign_interrupt_mode Found MSI capability
> [    2.774538] show_trace_log_lvl+0x12/0x25
> [    2.774606]  [show_trace+13/16] show_trace+0xd/0x10
> [    2.774698]  [dump_stack+25/27] dump_stack+0x19/0x1b
> [    2.774794]  [kmem_cache_create+1065/1116] kmem_cache_create+0x429/0x45c
> [    2.775078]  [msi_init+90/154] msi_init+0x5a/0x9a
> [    2.775554]  [pci_enable_msi+35/546] pci_enable_msi+0x23/0x222
> [    2.776041]  [pcie_port_device_register+522/847] pcie_port_device_register+0x20a/0x34f
> [    2.776519]  [pcie_portdrv_probe+87/128] pcie_portdrv_probe+0x57/0x80
> [    2.777001]  [pci_device_probe+57/91] pci_device_probe+0x39/0x5b
> [    2.777467]  [really_probe+60/181] really_probe+0x3c/0xb5
> [    2.778074]  [kthread+197/243] kthread+0xc5/0xf3
> [    2.778266]  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
> [    2.778360] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
> [    2.778403]
> [    2.778441] Leftover inexact backtrace:
> [    2.778444]
> [    2.778517]  [show_trace_log_lvl+18/37] show_trace_log_lvl+0x12/0x25
> [    2.778592]  [show_trace+13/16] show_trace+0xd/0x10
> [    2.778665]  [dump_stack+25/27] dump_stack+0x19/0x1b
> [    2.778738]  [kmem_cache_create+1065/1116] kmem_cache_create+0x429/0x45c
> [    2.778817]  [msi_init+90/154] msi_init+0x5a/0x9a
> [    2.778896]  [pci_enable_msi+35/546] pci_enable_msi+0x23/0x222
> [    2.778970]  [pcie_port_device_register+522/847] pcie_port_device_register+0x20a/0x34f
> [    2.779045]  [pcie_portdrv_probe+87/128] pcie_portdrv_probe+0x57/0x80
> [    2.779120]  [pci_device_probe+57/91] pci_device_probe+0x39/0x5b
> [    2.779193]  [really_probe+60/181] really_probe+0x3c/0xb5
> [    2.779267]  [kthread+197/243] kthread+0xc5/0xf3
> [    2.779341]  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
> [    2.779414]  =======================
> [    2.779455] PCI: MSI cache init failed
> [    2.802070] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> [    2.802247] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
