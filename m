Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTICXWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTICXWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:22:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:17603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264294AbTICXWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:22:40 -0400
Date: Wed, 3 Sep 2003 16:20:10 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@suse.cz>
cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
In-Reply-To: <20030903174904.GH30629@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0309031618390.944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > -void software_resume(void)
> > > +int __init swsusp_restore(void)
> > >  {
> > > -       if (num_online_cpus() > 1) {
> > > -               printk(KERN_WARNING "Software Suspend has
> > > malfunctioning SMP support. Disabled :(\n");
> > > -               return;
> > > -       }
> > > 
> > > I can not easily see where you moved this check.
> > 
> > Read the rest of the patches, and the changelogs (I do believe it's in 
> > them). It's in kernel/power/main.c::enter_state(), so all PM handlers can 
> > use it. 
> 
> Notice that this is done during resume. You are free to suspend with 1
> cpu, then attempt to resume with 2 cpus. Not *too* likely to happen,
> but....

That's a silly thing to do, though I don't support the notion of letting 
people find out the hard way. Why not just fail on CONFIG_SMP until it's 
done right? 



	Pat

