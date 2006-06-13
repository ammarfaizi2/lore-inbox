Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWFMNyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWFMNyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 09:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWFMNyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 09:54:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52438 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751125AbWFMNym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 09:54:42 -0400
Date: Tue, 13 Jun 2006 06:54:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: 2.6.16-rc6-mm2
Message-Id: <20060613065430.2bb511c4.akpm@osdl.org>
In-Reply-To: <1150136394.28414.23.camel@dyn9047017100.beaverton.ibm.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	<1150136394.28414.23.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 11:19:54 -0700
Badari Pulavarty <pbadari@gmail.com> wrote:

> On Fri, 2006-06-09 at 21:40 -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/
> > 
> > 
> 
> Not sure, if its reported earlier .. paniced on my ppc64 machine.

OK.  The powerpc tree in rc6-mm2 was fairly sick, but it looks like you
avoided the thus-far-known problems.

> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> e1000: 0000:c0:01.1: e1000_probe: (PCI-X:133MHz:64-bit) 00:0d:60:de:a9:d7
> e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PDC20275: IDE controller at PCI slot 0000:cc:01.0
> PDC20275: chipset revision 1
> PDC20275: 100% native mode on irq 134
>     ide2: BM-DMA at 0xdec00-0xdec07<3>PDC20275: -- Error, unable to allocate DMA table.

"unable to allocate DMA table".  Sergei,
ide-always-release-dma-engine.patch plays with that code.

Badari, it would be super-useful if you could retest with that reverted.


> Unable to handle kernel paging request for data at address 0xd000080000000000
> Faulting instruction address: 0xc000000000347b70
> Oops: Kernel access of bad area, sig: 7 [#1]
> SMP NR_CPUS=128 
> Modules linked in:
> NIP: C000000000347B70 LR: C00000000033E0B8 CTR: C000000000347B5C
> REGS: c000000002667610 TRAP: 0300   Not tainted  (2.6.17-rc6-mm2-autokern1)
> MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24004028  XER: 00000006
> DAR: D000080000000000, DSISR: 0000000042000000
> TASK = c00000000265a800[1] 'idle' THREAD: c000000002664000 CPU: 1
> GPR00: C000000000347B5C C000000002667890 C0000000006C8938 000000000000000B 
> GPR04: 0000000000000000 C0000000006ABBD8 C0000000006ABAE8 C0000000006ABBA8 
> GPR08: C0000000006ABBC0 D000080000000000 0000000000000000 0000000000000000 
> GPR12: 0000000000004000 C000000000570080 0000000000000000 0000000000000000 
> GPR16: 0000000000000000 0000000000000086 0000000000000000 C000000002667BE0 
> GPR20: C000000002514800 0000000000000000 C0000000005E97B8 0000000000000000 
> GPR24: C000000002514800 C0000000005E97B8 C0000000007AD480 C000000002667A22 
> GPR28: C0000000006ABB90 C0000000007AD480 C000000000604768 C0000000007AD480 
> NIP [C000000000347B70] .ide_outb+0x14/0x2c
> LR [C00000000033E0B8] .pdcnew_new_cable_detect+0x3c/0x78
> Call Trace:
> [C000000002667890] [C000000002667930] 0xc000000002667930 (unreliable)
> [C000000002667920] [C00000000033E19C] .init_hwif_pdc202new+0xa8/0x118
> [C0000000026679B0] [C000000000350984] .ide_pci_setup_ports+0x7e8/0x870
> [C000000002667AB0] [C000000000350E94] .do_ide_setup_pci_device+0x488/0x4b8
> [C000000002667B70] [C00000000035100C] .ide_setup_pci_device+0x2c/0xc4
> [C000000002667C10] [C00000000033E39C] .init_setup_pdcnew+0x10/0x24
> [C000000002667C90] [C00000000033E258] .pdc202new_init_one+0x4c/0x64
> [C000000002667D10] [C000000000532198] .ide_scan_pcidev+0x7c/0xd8
> [C000000002667DA0] [C000000000532228] .ide_scan_pcibus+0x34/0x130
> [C000000002667E20] [C0000000005320EC] .ide_init+0x78/0xa8
> [C000000002667EB0] [C000000000009480] .init+0x1fc/0x3b0
> [C000000002667F90] [C0000000000239C4] .kernel_thread+0x4c/0x68

I don't know what happened there - it might well be a preexisting bug which
is triggered by the ide_allocate_dma_engine() failure.

