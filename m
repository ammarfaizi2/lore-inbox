Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSLBVSt>; Mon, 2 Dec 2002 16:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbSLBVSm>; Mon, 2 Dec 2002 16:18:42 -0500
Received: from mk-smarthost-3.mail.uk.tiscali.com ([212.74.114.39]:32523 "EHLO
	mk-smarthost-3.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id <S265242AbSLBVRX>; Mon, 2 Dec 2002 16:17:23 -0500
Subject: Re: Exaggerated swap usage
From: Andrew Clayton <andrew@sol-1.demon.co.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nuno Monteiro <nuno@itsari.org>, linux-kernel@vger.kernel.org,
       jmarcet@pobox.com, jamagallon@able.es, khromy@lnuxlab.ath.cx,
       conman@kolivas.net
In-Reply-To: <20021202002108.GQ28164@dualathlon.random>
References: <20021130182345.GA21410@lnuxlab.ath.cx>
	<20021130184317.GH28164@dualathlon.random>
	<20021201075921.GC2483@jerry.marcet.dyndns.org>
	<20021201103643.GL28164@dualathlon.random>
	<20021201143713.GA871@hobbes.itsari.int> 
	<20021202002108.GQ28164@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Dec 2002 21:24:52 +0000
Message-Id: <1038864295.841.3.camel@delta.digital-domain.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 00:21, Andrea Arcangeli wrote: 
> On Sun, Dec 01, 2002 at 02:37:13PM +0000, Nuno Monteiro wrote:
> > 
> > Trace; c0117114 <__run_task_queue+4c/60>
> > Trace; c011e0e9 <context_thread+11d/19c>
> > Trace; c010588c <kernel_thread+28/38>
> 
> ok, now it's clear what the problem is. there are inuse-dirty inodes
> that triggers a deadlock in the schedule-capable
> try_to_sync_unused_inodes of 2.4.20rc2aa1 (that avoided me to backout an
> otherwise corrupt lowlatency fix). It can trigger only in UP,
> in SMP the other cpu can always run kupdate that will flush all dirty
> inodes, so it would lockup one cpu as worse for 2.5 sec, this is
> probably why I couldn't reproduce it, I assume all of you reproducing
> the deadlock were running on an UP machine (doesn't matter if the kernel

Correct (for me anyways). 


> was compiled for SMP or not).
> 
> Can you give a spin to this untested incremental fix?
> 

Yep, this also works for me. 


> thanks,
> 
> Andrea


Cheers, (excellent work) 

Andrew Clayton 


