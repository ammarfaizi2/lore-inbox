Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268991AbUIADjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268991AbUIADjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 23:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268992AbUIADjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 23:39:43 -0400
Received: from fmr01.intel.com ([192.55.52.18]:20955 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S268991AbUIADjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 23:39:40 -0400
Subject: Re: [2.6.9-rc1-bk7]  LIBATA - "irq 11: nobody cared" on sil 3112a
From: Len Brown <len.brown@intel.com>
To: Maciej =?ISO-8859-1?Q?G=F3rnicki?= <gutko@poczta.onet.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C4C22@hdsmsx403.hd.intel.com>
References: <566B962EB122634D86E6EE29E83DD808182C4C22@hdsmsx403.hd.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1094005073.20110.50.camel@linux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Aug 2004 23:39:34 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 16:47, Maciej Górnicki wrote:
> Hello,
> Im trying to run libata driver on my Asus A7N8X-deluxe 
> (latest bios 1008) with Sil 3112a controller, but i'm 
> permanently getting "irq 11: nobody cared.....disabling 
> irq11" error. After this error computer hangs totally. I 
> found some info about enabling "Enhanced mode" and "Sata 
> only" options in bios, but they are not avalible in my 
> motherboard. I've managed to chatch some, hopefully, useful 
> info through netconsole. My kernel config and lspci output 
> are also there. This log was made with  ACPI compiled in, 
> but there was exactly same problem when ACPI was not 
> compiled in.
> 
> http://www.gutko.neostrada.pl/nobody_cared.txt
> Maciej Gornicki
> ps. these 2 errors with "eth0: BUG!" appeared when I enabled 
> netconsole.
> 
> irq 11: nobody cared!
> [<c01080ca>] __report_bad_irq+0x2a/0x90
> [<c01081bc>] note_interrupt+0x6c/0xa0
> [<c0108491>] do_IRQ+0x121/0x130
> [<c0106674>] common_interrupt+0x18/0x20
> [<c011e530>] __do_softirq+0x30/0x90
> [<c011e5b6>]<4>eth0: BUG! Tx Ring full, refusing to send buffer.
> do_softirq+0x26/0x30
> [<c010846d>] do_IRQ+0xfd/0x130
> [<c0106674>] common_interrupt+0x18/0x20
> [<c0103b93>] default_idle+0x23/0x30
> [<c0103bfc>] cpu_idle+0x2c/0x40
> [<c03827ad>]<4>eth0: BUG! Tx Ring full, refusing to send buffer.
> start_kernel+0x17d/0x1c0
> [<c03823b0>] unknown_bootoption+0x0/0x160
> handlers:
> [<c02240f0>] (ata_interrupt+0x0/0x1c0)
> Disabling IRQ #11

One of the entertaining things about NFORCE2 boxes is
that their PCI interrupts are level/low in PIC mode
and level/high in APIC mode.

I've got an NFORCE2 box, and it works either way,
including putting both ohci_hcd and eth0 on irq 11
at level/low in PIC mode like yours.

But in PIC mode I still get kernel: Disabling IRQ #7,
so something isn't totally happy on this box.

I recommend that you try IOAPIC mode.

cheers,
-Len


