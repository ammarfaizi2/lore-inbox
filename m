Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129800AbRCHVmI>; Thu, 8 Mar 2001 16:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbRCHVl6>; Thu, 8 Mar 2001 16:41:58 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:62986 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129800AbRCHVlq>;
	Thu, 8 Mar 2001 16:41:46 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: BERECZ Szabolcs <szabi@inf.elte.hu>
Date: Thu, 8 Mar 2001 22:41:11 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [QUESTION] mga memsize
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <1812F3643F2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Mar 01 at 22:14, BERECZ Szabolcs wrote:
> How can I check the memsize of a matrox g400?
> I have a card with 16Mb memory, and the lspci show this:
>         Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SDRAM
>         Flags: bus master, medium devsel, latency 64, IRQ 11
>         Memory at e6000000 (32-bit, prefetchable) [size=32M]
> 
> So I could use the 16Mb in the name of the card, but an older lspci
> doesn't show that.
> In the 3rd line, it reports 32M. It doesn't work.
> the matroxfb init reports the correct memsize, but I don't know, how to
> get that.

Chip always needs 32MB range in mmio space. So lspci reports 32MB.
Real memory size depends on installed memory, as one could expect.
If you do not trust matroxfb, just do:

yes | dd of=/dev/fb0 bs=32M count=1; dd if=/dev/fb0 of=tmp bs=32M count=1

and then verify tmp file contents... If you get 16MB of 'yes\n' and
16MB of zeroes or 0xFF, you have really 16MB of memory...
                                                     Petr Vandrovec
                                                     vandrove@vc.cvut.cz
                                                     
