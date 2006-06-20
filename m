Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWFTFms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWFTFms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWFTFms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:42:48 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:56491 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S965048AbWFTFmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:42:47 -0400
Date: Mon, 19 Jun 2006 22:42:35 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Brice Goglin <brice@myri.com>,
       linux-kernel@vger.kernel.org, Greg Lindahl <greg.lindahl@qlogic.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
In-Reply-To: <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no>
Message-ID: <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com>
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no>
 <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Andi Kleen wrote:

| [you destroyed the cc list. Don't do that]
| 
| On Monday 19 June 2006 02:53, Greg Lindahl wrote:
| > On Sat, Jun 17, 2006 at 10:48:18AM -0400, Brice Goglin wrote:
| > > IIRC, HT1000 is the southbridge part of the HT2000 chipset. We have been
| > > told that MSI works on this chipset. And from what we've seen/tested, it
| > > is true.
| >
| > We can also say this is true -- our InfiniPath HCA requires MSI, so we
| > really notice this.
| 
| Isn't your HCA directly connected to HTX? If yes it will
| likely not run into PCI bridge bugs.

The HyperTransport is directly attached, but it still uses parts of
the MSI infrastructure.   Mostly we've direct-coded it, but at some
point the MSI code should be expanded to support HTX devices as well.

| We got a Serverworks based Supermicro system where the driver for the 
| integrated tg3 NIC complains about MSI not working. So either that particular
| system has a specific BIOS issue or it is broken for on motherboard
| devices.
|  
| I was extrapolating from that.

I've used our PCIe card on the serverworks HT2000/ST2000 chipset with MSI, and it seems
to work fine (once you enable MSI in the config space, which the current
BIOS doesn't seem to do for some reason).  It may be that it doesn't work
well with PCI, but does with PCIe (different parts of the chipset, after all,
so it seems possible).

| For me so far it looks like MSI is another HPET or mmconfig - something
| that looks nice in the specification, but hardware/BIOS developers
| don't seem to pay particular attention to and is ridden with 
| platform bugs.

Sure, that's true of almost everything new.   It remains broken until people
start using it, complain, and get the bugs fixed.   Some of us have a vested
interest in having MSI work, since it's the only way we can deliver interrupts.
We've already worked with a few BIOS writers to get problems fixed, and we'll
keep doing so as we find problems.   If enough hardware vendors and consumers
do so, the broken stuff will get fixed, and stay fixed, because it will get
tested.


Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
