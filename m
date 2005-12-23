Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbVLWFXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVLWFXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 00:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbVLWFXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 00:23:33 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:11015 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030415AbVLWFXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 00:23:33 -0500
Date: Fri, 23 Dec 2005 06:23:17 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Tim Warnock <timoid@getonit.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: Kernel oops v2.4.31 in e1000 network card driver.
Message-ID: <20051223052317.GP15993@alpha.home.local>
References: <C67FBCB411B4024382B11B96D68E49E4079693@server.local.GetOffice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C67FBCB411B4024382B11B96D68E49E4079693@server.local.GetOffice>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 10:06:19AM +1000, Tim Warnock wrote:
> > -----Original Message-----
> > From: Willy Tarreau [mailto:willy@w.ods.org] 
> > Sent: Friday, 23 December 2005 9:17 AM
> > To: Tim Warnock
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: FW: Kernel oops v2.4.31 in e1000 network card driver.
> > 
> > Hello,
> > 
> > On Thu, Dec 22, 2005 at 07:10:04PM +1000, Tim Warnock wrote:
> > > Further information to this:
> > > 
> > > Network card causing the problem is the intel quad port 
> > > gigabit ethernet pci card.
> > > I have tested also on 2.4.27, 2.4.32 and the latest 2.6 
> > > series kernel.
> > > 
> > > Under load (10-15kpps) the network driver crashes. Under 
> > > increased load (20-30kpps) the driver will actually cause
> > > a full kernel panic and reboot the box.
> > 
> > What type of system is it ? P3/P4/K7/K8 ? UP/SMP ? do you have a PCI-X
> > bus in it ? have you checked /proc/interrupts for strange behaviours ?
> 
> IBM x306 p4 3.0ghz UP/HT (acpi=ht) 1gb ram 

Mine are x305 at 2.66 GHz without HT. Nearly the same.

> It's a 64bit pci bus, the quad card is 64 bit also.
> 
> Underlying host os is debian sarge.
> 
> I never thought to check /proc/interrupts. I get the network card back
> from remote soon, I will put it in a bench system and see what happens.
> What should I be looking for in /proc/interrupts?

Suspect things. Eg: if you have one IRQ shared with ACPI or USB. Or
perhaps during traffic, only 3 or the 4 ports getting interrupts, etc...

It would be interesting to determine whether it's incoming traffic,
outgoing or both which cause the trouble. Use 'nc </dev/zero' for this.

Anyway, I really think that running a memtest or trying without HT will
give very useful info.

> > > After replacing the card with a single port intel gigabit 
> > ethernet pci card, the system has been rock stable.
> > > 
> > > According to intel, the quad port nic is based around the "Intel(r)
> > > 82546EB" controller, the single port nic is based around 
> > > the "Intel(r) 82545" controller.
> > > 
> > > Are there any other known problems with Intel(r) 82546EB controller
> > > support with the current e1000 driver?
> > 
> > Not to my knowledge. I have several of them running on moderate volume
> > (50 Mbps) on production up to 50-60 kpps, and they have never 
> > ever caused any trouble after 2.5 years. I even use others in 
> > stress-testing machines which throw up to 500 kpps per port without
> > any problem either. BTW, the ones in the stress-testers are more
> > recent, they are the ones with the "toundra" PCI bridge.
> > 
> > Do you encounter the problem in only one system ? I begin to suspect a
> > hardware failure somewhere (CPU, RAM) which is triggered by 
> > higher loads.
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Regards,
Willy

