Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267503AbUG2Wyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267503AbUG2Wyx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUG2Wv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:51:59 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:59570 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267503AbUG2WtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:49:11 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729224422.GG18623@elf.ucw.cz>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040729190438.GA468@openzaurus.ucw.cz>
	 <1091139864.2703.24.camel@desktop.cunninghams>
	 <20040729224422.GG18623@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1091141191.2703.42.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 30 Jul 2004 08:46:31 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-07-30 at 08:44, Pavel Machek wrote:
> Hi!
> 
> > > > -	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
> > > > +	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", 0, pd->name);
> > > >  	if (IS_ERR(pd->cdrw.thread)) {
> > > >  		printk("pktcdvd: can't start kernel thread\n");
> > > >  		ret = -ENOMEM;
> > > 
> > > What if someone does swapon /dev/pktdvd0?
> > 
> > Sorry. That's my ignorance. I thought the packet writer was only for
> > writing :>
> 
> Well, swapon /dev/pktdvd would be *very* bad idea as optical drives
> are very slow, but PF_NOFREEZE is more correct here.

Okay. I'll do a new patch for Andrew for this and the following
corrections.

[...]

> > > 
> > > I guess softinterrupts may be neccessary for suspend... Random drivers may use
> > > them, right?
> > 
> > I made this change at least a month ago and no one using suspend2 has
> > had any problems since, so perhaps not. Then again, with the voluntary
> > preemption (from what I've seen of comments about it) this would be a
> > definite yes.
> 
> Ok.

Just in case I wasn't clear, by 'a definite yes', I mean you're
absolutely right - it should be NOFREEZE.

Regards,

Nigel

