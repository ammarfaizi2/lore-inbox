Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUHWQYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUHWQYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUHWQXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 12:23:37 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:46224 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S266166AbUHWQQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 12:16:41 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Alexander Nyberg <alexn@telia.com>
Subject: Re: 2.6.8.1-mm IRQ routing problems
Date: Mon, 23 Aug 2004 10:16:36 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
References: <1093088008.777.13.camel@boxen> <20040822180911.22bbbc96.akpm@osdl.org> <1093264936.834.1.camel@boxen>
In-Reply-To: <1093264936.834.1.camel@boxen>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408231016.36318.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 August 2004 6:42 am, Alexander Nyberg wrote:
> On Mon, 2004-08-23 at 03:09, Andrew Morton wrote:
> > Alexander Nyberg <alexn@telia.com> wrote:
> > >
> > > Using 2.6.8.1-mm3 I ran into some problems on x86_64. This
> > > only happens when fsck runs at bootup because in my case
> > > of the max-mount-count being reached (I use ext3). Booting 
> > > with pci=routeirq makes problem go away.
> > > 
> > > Do I win the weird problem prize?
> > 
> > I think this was fixed in -mm4.  Please retest.
> 
> Still happens in -mm4.

Can you double-check this, and perhaps post the dmesg for the 2.6.8.1-mm4
attempt?  It still looks very much like the problem Randy fixed here:

    http://marc.theaimsgroup.com/?l=linux-kernel&m=109313574928853&w=2

I just checked, and Randy's patch is indeed in 2.6.8.1-mm4.  If the oops
still occurs there, it must be a different problem, and the dmesg might
help diagnose it.

> > > Pid: 121, comm: modprobe Not tainted 2.6.8.1-mm3
> > > RIP: 0010:[<ffffffff8035f090>] <ffffffff8035f090>{add_pin_to_irq+0}
> > > RSP: 0018:000001003eff1d40  EFLAGS: 00010216
> > > RAX: 0000000000002000 RBX: 0000000000000012 RCX: 0000000000008000
> > > RDX: 0000000000000012 RSI: 0000000000000000 RDI: 0000000000000012
> > > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > > R10: 0000000000000000 R11: ffffffff80232fa0 R12: 0000000000000001
> > > R13: 0000000000000001 R14: 0000000000000012 R15: 0000000000508b70
> > > FS:  0000002a95ac8380(0000) GS:ffffffff80351d40(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> > > CR2: 0000000000002000 CR3: 0000000000101000 CR4: 00000000000006e0
> > > Process modprobe (pid: 121, threadinfo 000001003eff0000, task 000001003f44aa50)
> > > Stack: ffffffff8011ac90 0000000000010000 0000000000000046 0000000000010000 
> > >        010000000001a900 000001003ffda200 ffffffffa00115e8 0000000000000012 
> > >        0000000000000001 0000000000000001 
> > > Call Trace:<ffffffff8011ac90>{io_apic_set_pci_routing+160} <ffffffff80118b68>{acpi_register_gsi+104} 
> > >        <ffffffff801e8688>{acpi_pci_irq_enable+413} <ffffffff801cbe26>{pci_enable_device_bars+38} 
> > >        <ffffffff801cbe55>{pci_enable_device+21} <ffffffffa001408a>{:e1000:e1000_probe+42} 
> > >        <ffffffff80185346>{d_rehash+118} <ffffffff801cca8f>{pci_device_probe+111} 
> > >        <ffffffff8020afd7>{bus_match+71} <ffffffff8020b0fb>{driver_attach+75} 
> > >        <ffffffff8020b490>{bus_add_driver+144} <ffffffff801cc8ce>{pci_register_driver+62} 
> > >        <ffffffffa001403e>{:e1000:e1000_init_module+62} <ffffffff8014abb9>{sys_init_module+281} 
> > >        <ffffffff8010e25e>{system_call+126} 
> > > 
> > > Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> > > RIP <ffffffff8035f090>{add_pin_to_irq+0} RSP <000001003eff1d40>
> > > CR2: 0000000000002000
