Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbQKQTAt>; Fri, 17 Nov 2000 14:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbQKQTAj>; Fri, 17 Nov 2000 14:00:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6671 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129270AbQKQTAV>; Fri, 17 Nov 2000 14:00:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VGA PCI IO port reservations
Date: 17 Nov 2000 10:29:58 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v3tf6$s3e$1@cesium.transmeta.com>
In-Reply-To: <3A156116.65CDBBE9@didntduck.org> <200011171656.QAA01320@raistlin.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200011171656.QAA01320@raistlin.arm.linux.org.uk>
By author:    Russell King <rmk@arm.linux.org.uk>
In newsgroup: linux.dev.kernel
>
> Brian Gerst writes:
> > This is an artifact from the ISA 10-bit IO bus.  Many ISA cards do not
> > decode all 16 address bits so you get aliases of the 0x100-0x3ff region
> > throughout IO space.  PCI cards should only use the first 256 ports of
> > any 1k block to avoid aliases unless they claim the base alias.  For
> > example, all the xxe8 addresses for the S3 are aliases of 0x02e8 to an
> > ISA card.  Video cards are an exception to the general rule because they
> > have to support all the legacy VGA crap.
> 
> No.  All xxe8 addresses access specific registers.  For example:
> 
>   0x9ea8 is the drawing command
>   0xa2e8 is the background colour register
>   0xa6e8 is the foreground colour register
> 
> So, as you see they aren't aliases.
> 

They aren't, but because early ISA cards did use these as aliases,
board manufacturers said "hey, we only need to allocate the bottom 10
bits, and we can use the remaining 6 address lines as we please."

Sigh.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
