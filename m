Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSFQD5d>; Sun, 16 Jun 2002 23:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316679AbSFQD5c>; Sun, 16 Jun 2002 23:57:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35568 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316678AbSFQD5b>; Sun, 16 Jun 2002 23:57:31 -0400
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0206170525520.2941-100000@e2>
References: <Pine.LNX.4.44.0206170525520.2941-100000@e2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 16 Jun 2002 20:57:17 -0700
Message-Id: <1024286237.924.49.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-16 at 20:49, Ingo Molnar wrote:

> i agree with the comment fixes, except these items:
> 
> > -	if (unlikely(in_interrupt()))
> > -		BUG();
> > +	BUG_ON(in_interrupt());
> > +
> 
> see the previous mail.

Shrug.  Preference I guess... though this is _the_ case for BUG_ON.

> > @@ -1790,4 +1790,4 @@
> >  		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
> >  			schedule_timeout(2);
> >  }
> > -#endif
> > +#endif /* CONFIG_SMP */
> 
> and this is just silly... I can see the point in doing #if comments in
> include files, but the nesting here is just so obvious.

I disagree, but OK.  I like having the #if marked by the #endif if they
are not close... and elsewhere through the kernel mirrors this.  While I
can scroll up and look - assuming the nesting is sane - a simple comment
makes that clear so what is the pain?

> the rest looks fine. (patch of my current 2.5 scheduler tree attached,
> against 2.5.22, with some more other nonfunctional bits added as well.)

Rest looks fine.

Then again, this is all invariants and comments so its really not a big
deal at all.  I guess better this than we are fighting over real code,
eh? ;-)

	Robert Love

