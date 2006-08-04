Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161451AbWHDVEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbWHDVEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWHDVEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:04:43 -0400
Received: from www.osadl.org ([213.239.205.134]:2997 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161451AbWHDVEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:04:42 -0400
Subject: Re: [PATCH 04/10] -mm  clocksource: add some new API calls
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1154719720.12936.50.camel@c-67-188-28-158.hsd1.ca.comcast.net>
References: <20060804032414.304636000@mvista.com>
	 <20060804032521.464282000@mvista.com>
	 <1154718400.5327.23.camel@localhost.localdomain>
	 <1154719720.12936.50.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 23:05:02 +0200
Message-Id: <1154725503.5932.251.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 12:28 -0700, Daniel Walker wrote:
> > >  int clocksource_register(struct clocksource *c)
> > >  {
> > >  	int ret = 0;
> > >  	unsigned long flags;
> > >  
> > > +	if (unlikely(!c))
> > > +		return -EINVAL;
> > > +
> > 
> > I'm not sure I understand the need for this. Is it really likely someone
> > would pass NULL to clocksource_register()?
> 
> Not likely, I was just covering all possibilities.. It might be better
> as a BUG_ON() actually.

BUG_ON is the only thing, which can be correct here. Registering a NULL
clocksource simply is a bug, but even the BUG_ON is overkill here. 

	tglx


