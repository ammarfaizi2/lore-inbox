Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWH1V5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWH1V5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWH1V5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:57:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:24729 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964799AbWH1V5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:57:37 -0400
Subject: Re: [PATCH -mm] Fix faulty HPET clocksource usage (fix for bug
	#7062)
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, michael.olbrich@gmx.net
In-Reply-To: <20060828143928.c6fc1b85.akpm@osdl.org>
References: <1156800759.16398.6.camel@localhost.localdomain>
	 <20060828143928.c6fc1b85.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 14:57:35 -0700
Message-Id: <1156802255.16398.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 14:39 -0700, Andrew Morton wrote:
> On Mon, 28 Aug 2006 14:32:39 -0700
> john stultz <johnstul@us.ibm.com> wrote:
> 
> > Apparently some systems export valid HPET addresses, but hpet_enable()
> > fails. Then when the HPET clocksource starts up, it only checks for a
> > valid HPET address, and the result is a system where time does not
> > advance.
> > 
> > See http://bugme.osdl.org/show_bug.cgi?id=7062 for details.
> > 
> > This patch just makes sure we better check that the HPET is functional
> > before registering the HPET clocksource.
> > 
> > Signed-off-by: John Stultz <johnstul@us.ibm.com>
> > 
> > diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
> > index c6737c3..17647a5 100644
> > --- a/arch/i386/kernel/hpet.c
> > +++ b/arch/i386/kernel/hpet.c
> > @@ -35,7 +35,7 @@ static int __init init_hpet_clocksource(
> >  	void __iomem* hpet_base;
> >  	u64 tmp;
> >  
> > -	if (!hpet_address)
> > +	if (!is_hpet_enabled())
> >  		return -ENODEV;
> >  
> >  	/* calculate the hpet address: */
> 
> Thanks.   This would be a 2.6.18 thing, wouldn't it?

I would think so.

thanks
-john


