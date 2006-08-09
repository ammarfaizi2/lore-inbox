Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWHIC5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWHIC5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWHIC5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:57:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:32465 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030293AbWHIC5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:57:02 -0400
Subject: Re: [RFC][PATCH 1/6] x86_64: Enable arch-generic vsyscall support.
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608090429.49951.ak@suse.de>
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
	 <20060809021714.23103.24280.sendpatchset@cog.beaverton.ibm.com>
	 <200608090429.49951.ak@suse.de>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 19:56:58 -0700
Message-Id: <1155092218.13030.107.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 04:29 +0200, Andi Kleen wrote:
> > diff --git a/kernel/timer.c b/kernel/timer.c
> > index b650f04..08b4a02 100644
> > --- a/kernel/timer.c
> > +++ b/kernel/timer.c
> > @@ -1023,6 +1023,12 @@ static int __init timekeeping_init_devic
> >  
> >  device_initcall(timekeeping_init_device);
> >  
> > +#ifdef CONFIG_GENERIC_TIME_VSYSCALL
> > +extern void update_vsyscall(struct timespec* ts, struct clocksource* c);
> > +#else
> > +#define update_vsyscall(now, c)
> > +#endif
> 
> Using a weak dummy function would be a bit cleaner.

Will compilers optimize out the call properly?

Looking at it now, it probably should go in a .h file and the empty
define should be a proper "do { } while(0)" 

thanks
-john


