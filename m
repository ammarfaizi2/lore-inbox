Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUBQFTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbUBQFTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:19:06 -0500
Received: from dp.samba.org ([66.70.73.150]:28108 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266003AbUBQFTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:19:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Christophe Saout <christophe@saout.de>,
       LKML <linux-kernel@vger.kernel.org>, pavel@suse.cz,
       Dirk Morris <dmorris@metavize.com>
Subject: Re: kthread, signals and PF_FREEZE (suspend) 
In-reply-to: Your message of "Mon, 16 Feb 2004 16:53:29 -0000."
             <20040216165329.GB17323@mail.shareable.org> 
Date: Tue, 17 Feb 2004 15:44:18 +1100
Message-Id: <20040217051911.779272C26A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040216165329.GB17323@mail.shareable.org> you write:
> Rusty Russell wrote:
> > > That means that signal_pending() will return true for that process which
> > > will make kthread stop the thread.
> > 
> > Yes, the way they are currently coded.  I had assumed that spurious
> > signals do not occur.
> 
> Yowch.  Does suspend mean this warning in futex_wait is wrong?
> 
> 	/* A spurious wakeup should never happen. */
> 	WARN_ON(!signal_pending(current));
> 	return -EINTR;

That's why it's a WARN_ON not a BUG_ON, and why suspend is
experimental.  But the bug reports we've seen didn't mention "I was
suspending when..."

Although Dirk has CONFIG_SOFTWARE_SUSPEND=y.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
