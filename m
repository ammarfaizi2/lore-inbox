Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161399AbWJSNrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161399AbWJSNrY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161416AbWJSNrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:47:24 -0400
Received: from ns1.suse.de ([195.135.220.2]:4484 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161399AbWJSNrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:47:23 -0400
From: Andi Kleen <ak@suse.de>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: + i386-time-avoid-pit-smp-lockups.patch added to -mm tree
Date: Thu, 19 Oct 2006 15:47:09 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, mingo@elte.hu,
       tglx@linutronix.de
References: <200610112126.k9BLQqKG002529@shell0.pdx.osdl.net> <1161265475.11264.7.camel@c-67-180-230-165.hsd1.ca.comcast.net>
In-Reply-To: <1161265475.11264.7.camel@c-67-180-230-165.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191547.09640.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 October 2006 15:44, Daniel Walker wrote:
> On Wed, 2006-10-11 at 14:26 -0700, akpm@osdl.org wrote:
> 
> > diff -puN arch/i386/kernel/i8253.c~i386-time-avoid-pit-smp-lockups arch/i386/kernel/i8253.c
> > --- a/arch/i386/kernel/i8253.c~i386-time-avoid-pit-smp-lockups
> > +++ a/arch/i386/kernel/i8253.c
> > @@ -109,7 +109,7 @@ static struct clocksource clocksource_pi
> >  
> >  static int __init init_pit_clocksource(void)
> >  {
> > -	if (num_possible_cpus() > 4) /* PIT does not scale! */
> > +	if (num_possible_cpus() > 1) /* PIT does not scale! */
> >  		return 0;
> >  
> 
> Can we ifdef some code here on CONFIG_SMP . It bugs me that there just
> dead code laying around on smp systems.

The optimizer should optimize it all out since num_possible_cpus() is a 0
constant on UP.

-Andi
