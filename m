Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423153AbWJSS3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423153AbWJSS3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423172AbWJSS3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:29:21 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:65436 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423153AbWJSS3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:29:20 -0400
Subject: Re: + i386-time-avoid-pit-smp-lockups.patch added to -mm tree
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, mingo@elte.hu,
       tglx@linutronix.de
In-Reply-To: <1161265475.11264.7.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610112126.k9BLQqKG002529@shell0.pdx.osdl.net>
	 <1161265475.11264.7.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 11:27:34 -0700
Message-Id: <1161282454.6961.126.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 06:44 -0700, Daniel Walker wrote:
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

I still want the pit to be available on SMP kernels that boot on UP
systems, so I don't think an ifdef will do it. Maybe it would be
possible to do some smp alternatives-like code removal on SMP systems?

thanks
-john


