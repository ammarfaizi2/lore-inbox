Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752633AbWAHRTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbWAHRTb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbWAHRTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:19:31 -0500
Received: from [139.30.44.16] ([139.30.44.16]:10035 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1752633AbWAHRTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:19:30 -0500
Date: Sun, 8 Jan 2006 18:19:26 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Michael Buesch <mbuesch@freenet.de>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 5/7]  uninline capable()
In-Reply-To: <200601061218.17369.mbuesch@freenet.de>
Message-ID: <Pine.LNX.4.63.0601081808470.6962@gockel.physik3.uni-rostock.de>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
 <1136544160.2940.20.camel@laptopd505.fenrus.org> <200601061218.17369.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Michael Buesch wrote:

> On Friday 06 January 2006 11:42, you wrote:
> > Index: linux-2.6.15/include/linux/sched.h
> > ===================================================================
> > --- linux-2.6.15.orig/include/linux/sched.h
> > +++ linux-2.6.15/include/linux/sched.h
> > @@ -1102,19 +1102,8 @@ static inline int sas_ss_flags(unsigned 
> >  }
> >  
> >  
> > -#ifdef CONFIG_SECURITY
> > -/* code is in security.c */
> > +/* code is in security.c or kernel/sys.c if !SECURITY */
> >  extern int capable(int cap);

Great! I really love this.
capable() was a great offender in the sched.h includes cleanup.

> BTW, is there a special reason why this is declared in sched.h
> instead of capability.h?

Header file detangling. capable() needs to dereference current.

Moving capable() to capability.h would mean that capability.h needs to 
include sched.h, which 1) is inefficient as capability.h is included in 
about 5885 files and sched.h drags in another 133 header files and 2)
results in a circular dependency.

Tim
