Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264939AbUELVgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264939AbUELVgf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbUELVge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:36:34 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:51663 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263798AbUELVdI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:33:08 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 12 May 2004 14:33:07 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Valdis.Kletnieks@vt.edu
cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up... 
In-Reply-To: <200405122103.i4CL3AUp014523@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0405121432070.11950@bigblue.dev.mdolabs.com>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com>
 <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu>
 <200405121947.i4CJlJm5029666@turing-police.cc.vt.edu>
 <Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com>
 <200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu> <20040512202807.GA16849@elte.hu>
 <20040512203500.GA17999@elte.hu>            <20040512205028.GA18806@elte.hu>
 <200405122103.i4CL3AUp014523@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004 Valdis.Kletnieks@vt.edu wrote:

> On Wed, 12 May 2004 22:50:28 +0200, Ingo Molnar said:
> 
> > Content-Disposition: attachment; filename="hz-cleanup-2.6.6-A2"
> > 
> > --- linux/include/linux/time.h.orig	
> > +++ linux/include/linux/time.h	
> > @@ -177,6 +177,24 @@ struct timezone {
> >  	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 
> 1) - 1)
> >  
> >  #endif
> > +
> > +/*
> > + * Convert jiffies to milliseconds and back.
> > + *
> > + * Avoid unnecessary multiplications/divisions in the
> > + * two most common HZ cases:
> > + */
> > +#if HZ == 1000
> > +# define JIFFIES_TO_MSECS(x)	(x)
> > +# define MSECS_TO_JIFFIES(x)	(x)
> > +#elif HZ == 100
> > +# define JIFFIES_TO_MSECS(x)	((x) * 10)
> > +# define MSECS_TO_JIFFIES(x)	((x) / 10)
> > +#else
> > +# define JIFFIES_TO_MSECS(x)	((x) * 1000 / HZ)
> > +# define MSECS_TO_JIFFIES(x)	((x) * HZ / 1000)
> > +#endif
> > +
> 
> Looks good to me.. :)

Guys, why don't you leave the compiler to do its job?



- Davide

