Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264096AbUKZUtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbUKZUtw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUKZUsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:48:24 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:40617 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264109AbUKZUkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:40:14 -0500
Subject: Re: Suspend 2 merge: 21/51: Refrigerator upgrade.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125223610.GC2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101296026.5805.275.camel@desktop.cunninghams>
	 <20041125183332.GJ1417@openzaurus.ucw.cz>
	 <1101420616.27250.65.camel@desktop.cunninghams>
	 <20041125223610.GC2711@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101422986.27250.106.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 09:49:46 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 09:36, Pavel Machek wrote:
> Hi!
> 
> > > > Included in this patch is a new try_to_freeze() macro Andrew M suggested
> > > > a while back. The refrigerator declarations are put in sched.h to save
> > > > extra includes of suspend.h.
> > > 
> > > try_to_freeze looks nice. Could we get it in after 2.6.10 opens?
> > 
> > I'm hoping to get the whole thing in mm once all these replies are dealt
> > with. Does that sound unrealistic?
> 
> Yes, a little ;-).

I'm not talking about talking about problems and then doing nothing :>
I'm writing a list of changes as I look at each of these responses.
Assuming they're all addressed (or not changed for good reasons), and
the code is actually useful, why shouldn't it go into mm?

> > > >   */
> > > >  int fsync_super(struct super_block *sb)
> > > >  {
> > > > +	int ret;
> > > > +
> > > > +	/* A safety net. During suspend, we might overwrite
> > > > +	 * memory containing filesystem info. We don't then
> > > > +	 * want to sync it to disk. */
> > > > +	if (unlikely(test_suspend_state(SUSPEND_DISABLE_SYNCING)))
> > > > +		return 0;
> > > > +	
> > > 
> > > If it is safety net, do BUG_ON().
> > 
> > Could get triggered by user pressing SysRq. (Or via a panic?). I don't
> > think the SysRq should result in a panic; nor should a panic result in a
> > recursive call to panic (although I'm wondering here, wasn't the call to
> > syncing in panic taken out?).
> 
> Silently doing nothing when user asked for sync is not nice,
> either. BUG() is better solution than that.

I don't think we should BUG because the user presses Sys-Rq S while
suspending. I'll make it BUG_ON() and make the Sys_Rq printk & ignore
when suspending. Sound reasonable?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

