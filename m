Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263271AbUJ2AqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUJ2AqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbUJ2Aoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:44:39 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:10708 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263267AbUJ2A2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:28:19 -0400
Subject: Re: time and suspending sysdevs [was Re: Fixing MTRR smp breakage
	and suspending sysdevs.]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Li, Shaohua" <shaohua.li@intel.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041028223838.GA2319@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com>
	 <20041027100046.GB26265@elf.ucw.cz>  <20041028223838.GA2319@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1099009119.3441.12.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 29 Oct 2004 10:18:39 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 08:38, Pavel Machek wrote:
> Hi!
> 
> > > >One thing I have noticed is that by adding the sysdev suspend/resume
> > > >calls, I've gained a few seconds delay. I'll see if I can track down
> > > the
> > > >cause.

Don't think I actually mentioned the case: it's the pit timer, it
appears (number before is jiffies). Interestingly, there is a delay in
suspending, but it only shows after we exit the sysdev call (when
interrupts are reenabled? Haven't looked more closely).

Suspending System Devices
Suspending type 'irqrouter':
 4294741499: Starting global drivers irqrouter0
 4294741499: Starting auxillary drivers.
Suspending type 'ioapic':
 4294741499: Starting global drivers ioapic0
 4294741499: Starting auxillary drivers.
 4294741499: Starting generic driver.
 4294741499: Done.
Suspending type 'lapic':
 4294741499: Starting global drivers lapic0
 4294741499: Starting auxillary drivers.
 4294741499: Starting generic driver.
 4294741499: Done.
Suspending type 'timer':
 4294741499: Starting global drivers timer0
 4294741499: Starting auxillary drivers.
Suspending type 'pit':
 4294741499: Starting global drivers pit0
 4294741499: Starting auxillary drivers.
 4294741499: Starting generic driver.
 4294741499: Done.
Suspending type 'i8259':
 4294741499: Starting global drivers i82590
 4294741499: Starting auxillary drivers.
 4294741499: Starting generic driver.
 4294741499: Done.
Suspending type 'cpu':
 4294741499: Starting global drivers cpu0
 4294741499: Starting auxillary drivers.
 4294741499: Starting global drivers cpu1
 4294741499: Starting auxillary drivers.
Back from sysdev_suspend.
sysdev_resume
Resuming System Devices
Resuming type 'cpu':
 4294742128: cpu0
 4294742128: Starting auxillary drivers.
 4294742128: Starting global drivers cpu0
 4294742128: Done.
 4294742128: cpu1
 4294742128: Starting auxillary drivers.
 4294742128: Starting global drivers cpu1
 4294742128: Done.
Resuming type 'i8259':
 4294742128: i82590
 4294742128: Starting generic driver.
 4294742128: Starting auxillary drivers.
 4294742128: Starting global drivers i82590
 4294742128: Done.
Resuming type 'pit':
 4294742128: pit0
 4294742128: Starting generic driver.
 4294772030: Starting auxillary drivers.
 4294772030: Starting global drivers pit0
 4294772030: Done.
Resuming type 'timer':
 4294772030: timer0
 4294772030: Starting generic driver.
 4294772030: Starting auxillary drivers.
 4294772030: Starting global drivers timer0
 4294772030: Done.
Resuming type 'lapic':
 4294772030: lapic0
 4294772030: Starting generic driver.
 4294772030: Starting auxillary drivers.
 4294772030: Starting global drivers lapic0
 4294772030: Done.
Resuming type 'ioapic':
 4294772030: ioapic0
 4294772030: Starting generic driver.
 4294772030: Starting auxillary drivers.
 4294772030: Starting global drivers ioapic0
 4294772030: Done.
Resuming type 'irqrouter':
 4294772030: irqrouter0
 4294772030: Starting generic driver.
 4294772030: Starting auxillary drivers.
 4294772030: Starting global drivers irqrouter0
 4294772030: Done.
power up suspend device tree.
done

Regards,

Nigel

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

