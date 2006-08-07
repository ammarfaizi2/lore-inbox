Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWHGQLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWHGQLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWHGQLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:11:47 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:15622 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S932198AbWHGQLk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:11:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Date: Mon, 7 Aug 2006 11:11:25 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0C86@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <20060807085924.72f832af.rdunlap@xenotime.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Thread-Index: Aca6OhYv+PYhHg7wTIGnJ8rqhEvcTwAAcW7Q
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Aug 2006 16:11:25.0903 (UTC) FILETIME=[2211BDF0:01C6BA3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Currrently on a SMP system we can theoretically support
> > NR_CPUS*224 irqs.  Unfortunately our data structures don't 
> cope will 
> > with that many irqs, nor does hardware typically provide 
> that many irq 
> > sources.
> > 
> > With the number of cores starting to follow Moores law, and 
> the apicid 
> > limits being raised beyond an 8bit number trying to track 
> our current 
> > maximum with our current data structures would be fatal and 
> wasteful.
> > 
> > So this patch decouples the number of irqs we support from 
> the number 
> > of cpus.  We can revisit this decision once someone reworks the 
> > current data structures.
> > 
> > Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> > ---
> >  arch/x86_64/Kconfig      |   13 +++++++++++++
> >  include/asm-x86_64/irq.h |    3 ++-
> >  2 files changed, 15 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig index 
> > 7598d99..d744e5b 100644
> > --- a/arch/x86_64/Kconfig
> > +++ b/arch/x86_64/Kconfig
> > @@ -384,6 +384,19 @@ config NR_CPUS
> >  	  This is purely to save memory - each supported CPU requires
> >  	  memory in the static kernel configuration.
> >  
> > +config NR_IRQS
> > +	int "Maximum number of IRQs (224-4096)"
> > +	range 256 4096
> > +	depends on SMP
> > +	default "4096"
> > +	help
> > +	  This allows you to specify the maximum number of IRQs 
> which this
> > +	  kernel will support. Current maximum is 4096 IRQs as that
> > +	  is slightly larger than has observed in the field.
> > +
> > +	  This is purely to save memory - each supported IRQ requires
> > +	  memory in the static kernel configuration.
> 
> If (a) "nor does hardware typically provide that many irq sources"
> and (b) "This is purely to save memory", why is the default
> 4096 instead of something smaller?
> 

4k being a humble maximum is definitely a relative term here, but on the
system with "only" 64 or 128 processors the cpu*224 would be much higher
:) However, maybe CONFIG_TINY that Andi suggested would leverage this
number also. What do you think, Eric?

--Natalie
