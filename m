Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWJHOnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWJHOnB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWJHOnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:43:01 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:46246 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751201AbWJHOnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:43:00 -0400
Subject: Re: + clocksource-initialize-list-value.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160301039.22911.22.camel@localhost.localdomain>
References: <200610070153.k971rsDf020869@shell0.pdx.osdl.net>
	 <1160301039.22911.22.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 07:42:59 -0700
Message-Id: <1160318579.3693.8.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 11:50 +0200, Thomas Gleixner wrote:
> On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> > A change to clocksource initialization.  It's optional for new clocksources,
> > but prefered.  If the list field is initialized it allows clocksource_register
> > to complete faster since it doesn't have the scan the list of clocks doing
> > strcmp on each.
> 
> Either make it required or not.

This is for compatability with all those clocksources people are writing
that just haven't been released (assuming they will be eventually
released). I would love to make this required.

> > diff -puN arch/i386/kernel/hpet.c~clocksource-initialize-list-value arch/i386/kernel/hpet.c
> > --- a/arch/i386/kernel/hpet.c~clocksource-initialize-list-value
> > +++ a/arch/i386/kernel/hpet.c
> > @@ -27,6 +27,7 @@ static struct clocksource clocksource_hp
> >  	.mult		= 0, /* set below */
> >  	.shift		= HPET_SHIFT,
> >  	.is_continuous	= 1,
> > +	.list		= CLOCKSOURCE_LIST_INIT(clocksource_hpet.list),
> ... 
> > +/* Abstracted list initialization */
> > +#define CLOCKSOURCE_LIST_INIT(x)	LIST_HEAD_INIT(x)
> > +
> 
> Please use LIST_HEAD_INIT(). This is not an abstraction, this is an
> obfuscation. 

The reason it's there is to make the list->plist or plist->list
transition easier. I'd be happy to remove when I feel that's settled,
which may be right now.

Daniel

