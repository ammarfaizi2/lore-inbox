Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271028AbTGPSLl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270978AbTGPSLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:11:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43201 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271028AbTGPSIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:08:06 -0400
Date: Wed, 16 Jul 2003 20:22:52 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Adam Belay <ambx1@neo.rr.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
Subject: Re: 2.5.73: ALSA ISA pnp_init_resource_table compile errors
Message-ID: <20030716182251.GW10191@fs.tum.de>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <20030622234447.GB3710@fs.tum.de> <20030623000808.GA14945@neo.rr.com> <20030703025343.GC282@fs.tum.de> <20030703190304.GA17707@neo.rr.com> <20030704121124.GB12633@fs.tum.de> <20030715224732.GA31942@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715224732.GA31942@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 10:47:32PM +0000, Adam Belay wrote:
> 
> Hi Adrian,

Hi Adam,

> Sorry for the delayed response.

no problem.

> > Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
> > request_module: failed /sbin/modprobe -- snd-card-0. error = -16specify port
> > pnp: the driver 'ad1816a' has been registered
> > pnp: match found with the PnP device '01:01.00' and the driver 'ad1816a'
> > pnp: match found with the PnP device '01:01.01' and the driver 'ad1816a'
> > pnp: Device 01:01.00 activated.
> > pnp: Device 01:01.01 activated.
> > ALSA device list:
> >   No soundcards found.
> >
> > <--  snip  -->
> >
> > This problem is hopefully not unresolvable, the card works fine
> > with ISAPNP with both kernel 2.4 and kernel 2.5 <= 2.5.72 .
> 
> Because activation was successful, it looks like its a bug instead of a
> conflict.
> 
> >
> > # cat /sys/bus/pnp/devices/01\:01.01/options
> 
> > # cat /sys/bus/pnp/devices/01\:01.01/resources
> 
> Could I see the output for 01:01.00/options and 01:01.00/resources also,
> perhaps it will provide some insight.  I'm guessing the resources may be
> incorrect in that node.

It's below, this using with 2.6.0-test1 (same dmesg output):

<--  snip  -->

# cat /sys/bus/pnp/devices/01\:01.01/resources
state = active
io 0x330-0x331
irq 9
# cat /sys/bus/pnp/devices/01\:01.01/options
Dependent: 01 - Priority preferred
   port 0x330-0x330, align 0xf, size 0x2, 16-bit address decoding
   irq 2/9 High-Edge
Dependent: 02 - Priority acceptable
   port 0x300-0x330, align 0xf, size 0x2, 16-bit address decoding
   irq 2/9 High-Edge
Dependent: 03 - Priority functional
   port 0x300-0x330, align 0xf, size 0x2, 16-bit address decoding
   irq 2/9,10,11,15 High-Edge
# cat /sys/bus/pnp/devices/01\:01.00/resources
state = active
io 0x220-0x22f
io 0x388-0x38b
io 0x500-0x50f
irq 5
dma 1
dma disabled
# cat /sys/bus/pnp/devices/01\:01.00/options
Dependent: 01 - Priority preferred
   port 0x220-0x220, align 0x1f, size 0x10, 16-bit address decoding
   port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
   port 0x530-0x530, align 0x7, size 0x10, 16-bit address decoding
   irq 5 High-Edge
   dma 1 8-bit byte-count type-A
   dma 3 8-bit byte-count type-A
Dependent: 02 - Priority acceptable
   port 0x220-0x240, align 0x1f, size 0x10, 16-bit address decoding
   port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
   port 0x530-0x530, align 0xf, size 0x10, 16-bit address decoding
   irq 5,7 High-Edge
   dma 0,1,3 8-bit byte-count type-A
   dma 0,1,3 8-bit byte-count type-A
Dependent: 03 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x388-0x3b8, align 0x7, size 0x4, 16-bit address decoding
   port 0x500-0x560, align 0xf, size 0x10, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count type-A
   dma 0,1,3 8-bit byte-count type-A
Dependent: 04 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x388-0x3b8, align 0x7, size 0x4, 16-bit address decoding
   port 0x500-0x620, align 0xf, size 0x10, 16-bit address decoding
   irq 5,7,10,11 High-Edge
   dma 0,1,3 8-bit byte-count type-A
   dma <none> 8-bit byte-count type-A
Dependent: 05 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x388-0x3b8, align 0x7, size 0x4, 16-bit address decoding
   port 0x500-0x620, align 0xf, size 0x10, 16-bit address decoding
   irq 5,7,2/9,10,11,15 High-Edge
   dma 0,1,3 8-bit byte-count type-A
   dma <none> 8-bit byte-count type-A
# 

<--  snip  -->

> Thanks,
> Adam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

