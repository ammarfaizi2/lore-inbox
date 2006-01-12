Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWALBOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWALBOt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWALBOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:14:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964934AbWALBOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:14:48 -0500
Date: Wed, 11 Jan 2006 17:14:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, sct@redhat.com,
       mingo@elte.hu
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs II - more problems
Message-Id: <20060111171402.3f79e9f9.akpm@osdl.org>
In-Reply-To: <200601120155.26679.ak@suse.de>
References: <200601112126.59796.ak@suse.de>
	<20060111130728.579ab429.akpm@osdl.org>
	<1137014875.2929.81.camel@laptopd505.fenrus.org>
	<200601120155.26679.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Wednesday 11 January 2006 22:27, Arjan van de Ven wrote:
> > > 15/fs/ext3/super.c~	2006-01-11 21:54:13.000000000 +0100
> > > > +++ linux-2.6.15/fs/ext3/super.c	2006-01-11 21:54:13.000000000 +0100
> > > > @@ -2150,7 +2150,7 @@
> > > >  
> > > >  static void ext3_write_super (struct super_block * sb)
> > > >  {
> > > > -	if (mutex_trylock(&sb->s_lock) != 0)
> > > > +	if (!mutex_trylock(&sb->s_lock) != 0)
> > > >  		BUG();
> > > >  	sb->s_dirt = 0;
> > > >  }
> > > 
> > > We expect the lock to be held on entry.  Hence we expect mutex_trylock()
> > > to return zero.
> > 
> > you are correct, and the x86-64 mutex.h is buggy
> 
> While this patch seemed  to fix LTP my desktop running the same kernel (with 
> mutex fix) hung the mailer while sending an unrelated mail. Again on ext3.
> 
> I unfortunately don't have the backtraces anymore because I couldn't
> save them to disk before the reboot (and forgot to copy them
> to another system sorry), but they were also hanging in some JBD/ext3
> functions in D, with all disk accesses hanging.
> 
> So things appear to be still broken in ext3 land.

Are you using MD?

sata?   If so, which?
