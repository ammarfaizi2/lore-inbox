Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbUKVJQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbUKVJQg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 04:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUKVJQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 04:16:36 -0500
Received: from math.ut.ee ([193.40.5.125]:61153 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262003AbUKVJLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 04:11:19 -0500
Date: Mon, 22 Nov 2004 10:37:19 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Li Shaohua <shaohua.li@intel.com>
cc: matthieu castet <castet.matthieu@free.fr>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
In-Reply-To: <1101086961.2940.7.camel@sli10-desk.sh.intel.com>
Message-ID: <Pine.SOC.4.61.0411221016270.16427@math.ut.ee>
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr> 
 <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee> 
 <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee> 
 <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee> 
 <419F136B.8010308@free.fr> <Pine.SOC.4.61.0411211949260.23880@math.ut.ee> 
 <41A0DB78.2010807@free.fr> <Pine.SOC.4.61.0411212050490.11420@math.ut.ee> 
 <41A0F893.9020106@free.fr> <1101086961.2940.7.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please attach the output of 'cat 00:0a/resources' (0a is the
> device, right?). ACPI spec said set resource should be according to the
> output of current resource. That is we should build a template according
> to current resource (_CRS). If _CRS doesn't return a correct resource
> templete, set resource will fail.

resources after auto and activate and options are now exactly the same 
after the pnpacpi patch:

resources:

state = active
io 0x100-0x107
io 0x2e8-0x2ef
irq 5
dma 3

options:

port 0x100-0x130, align 0xf, size 0x8, 16-bit address decoding
irq 3,4,5,7,10,11 High-Edge
dma 1,2,3 16-bit compatible
Dependent: 01 - Priority acceptable
    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority acceptable
    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 03 - Priority acceptable
    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 04 - Priority acceptable
    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding


With pnpbios, module loading gives this:

found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
smsc_superio_flat(): fir: 0x2e8, sir: 0x100, dma: 03, irq: 5, mode: 0x0e
SMsC IrDA Controller found
  IrCC version 2.0, firport 0x2e8, sirport 0x100 dma=3, irq=5
No transceiver found. Defaulting to Fast pin select
divert: not allocating divert_blk for non-ethernet device irda0
IrDA: Registered device irda0

With pnpacpi, module loading gives this:

found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
smsc_superio_flat(): IrDA not enabled
smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02

Haven't tried Villes patch yet, will do today evening.

-- 
Meelis Roos (mroos@linux.ee)
