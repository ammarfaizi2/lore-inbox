Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263242AbTC2AS1>; Fri, 28 Mar 2003 19:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263301AbTC2AS1>; Fri, 28 Mar 2003 19:18:27 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:21966 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263242AbTC2AS0>; Fri, 28 Mar 2003 19:18:26 -0500
Subject: Re: 3c59x gives HWaddr FF:FF:...
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030328230510.GA5124@werewolf.able.es>
References: <20030328145159.GA4265@werewolf.able.es>
	 <20030328124832.44243f83.akpm@digeo.com>
	 <20030328230510.GA5124@werewolf.able.es>
Content-Type: text/plain
Organization: 
Message-Id: <1048897765.601.5.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 29 Mar 2003 01:29:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 00:05, J.A. Magallon wrote:
> > > What happens ? Any solution available ?
> > 
> > The eeprom wasn't powered up.
> > 
> > Please take the 2.4.20 3c59x.c and place that into the 2.5 tree and confirm
> > that it does the same thing (it will).> 
> 
> Hum, I suppose you want to say take the _2.5_ one and put into my _2.4_ tree ?
> Some previous answer also talked about a more recent version in -ac.
> (btw, can 2.5 be useful for something ? does not the driver depend on a new
> arch of, for example, the PCI layer ? )
> 
> > Then try disabling APCI and/or otherwise fiddling with your power management
> > options (maybe in BIOS too).> 
> 
> I don't build ACPI, just APM power-off (SMP box).
> Will take a look at 2.4-ac (it looks like the most similar thing to what I have)
> and to 2.5.

I had exactly the same issue as you, but this time it was on my laptop
when using a 3CCFE575CT CardBus 10/100 NIC. The only solution I found
was to use SourceForge's PCMCIA-CS instead of the built-in PCMCIA
support.

I tracked down the problem to PCI resource allocation, although never
knew what was causing it: the CardBus bridge was using the PCI subsystem
to allocate resources for my CardBus NIC, but it failed and tried to
assign an invalid I/O range (the starting I/O address was higher than
the ending I/O address). I wasn't able to fix it, but in newer kernel
releases, the problem was fixed.

Now, I've got other problems: the card works correctly and I get full
throughput when sending data using FTP/NFS/SCP (~12MBps) but no more
than 4MBps when receiving files.

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

