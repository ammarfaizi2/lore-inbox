Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWJES5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWJES5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWJES5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:57:49 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:5596 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750849AbWJES5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:57:48 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45255574.5020203@s5r6.in-berlin.de>
Date: Thu, 05 Oct 2006 20:56:52 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net
Subject: ohci1394 regression in 2.6.19-rc1 (was Re: Merge window closed: v2.6.19-rc1)
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <200610051609.12466.s0348365@sms.ed.ac.uk>
In-Reply-To: <200610051609.12466.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> Booted fine here, but I've got a few strange messages from the firewire
> subsystem that weren't present in 2.6.18. I think it marginally slows down
> boot up, but I could just be imagining it.
> 
> [alistair] 16:04 [~] dmesg | grep 1394
> ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[dffff000-dffff7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
> ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[17]  MMIO=[dfffc000-dfffc7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
> ohci1394: fw-host0: Running dma failed because Node ID is not valid
> ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
> ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0091023fd7]
> ieee1394: Host added: ID:BUS[1-00:1023]  GUID[000129200003d023]

Thanks for the quick report. Could you please test the following, each
one separately?

A. Configure PCI_MULTITHREAD_PROBE=n

B. Revert patch "Initialize ieee1394 early when built in"
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=8df4083c5291b3647e0381d3c69ab2196f5dd3b7

I don't see how any other ohci1394 patch after 2.6.18 could lead up to
that message. I also don't understand what causes this glitch. At least
it seems recoverable, according to the "Host added" lines.
-- 
Stefan Richter
-=====-=-==- =-=- --=-=
http://arcgraph.de/sr/
