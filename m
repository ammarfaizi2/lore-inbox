Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWEJUa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWEJUa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWEJUa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:30:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60065 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932489AbWEJUa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:30:56 -0400
Date: Wed, 10 May 2006 22:30:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
Message-ID: <20060510203015.GA13949@elf.ucw.cz>
References: <20060509084945.373541000@sous-sol.org> <20060509085154.802230000@sous-sol.org> <20060509071640.GA4150@ucw.cz> <200605102209.05004.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605102209.05004.ak@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 10-05-06 22:09:04, Andi Kleen wrote:
> On Tuesday 09 May 2006 09:16, Pavel Machek wrote:
> > Hi!
> > 
> > > --- linus-2.6.orig/include/asm-i386/mach-default/mach_system.h
> > > +++ linus-2.6/include/asm-i386/mach-default/mach_system.h
> > > @@ -1,6 +1,8 @@
> > >  #ifndef __ASM_MACH_SYSTEM_H
> > >  #define __ASM_MACH_SYSTEM_H
> > >  
> > > +#define clearsegment(seg)
> > 
> > do {} while (0), please.
> 
> It's not needed. Think about it.

Really? If someone does 

	if (something)
		clearsegment(seg)
	somethingelse();

... he'll get very confusing behaviour instead of compile error. 

Okay, that's weaker argument than expected...

Also clearsegment(x) clearsegment(y); will compile when it should not.

Also clearsegment(i++) will behave strangely. So perhaps 

#define clearsegment(seg) do { seg; } while (0)

is best variant?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
