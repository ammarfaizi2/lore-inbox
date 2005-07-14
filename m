Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVGNVDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVGNVDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVGNVDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:03:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:8877 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261724AbVGNVDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:03:36 -0400
Date: Thu, 14 Jul 2005 14:03:28 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 1/4] add jiffies_to_nsecs() helper and fix up size of usecs
Message-ID: <20050714210328.GJ28100@us.ibm.com>
References: <20050714202629.GD28100@us.ibm.com> <20050714202826.GE28100@us.ibm.com> <1121374488.15263.54.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121374488.15263.54.camel@localhost>
X-Operating-System: Linux 2.6.13-rc2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.2005 [13:54:47 -0700], Dave Hansen wrote:
> On Thu, 2005-07-14 at 13:28 -0700, Nishanth Aravamudan wrote:
> > +static inline u64 jiffies_to_nsecs(const unsigned long j)
> > +{
> > +#if HZ <= NSEC_PER_SEC && !(NSEC_PER_SEC % HZ)
> > +	return (NSEC_PER_SEC / HZ) * (u64)j;
> > +#elif HZ > NSEC_PER_SEC && !(HZ % NSEC_PER_SEC)
> > +	return ((u64)j + (HZ / NSEC_PER_SEC) - 1)/(HZ / NSEC_PER_SEC);
> > +#else
> > +	return ((u64)j * NSEC_PER_SEC) / HZ;
> > +#endif
> > +}
> 
> That might look a little better something like:
> 
> static inline u64 jiffies_to_nsecs(const unsigned long __j)
> {
> 	u64 j = __j;
> 
> 	if (HZ <= NSEC_PER_SEC && !(NSEC_PER_SEC % HZ))
> 		return (NSEC_PER_SEC / HZ) * j;
> 	else if (HZ > NSEC_PER_SEC && !(HZ % NSEC_PER_SEC))
> 		return (j + (HZ / NSEC_PER_SEC) - 1)/(HZ / NSEC_PER_SEC);
> 	else
> 		return (j * NSEC_PER_SEC) / HZ;
> }
> 
> Compilers are smart :)

Well, I was trying to keep it similar to the other conversion functions.
I guess the compiler can evaluate the conditional full of constants at
compile-time regardless of whether it is #if or if ().

I can make these changes if others would like them as well.

Thanks,
Nish
