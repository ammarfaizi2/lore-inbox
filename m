Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161385AbWJYUz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161385AbWJYUz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161391AbWJYUz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:55:56 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:2476 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161386AbWJYUzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:55:55 -0400
Subject: Re: [PATCH] Fix generic WARN_ON message
From: Steven Rostedt <rostedt@goodmis.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061025100405.GB7658@elf.ucw.cz>
References: <4535902E.1000608@goop.org> <20061018055542.GA14784@elte.hu>
	 <20061025100405.GB7658@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 16:55:22 -0400
Message-Id: <1161809722.3207.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 12:04 +0200, Pavel Machek wrote:
> Hi!
> 
> > * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> > 
> > > A warning is a warning, not a BUG.
> > 
> > > -		printk("BUG: warning at %s:%d/%s()\n", __FILE__,	\
> > > +		printk("WARNING at %s:%d %s()\n", __FILE__,	\
> > 
> > i'm not really happy about this change.
> > 
> > Firstly, most WARN_ON()s are /bugs/, not warnings ... If it's a real 
> > warning, a KERN_INFO printk should be done.
> > 
> > Secondly, the reason i changed it to the 'BUG: ...' format is that i 
> > tried to make it easier for automated tools (and for users) to figure 
> > out that a kernel bug happened.
> 
> Well... but the message is really bad. It leads to users telling us "I
> hit BUG in kernel"...

But they *did* hit a BUG. It just so happens that the BUG was fixable.
We want this reported because a WARN_ON should *never* be hit unless
there's a bug.  If people start getting "WARNING" messages, they will
more likely not be reporting them.

As Ingo already said, if it is just a "warning" then a normal printk
should be used.

-- Steve


