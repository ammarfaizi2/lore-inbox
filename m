Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbUK0FgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbUK0FgH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUK0Dyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:54:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262519AbUKZTdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:32 -0500
Date: Thu, 25 Nov 2004 23:36:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 21/51: Refrigerator upgrade.
Message-ID: <20041125223610.GC2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296026.5805.275.camel@desktop.cunninghams> <20041125183332.GJ1417@openzaurus.ucw.cz> <1101420616.27250.65.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101420616.27250.65.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Included in this patch is a new try_to_freeze() macro Andrew M suggested
> > > a while back. The refrigerator declarations are put in sched.h to save
> > > extra includes of suspend.h.
> > 
> > try_to_freeze looks nice. Could we get it in after 2.6.10 opens?
> 
> I'm hoping to get the whole thing in mm once all these replies are dealt
> with. Does that sound unrealistic?

Yes, a little ;-).

> > >   */
> > >  int fsync_super(struct super_block *sb)
> > >  {
> > > +	int ret;
> > > +
> > > +	/* A safety net. During suspend, we might overwrite
> > > +	 * memory containing filesystem info. We don't then
> > > +	 * want to sync it to disk. */
> > > +	if (unlikely(test_suspend_state(SUSPEND_DISABLE_SYNCING)))
> > > +		return 0;
> > > +	
> > 
> > If it is safety net, do BUG_ON().
> 
> Could get triggered by user pressing SysRq. (Or via a panic?). I don't
> think the SysRq should result in a panic; nor should a panic result in a
> recursive call to panic (although I'm wondering here, wasn't the call to
> syncing in panic taken out?).

Silently doing nothing when user asked for sync is not nice,
either. BUG() is better solution than that.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
