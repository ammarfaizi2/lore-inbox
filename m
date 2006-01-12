Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWALA4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWALA4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWALA4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:56:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:17829 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964887AbWALA4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:56:31 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs II - more problems
Date: Thu, 12 Jan 2006 01:55:26 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sct@redhat.com, mingo@elte.hu
References: <200601112126.59796.ak@suse.de> <20060111130728.579ab429.akpm@osdl.org> <1137014875.2929.81.camel@laptopd505.fenrus.org>
In-Reply-To: <1137014875.2929.81.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601120155.26679.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 22:27, Arjan van de Ven wrote:
> > 15/fs/ext3/super.c~	2006-01-11 21:54:13.000000000 +0100
> > > +++ linux-2.6.15/fs/ext3/super.c	2006-01-11 21:54:13.000000000 +0100
> > > @@ -2150,7 +2150,7 @@
> > >  
> > >  static void ext3_write_super (struct super_block * sb)
> > >  {
> > > -	if (mutex_trylock(&sb->s_lock) != 0)
> > > +	if (!mutex_trylock(&sb->s_lock) != 0)
> > >  		BUG();
> > >  	sb->s_dirt = 0;
> > >  }
> > 
> > We expect the lock to be held on entry.  Hence we expect mutex_trylock()
> > to return zero.
> 
> you are correct, and the x86-64 mutex.h is buggy

While this patch seemed  to fix LTP my desktop running the same kernel (with 
mutex fix) hung the mailer while sending an unrelated mail. Again on ext3.

I unfortunately don't have the backtraces anymore because I couldn't
save them to disk before the reboot (and forgot to copy them
to another system sorry), but they were also hanging in some JBD/ext3
functions in D, with all disk accesses hanging.

So things appear to be still broken in ext3 land.

-Andi

