Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272719AbTG3DBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 23:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272731AbTG3DBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 23:01:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40969 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S272719AbTG3DBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 23:01:24 -0400
Date: Tue, 29 Jul 2003 22:53:30 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@osdl.org>
cc: ffrederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]2.6 test1 mm2 user.c race (?)
In-Reply-To: <20030728121420.255ce643.akpm@osdl.org>
Message-ID: <Pine.LNX.3.96.1030729224929.27753C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Andrew Morton wrote:

> <ffrederick@prov-liege.be> wrote:
> >
> > +	spin_lock(&uidhash_lock);
> >  	uid_hash_insert(&root_user, uidhashentry(0));
> > +	spin_unlock(&uidhash_lock);	
> 
> This code runs within an initcall, so it is very unlikely that anything
> will race with us here.
> 
> But SMP is up, and this code gets dropped out of memory later (the
> out-of-line spinlock code doesn't get dropped though).
> 
> So yes, I'd prefer that the locking be there, if only for documentary
> purposes.  A /* comment */ which explains why the locking was omitted would
> also be suitabe.

I like the locking better than the comment, I trust the analysis today,
but with SMP and preempt, the lock protects the future (and you may be
missing something even today).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

