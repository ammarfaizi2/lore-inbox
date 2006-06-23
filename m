Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933025AbWFWLAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933025AbWFWLAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 07:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933027AbWFWLAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 07:00:07 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37861 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933017AbWFWLAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 07:00:04 -0400
Date: Fri, 23 Jun 2006 12:55:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 55/61] lock validator: special locking: sb->s_umount
Message-ID: <20060623105505.GR4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212732.GC3155@elte.hu> <20060529183624.2c8032cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183624.2c8032cd.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > +++ linux/fs/dcache.c
> > @@ -470,8 +470,9 @@ static void prune_dcache(int count, stru
> >  		s_umount = &dentry->d_sb->s_umount;
> >  		if (down_read_trylock(s_umount)) {
> >  			if (dentry->d_sb->s_root != NULL) {
> > -				prune_one_dentry(dentry);
> > +// lockdep hack: do this better!
> >  				up_read(s_umount);
> > +				prune_one_dentry(dentry);
> >  				continue;
> 
> argh, you broke my kernel!
> 
> I'll whack some ifdefs in here so it's only known-broken if 
> CONFIG_LOCKDEP.
> 
> Again, we'd need the real fix here.

yeah. We should undo this patch for now. This will only be complained 
about if CONFIG_DEBUG_NON_NESTED_UNLOCKS is enabled. [i'll do this in my 
refactored queue]

	Ingo
