Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVCRKj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVCRKj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 05:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVCRKj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 05:39:28 -0500
Received: from [24.24.2.55] ([24.24.2.55]:50616 "EHLO ms-smtp-01.nyroc.rr.com")
	by vger.kernel.org with ESMTP id S261566AbVCRKjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 05:39:19 -0500
Date: Fri, 18 Mar 2005 05:38:52 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove lame schedule in journal inverted_lock (was: Re:
 [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks)
In-Reply-To: <20050318013251.330e4d78.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503180531580.21994@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
 <20050315120053.GA4686@elte.hu> <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
 <20050315133540.GB4686@elte.hu> <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
 <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org>
 <20050316095155.GA15080@elte.hu> <20050316020408.434cc620.akpm@osdl.org>
 <20050316101906.GA17328@elte.hu> <20050316024022.6d5c4706.akpm@osdl.org>
 <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
 <20050316031909.08e6cab7.akpm@osdl.org> <Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
 <Pine.LNX.4.58.0503161141001.14087@localhost.localdomain>
 <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
 <20050316131521.48b1354e.akpm@osdl.org> <Pine.LNX.4.58.0503170406500.17019@localhost.localdomain>
 <Pine.LNX.4.58.0503180415370.21994@localhost.localdomain>
 <20050318013251.330e4d78.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Mar 2005, Andrew Morton wrote:
> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> > Andrew,
> >
> > Since I haven't gotten a response from you,
>
> It sometimes takes me half a day to get onto looking at patches.  And if I
> take them I usually don't reply (sorry).  But I don't drop stuff, so if you
> don't hear, please assume the patch stuck.  If others raise objections
> to the patch I'll usually duck it as well, but it's pretty obvious when that
> happens.

Sorry, I didn't mean to be pushy. I understand that you have a lot on your
plate, and I'm sure you don't drop stuff. I just wasn't sure that you
noticed that that was a patch and not just a reply on this thread, since I
didn't flag it as such in the subject. I just didn't want it to slip under
the radar.


>
> I really should knock up a script to send out an email when I add a patch
> to -mm.
>

I thought you might have had something like that already, which was
another reason I thought you might have skipped this.


> > I'd figure that you may have
> > missed this, since the subject didn't change.  So I changed the subject to
> > get your attention, and I've resent this. Here's the patch to get rid of
> > the the lame schedule that was in fs/jbd/commit.c.   Let me know if this
> > patch is appropriate.
>
> I'm rather aghast at all the ifdeffery and complexity in this one.  But I
> haven't looked at it closely yet.
>

I wanted to keep the wait logic out when it wasn't a problem. Basically,
the problem only occurs when bit_spin_trylock is defined as an actual
trylock. So I put in a define there to enable the wait queues.  I didn't
want to waste cycles checking the wait queue in jbd_unlock_bh_state when
there would never be anything on it.  Heck, I figured why even have the
wait queue wasting memory if it wasn't needed.  So that added the
ifdeffery complexity.

Thanks,

-- Steve

