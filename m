Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261919AbSIYGIT>; Wed, 25 Sep 2002 02:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261920AbSIYGIT>; Wed, 25 Sep 2002 02:08:19 -0400
Received: from dp.samba.org ([66.70.73.150]:53957 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261919AbSIYGIS>;
	Wed, 25 Sep 2002 02:08:18 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module rewrite 2/20: bigrefs 
In-reply-to: Your message of "Wed, 25 Sep 2002 13:51:28 +1000."
             <15761.12992.408142.964391@notabene.cse.unsw.edu.au> 
Date: Wed, 25 Sep 2002 15:59:15 +1000
Message-Id: <20020925061334.1745A2C057@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15761.12992.408142.964391@notabene.cse.unsw.edu.au> you write:
> On Wednesday September 25, rusty@rustcorp.com.au wrote:
> > +static inline void bigref_init(struct bigref *ref, int value)
> > +{
> > +	unsigned int i;
> > +	atomic_set(&ref->ref[0].counter, value);
> > +	for (i = 1; i < NR_CPUS; i++)
> -----------------^
> > +		atomic_set(&ref->ref[i].counter, 0);
> > +	ref->waiter = NULL; /* To trap bugs */
> > +}
> 
> Should this be '0', or should there be a comment explaining why it
> one?

No, if it were 0, it would overwrite the atomic_set() immediately
above it.  I didn't think a comment was required since this is the
most obvious way to initialize a per-cpu counter to a total value.

I could add:
	/* Set one to the value, the others to zero */

If you missed it, others probably will, too.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
