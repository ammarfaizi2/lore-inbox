Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWCZXge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWCZXge (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWCZXge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:36:34 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:18883 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932205AbWCZXgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:36:33 -0500
Date: Mon, 27 Mar 2006 01:33:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org,
       arjan@infradead.org
Subject: Re: [patch 05/10] PI-futex: rt-mutex core
Message-ID: <20060326233357.GA21955@elte.hu>
References: <20060325184612.GF16724@elte.hu> <20060325213551.3003c2f8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325213551.3003c2f8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > --- linux-pi-futex.mm.q.orig/init/Kconfig
> >  +++ linux-pi-futex.mm.q/init/Kconfig
> >  @@ -361,9 +361,14 @@ config BASE_FULL
> >   	  kernel data structures. This saves memory on small machines,
> >   	  but may reduce performance.
> >   
> >  +config RT_MUTEXES
> >  +	boolean
> >  +	select PLIST
> >  +
> >   config FUTEX
> >   	bool "Enable futex support" if EMBEDDED
> >   	default y
> >  +	select RT_MUTEXES
> >   	help
> 
> We can't turn these things off unless we also turn off futexes.  There 
> goes another 8.7 kbytes...

do we want to make the futex API so splintered via .config? 8.7 kbytes 
on SMP boxes, a bit less on UP boxes. RAM-starving embedded platforms 
will want to turn off all things futexes i guess.

	Ingo
