Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTIHRFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 13:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTIHRFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 13:05:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:33742 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263076AbTIHRF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 13:05:28 -0400
Date: Mon, 8 Sep 2003 10:04:57 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes
Message-Id: <20030908100457.42ba2606.shemminger@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain>
References: <3F58F0F7.4090105@redhat.com>
	<Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Sep 2003 17:28:44 +0100 (BST)
Hugh Dickins <hugh@veritas.com> wrote:

> On Fri, 5 Sep 2003, Ulrich Drepper wrote:
> > ... broke NPTL.  Tests which worked with previous kernels fail now.  One
> > test eventually succeeded, but the process somehow got stuck for about
> > 30-40 seconds.  Then it finished.  Running strace showed a call to
> > clone() as the last operation but there were other threads running at
> > that time.
> >....
> > What I can offer are statically linked versions of the tests.
> > One is here: http://people.redhat.com/drepper/tst-cond2.bz2
> 
> Very helpful, thank you: it showed two bugs, one new and one old. 
> Does the patch below work for you, Ulrich?
> 
> The new bug is that "offset" has been declared as an alternative in
> the union, instead of as an element in the structures comprising it,
> effectively eliminating it from the key: keys match which should not.
> 
> The old bug is that if futex_requeue were called with identical
> key1 and key2 (sensible? tended to happen given the first bug),
> it was liable to loop for a long time holding futex_lock: guard
> against that, still respecting the semantics of futex_requeue.
> 
> While here, please let's also fix the get_futex_key VM_NONLINEAR
> case, which was returning the 1 from get_user_pages, taken as an
> error by its callers.  And save a few bytes and improve debuggability
> by uninlining the top-level futex_wake, futex_requeue, futex_wait.
> 
> Hugh

Everything is working fine for me now.
