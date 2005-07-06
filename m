Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVGFUov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVGFUov (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVGFUlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:41:04 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:1666 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261718AbVGFUgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:36:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.13-rc2: PCMCIA problem on AMD64
Date: Wed, 6 Jul 2005 22:36:30 +0200
User-Agent: KMail/1.8.1
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, akpm@osdl.org,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <20050706164724.GB14165@kroah.com> <Pine.LNX.4.58.0507060958590.3570@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507060958590.3570@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507062236.30707.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 6 of July 2005 19:16, Linus Torvalds wrote:
> 
> On Wed, 6 Jul 2005, Greg KH wrote:
> >
> > On Wed, Jul 06, 2005 at 11:28:49AM +0200, Rafael J. Wysocki wrote:
> > > PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.0
> > > PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.1
> > > PCI: Failed to allocate I/O resource #7:1000@e000 for 0000:02:01.1
> > > PCI: Failed to allocate I/O resource #8:1000@e000 for 0000:02:01.1
> > 
> > Do you also get the above errors on booting with -rc1?
> 
> I'd assume so - there are basically no resource changes in -rc2, but -rc1 
> has a lot of PCMCIA updates. Dominik - the full dmesg is in the original 
> report by Rafael on linux-kernel, mind taking a look?
> 
> However, the above also seems to have tried to allocate a 64-bit resource,
> and I wonder if that's right. Rafael, what does lspci say? Is that 2:1.1
> device actually 64-bit capable? Sounds unlikely (they are pretty rare),
> and hat would be a PCI layer bug if not.

'lspci -v' says:

0000:02:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ab)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 1854
        Flags: bus master, medium devsel, latency 64
        Memory at fd200000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 30000000-31fff000 (prefetchable)
        Memory window 1: fc600000-fd1ff000
        I/O window 0: 0000b000-0000bfff
        I/O window 1: 0000c000-0000cfff
        16-bit legacy interface ports at 0001

0000:02:01.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ab)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 1854
        Flags: bus master, medium devsel, latency 64
        Memory at fa200000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 32000000-33fff000 (prefetchable)
        Memory window 1: f9600000-fa1ff000
        I/O window 0: 0000b000-0000b7ff
        I/O window 1: 0000b800-0000bfff
        16-bit legacy interface ports at 0001

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
