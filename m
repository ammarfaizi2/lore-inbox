Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbTLEUZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 15:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTLEUZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 15:25:41 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:37516 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S264356AbTLEUZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 15:25:39 -0500
Date: Fri, 5 Dec 2003 13:36:05 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Allen Martin <AMartin@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
Message-ID: <20031205203605.GA391@tesore.local>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 11:11:39AM -0800, Allen Martin wrote:
> > -----Original Message-----
> > From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
> > Sent: Friday, December 05, 2003 4:15 AM
> >
> >  > So does this confirm that the lockups with nforce2 
> > chipsets and apic
> >  > is actually a hardware problem after all? 
> > 
> > Confirm with very high probability. There may be quirks in nVidia's
> > chipset that we (unlike their Windoze drivers) don't know about.
> > 
> > Ask nVidia for detailed chipset documentation. Then maybe we 
> > can fix this.
> 
> NVIDIA doesn't provide a windows driver to setup APIC interrupts.  APIC
> functionality is exported through the ACPI methods and MP table in the
> system BIOS which the motherboard vendors supply.
> 
> Likely the root of the problem has to do with the way the Linux kernel is
> using the ACPI methods to setup the interrupts which is different from win
> 9x/2k/XP.  I can help track this down, unfortunately so far I've been unable
> to reproduce the hangs on any of the boards I have.
> 

Do you know whether the nforce2's with apic support the timer (IRQ 0) in 
IO-APIC mode?  To me, it seems like a bug:
"Dec  4 20:13:11 tesore kernel: ..MP-BIOS bug: 8254 timer not connected to 
IO-APIC"
(This message originates in arch/i386/kernel/io_apic.c)

nmi_watchdog doesn't seem to work at all because of this.  If it was working, 
then maybe I can catch the lockup, because if it's like you say, it's probably 
the kernel not hardware.

Jesse
