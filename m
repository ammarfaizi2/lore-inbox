Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUDOAiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 20:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUDOAiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 20:38:21 -0400
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:10396 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S262493AbUDOAiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 20:38:15 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Christian =?iso-8859-1?q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH]
Date: Thu, 15 Apr 2004 10:41:35 +1000
User-Agent: KMail/1.5.1
Cc: Len Brown <len.brown@intel.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
References: <200404142301.33153.christian.kroener@tu-harburg.de>
In-Reply-To: <200404142301.33153.christian.kroener@tu-harburg.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404151041.35196.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 07:01, Christian Kröner wrote:
> > Just would like to add that if we cannot get Maciej's 8259 ack patch
> > back into the distro then we need an if statement in the check_timer()
> > to turn off timer_ack for nforce2 or Christian might get his hi-load back
> > and certainly nmi_debug=1 won't work.
> >
> > e.g. for 2.4.26-rc2 io_apic.c line 1613 or 2.6.5 line 2180
> >       if (pin1 != -1) {
> >               /*
> >                * Ok, does IRQ0 through the IOAPIC work?
> >                */
> > +             if(acpi_skip_timer_override)
> > +                     timer_ack=0;
> >               unmask_IO_APIC_irq(0);
> >
> 
> Also on mainline 2.6.5 this if-statement doesn't seem to be necessary. Len's 
> patch worked on this kernel as well, setting the timer interrupt to 
> IO-APIC-edge and there is no strange hi-load anymore too.
> 

Good that your hi-load is fixed just by routing the timer through io-apic.

Could you try the "nmi_watchdog=1" kernel arg please.

You should get a message in your boot log as to whether it works
also cat /proc/interrupts to see if it stops. 
Wouldn't hurt to try "nmi_watchdog=2" either.
I had a situation where "nmi_watchdog=2" tested ok in boot log
but halted after 23 interrupts.


> thanks, christian.
> 
> 
> 

