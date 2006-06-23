Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933078AbWFWL6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933078AbWFWL6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 07:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933079AbWFWL6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 07:58:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:25237 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933078AbWFWL6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 07:58:18 -0400
Date: Fri, 23 Jun 2006 13:52:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 50/61] lock validator: special locking: hrtimer.c
Message-ID: <20060623115254.GA12075@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212709.GX3155@elte.hu> <20060529183556.602b1570.akpm@osdl.org> <20060623100439.GI4889@elte.hu> <20060623033825.b62eec20.akpm@osdl.org> <20060623105255.GQ4889@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623105255.GQ4889@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > > perhaps the naming should be clearer? I had it named 
> > > spin_lock_init_standalone() originally, then cleaned it up to be 
> > > spin_lock_init_static(). Maybe the original name is better?
> > > 
> > 
> > hm.  This is where a "term of art" is needed.  What is lockdep's 
> > internal term for locks-of-a-different-type?  It should have such a 
> > term.
> 
> 'lock type' is what i tried to use consistenty.
> 
> > "class" would be a good term, although terribly overused.  Using that 
> > as an example, spin_lock_init_standalone_class()?  ug.

actually ... 'class' might be an even better term than 'type', mainly 
because type is even more overloaded in this context than class. "Q: 
What type does this lock have?" The natural answer: "it's a spinlock".

so i'm strongly considering the renaming of 'lock type' to 'lock class' 
and push that through all the APIs (and documentation). (i.e. we'd have 
'subclasses' of locks, not 'subtypes'.)

then we could do the annotations (where the call-site heuristics get the 
class wrong and either do false splits or dont do a split) via:

	spin_lock_set_class(&lock, &class_key)
	rwlock_set_class(&rwlock, &class_key)
	mutex_set_class(&mutex, &class_key)
	rwsem_set_class(&rwsem, &class_key)

[And for class-internal nesting, we'd have subclass nesting levels.]

hm?

	Ingo
