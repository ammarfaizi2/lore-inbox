Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVKDMko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVKDMko (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 07:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVKDMko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 07:40:44 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:60939 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S932140AbVKDMkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 07:40:43 -0500
Date: Fri, 4 Nov 2005 12:40:31 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: john stultz <johnstul@us.ibm.com>
Cc: rddunlap@osdl.org, Len Brown <len.brown@intel.com>,
       Jean-Christian de Rivaz <jc@eclis.ch>, linux-kernel@vger.kernel.org,
       dean@arctic.org, zippel@linux-m68k.org,
       Andy Currid <acurrid@nvidia.com>
Subject: Re: NTP broken with 2.6.14
In-Reply-To: <1131058482.27168.612.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.55.0511041229140.17988@blysk.ds.pg.gda.pl>
References: <4369464B.6040707@eclis.ch>  <1130973717.27168.504.camel@cog.beaverton.ibm.com>
  <43694DD1.3020908@eclis.ch>  <1130976935.27168.512.camel@cog.beaverton.ibm.com>
  <43695D94.10901@eclis.ch>  <1130980031.27168.527.camel@cog.beaverton.ibm.com>
  <43697550.7030400@eclis.ch>  <1131046348.27168.537.camel@cog.beaverton.ibm.com>
  <436A7D4B.8080109@eclis.ch>  <1131054087.27168.595.camel@cog.beaverton.ibm.com>
  <436A8ADB.2090307@eclis.ch> <1131058482.27168.612.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, john stultz wrote:

> > I compared the dmesg log of the different kernel, but since I don't know 
> > what I should find it's a little difficult. There is many differences 
> > between each kernels. Despit that, I noticed this difference between the 
> > kernel 2.6.9 (ntps working) and the kernel 2.6.10 (ntpd failed):
> > 
> > --- linux-2.6.9.txt  2005-11-03 22:49:29.000000000 +0100
> > +++ linux-2.6.10.txt  2005-11-03 22:48:41.000000000 +0100
> > [...snip...]
> > @@ -67,16 +68,12 @@
> >    Enabling unmasked SIMD FPU exception support... done.
> >    Checking 'hlt' instruction... OK.
> >    ENABLING IO-APIC IRQs
> > - vector=0x31 pin1=2 pin2=-1
> > - 8254 timer not connected to IO-APIC
> > - ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> > - ...trying to set up timer as Virtual Wire IRQ... failed.
> > - ...trying to set up timer as ExtINT IRQ... works.
> > + vector=0x31 pin1=0 pin2=-1
> >    Registered protocol family 16
> >    PCI BIOS revision 2.10 entry at 0xfbbb0, last bus=3
> >    Using configuration type 1
> > [..snip...]
> > 
> > Maybe a way to go ?
> 
> 
> You might check booting w/ noapic to see if that changes the behaviour
> in 2.6.10.
> 
> I know there were some pretty troubling issues w/ the nforce2 early in
> the 2.6 cycle.  See
> http://atlas.et.tudelft.nl/verwei90/nforce2/index.html for some details.
> 
> 
> Maciej: I noticed you had been involved with earlier nforce2 issues.
> Does the above change in the ioapic pin1 value look familiar?

 Oh, absolutely -- the timer interrupt line of the nForce2 chipset is
known to suffer from glitches under certain circumstances.  As APIC inputs
are truly edge-triggered, if thus configured, unlike ones of 8259A chips
which ignore such interrupts if not handled before deassertion, all
glitches are actually handled as real interrupts leading to a significant
time drift.  I've thought nVidia had a workaround for that -- cc-ing their
contact; not sure if still active.  I've had a brief look at my archives
and the suggestion was to disable the "Spread Spectrum" option if
available in the firmware setup (not sure what to do if there is none).

  Maciej
