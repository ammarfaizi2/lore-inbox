Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUKILxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUKILxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUKILxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:53:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:55485 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261498AbUKILxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:53:06 -0500
Subject: Re: [PATCH 1/11] oprofile: add check_user_page_readable()
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041109032658.5d67d5e3.akpm@osdl.org>
References: <1099996636.1985.781.camel@hole.melbourne.sgi.com>
	 <20041109030403.7a306fcd.akpm@osdl.org>
	 <1099999253.1985.823.camel@hole.melbourne.sgi.com>
	 <20041109032658.5d67d5e3.akpm@osdl.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1100001164.1985.855.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 22:52:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 22:26, Andrew Morton wrote:
> > The i386 callgraph code attempts to follow user stacks, from
> > an interrupt (perfmon, NMI, or timer)
> 
> Yikes.

There are a number of problems with this, for example modern libcs
built with -fomit-frame-pointer limit it's usefulness.  But when it
does get meaningful traces it's really quite useful.

> > >   And why is that usage
> > > pattern not racy in the presence of paging activity?
> > 
> > The i386 backtracer takes the &current->mm->page_table_lock,
> 
> But that cannot be taken from interrupt context.  A trylock would be OK I
> guess.

The code reads:

#ifdef CONFIG_SMP
        if (!spin_trylock(&current->mm->page_table_lock))
                return;
#endif

i.e. it tries to get the lock and abandons the trace if it can't.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


