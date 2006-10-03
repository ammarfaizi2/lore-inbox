Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWJCEr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWJCEr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWJCEr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:47:29 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:51345 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965191AbWJCEr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:47:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:Reply-To:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=5FsDGxtHmhbjVCu+wFYSgsjyPAOcwEDbrIH+a8gfKxaBXQ2REZwkNXmb90hnxktnFnFWKrsNUCYUbdqjm0WG1iTr4cp9fHlhi2NfpM5PXff3ndoD/lKrZ+XLR2e/a3jBmSfqXEynASiNPpq7KGmBoYzs8Ws1IKFvUlQQypCgDgg=  ;
Subject: Re: [patch 13/23] clockevents: core
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       jkacur@ca.ibm.com
In-Reply-To: <20060930013958.a350b7a1.akpm@osdl.org>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	 <20060929234440.290256000@cruncher.tec.linutronix.de>
	 <20060930013958.a350b7a1.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 00:33:52 -0400
Message-Id: <1159850032.7163.31.camel@moblin.mtmk.phub.net.cable.rogers.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-30 at 01:39 -0700, Andrew Morton wrote:
> On Fri, 29 Sep 2006 23:58:32 -0000
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > We have two types of clock event devices:
> > - global events (one device per system)
> > - local events (one device per cpu)
> > 
> > We assign the various time(r) related interrupts to those devices:
> > 
> > - global tick
> > - profiling (per cpu)
> > - next timer events (per cpu)
> > 
> > architectures register their clockevent sources, with specific capability
> > masks set, and the generic high-res-timers code picks the best one,
> > without the architecture having to worry about that.
> > 
> > here are the capabilities a clockevent driver can register:
> > 
> >  #define CLOCK_CAP_TICK		0x000001
> >  #define CLOCK_CAP_UPDATE	0x000002
> >  #define CLOCK_CAP_PROFILE	0x000004
> >  #define CLOCK_CAP_NEXTEVT	0x000008
> 
> OK..  Perhaps this info is worth promoting to a code comment.
> 
> > +++ linux-2.6.18-mm2/include/linux/clockchips.h	2006-09-30 01:41:17.000000000 +0200
> > @@ -0,0 +1,104 @@
> > +/*  linux/include/linux/clockchips.h
> > + *
> > + *  This file contains the structure definitions for clockchips.
> > + *
> > + *  If you are not a clockchip, or the time of day code, you should
> > + *  not be including this file!
> > + */
> > +#ifndef _LINUX_CLOCKCHIPS_H
> > +#define _LINUX_CLOCKCHIPS_H
> > +
> > +#include <linux/config.h>
> 
> The build system includes config.h for you.
> 
> > +#ifdef CONFIG_GENERIC_TIME
> > +
> > +#include <linux/clocksource.h>
> > +#include <linux/interrupt.h>
> > +
> > +/* Clock event mode commands */
> > +enum {
> > +	CLOCK_EVT_PERIODIC,
> > +	CLOCK_EVT_ONESHOT,
> > +	CLOCK_EVT_SHUTDOWN,
> > +};
> > +
> > +/* Clock event capability flags */
> > +#define CLOCK_CAP_TICK		0x000001
> > +#define CLOCK_CAP_UPDATE	0x000002
> > +#ifndef CONFIG_PROFILE_NMI
> > +# define CLOCK_CAP_PROFILE	0x000004
> > +#else
> > +# define CLOCK_CAP_PROFILE	0x000000
> > +#endif
> > +#ifdef CONFIG_HIGH_RES_TIMERS
> > +# define CLOCK_CAP_NEXTEVT	0x000008
> > +#else
> > +# define CLOCK_CAP_NEXTEVT	0x000000
> > +#endif
> 
> There is no CONFIG_PROFILE_NMI in the kernel nor anywhere else in this
> patchset.
> 
---SNIP----

As I've pointed out - this breaks the ability to do timer tick profiling
too.
http://marc.theaimsgroup.com/?l=linux-kernel&m=115484411119770&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=115484446530853&w=2

