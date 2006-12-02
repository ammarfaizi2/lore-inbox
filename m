Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424278AbWLBRrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424278AbWLBRrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424279AbWLBRrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:47:25 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:12704 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1424278AbWLBRrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:47:25 -0500
Date: Sat, 02 Dec 2006 11:46:38 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: nforce chipset + dualcore x86-64: Oops, NMI, Null pointer deref,
 etc
In-reply-to: <fa.EzYK0cTOJOhsylgT7NpDZwIOqx8@ifi.uio.no>
To: linux-kernel@vger.kernel.org
Cc: Bart Trojanowski <bart@jukie.net>
Message-id: <4571BBFE.9000707@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.EzYK0cTOJOhsylgT7NpDZwIOqx8@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Trojanowski wrote:
> Hi,
> 
> to see my history please see this thread...
> 
> http://lkml.org/lkml/2006/11/29/156
> 
> It might be sata related, but I cannot tell for sure.
> 
> In summary, I have an Opteron 170 in a Shuttle SN25P (nforce4 chipset).
> I've tested the ram overnight and swapped out every component in the
> system except for the HDDs.  I see these problems only with the
> dual-core, and even on an older Asus nforce4 based motherboard.  
> 
> I've had a hell of a time getting 2.6.18 to stay up longer then a day.
> 2.6.19 is better but I am still seeing strangeness.  This morning I
> noticed the following events (the complete dmesg is included below).
> 
> [36514.296462] Unable to handle kernel paging request at 00000000ff757c4f RIP: 
> ..
> [36514.515894]  NMI Watchdog detected LOCKUP on CPU 0
> ..
> [36519.958059] Unable to handle kernel NULL pointer dereference at 0000000000000038 RIP: 
> 
> Now the system is quite non-responsive.  I start programs, but they
> don't run for a few minutes.  Existing programs seem to work ok.
> 
> Any suggestions would be appreciated... I am going to boot with noapic
> for now.  From what I can tell things work better with APIC disabled.

...

> [   27.337641] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> [   27.344035] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> [   27.352191] Probing IDE interface ide0...
> [   28.145997] hda: PLEXTOR DVDR PX-716AL, ATAPI CD/DVD-ROM drive
> [   28.457643] Probing IDE interface ide1...
> [   28.970267] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

Hmm. Something seems missing here. Chipset-specific driver not enabled? 
I don't see any references to DMA mode or the controller type. It seems 
like in this case something in drivers/ide is blowing up later on (which 
shouldn't happen in any case but that code is not the greatest).

Myself, I would try disabling CONFIG_IDE entirely and enabling the 
corresponding new libata PATA driver for this chipset's PATA ports (for 
nForce4 it will be pata_amd). Even if it still doesn't work it may allow 
the real problem to be diagnosed more easily.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

