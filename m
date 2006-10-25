Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWJYVnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWJYVnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 17:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWJYVnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 17:43:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61893 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750789AbWJYVnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 17:43:05 -0400
Date: Wed, 25 Oct 2006 23:42:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix generic WARN_ON message
Message-ID: <20061025214257.GA2578@elf.ucw.cz>
References: <4535902E.1000608@goop.org> <20061018055542.GA14784@elte.hu> <20061025100405.GB7658@elf.ucw.cz> <1161809722.3207.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161809722.3207.3.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-10-25 16:55:22, Steven Rostedt wrote:
> On Wed, 2006-10-25 at 12:04 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> > > 
> > > > A warning is a warning, not a BUG.
> > > 
> > > > -		printk("BUG: warning at %s:%d/%s()\n", __FILE__,	\
> > > > +		printk("WARNING at %s:%d %s()\n", __FILE__,	\
> > > 
> > > i'm not really happy about this change.
> > > 
> > > Firstly, most WARN_ON()s are /bugs/, not warnings ... If it's a real 
> > > warning, a KERN_INFO printk should be done.
> > > 
> > > Secondly, the reason i changed it to the 'BUG: ...' format is that i 
> > > tried to make it easier for automated tools (and for users) to figure 
> > > out that a kernel bug happened.
> > 
> > Well... but the message is really bad. It leads to users telling us "I
> > hit BUG in kernel"...
> 
> But they *did* hit a BUG. It just so happens that the BUG was fixable.
> We want this reported because a WARN_ON should *never* be hit unless
> there's a bug.  If people start getting "WARNING" messages, they will
> more likely not be reporting them.
> 
> As Ingo already said, if it is just a "warning" then a normal printk
> should be used.

Fine, then why is the macro called WARN_ON()? That's certainly highly
confusing.

NONFATAL_BUG_ON()?

I hate people reporting BUG (or BUG()) when they hit WARN_ON(), and
current wording certainly makes it easy.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
