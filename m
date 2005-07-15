Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVGPNy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVGPNy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 09:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVGPNvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 09:51:45 -0400
Received: from cpu2485.adsl.bellglobal.com ([207.236.16.208]:28395 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261341AbVGPNuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 09:50:24 -0400
Date: Fri, 15 Jul 2005 14:14:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 1/4] add jiffies_to_nsecs() helper and fix up size of usecs
Message-ID: <20050715121424.GA1775@elf.ucw.cz>
References: <20050714202629.GD28100@us.ibm.com> <20050714202826.GE28100@us.ibm.com> <1121374488.15263.54.camel@localhost> <20050714210328.GJ28100@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714210328.GJ28100@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +static inline u64 jiffies_to_nsecs(const unsigned long j)
> > > +{
> > > +#if HZ <= NSEC_PER_SEC && !(NSEC_PER_SEC % HZ)
> > > +	return (NSEC_PER_SEC / HZ) * (u64)j;
> > > +#elif HZ > NSEC_PER_SEC && !(HZ % NSEC_PER_SEC)
> > > +	return ((u64)j + (HZ / NSEC_PER_SEC) - 1)/(HZ / NSEC_PER_SEC);
> > > +#else
> > > +	return ((u64)j * NSEC_PER_SEC) / HZ;
> > > +#endif
> > > +}
> > 
> > That might look a little better something like:
> > 
> > static inline u64 jiffies_to_nsecs(const unsigned long __j)
> > {
> > 	u64 j = __j;
> > 
> > 	if (HZ <= NSEC_PER_SEC && !(NSEC_PER_SEC % HZ))
> > 		return (NSEC_PER_SEC / HZ) * j;
> > 	else if (HZ > NSEC_PER_SEC && !(HZ % NSEC_PER_SEC))
> > 		return (j + (HZ / NSEC_PER_SEC) - 1)/(HZ / NSEC_PER_SEC);
> > 	else
> > 		return (j * NSEC_PER_SEC) / HZ;
> > }
> > 
> > Compilers are smart :)
> 
> Well, I was trying to keep it similar to the other conversion functions.
> I guess the compiler can evaluate the conditional full of constants at
> compile-time regardless of whether it is #if or if ().
> 
> I can make these changes if others would like them as well.

Yes, please. And feel free to convert nearby functions, too ;-).
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
