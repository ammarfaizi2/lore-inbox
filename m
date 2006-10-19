Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161429AbWJSN5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161429AbWJSN5K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161432AbWJSN5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:57:10 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:64233 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161429AbWJSN5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:57:08 -0400
Subject: Re: + i386-time-avoid-pit-smp-lockups.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, mingo@elte.hu,
       tglx@linutronix.de
In-Reply-To: <200610191547.09640.ak@suse.de>
References: <200610112126.k9BLQqKG002529@shell0.pdx.osdl.net>
	 <1161265475.11264.7.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <200610191547.09640.ak@suse.de>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 06:57:05 -0700
Message-Id: <1161266225.11264.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 15:47 +0200, Andi Kleen wrote:
> On Thursday 19 October 2006 15:44, Daniel Walker wrote:
> > On Wed, 2006-10-11 at 14:26 -0700, akpm@osdl.org wrote:
> > 
> > > diff -puN arch/i386/kernel/i8253.c~i386-time-avoid-pit-smp-lockups arch/i386/kernel/i8253.c
> > > --- a/arch/i386/kernel/i8253.c~i386-time-avoid-pit-smp-lockups
> > > +++ a/arch/i386/kernel/i8253.c
> > > @@ -109,7 +109,7 @@ static struct clocksource clocksource_pi
> > >  
> > >  static int __init init_pit_clocksource(void)
> > >  {
> > > -	if (num_possible_cpus() > 4) /* PIT does not scale! */
> > > +	if (num_possible_cpus() > 1) /* PIT does not scale! */
> > >  		return 0;
> > >  
> > 
> > Can we ifdef some code here on CONFIG_SMP . It bugs me that there just
> > dead code laying around on smp systems.
> 
> The optimizer should optimize it all out since num_possible_cpus() is a 0
> constant on UP.

You just mean the if statement above though? I was talking more about
the structure above this called "clocksource_pit" which isn't used on
SMP systems due to this code addition. AFAIK init_pit_clocksource()
could disappear along with the clocksource structure ..

Daniel 

