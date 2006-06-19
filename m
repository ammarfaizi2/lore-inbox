Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWFSI3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWFSI3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWFSI3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:29:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:63176 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932325AbWFSI3C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:29:02 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, Brice Goglin <brice@myri.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Date: Mon, 19 Jun 2006 10:28:50 +0200
User-Agent: KMail/1.8
Cc: Greg Lindahl <greg.lindahl@qlogic.com>
References: <4493709A.7050603@myri.com> <44941632.4050703@myri.com> <20060619005329.GA1425@greglaptop>
In-Reply-To: <20060619005329.GA1425@greglaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200606191028.51242.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[you destroyed the cc list. Don't do that]

On Monday 19 June 2006 02:53, Greg Lindahl wrote:
> On Sat, Jun 17, 2006 at 10:48:18AM -0400, Brice Goglin wrote:
> > IIRC, HT1000 is the southbridge part of the HT2000 chipset. We have been
> > told that MSI works on this chipset. And from what we've seen/tested, it
> > is true.
>
> We can also say this is true -- our InfiniPath HCA requires MSI, so we
> really notice this.

Isn't your HCA directly connected to HTX? If yes it will
likely not run into PCI bridge bugs.

We got a Serverworks based Supermicro system where the driver for the 
integrated tg3 NIC complains about MSI not working. So either that particular
system has a specific BIOS issue or it is broken for on motherboard
devices.
 
I was extrapolating from that.

It doesn't complain on another Supermicro system, but that seems
to be because that particular BCM570x silicon revision is blacklisted
for MSI in the tg3 driver.

>From that experience I certainly cannot say that MSI works 
very well on Serverworks so far. It might be safer to blacklist
until someone can explain what's going on on these systems.
The problem is that not all drivers do the MSI probing tg3 do,
so if you got a system where MSI doesn't work. but it tells
the kernel it does, and a driver turns on MSI things just
break.

For me so far it looks like MSI is another HPET or mmconfig - something
that looks nice in the specification, but hardware/BIOS developers
don't seem to pay particular attention to and is ridden with 
platform bugs.

-Andi
