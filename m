Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbRAPVmS>; Tue, 16 Jan 2001 16:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbRAPVmI>; Tue, 16 Jan 2001 16:42:08 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:21256 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129846AbRAPVmA>;
	Tue, 16 Jan 2001 16:42:00 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Chad Miller <cmiller@surfsouth.com>
Date: Tue, 16 Jan 2001 22:40:51 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: G400 behavior different, 2.2.18->2.4.0 (was: matroxfb o
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <12C5A55170A3@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 01 at 15:55, Chad Miller wrote:
> (CC'd to lkml)
> 
> On Tue, Jan 16, 2001 at 07:31:33PM +0000, Petr Vandrovec wrote:
> > There is something wrong with your hardware. First region for G400 should
> > be 32MB, not 16MB (even if you have 16MB G400, which I doubt).
> 
> Ooo!  Here's an edited diff of 'lspci -v' under 2.2.18 versus 2.4.0:
> 
> 36,41c37,42
> <   Flags: bus master, VGA palette snoop, medium devsel, latency 32, IRQ 10
> <   Memory at d6000000 (32-bit, prefetchable)
> ---
> >   Flags: bus master, VGA palette snoop, medium devsel, latency 64, IRQ 10
> >   Memory at d8000000 (32-bit, prefetchable) [size=16M]

> Do you think any configuration parameters could affect this?  (I haven't
> paid as much attention to the evolution from 2.2 to 2.4 as I should've.)
> 
> Here's the diff of X' output, from 2.2.18 to 2.4.0:
> 
> 43c43
> < (--) PCI:*(1:0:0) Matrox MGA G400 AGP rev 5, Mem @ 0xd6000000/25, 0xd4000000/14, 0xd5000000/23
> ---
> > (--) PCI:*(1:0:0) Matrox MGA G400 AGP rev 5, Mem @ 0xd6000000/24, 0xd4000000/14, 0xd5000000/23
> 72,73d71
> < (WW) ****INVALID MEM ALLOCATION**** b: 0xd6000000 e: 0xd7ffffff correcting
> < (EE) Cannot find a replacement memory range

Output under 2.2.x is correct: '/25' for 32MB range. I have no idea
why X complains about region D6000000-D7FFFFFF - can you look at
'... regions behind bridge' when you boot 2.2.x (they are on 0:01.0
device, AFAIK) ? Under 2.4.x you showed that prefetchable region is 
D6000000-D8FFFFFF, which correctly covers 2.2.x framebuffer address
(although it is not power of 2, but who knows...).

You should see D4000000-D5FFFFFF as non-prefetchable memory behind bridge,
and D6000000-D7FFFFFF as prefetchable memory behind bridge.
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
