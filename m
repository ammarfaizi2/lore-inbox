Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAPUyW>; Tue, 16 Jan 2001 15:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAPUyN>; Tue, 16 Jan 2001 15:54:13 -0500
Received: from shelly.surfsouth.com ([216.128.200.24]:19728 "EHLO
	shelly.surfsouth.com") by vger.kernel.org with ESMTP
	id <S129631AbRAPUyF> convert rfc822-to-8bit; Tue, 16 Jan 2001 15:54:05 -0500
Date: Tue, 16 Jan 2001 15:55:46 -0500
From: Chad Miller <cmiller@surfsouth.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: G400 behavior different, 2.2.18->2.4.0 (was: matroxfb on 2.4.0 / PCI: Failed to allocate...)
Message-ID: <20010116155545.A359@cahoots.surfsouth.com>
In-Reply-To: <12C27D8E5537@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <12C27D8E5537@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Tue, Jan 16, 2001 at 07:31:33PM +0000
X-mrl-nonsense: It's better to be Pavlov's Dog than Schrodenger's Cat.
X-key-info: GPG key at http://web.chad.org/home/gpgkey
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(CC'd to lkml)

On Tue, Jan 16, 2001 at 07:31:33PM +0000, Petr Vandrovec wrote:
> There is something wrong with your hardware. First region for G400 should
> be 32MB, not 16MB (even if you have 16MB G400, which I doubt).

Ooo!  Here's an edited diff of 'lspci -v' under 2.2.18 versus 2.4.0:

36,41c37,42
< 	Flags: bus master, VGA palette snoop, medium devsel, latency 32, IRQ 10
< 	Memory at d6000000 (32-bit, prefetchable)
< 	Memory at d4000000 (32-bit, non-prefetchable)
< 	Memory at d5000000 (32-bit, non-prefetchable)
< 	Capabilities: [dc] Power Management version 2
< 	Capabilities: [f0] AGP version 2.0
---
> 	Flags: bus master, VGA palette snoop, medium devsel, latency 64, IRQ 10
> 	Memory at d8000000 (32-bit, prefetchable) [size=16M]
> 	Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
> 	Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
> 	Expansion ROM at <unassigned> [disabled] [size=64K]
> 	Capabilities: <available only to root>

Change in latency and base address.  Interesting, eh?

Do you think any configuration parameters could affect this?  (I haven't
paid as much attention to the evolution from 2.2 to 2.4 as I should've.)

Here's the diff of X' output, from 2.2.18 to 2.4.0:

43c43
< (--) PCI:*(1:0:0) Matrox MGA G400 AGP rev 5, Mem @ 0xd6000000/25, 0xd4000000/14, 0xd5000000/23
---
> (--) PCI:*(1:0:0) Matrox MGA G400 AGP rev 5, Mem @ 0xd6000000/24, 0xd4000000/14, 0xd5000000/23
72,73d71
< (WW) ****INVALID MEM ALLOCATION**** b: 0xd6000000 e: 0xd7ffffff correcting
< (EE) Cannot find a replacement memory range

Ideas?
						- chad

--
Chad Miller <cmiller@surfsouth.com>   URL: http://web.chad.org/   (GPG)
"Any technology distinguishable from magic is insufficiently advanced".
First corollary to Clarke's Third Law (Jargon File, v4.2.0, 'magic')
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
