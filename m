Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUBXBrl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUBXBrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:47:41 -0500
Received: from post.tau.ac.il ([132.66.16.11]:30699 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S262133AbUBXBrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:47:39 -0500
Date: Tue, 24 Feb 2004 03:46:49 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Cc: Micha Feigin <michf@post.tau.ac.il>
Subject: Re: laptop mode in 2.4.24
Message-ID: <20040224014649.GC14051@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Micha Feigin <michf@post.tau.ac.il>
References: <1077276719.6533.16.camel@piro> <20040220134218.GA15112@fpirisp.portsdebalears.com> <87vfm136lu.fsf@ceramic.fifi.org> <20040221040239.GH18007@luna.mooo.com> <20040221182921.GF1162@laptop.localdomain.>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040221182921.GF1162@laptop.localdomain.>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.24.0.4; VDF: 6.24.0.15; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 01:29:21PM -0500, Eric Hustvedt wrote:
> On Sat, 21 Feb 2004, Micha Feigin wrote:
> 
> > The problem with this patch is that it overrides the built in commit
> > option that existed before the laptop mode patch was introduced.
> > 
> > > diff -ruN linux-2.4.24.orig/fs/jbd/transaction.c linux-2.4.24/fs/jbd/transaction.c
> > > --- linux-2.4.24.orig/fs/jbd/transaction.c	Fri Nov 28 10:26:21 2003
> > > +++ linux-2.4.24/fs/jbd/transaction.c	Mon Jan 12 12:01:54 2004
> > > @@ -56,7 +56,11 @@
> > >  	transaction->t_journal = journal;
> > >  	transaction->t_state = T_RUNNING;
> > >  	transaction->t_tid = journal->j_transaction_sequence++;
> > > -	transaction->t_expires = jiffies + journal->j_commit_interval;
> > > +	/*
> > > +	 * have to do it here, otherwise changed age_buffers since boot
> > > +	 * wont have any effect
> > > +	 */
> > > +	transaction->t_expires = jiffies + get_buffer_flushtime();
> > >  	INIT_LIST_HEAD(&transaction->t_jcb);
> > >  
> > >  	/* Set up the commit timer for the new transaction. */
> 
> What about changing the logic to use the greater of get_buffer_flushtime() or 
> j_commit_interval when laptop_mode is enabled? If laptop_mode is disabled, 
> j_commit_interval can be used, as it is currently.
> 
> I don't have my kernel dev trees on this computer, but I can whip up a patch,
> if people are interested.
> 

Considering that this was somewhat of a dirty hack in the first place,
that ext3 already has the functionality through the commit mount option
and that 2.6 laptop mode I think the proper way would be to throw this
out and use the commit option instead. All it needs is the reset option
(use commit=0 to use the default file system value). This way among
other things it will be possible to use the same laptop mode script for
both 2.4 and 2.6.
I have a patch for that which is in a testing phase now (along with a
fix for reiserfs and xfs), I am a bit slow on it now due to test season
but I am hoping to publish it next week or something around that. I
will check with the guy doing the 2.6 laptop-mode patch to see whats
the state of the testing.

> -Eric


