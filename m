Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSFQEJj>; Mon, 17 Jun 2002 00:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSFQEJj>; Mon, 17 Jun 2002 00:09:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18664 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316683AbSFQEJi>;
	Mon, 17 Jun 2002 00:09:38 -0400
Date: Mon, 17 Jun 2002 06:07:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
In-Reply-To: <1024286237.924.49.camel@sinai>
Message-ID: <Pine.LNX.4.44.0206170556300.2941-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Jun 2002, Robert Love wrote:

> > > @@ -1790,4 +1790,4 @@
> > >  		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
> > >  			schedule_timeout(2);
> > >  }
> > > -#endif
> > > +#endif /* CONFIG_SMP */
> > 
> > and this is just silly... I can see the point in doing #if comments in
> > include files, but the nesting here is just so obvious.
> 
> I disagree, but OK.  I like having the #if marked by the #endif if they
> are not close... and elsewhere through the kernel mirrors this.  While I
> can scroll up and look - assuming the nesting is sane - a simple comment
> makes that clear so what is the pain?

and in this specific sched.c case, are we going to put in magic comments
every 25 lines inbetween:

/* this is CONFIG_SMP conditional code */

just to save us some scrolling up? I dont think #endif is special wrt.  
such comments.

in header files the #ifdef jungle often makes proper nesting hard. In
those cases putting comments to #else and #endif makes a real difference
in readability. But in sched.c there is not a single nested #ifdef. (and
that's very much intentional.)

	Ingo

