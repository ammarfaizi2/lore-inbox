Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129188AbQKQS6K>; Fri, 17 Nov 2000 13:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129220AbQKQS6A>; Fri, 17 Nov 2000 13:58:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:65038 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129188AbQKQS5w>; Fri, 17 Nov 2000 13:57:52 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VGA PCI IO port reservations
Date: 17 Nov 2000 10:27:36 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v3tao$s2l$1@cesium.transmeta.com>
In-Reply-To: <200011171620.eAHGKgg00324@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200011171620.eAHGKgg00324@flint.arm.linux.org.uk>
By author:    Russell King <rmk@arm.linux.org.uk>
In newsgroup: linux.dev.kernel
> 
> I've been looking at a number of VGA cards recently, and I've started
> wondering out the Linux resource management as far as allocation of
> IO ports.  I've come to the conclusion that it does not contain all
> information necessary to allow allocations to be made safely.
> 
> Thus far, VGA cards that I've looked at scatter extra registers through
> out the PCI IO memory region without appearing in the PCI BARs.  In fact,
> for some cards there wouldn't be enough BARs to list them all.
> 

This (and ISA) is why PCs usually allocate only addresses that match
the following equation for PCI IO:

       (port >= 0x1000 && (port & 0x0300) == 0).

As you can see, the ports you list below all violate the second
criterion, they are thus "ISA equivalent ports".

The downside is that it's impossible to allocate more than 256
consecutive ports.

> For example, S3 cards typically use:
> 
>  0x0102,  0x42e8,  0x46e8,  0x4ae8,  0x8180 - 0x8200,  0x82e8,  0x86e8,
>  0x8ae8,  0x8ee8,  0x92e8,  0x96e8,  0x9ae8,  0x9ee8,  0xa2e8,  0xa6e8,
>  0xaae8,  0xaee8,  0xb2e8,  0xb6e8,  0xbae8,  0xbee8,  0xe2e8, 
>  0xff00 - 0xff44
> 
> And Trident TGUI9440 uses:
> 
>  0x2120,  0x43c4
> 
> Cyber2000-type cards use:
> 
>  0x0102,  0x46e8
> 

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
