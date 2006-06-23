Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933042AbWFWMGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933042AbWFWMGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933080AbWFWMGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:06:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933042AbWFWMGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:06:40 -0400
Date: Fri, 23 Jun 2006 05:06:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 50/61] lock validator: special locking: hrtimer.c
Message-Id: <20060623050625.997fbdf8.akpm@osdl.org>
In-Reply-To: <20060623115254.GA12075@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212709.GX3155@elte.hu>
	<20060529183556.602b1570.akpm@osdl.org>
	<20060623100439.GI4889@elte.hu>
	<20060623033825.b62eec20.akpm@osdl.org>
	<20060623105255.GQ4889@elte.hu>
	<20060623115254.GA12075@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 13:52:54 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > > perhaps the naming should be clearer? I had it named 
> > > > spin_lock_init_standalone() originally, then cleaned it up to be 
> > > > spin_lock_init_static(). Maybe the original name is better?
> > > > 
> > > 
> > > hm.  This is where a "term of art" is needed.  What is lockdep's 
> > > internal term for locks-of-a-different-type?  It should have such a 
> > > term.
> > 
> > 'lock type' is what i tried to use consistenty.
> > 
> > > "class" would be a good term, although terribly overused.  Using that 
> > > as an example, spin_lock_init_standalone_class()?  ug.
> 
> actually ... 'class' might be an even better term than 'type', mainly 
> because type is even more overloaded in this context than class. "Q: 
> What type does this lock have?" The natural answer: "it's a spinlock".
> 
> so i'm strongly considering the renaming of 'lock type' to 'lock class' 
> and push that through all the APIs (and documentation). (i.e. we'd have 
> 'subclasses' of locks, not 'subtypes'.)
> 
> then we could do the annotations (where the call-site heuristics get the 
> class wrong and either do false splits or dont do a split) via:
> 
> 	spin_lock_set_class(&lock, &class_key)
> 	rwlock_set_class(&rwlock, &class_key)
> 	mutex_set_class(&mutex, &class_key)
> 	rwsem_set_class(&rwsem, &class_key)
> 
> [And for class-internal nesting, we'd have subclass nesting levels.]
> 

Works for me.
