Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbQKQWco>; Fri, 17 Nov 2000 17:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129772AbQKQWcf>; Fri, 17 Nov 2000 17:32:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40200 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129227AbQKQWc0>; Fri, 17 Nov 2000 17:32:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VGA PCI IO port reservations
Date: 17 Nov 2000 14:02:00 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v49so$tlt$1@cesium.transmeta.com>
In-Reply-To: <200011171646.QAA01224@raistlin.arm.linux.org.uk> <Pine.LNX.4.10.10011172134510.27177-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10011172134510.27177-100000@sphinx.mythic-beasts.com>
By author:    Matthew Kirkwood <matthew@hairy.beasts.org>
In newsgroup: linux.dev.kernel
>
> On Fri, 17 Nov 2000, Russell King wrote:
> 
> > Therefore, it should be reserved independent of whether we have the
> > driver loaded/in kernel or not.
> 
> Is this not an argument for a more flexible resource allocation
> API?  One offering both:
> 
>    res = allocate_resource(restype, dev, RES_ALLOC_UNUSED, region);
> 
> and
> 
>    res = allocate_resource(restype, dev_ RES_ALLOC_HW, region);
> 

One way to do this is to treat PCI IO and ISA IO as two separate
address spaces.  The PCI IO address space is a 14-bit address space
(bits 9:8 are always zero) ranging from 0x1000 to 0xFCFF.  ISA IO is a
10-bit space (bits 15:10 are available for the card to use) ranging
from 0x100 to 0x3FF.

VGA cards may be PCI and AGP, but still have allocations in the ISA
range.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
