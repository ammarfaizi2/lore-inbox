Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWFMRDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWFMRDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWFMRDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:03:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:8112 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932201AbWFMRDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:03:02 -0400
Subject: Re: 2.6.16-rc6-mm2
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <20060613065430.2bb511c4.akpm@osdl.org>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	 <1150136394.28414.23.camel@dyn9047017100.beaverton.ibm.com>
	 <20060613065430.2bb511c4.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 10:04:50 -0700
Message-Id: <1150218290.28414.47.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 06:54 -0700, Andrew Morton wrote:
> On Mon, 12 Jun 2006 11:19:54 -0700
> Badari Pulavarty <pbadari@gmail.com> wrote:
> 
> > On Fri, 2006-06-09 at 21:40 -0700, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/
> > > 
> > > 
> > 
> > Not sure, if its reported earlier .. paniced on my ppc64 machine.
> 
> OK.  The powerpc tree in rc6-mm2 was fairly sick, but it looks like you
> avoided the thus-far-known problems.
> 
> > e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> > e1000: 0000:c0:01.1: e1000_probe: (PCI-X:133MHz:64-bit) 00:0d:60:de:a9:d7
> > e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > PDC20275: IDE controller at PCI slot 0000:cc:01.0
> > PDC20275: chipset revision 1
> > PDC20275: 100% native mode on irq 134
> >     ide2: BM-DMA at 0xdec00-0xdec07<3>PDC20275: -- Error, unable to allocate DMA table.
> 
> "unable to allocate DMA table".  Sergei,
> ide-always-release-dma-engine.patch plays with that code.
> 
> Badari, it would be super-useful if you could retest with that reverted.

Nope. Reverting the patch did not help. I ran into same panic on boot.

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PDC20275: IDE controller at PCI slot 0000:cc:01.0
PDC20275: chipset revision 1
PDC20275: 100% native mode on irq 134
    ide2: BM-DMA at 0xdec00-0xdec07<3>PDC20275: -- Error, unable to
allocate CPU DMA table(s).
Unable to handle kernel paging request for data at address
0xd000080000000000
Faulting instruction address: 0xc0000000003480ac
Oops: Kernel access of bad area, sig: 7 [#1]
SMP NR_CPUS=128
Modules linked in:
NIP: C0000000003480AC LR: C00000000033E5F4 CTR: C000000000348098
REGS: c000000002667610 TRAP: 0300   Not tainted  (2.6.17-rc6-mm2-
autokern1)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24004028  XER: 0000000D
DAR: D000080000000000, DSISR: 0000000042000000
TASK = c00000000265a800[1] 'idle' THREAD: c000000002664000 CPU: 1
GPR00: C000000000348098 C000000002667890 C0000000006C97D0
000000000000000B
GPR04: 0000000000000000 C0000000006AC9F8 C0000000006AC908
C0000000006AC9C8
GPR08: C0000000006AC9E0 D000080000000000 0000000000000000
0000000000000000
GPR12: 0000000000004000 C000000000570080 0000000000000000
0000000000000000
GPR16: 0000000000000000 0000000000000086 0000000000000000
C000000002667BE0
GPR20: C000000002514800 0000000000000000 C0000000005E9FE8
0000000000000000
GPR24: C000000002514800 C0000000005E9FE8 C0000000007AD500
C000000002667A22
GPR28: C0000000006AC9B0 C0000000007AD500 C000000000605128
C0000000007AD500
NIP [C0000000003480AC] .ide_outb+0x14/0x2c
LR [C00000000033E5F4] .pdcnew_new_cable_detect+0x3c/0x78
Call Trace:
[C000000002667890] [C000000002667930] 0xc000000002667930 (unreliable)
[C000000002667920] [C00000000033E6D8] .init_hwif_pdc202new+0xa8/0x118
[C0000000026679B0] [C000000000350EC0] .ide_pci_setup_ports+0x7e8/0x870
[C000000002667AB0] [C0000000003513D0] .do_ide_setup_pci_device
+0x488/0x4b8
[C000000002667B70] [C000000000351548] .ide_setup_pci_device+0x2c/0xc4
[C000000002667C10] [C00000000033E8D8] .init_setup_pdcnew+0x10/0x24
[C000000002667C90] [C00000000033E794] .pdc202new_init_one+0x4c/0x64
[C000000002667D10] [C000000000532198] .ide_scan_pcidev+0x7c/0xd8
[C000000002667DA0] [C000000000532228] .ide_scan_pcibus+0x34/0x130
[C000000002667E20] [C0000000005320EC] .ide_init+0x78/0xa8
[C000000002667EB0] [C000000000009480] .init+0x1fc/0x3b0
[C000000002667F90] [C0000000000239C4] .kernel_thread+0x4c/0x68
Instruction dump:
eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8 7c0803a6 4e800020 fbc1fff0
ebc2cc00 e93e8000 60000000 e9290000 <7c6449ae> 7c0004ac 60000000
60000000

Thanks,
Badari

