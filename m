Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132632AbRAPW2S>; Tue, 16 Jan 2001 17:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132637AbRAPW2I>; Tue, 16 Jan 2001 17:28:08 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:41224 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132632AbRAPW16>;
	Tue, 16 Jan 2001 17:27:58 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Chad Miller <cmiller@surfsouth.com>
Date: Tue, 16 Jan 2001 23:27:02 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: G400 behavior different, 2.2.18->2.4.0
CC: linux-kernel@vger.kernel.org, mj@suse.cz
X-mailer: Pegasus Mail v3.40
Message-ID: <12C66A4F35BB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 01 at 17:16, Chad Miller wrote:

(added mj@suse.cz, as he may be interested in one range behind bridge 
overlapping both forwarding ranges...)

> #00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP]  (prog-if \
> #00 [Normal decode])
> #   Flags: bus master, 66Mhz, medium devsel, latency 0
> #   Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> #   Memory behind bridge: d4000000-d6ffffff
> #   Prefetchable memory behind bridge: d7000000-d8ffffff
> #   Capabilities: [80] Power Management version 2
> #01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP \
> #(rev 05) (prog-if 00 [VGA])
> #   Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
> #   Flags: bus master, VGA palette snoop, medium devsel, latency 32, IRQ 10
> #   Memory at d6000000 (32-bit, prefetchable)
> #   Memory at d4000000 (32-bit, non-prefetchable)
> #   Memory at d5000000 (32-bit, non-prefetchable)
> #   Capabilities: [dc] Power Management version 2
> #   Capabilities: [f0] AGP version 2.0

Please, add your BIOS into list of broken BIOSes and stop complaining ;-)

Your BIOS splitted 32MB G400 range into 16MB non-prefetchable d600-d6ff 
and 16MB prefetchable (d700-d7ff) range. Probably BIOS though that it
is setting G400 framebuffer at D7000000 for 32MB, but as D7000000 is not
multiple of 32MB, it cannot work.

You should try upgrading BIOS. If it does not help... you can try
kernel resources assigning code, but as it skips VGA adapters currently,
it is long way to go.

BTW, correct BIOS should put G400's resource #1 at D4000000, #2 at D4800000,
and #0 at D6000000. Programming non-prefetchable range for D400-D4FF,
and prefetchable as D600-D7FF... Leaving D5xx unused. 
                                    Sorry for bad news,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
