Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUAHM7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 07:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbUAHM7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 07:59:24 -0500
Received: from imap.gmx.net ([213.165.64.20]:62084 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264428AbUAHM7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 07:59:20 -0500
X-Authenticated: #20450766
Date: Thu, 8 Jan 2004 13:48:34 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: bill davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <bti19d$7fn$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0401081144050.22099-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2004, bill davidsen wrote:

> I'm sure you checked this, but does mii-tool show that you have
> negotiated the proper connection to the hub or switch? I found that my
> 3cXXX and eepro100 cards were negotiating half duplex with the switches
> and cable modems, causing the throughput to go forth and conjugate the
> verb "to suck" until I fixed it.

Actually, I didn't. Just tried - mii-tool says
SIOCGMIIPHY on 'eth0' failed: Operation not supported
no MII interfaces found
And if you look in the tulip driver you'll see the same - ADMtek Comet
doesn't have the HAS_MII flag set:-( Is it really that bad? It was a cheap
(damn it, when will I learn not to buy cheap stuff, even if it says
"Linux supported"...) card, no technical documentation, none on
www.sitecom.com either. I've sent them a service-request though. Also
funny, on their site they say, it's a realtek 8139 chip... I would even
less hope that the other 3c59x card, which can only do half-duplex (I
think) 10mbps, has mii... But - the light on the hub and on the card say
it's 100mbps full-duplex. Actually, if something was wrong with network
settings - ftp wouldn't work reliable either, right? Well, maybe it
affects UDP only somehow. Well, yes - with TCP it seems to work. Only now
I have another problem with my PC2 with 2.6 (Pentium 133MHz, 24M). It
swaps like a mad already under very mild load... Have to narrow it down
though... So, 4M file I was able to copy without problem to tmpfs, 120M to
the disk lasts already many minutes (~30) with hard swapping. Problem is I
can't use terminals in such situation - they become nearly irresponsive.
So, only sysrq's work... Hm, just looked at the backtrace of the cp
process - it looks completely sick.
__wake_up_common
preempt_schedule
__wake_up
wakeup_kswapd
__alloc_pages
read_swap_cache_async
read_swap_cache_async
swapin_readahead
do_swap_page
handle_mm_fault
do_page_fault
do_page_fault
do_DC390_Interrupt
handle_IRQ_event
end_8259A_irq
do_IRQ
error_code

So, since TCP works - shall we consider the case closed, or shall UDP also
be fixed? Ok, presumably, Linux-Linux can always use TCP, what about other
UNIXes? Can they also do mount -otcp?

...and what is this:
RPC request reserved 0 but used 116

Thanks
Guennadi
---
Guennadi Liakhovetski


