Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbUCWMVx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 07:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbUCWMVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 07:21:53 -0500
Received: from gizmo04ps.bigpond.com ([144.140.71.14]:40078 "HELO
	gizmo04ps.bigpond.com") by vger.kernel.org with SMTP
	id S262508AbUCWMVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 07:21:51 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: doug@pigeonhold.com
Subject: Re: PROBLEM: APIC on Chaintech ZNF3-150 Motherboard   
Date: Tue, 23 Mar 2004 22:24:02 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, mikpe_at_csd.uu.se@albatron
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403232224.02599.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 23 Mar 2004 10:32:45 +0000, Doug Winter wrote: 
> >I've just put a new computer together with an AMD Athlon 64 3200+ and a 
> >Chaintech ZNF3-150 motherboard. This has the Nvidia NForce 3 chipset. 
> > 
> >Booting 2.6.4, from the debian kernel-image-2.6.4-1-k7 package, I get 
> >reproducible errors from the onboard BCM5788 NIC and a Realtek 8139 NIC 
> >when under load. 
> > 
> >When the disk is under load, I get reproducible DMA errors from any IDE 
> >disk that is under load. 
> > 
> >When I boot with "noapic", these problems go away. 

> NVidia chipsets are known to have problems when used with 
> local APIC or I/O-APIC. We don't know exactly what happens, 
> but it looks like a hardware or BIOS problem. The only 
> known cure is to try combinations of: 
 
> upgrade BIOS 
> pci=noacpi 
> acpi=off 
> noapic 
> nolapic 

>FWIW, VIA's K8T800 chipset seems to work very well. 
  
Perhaps I should ask firstly how your timer interrupts are routed?
io-apic edge, local apic, or xtpic - does it still have one of these?

And you could check and see whether this patch has made it through to your 
current kernel (I just remember the posting - I don't have an nforce3).
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/1648.html
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/1604.html

I don't know about idle states for K8 and nforce3 but you could also try my C1
idle halt patch (for K7 and Nforce2 - also SiS740). It may have no effect on
nforce3 but you might get lucky (don't forget the kernel arg or it won't work).
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/6520.html
The io-apic patch there may also help route the timer interrupts via IO-apic
assuming nvidia followed nforce2 methods.

Please CC me with your responses.
Regards
Ross.



