Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWAHTDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWAHTDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbWAHTDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:03:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932754AbWAHTDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:03:25 -0500
Date: Sun, 8 Jan 2006 11:03:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: rdunlap@xenotime.net, mbuesch@freenet.de, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] move capable() to capability.h
Message-Id: <20060108110300.557ea8d0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0601081904170.6962@gockel.physik3.uni-rostock.de>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	<200601061218.17369.mbuesch@freenet.de>
	<1136546539.2940.28.camel@laptopd505.fenrus.org>
	<200601061226.42416.mbuesch@freenet.de>
	<20060107215106.38d58bb9.rdunlap@xenotime.net>
	<Pine.LNX.4.63.0601081904170.6962@gockel.physik3.uni-rostock.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
>
> On Sat, 7 Jan 2006, Randy.Dunlap wrote:
> 
> ...
> > +#ifdef CONFIG_SECURITY
> > +/* code is in security.c */
> > +extern int capable(int cap);
> > +#else
> > +static inline int capable(int cap)
> > +{
> > +	if (cap_raised(current->cap_effective, cap)) {
> > +		current->flags |= PF_SUPERPRIV;
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> > +#endif
> 
> I wonder how this can actually work. For dereferencing current, it is not 
> enough to include <asm/current.h>. The actual layout of struct task_struct
> needs to be known to the compiler, which is given in <linux/sched.h>.
> 
> Maybe you were just lucky with your .config and every file using capable()
> just by chance also included <linux/sched.h>?
> 
> (Chances are not bad since currently about every other .c file includes 
> sched.h. However, I have patches pending to reduce this number to ~500..1000)
> 
> Uninlining capable() might indeed help us here.
> 

I mangled Randy's patch so it applies after uninline-capable.patch, so all
is OK.

