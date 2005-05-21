Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVEUBaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVEUBaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 21:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEUBaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 21:30:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:30171 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261626AbVEUBaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 21:30:09 -0400
Subject: Re: [PATCH] Fixes for IPMI use of timers
From: Lee Revell <rlrevell@joe-job.com>
To: george@mvista.com
Cc: Corey Minyard <minyard@acm.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <428E8B68.6040909@mvista.com>
References: <428D2181.2080106@acm.org>  <428E8B68.6040909@mvista.com>
Content-Type: text/plain
Date: Fri, 20 May 2005 21:30:05 -0400
Message-Id: <1116639005.14582.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 18:14 -0700, George Anzinger wrote:
> >  		/* We already have irqsave on, so no need for it
> >                     here. */
> > -		read_lock(&xtime_lock);
> > +		read_lock_irqsave(&xtime_lock, flags);
> 
> I rather hope this fails to compile :)  xtime_lock is a sequence lock in the 2.6 
> kernel.
> 
> >  		jiffies_now = jiffies;
> >  		smi_info->si_timer.expires = jiffies_now;
> >  		smi_info->si_timer.sub_expires = get_arch_cycles(jiffies_now);
> > +		read_unlock_irqrestore(&xtime_lock, flags);

The old code clearly has an unbalanced lock/unlock, maybe it's
sufficient to just fix that?

Lee

