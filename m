Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWG3TvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWG3TvT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWG3TvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:51:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12945 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932452AbWG3TvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:51:19 -0400
Date: Sun, 30 Jul 2006 12:51:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf
Message-Id: <20060730125115.d9f9d625.akpm@osdl.org>
In-Reply-To: <9a8748490607301217g1edad85dre8a45457c57bee35@mail.gmail.com>
References: <200607301830.01659.jesper.juhl@gmail.com>
	<200607301835.35053.jesper.juhl@gmail.com>
	<20060730113416.7c1d8f80.pj@sgi.com>
	<9a8748490607301148q13992d9cr910a1dadb42e11fd@mail.gmail.com>
	<20060730120631.9ee1ab09.akpm@osdl.org>
	<9a8748490607301217g1edad85dre8a45457c57bee35@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 21:17:18 +0200
"Jesper Juhl" <jesper.juhl@gmail.com> wrote:

> > (looks at
> > lock_cpu_hotplug())
> >
> Hmm, I'll take a look at lock_cpu_hotplug() - can you provide
> additional details?
> 

eh.  We put the recursive-sem thing in there as a temp fix to cpufreq to
get 2.6.something out the door, expressing fine intentions to fix it for
real later on.  Then look what happened.  Don't go there.

> 
> > That being said, no, we can't go and rename up().  Let us go through the
> > patches one-at-a-time..
> >
> i figured as much. *But* won't you agree that up_sem() (or considering
> the other locking function names, sem_up() would probably be better)
> would be a much better name for a global like this one?
> 
> How about a plan like this:
> We introduce sem_up() and sem_down() wrapper functions now. They could
> go into 2.6.19 for example - and also add a note to
> feature-removal-schedule.txt that the old function names will be
> removed in 1 year. Then in a few kernel versions - say 2.6.21 - we
> deprecate the old names and add a big fac comment in the source as
> well.
> Wouldn't that be doable?   Or do we have to live with up()/down() forever?

Well actually when struct mutex went in we decided to remove all
non-counting uses of semaphores kernel-wide, migrating them to mutexes. 
Then to remove all the arch-specific semaphore implementations and
implement an arch-neutral version.  After that has been done would be an
appropriate time to rename things.

But it never happened.  See "fine intentions", above ;)
