Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTJOMes (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbTJOMes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:34:48 -0400
Received: from web40904.mail.yahoo.com ([66.218.78.201]:10099 "HELO
	web40904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263036AbTJOMep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:34:45 -0400
Message-ID: <20031015123444.46223.qmail@web40904.mail.yahoo.com>
Date: Wed, 15 Oct 2003 05:34:44 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: 2.6.0-test7-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031015032215.58d832c1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Morton,

--- Andrew Morton <akpm@osdl.org> wrote:
> Bradley Chapman <kakadu_croc@yahoo.com> wrote:
> >
> > After compiling 2.6.0-test7-mm1, I get the following error after installing the
> >  modules:
> > 
> >  if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test7-mm1; fi
> >  WARNING: /lib/modules/2.6.0-test7-mm1/kernel/fs/ext2/ext2.ko needs unknown
> symbol
> >  __blockdev_direct_IO
> 
> Thanks.

<SNIPPED>

You're welcome. Unfortunately I got this non-fatal Oops when I first booted:

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
Packet=[2048]
Debug: sleeping function called from invalid context at mm/slab.c:1869
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c0123fc6>] __might_sleep+0xa0/0xc2
 [<c0156bc4>] __kmalloc+0x204/0x216
 [<e08a9ed4>] hpsb_create_hostinfo+0x6b/0xe8 [ieee1394]
 [<e08af0e6>] nodemgr_add_host+0x23/0x1d2 [ieee1394]
 [<c0216bd4>] sprintf+0x1f/0x23
 [<e08aa789>] highlevel_add_host+0x6b/0x6f [ieee1394]
 [<e08a9cce>] hpsb_add_host+0x6d/0x95 [ieee1394]
 [<e08c0ba2>] ohci1394_pci_probe+0x512/0x620 [ohci1394]
 [<e08bdb41>] ohci_irq_handler+0x0/0x1129 [ohci1394]
 [<c021cf6a>] pci_device_probe_static+0x52/0x63
 [<c021cfb6>] __pci_device_probe+0x3b/0x4e
 [<c021cff5>] pci_device_probe+0x2c/0x4a
 [<c027ffaa>] bus_match+0x3f/0x6a
 [<c02800bc>] driver_attach+0x56/0x80
 [<c028038e>] bus_add_driver+0x9f/0xb1
 [<c02807f2>] driver_register+0x8c/0x90
 [<c021d1e1>] pci_register_driver+0x8c/0xab
 [<e0886013>] ohci1394_init+0x13/0x3d [ohci1394]
 [<c01482f9>] sys_init_module+0x213/0x3e6
 [<c0176191>] sys_read+0x42/0x63
 [<c03add36>] sysenter_past_esp+0x43/0x65

ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0b8060000db10]

I don't see any patches in your ChangeLog which could have caused this, since
it didn't happen under 2.6.0-test7 or 2.6.0-test6-mm4. Just from looking at the
stack trace, it looks like bugs in my IEEE1394 chipset. Here's what lspci -vv
has to say:

02:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller
(PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8207000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at e8200000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

And the interesting part of my .config:

CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
