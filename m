Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310113AbSCAVFA>; Fri, 1 Mar 2002 16:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310114AbSCAVEv>; Fri, 1 Mar 2002 16:04:51 -0500
Received: from ubermail.mweb.co.za ([196.2.53.169]:20996 "EHLO
	ubermail.mweb.co.za") by vger.kernel.org with ESMTP
	id <S310113AbSCAVEd>; Fri, 1 Mar 2002 16:04:33 -0500
Subject: Re: [RFC][PATCH] #define yield() for 2.4 scheduler (anticipating
	O(1))
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020301185825.GK2711@matchmail.com>
In-Reply-To: <20020301163237.GC16716@opeth.ath.cx> 
	<20020301185825.GK2711@matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.21mdk 
Date: 01 Mar 2002 23:18:12 +0200
Message-Id: <1015017496.2325.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-01 at 20:58, Mike Fedyk wrote:
> On Fri, Mar 01, 2002 at 11:32:37AM -0500, Dan Chen wrote:
> > In response to Rik's post concerning a #define yield(), I've done a
> > quick egrep over the 2.4.19-pre2 tree and modified as necessary. This is
> > a strict search and replace. Thanks to Rik and Davide for assistance.
> > Please correct me if I erred.
> > 
> > -- 
> > Dan Chen                 crimsun@email.unc.edu
> > GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc
> 
> > diff -uNr linux.orig/fs/buffer.c linux/fs/buffer.c
> > --- linux.orig/fs/buffer.c	Thu Feb 28 22:00:02 2002
> > +++ linux/fs/buffer.c	Fri Mar  1 10:29:52 2002
> > @@ -735,9 +735,8 @@
> >  	wakeup_bdflush();
> >  	try_to_free_pages(zone, GFP_NOFS, 0);
> >  	run_task_queue(&tq_disk);
> > -	current->policy |= SCHED_YIELD;
> >  	__set_current_state(TASK_RUNNING);
> > -	schedule();
> > +	yield();
> >  }
> >  
> >  void init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void *private)
> 
> is __set_current_state(TASK_RUNNING) compatible with the new scheduler?
> -

I once tried to apply the O(1) scheduler on 2.4.18-pre9 + aa vm and I
made a similar change (the O(1) patch was rejected on buffer.c) and it
caused so corruption on my file system (ext2), but I'm still not sure
what cause it that change was my main concern. I think Ingo is using
sys_sched_yield(); instead of yield. I will still be carefull about it
though.

