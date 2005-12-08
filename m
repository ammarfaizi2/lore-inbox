Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVLHASL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVLHASL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVLHASL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:18:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:26270 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965066AbVLHASK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:18:10 -0500
Subject: Re: uart_match_port() question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200512071636.33901.bjorn.helgaas@hp.com>
References: <1133050906.7768.66.camel@gaston>
	 <200512071515.11937.bjorn.helgaas@hp.com> <1133997226.7168.93.camel@gaston>
	 <200512071636.33901.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 11:17:28 +1100
Message-Id: <1134001049.7168.97.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 16:36 -0700, Bjorn Helgaas wrote:
> On Wednesday 07 December 2005 4:13 pm, Benjamin Herrenschmidt wrote:
> > ...  Part of the problem here is for example PIO. There is no such
> > thing as PIO on a PowerPC, it's purely a PCI abstraction, thus inX/outX
> > will only work once the PCI host briges have been discovered and their
> > IO space mapped (setup_arch() time, but I definitely want my early
> > console earlier).
> 
> ia64 has a similar problem, but it's a bit easier because firmware
> configures and tells us about the legacy (0-64K) I/O port space.
> So we do have to look up the MMIO base where those I/O ports get
> mapped, but that's basically the first thing in setup_arch().  We
> don't do much before that, so it hasn't been worthwhile to make
> the console work earlier.

Oh, that's what I do too, that is, I have a mecanism now to walk the
firmware device-tree and get the MMIO, my problem was with matching that
MMIO address with the PIO one that 8250 gets later on. It seems that you
solved that problem so it looks like I really need to look more closely
at what you are doing :)

Ben.


