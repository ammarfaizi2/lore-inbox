Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVCPLTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVCPLTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 06:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVCPLTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 06:19:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:7085 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262549AbVCPLTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 06:19:33 -0500
Date: Wed, 16 Mar 2005 03:19:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: rostedt@goodmis.org
Cc: mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
Message-Id: <20050316031909.08e6cab7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	<Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	<20050315120053.GA4686@elte.hu>
	<Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	<20050315133540.GB4686@elte.hu>
	<Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
	<20050316085029.GA11414@elte.hu>
	<20050316011510.2a3bdfdb.akpm@osdl.org>
	<20050316095155.GA15080@elte.hu>
	<20050316020408.434cc620.akpm@osdl.org>
	<20050316101906.GA17328@elte.hu>
	<20050316024022.6d5c4706.akpm@osdl.org>
	<Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> 
> 
> On Wed, 16 Mar 2005, Andrew Morton wrote:
> 
> >
> > Those two are in the journal, actually.  You refer to jbd_lock_bh_state()
> > and jbd_lock_bh_journal_head().  I think they both need to be in the
> > buffer_head.  jbd_lock_bh_journal_head() can probably go away (just use
> > caller's jbd_lock_bh_state()).
> >
> > Or make them global, or put them in the journal.
> 
> The jbd_lock_bh_journal_head can be one global lock without a problem.

As I say, we can probably eliminate it.

> But
> when I made jbd_lock_bh_state a global lock, I believe it deadlocked on
> me.

That's a worry.

>  So this one has to go into the buffer head.  What do you mean with
> "put them in the journal", do you mean the journal_s structure?

Yes.

> Is there a
> safe way to get to that structure from the buffer head?

No convenient way, iirc.  But there's usually a fairly straightforward way
to get at the journal from within JBD code.

>  The state lock is
> used quite a bit and it gets tricky trying to figure out how to use other
> structures wrt buffer_heads at all the locations that use
> jbd_lock_bh_state.

That one should go into the buffer_head, I guess.
