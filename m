Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbUKSXgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbUKSXgQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUKSXea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:34:30 -0500
Received: from math.ut.ee ([193.40.5.125]:28837 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261652AbUKSXce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:32:34 -0500
Date: Sat, 20 Nov 2004 01:09:36 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: matthieu castet <castet.matthieu@free.fr>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       "Li, Shaohua" <shaohua.li@intel.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
In-Reply-To: <419E3B7A.4000904@free.fr>
Message-ID: <Pine.SOC.4.61.0411200102580.12992@math.ut.ee>
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr>
 <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee>
 <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>
 <419E3B7A.4000904@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried it with pnpbios (acpi=off) and it started to work after auto and 
activate (but not with auto alone):

nartsiss:/# modprobe smsc-ircc2
found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
smsc_superio_flat(): IrDA not enabled
smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02
FATAL: Error inserting smsc_ircc2 (/lib/modules/2.6.10-rc2/kernel/drivers/net/irda/smsc-ircc2.ko): No such device
nartsiss:/# echo activate > resources
pnp: Device 00:0f activated.
nartsiss:/# modprobe smsc-ircc2
found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
smsc_superio_flat(): fir: 0x2e8, sir: 0x100, dma: 03, irq: 5, mode: 0x0e
SMsC IrDA Controller found
  IrCC version 2.0, firport 0x2e8, sirport 0x100 dma=3, irq=5
No transceiver found. Defaulting to Fast pin select
IrDA: Registered device irda0

>>> Could you send me the result of : "for i in /sys/bus/pnp/devices/*; do cat 
>>> $i/id $i/options; done" in order to see if other devices have missing 
>>> resources ?

The output with pnpbios is below for comparision.

>> PNP0c01
>> PNP0200
>> PNP0800
>> PNP0c04
>> PNP0303
>> PNP0f13
>> PNP0b00
>> PNP0c02
>> PNP0700
>> port 0x3f0-0x3f0, align 0x0, size 0x6, 16-bit address decoding
>> port 0x3f7-0x3f7, align 0x0, size 0x1, 16-bit address decoding
>> irq 6 High-Edge
>> dma 2 8-bit compatible
> floppy : seem ok
>> PNP0501
>> Dependent: 01 - Priority acceptable
>>    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
>> Dependent: 02 - Priority acceptable
>>    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
>> Dependent: 03 - Priority acceptable
>>    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
>> Dependent: 04 - Priority acceptable
>>    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
> serial miss irq
>> SMCf010
>> Dependent: 01 - Priority acceptable
>>    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
>> Dependent: 02 - Priority acceptable
>>    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
>> Dependent: 03 - Priority acceptable
>>    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
>> Dependent: 04 - Priority acceptable
>>    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
> irda : miss io,irq,dma
>> PNP0401
>> Dependent: 01 - Priority acceptable
>>    port 0x378-0x378, align 0x0, size 0x3, 16-bit address decoding
>>    port 0x778-0x778, align 0x0, size 0x3, 16-bit address decoding
>>    irq 7 High-Edge
>> Dependent: 02 - Priority acceptable
>>    port 0x278-0x278, align 0x0, size 0x3, 16-bit address decoding
>>    port 0x678-0x678, align 0x0, size 0x3, 16-bit address decoding
>>    irq 5 High-Edge
>> Dependent: 03 - Priority acceptable
>>    port 0x3bc-0x3bc, align 0x0, size 0x3, 16-bit address decoding
>>    port 0x7bc-0x7bc, align 0x0, size 0x3, 16-bit address decoding
>>    irq 7 High-Edge
> parallel port: miss dma
>> TOS6200
>>

PNP0c01
PNP0200
PNP0000
PNP0100
PNP0800
PNP0c04
PNP0303
PNP0f13
irq 12 High-Edge
PNP0b00
PNP0c02
PNP0700
port 0x3f0-0x3f0, align 0x0, size 0x6, 16-bit address decoding
port 0x3f7-0x3f7, align 0x0, size 0x1, 16-bit address decoding
irq 6 High-Edge
dma 2 8-bit byte-count compatible
PNP0501
irq 3,4,5,7,10,11 High-Edge
Dependent: 01 - Priority acceptable
    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority acceptable
    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 03 - Priority acceptable
    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 04 - Priority acceptable
    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
SMCf010
PNP0510
port 0x100-0x130, align 0xf, size 0x8, 16-bit address decoding
irq 3,4,5,7,10,11 High-Edge
dma 1,2,3 16-bit byte-count compatible
Dependent: 01 - Priority acceptable
    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority acceptable
    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 03 - Priority acceptable
    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 04 - Priority acceptable
    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
PNP0401
dma 1,2,3 8-bit byte-count compatible
Dependent: 01 - Priority acceptable
    port 0x378-0x378, align 0x0, size 0x3, 16-bit address decoding
    port 0x778-0x778, align 0x0, size 0x3, 16-bit address decoding
    irq 7 High-Edge
Dependent: 02 - Priority acceptable
    port 0x278-0x278, align 0x0, size 0x3, 16-bit address decoding
    port 0x678-0x678, align 0x0, size 0x3, 16-bit address decoding
    irq 5 High-Edge
Dependent: 03 - Priority acceptable
    port 0x3bc-0x3bc, align 0x0, size 0x3, 16-bit address decoding
    port 0x7bc-0x7bc, align 0x0, size 0x3, 16-bit address decoding
    irq 7 High-Edge
PNP0a03
PNP0e03
PNP0e00
Dependent: 01 - Priority acceptable
    port 0x3e0-0x3e0, align 0x0, size 0x2, 16-bit address decoding
    irq <none> High-Edge
Dependent: 02 - Priority acceptable
    port 0x3e0-0x3e0, align 0x0, size 0x2, 16-bit address decoding
    irq 3,4,5,7,10,11 High-Edge

-- 
Meelis Roos (mroos@linux.ee)
